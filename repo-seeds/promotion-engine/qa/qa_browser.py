import json, os, shutil, subprocess, sys, time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select, WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

ROOT = Path.home() / "PromotionEngineQA"
SITE = ROOT / "site"
PROFILE = ROOT / "chrome-qa-profile"
DOWNLOADS = ROOT / "downloads"
REPORT = ROOT / "qa-report.json"
DESKTOP_SHOT = ROOT / "desktop.png"
MOBILE_SHOT = ROOT / "mobile.png"
URL = "http://127.0.0.1:8765/"
STORAGE_KEY = "smartpickshop-promotion-engine-progress-v2"
CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
DOWNLOADS.mkdir(exist_ok=True)
if PROFILE.exists():
    shutil.rmtree(PROFILE)

server = subprocess.Popen([sys.executable, "-m", "http.server", "8765", "--bind", "127.0.0.1", "--directory", str(SITE)],
                          stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
time.sleep(1.5)
results = {"started_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"), "checks": {}}
def launch(mobile=False):
    opts = webdriver.ChromeOptions()
    opts.binary_location = CHROME
    opts.add_argument("--headless=new")
    opts.add_argument("--no-first-run")
    opts.add_argument("--no-default-browser-check")
    opts.add_argument("--disable-background-networking")
    opts.add_argument(f"--user-data-dir={PROFILE}")
    prefs = {"download.default_directory": str(DOWNLOADS), "download.prompt_for_download": False}
    opts.add_experimental_option("prefs", prefs)
    if mobile:
        opts.add_experimental_option("mobileEmulation", {
            "deviceMetrics": {"width": 390, "height": 844, "pixelRatio": 3},
            "userAgent": "Mozilla/5.0 (Linux; Android 14; Pixel 7) AppleWebKit/537.36 Chrome/154 Mobile Safari/537.36"
        })
    else:
        opts.add_argument("--window-size=1440,1000")
    service = Service(str(ROOT / "chromedriver" / "chromedriver-win64" / "chromedriver.exe"))
    return webdriver.Chrome(service=service, options=opts)

def wait_ready(d):
    d.get(URL)
    WebDriverWait(d, 20).until(lambda x: x.execute_script("return document.readyState") == "complete")
    WebDriverWait(d, 20).until(lambda x: len(x.find_elements(By.CSS_SELECTOR, ".route-card")) == 35)

try:
    d = launch(False)
    wait_ready(d)
    results["checks"]["desktop_route_count_35"] = len(d.find_elements(By.CSS_SELECTOR, ".route-card")) == 35
    results["checks"]["six_views_present"] = len(d.find_elements(By.CSS_SELECTOR, ".tab")) == 6
    Select(d.find_element(By.ID, "statusFilter")).select_by_visible_text("Ready — Free")
    d.execute_script("arguments[0].dispatchEvent(new Event('change',{bubbles:true}))", d.find_element(By.ID, "statusFilter"))
    time.sleep(0.3)
    results["checks"]["ready_free_filter_20"] = len(d.find_elements(By.CSS_SELECTOR, ".route-card")) == 20
    Select(d.find_element(By.ID, "statusFilter")).select_by_index(0)
    d.find_element(By.ID, "searchInput").send_keys("SubmitMySaas")
    time.sleep(0.3)
    results["checks"]["search_submitmysaas_1"] = len(d.find_elements(By.CSS_SELECTOR, ".route-card")) == 1
    d.find_element(By.ID, "searchInput").clear()
    d.execute_script("arguments[0].dispatchEvent(new Event('input',{bubbles:true}))", d.find_element(By.ID, "searchInput"))
    d.find_element(By.CSS_SELECTOR, "button[data-view='workspace']").click()
    progress = Select(d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='progress']"))
    progress.select_by_visible_text("In Progress")
    project = d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='project']")
    project.clear(); project.send_keys("QA-PERSISTENCE-TEST")
    project.send_keys("\t")
    notes = d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='notes']")
    notes.clear(); notes.send_keys("QA persistence sentinel")
    notes.send_keys("\t")
    stored = d.execute_script("return localStorage.getItem(arguments[0])", STORAGE_KEY)
    results["checks"]["localstorage_written"] = "QA-PERSISTENCE-TEST" in (stored or "")
    for f in DOWNLOADS.glob("promotion-engine-progress*.json"):
        f.unlink()
    d.find_element(By.ID, "exportBtn").click()
    export_file = DOWNLOADS / "promotion-engine-progress.json"
    WebDriverWait(d, 10).until(lambda x: export_file.exists())
    exported = json.loads(export_file.read_text(encoding="utf-8"))
    results["checks"]["export_contains_sentinel"] = exported.get("progress",{}).get("P035",{}).get("project") == "QA-PERSISTENCE-TEST"
    d.save_screenshot(str(DESKTOP_SHOT))
    d.quit()

    d = launch(False)
    wait_ready(d)
    d.find_element(By.CSS_SELECTOR, "button[data-view='workspace']").click()
    project2 = d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='project']").get_attribute("value")
    progress2 = Select(d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='progress']")).first_selected_option.text
    results["checks"]["restart_persistence"] = project2 == "QA-PERSISTENCE-TEST" and progress2 == "In Progress"

    d.execute_script("localStorage.removeItem(arguments[0]);", STORAGE_KEY)
    d.refresh()
    WebDriverWait(d, 10).until(lambda x: len(x.find_elements(By.CSS_SELECTOR, ".route-card")) == 35)
    inp = d.find_element(By.ID, "importInput")
    inp.send_keys(str(export_file))
    WebDriverWait(d, 5).until(EC.alert_is_present())
    d.switch_to.alert.accept()
    time.sleep(0.5)
    d.find_element(By.CSS_SELECTOR, "button[data-view='workspace']").click()
    project3 = d.find_element(By.CSS_SELECTOR, "[data-id='P035'][data-field='project']").get_attribute("value")
    results["checks"]["import_restores_progress"] = project3 == "QA-PERSISTENCE-TEST"
    d.quit()
    d = launch(True)
    wait_ready(d)
    dims = d.execute_script("""
      const de=document.documentElement, top=document.querySelector('.topbar'),
            grid=document.querySelector('.route-grid'), tabs=document.querySelector('.tabs');
      return {
        innerWidth: innerWidth, scrollWidth: de.scrollWidth,
        topRight: top.getBoundingClientRect().right,
        gridRight: grid.getBoundingClientRect().right,
        tabsOverflow: tabs.scrollWidth >= tabs.clientWidth,
        routeCount: document.querySelectorAll('.route-card').length
      };
    """)
    results["mobile_metrics"] = dims
    results["checks"]["mobile_route_count_35"] = dims["routeCount"] == 35
    results["checks"]["mobile_no_page_overflow"] = dims["scrollWidth"] <= dims["innerWidth"] + 1
    results["checks"]["mobile_primary_content_fits"] = dims["topRight"] <= dims["innerWidth"] + 1 and dims["gridRight"] <= dims["innerWidth"] + 1
    d.save_screenshot(str(MOBILE_SHOT))
    d.execute_script("localStorage.removeItem(arguments[0]);", STORAGE_KEY)
    d.quit()

    failed = [k for k,v in results["checks"].items() if v is not True]
    results["failed"] = failed
    results["passed"] = not failed
except Exception as e:
    results["passed"] = False
    results["exception"] = repr(e)
finally:
    try:
        if "d" in locals():
            d.quit()
    except Exception:
        pass
    server.terminate()
    results["finished_at"] = time.strftime("%Y-%m-%dT%H:%M:%S%z")
    REPORT.write_text(json.dumps(results, indent=2), encoding="utf-8")
    print(json.dumps(results, indent=2))