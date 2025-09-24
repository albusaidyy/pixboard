@echo off

if "%1"=="fmt" goto fmt
if "%1"=="get" goto get
if "%1"=="install" goto install
if "%1"=="installdev" goto installdev
if "%1"=="icons" goto icons
if "%1"=="gen" goto gen
if "%1"=="build-dev" goto build-dev
if "%1"=="dev" goto dev
if "%1"=="dev-release" goto dev-release
if "%1"=="dev-web-port" goto dev-web-port
if "%1"=="dev-web" goto dev-web
if "%1"=="dev-web-release" goto dev-web-release
if "%1"=="build-stg" goto build-stg
if "%1"=="staging" goto staging
if "%1"=="staging-web" goto staging-web
if "%1"=="build-prod" goto build-prod
if "%1"=="prod" goto prod
if "%1"=="prod-release" goto prod-release
if "%1"=="prod-web" goto prod-web
if "%1"=="prod-web-release" goto prod-web-release
if "%1"=="prod-web-port" goto prod-web-port
if "%1"=="clean" goto clean
if "%1"=="localize" goto localize
if "%1"=="fix" goto fix
if "%1"=="commit-empty" goto commit-empty
if "%1"=="shorebird-patch" goto shorebird-patch

goto :eof

:fmt
dart format lib
goto :eof

:get
flutter pub get
goto :eof

:install
flutter pub add "%2"
goto :eof

:installdev
flutter pub add -d "%2"
goto :eof

:icons
dart run flutter_launcher_icons:main && dart run icons_launcher:create
goto :eof

:gen
dart run build_runner build --delete-conflicting-outputs
goto :eof

:build-dev
flutter build apk  --flavor development --target lib/main_development.dart
goto :eof

:dev
flutter run --flavor development --target lib/main_development.dart
goto :eof

:dev-release
flutter run --flavor development --target lib/main_development.dart --release
goto :eof

:dev-web-port
flutter run --flavor development --target lib/main_development.dart -d chrome --web-port=8080
goto :eof

:dev-web
flutter run --flavor development --target lib/main_development.dart -d chrome
goto :eof

:dev-web-release
flutter run --flavor development --target lib/main_development.dart -d chrome --release
goto :eof

:build-stg
flutter build apk  --flavor staging --target lib/main_staging.dart
goto :eof

:staging
flutter run --flavor staging --target lib/main_staging.dart
goto :eof

:staging-web
flutter run --flavor staging --target lib/main_staging.dart -d chrome
goto :eof

:build-prod
flutter build apk  --flavor production --target lib/main_production.dart
goto :eof

:prod
flutter run --flavor production --target lib/main_production.dart
goto :eof

:prod-release
flutter run --flavor production --target lib/main_production.dart --release
goto :eof

:prod-web
flutter run --flavor production --target lib/main_production.dart -d chrome
goto :eof

:prod-web-release
flutter run --flavor production --target lib/main_production.dart -d chrome --release
goto :eof

:prod-web-port
flutter run --flavor production --target lib/main_production.dart -d chrome --web-port=80
goto :eof

:clean
flutter clean
goto :eof

:localize
flutter gen-l10n
goto :eof

:fix
dart fix --apply
goto :eof

:commit-empty
git commit --allow-empty -m "Trigger build"
goto :eof

:shorebird-patch
shorebird patch android --target lib/main_production.dart --flavor production
goto :eof
