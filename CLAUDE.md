# Orbit Bound

Flutter game (Flame + Forge2D). Package id `com.janboucek.orbit_bound`, Dart package name `space_balls`.

## Android SDK levels

`compileSdk` / `minSdk` / `targetSdk` / `ndkVersion` deliberately come from Flutter's
`flutter.*` extension, not pinned literals. To change the target API level, upgrade the
Flutter SDK — don't hardcode a number. Toolchain versions in `android/settings.gradle` and
the Gradle wrapper track what `flutter create` generates for the pinned Flutter version.

Release builds need `android/key.properties` (gitignored, not on CI).

## Testing the game on an emulator

`Medium_Phone_API_36.0` is the API 36 AVD. Screenshots come back 1080x2400.

```
flutter emulators --launch Medium_Phone_API_36.0
flutter build apk --release --target-platform android-arm64   # arm64 only: much faster on Apple Silicon
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb shell am start -n com.janboucek.orbit_bound/.MainActivity
```

Getting into a level (tap coordinates, 1080x2400):

1. `539 1698` — Play
2. `194 556` — level 1 (tutorial)
3. `539 1200` — dismiss the "Tutorial" popup. **The game ignores input until this is
   dismissed.** Screenshots taken before this look like a live game but nothing responds.

Shooting: swipe from the ball, e.g. `adb shell input swipe 719 1322 660 900 500`. The HUD
bottom-right then reads `Last shot: <power> @ <angle>°` — that string is the proof input
was registered. Low power (< ~2) barely moves the ball, so aim for a longer drag.

To confirm physics actually run, take two screenshots a moment apart and compare the
planet's position — it orbits continuously. A single screenshot proves rendering only.

Harmless noise in `adb logcat`, all unrelated to the app:

- `google_fonts ... Failed host lookup: fonts.gstatic.com` — fonts are fetched at runtime
  and the emulator has no network.
- `SIGABRT` in `droid.bluetooth` — the emulator's own Bluetooth stack.
- `ShellStartingWindow: Drawable ... launch_background` not found.
