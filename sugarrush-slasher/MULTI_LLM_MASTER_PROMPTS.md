# SugarRush Slasher — Multi-LLM Review Round

## Posting order
1. ChatGPT Lead Integrator (already active)
2. Grok Free Chat — adversarial architecture/runtime review
3. Gemini Free — Android/API35/tablet review
4. GitHub Copilot Free — Gradle/CI/Kotlin implementation review
5. Qwen2.5-Coder 3B local — repository static/code repair review
6. DeepSeek-Coder 1.3B local — independent code/logic review
7. DeepSeek-R1 1.5B local — edge-case/test reasoning review
8. Return all outputs to ChatGPT for final synthesis and implementation

## Shared immutable project context
Project: SugarRush Slasher
Current candidate: v0.4 Music Integration
Current local revision: ee576fc
Primary goal: finish Android first, then tablet, web, and Windows PC without changing the original game identity.

Verified/source-side state:
- Android core combat vertical slice exists.
- JDK 17, Gradle 8.9, Android API 35 and ADB have been verified on the Windows build machine.
- Android Build Tools 35.0.0 are now installed.
- Known fixes already applied: Surface spawn timing, wave-16 persistence, cumulative totalKills, SaveManager wiring, Kotlin Android plugin.
- Pure Kotlin GameRules regression suite passed 15/15.
- Full production Kotlin source type-check passed against Android API stubs.
- Five original 140-BPM dubstep game cues exist: three stage loops, boss loop, heavier boss-phase-two loop.
- Dynamic music switching, beat-reactive visuals, exact quote stingers, voice-resource hooks, music/SFX/haptics settings exist in the v0.4 candidate.
- No verified v0.4 APK/device runtime certification yet.
- Do not copy copyrighted music, lyrics, characters, dialogue, stages, UI, logos, or visual assets.
- Broad genre/mechanical inspiration is allowed; SugarRush Slasher must remain original IP.

Evidence rule for every reviewer:
Separate VERIFIED FACT, SOURCE-ONLY FINDING, ASSUMPTION, and UNKNOWN. Never call the project complete from source inspection alone.

---

## PROMPT 1 — GROK FREE CHAT — ADVERSARIAL REVIEW
You are the adversarial systems reviewer for SugarRush Slasher v0.4.

Use the shared project context above and inspect the attached/current project files. Do not rewrite the project for stylistic preference. Try to break the design mentally before suggesting fixes.

Focus on:
- SurfaceView lifecycle and thread races
- touch/controller conflicts
- wave/boss/state transitions
- save corruption and process-death behavior
- MediaPlayer lifecycle, resource leaks, audio-focus problems, pause/resume, boss-track transitions
- beat-sync drift at 140 BPM
- Android API 35 compatibility
- tablet scaling/orientation problems
- performance/memory risks on lower-end devices
- cross-platform assumptions that would later hurt Web/Windows ports

For every issue return: severity, exact file/system, evidence, failure scenario, smallest safe fix, exact test that proves the fix. Flag false positives explicitly.

Do NOT claim APK/runtime success. End with a prioritized blocker list: P0 launch blockers, P1 certification blockers, P2 polish.

---

## PROMPT 2 — GEMINI FREE — ANDROID + TABLET SPECIALIST
Act as Android/API-35 and large-screen QA specialist for SugarRush Slasher v0.4.

Review the project against current Android behavior with special attention to Android 15/API 35, SurfaceView, game-loop threading, lifecycle, audio, haptics, controller input, landscape orientation, tablets, DPI/resolution changes, background/foreground transitions, and SharedPreferences persistence.

Check whether phone assumptions fail on 7–13 inch tablets. Identify hardcoded pixel coordinates, touch targets, HUD scaling, aspect-ratio distortion, cutouts/insets, rotation/recreation behavior, and performance risks.

Return:
1. build/runtime blockers
2. phone-only bugs
3. tablet-specific bugs
4. exact smallest code/config fixes
5. an Android + tablet acceptance matrix with pass/fail criteria
6. tests that need physical hardware versus emulator

Do not redesign the art direction. Do not mark anything runtime-verified unless you actually ran it.

---

## PROMPT 3 — GITHUB COPILOT FREE — BUILD/CI IMPLEMENTATION REVIEW
Act as build engineer for SugarRush Slasher v0.4.

Inspect Gradle Kotlin DSL, AGP/Kotlin compatibility, compileSdk/targetSdk 35, wrapper configuration, GitHub Actions workflow, resource packaging, raw audio resources, manifest, minSdk 26 behavior, and debug APK artifact generation.

Goal: make `assembleDebug` deterministic and produce an inspectable APK artifact with SHA-256 evidence.

Tasks:
- identify any build-script errors or unnecessary dependencies
- verify the Kotlin Android plugin setup
- inspect CI ordering and caching
- ensure core-tests run before APK build
- ensure CI fails if APK is absent
- ensure artifact path/hash collection is correct
- propose the smallest patch set only

Output exact file diffs or patch snippets, commands to run, expected successful outputs, and rollback instructions. Do not touch unrelated code.

---

## PROMPT 4 — QWEN2.5-CODER 3B LOCAL — STATIC CODE REPAIR REVIEW
You are a local offline code reviewer. Work only from the SugarRush Slasher source tree supplied to you.

Perform a deterministic static review of all production Kotlin files. Look for nullability problems, thread-safety errors, lifecycle misuse, stale state, invalid transitions, arithmetic bugs, unbounded collections, MediaPlayer leaks, Surface lifecycle races, unsafe assumptions about width/height, controller-event mistakes, touch-event mistakes, and save-data bugs.

Return a compact table: file, line/function, severity, why it can fail, minimal patch, regression test. Do not invent Android runtime results. Prefer no change when evidence is weak.

---

## PROMPT 5 — DEEPSEEK-CODER 1.3B LOCAL — INDEPENDENT SECOND PASS
Independently inspect SugarRush Slasher without relying on conclusions from other reviewers.

Concentrate on logic correctness:
- wave progression 1–15
- boss every fifth wave
- boss phase-two trigger
- stage clear
- game over/restart
- cumulative kills and bank candy
- combo/finisher scoring
- save/reload invariants
- music-state selection matching gameplay state

Try to produce counterexamples for each state transition. Report only issues you can support from code. Give minimal corrections and executable unit-test ideas.

---

## PROMPT 6 — DEEPSEEK-R1 1.5B LOCAL — EDGE-CASE TEST DESIGN
Act as a hostile QA planner, not an implementer.

Using the current SugarRush Slasher rules, construct the smallest high-value test set that could expose hidden failures before launch.

Cover:
- app start before Surface dimensions are ready
- background/foreground during combat and boss music
- pause during a beat transition
- rapid touch + controller input together
- death during wave transition
- final kill on wave 15
- process death immediately after save
- malformed/old save data
- sound/music/haptics toggles across relaunch
- tablet aspect ratios
- no controller / controller reconnect
- missing or failed audio resource

Return test ID, setup, action, expected invariant, evidence to capture, and severity if failed. Keep the list lean and non-duplicative.

---

## PROMPT 7 — CHATGPT FINAL SYNTHESIS / IMPLEMENTATION
You are the lead integrator. Reconcile the outputs from Grok, Gemini, Copilot, Qwen, and DeepSeek against the actual current source and live build evidence.

Rules:
- Do not accept a finding merely because multiple models repeat it.
- Verify each issue in source/build/runtime evidence.
- Merge duplicate findings.
- Reject unsupported speculation.
- Apply P0 fixes first, then P1 certification fixes, then P2 polish.
- Preserve original IP, current gameplay identity, and working features.
- Maintain rollback copies/commits before risky changes.
- Re-run GameRules tests, static audit, full Android build, APK hash, install/launch, touch/controller/save/audio tests after changes.
- Android is the reference implementation; only after Android acceptance passes should tablet, Web, and Windows ports proceed.

Final output must include:
1. accepted findings
2. rejected findings and why
3. files changed
4. tests run and exact results
5. APK path/hash if produced
6. runtime evidence
7. remaining blockers
8. platform-by-platform launch readiness for Android, tablet, Web, Windows PC
