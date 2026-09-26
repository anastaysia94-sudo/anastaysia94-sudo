# AI Handoff

Updated: 2026-09-25

## Identity
- Project: PTEDBoss
- Stable ID: P035
- Technical package: `com.smartpickshop.ptedboss`
- Planned repository: `anastaysia94-sudo/ptedboss`

## Verified recovered evidence
PTEDBoss v3.1.1 QA records a release build with Gradle CI PASS, APK integrity PASS, zipalign PASS, APK Signature Scheme v2/v3 PASS, preserved release certificate, adaptive launcher fix, and task deletion that preserves linked receipt evidence while clearing the deleted task link.

## Important limit
Real-phone verification remains authoritative for launcher appearance and device-specific camera/GPS/background behavior.

## Resume protocol
1. Recover the v3.1.1 source/APK if available.
2. Use the v3.1.1 retest survey rather than restarting old QA.
3. Retest the exact physical-device gates.
4. Record pass/fail evidence before calling the build production-ready.
