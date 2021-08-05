#!/usr/bin/env bash

# Для установки инструмента: curl -sL firebase.tools | bash
# Обновление: sudo rm /usr/local/bin/firebase && curl -sL firebase.tools | bash

set -e

ver=`./gradlew -q printVersionName`

echo "Версия для Firebase App Tester: $ver"
read -p "Press enter to continue"

./gradlew clean build

# stage
firebase appdistribution:distribute "app/build/outputs/apk/release_tst/app-id-v${ver}-stage.apk"  \
    --app 1:58362805903:android:594b7217fc5fd7e895bafa  \
    --release-notes-file "release_notes.txt" \
    --groups "Internal-testers"

# release
firebase appdistribution:distribute "app/build/outputs/apk/release/app-id-v${ver}-release.apk"  \
    --app 1:1023881250695:android:be44a0a36c260b8d  \
    --release-notes-file "release_notes.txt" \
    --groups "Internal-testers"

