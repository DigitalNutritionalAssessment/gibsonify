# Development Instructions

This document outlines how to set up your development environment for Gibsonify, run the app, and also explains the app structure, how to contribute, and how to build and release the app.

## Dev Environment Set up

For development, it is recommended to run the app on an Android emulator using a Flutter SDK. You can run the app using the SDK from the command line, or from an IDE such as VSCode/VSCodium (with the [Flutter extension](https://open-vsx.org/extension/Dart-Code/flutter)) or Android Studio.

Currently, it is attempted to carry out development on the latest Flutter [stable](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) SDK [release](https://flutter.dev/docs/development/tools/sdk/releases). However, due to the rapid development of Flutter, this might not keep up in the future, which is why the last tested SDK version is noted in the `fvm_config.json` file within the `.fvm` directory.

Developing can be done using the Flutter SDK, which can be installed from [here](https://flutter.dev/docs/get-started/install), by following all the commands below while omitting `fvm ` from them e.g. running `flutter doctor` instead of `fvm flutter doctor` (and also skipping `fvm install`). All commands below assume the use of a unix-like system.

If the latest stable Flutter SDK doesn't work, it is recommended to use [Flutter Version Management (fvm)](https://fvm.app) with the Flutter SDK version specified in `fvm_config.json`. First, install fvm using the [official instructions](https://fvm.app/docs/getting_started/installation). Then, after cloning this project and navigating into its directory in terminal, install the required Flutter SDK version

```bash
fvm install
```

This should automatically install the correct Flutter version via fvm, which you can check by running `fvm doctor`.

After installing, you can optionally disable Flutter and Dart analytics

```bash
fvm flutter config --no-analytics && fvm dart --disable-analytics
```

Afterwards, make sure to correctly set up the Android toolchain, Android studio, or anything else that will be missing until Flutter stops complaining after running doctor

```bash
fvm flutter doctor
```

## Running

Before running Gibsonify for the first time, fetch all the dependencies

```bash
fvm flutter pub get
```

You can run the app in debug mode from Android Studio, from VSCode/VSCodium by pressing `F5` or from the terminal with

```bash
fvm flutter run
```

## App structure

Gibsonify uses a feature-driven directory structure, where the app is broken down into multiple self-contained features, each having its own subdirectory in the `lib` directory e.g. `collection` or `recipe`. Each feature is acessible in other parts of the app by importing its barrel file (e.g. `collection.dart`), for example

```dart
import 'package:gibsonify/navigation/navigation.dart';
```

For [state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro), Gibsonify uses the [BLoC pattern](https://www.flutterclutter.dev/flutter/basics/what-is-the-bloc-pattern/2021/2084/) with the help of the [flutter_bloc](https://bloclibrary.dev) library. Each feature has one BLoC, located in the `bloc` subdirectory of each feature, along with its states and events. To easily implement new BLoCs, the BLoC extension for [VSCode/VSCodium](https://bloclibrary.dev/#/blocvscodeextension) or [Android Studio](https://bloclibrary.dev/#/blocintellijextension) is handy.

The underlying classes used by the BLoC of each feature are in the `models` subdirectory of each feature, and the UI of the feature is in the `view` subdirectory, utilizing modular widgets in the `widgets` subdirectory.

## Contributing

<!--
TODO: delete `main` branch and rename `dev` to main to simplify development.
-->

This project follows the gitflow branch structure and [Conventional Commits](https://www.conventionalcommits.org/). The stable branch is `main`, which shouldn't be directly commited to. The main development branch, `dev`, is merged into `main` after checks pass, but `dev` also shouldn't be directly commited to. Commits should be made into branches branched out from the `dev` branch, e.g. `feat/add-awesome-feature`.

To contribute, open a pull request (PR) from your branch to the `dev` branch, naming your PR according to Conventional Commits, e.g. `feat: add awesome feature`. Your commits should also follow Conventional Commits, and it is recommended to use [Commitizen](https://commitizen-tools.github.io/commitizen/), which creates conventional commits for you using `cz c`. For major changes, please open an issue first to discuss what you would like to change.

All changes are documented in `CHANGELOG.md`, which is generated using commitizen as well. After a PR is approved, run the following to update the changelog

```bash
cz changelog
```

This should be then commited as `docs(changelog): update`, and the PR should be merged to dev `dev` using a merge commit with message corresponding to the PR name (e.g. `feat: add awesome feature`). If the commits in the PR _don't_ follow conventional commits, do a squash and merge to preserve conventional commits in `dev`.

<!-- 
TODO: Check if the above works (i.e. if there are no merge conflicts with `dev` after generating the changelog), if not, rewrite to:

This can then be commited straight to `dev` (the only exception, as it avoids merge conflicts), with the message `docs(changelog): update`
-->

<!--
TODO Add testing instructions once a testing suite is implemented, probably using bloc_test and mockito or mocktail.
-->

## Releasing

Before making a new release version, create a `chore/release-x.y.z` branch from the `dev` branch, implement any pre-release changes, and open a PR named `chore: release x.y.z`, where `x.y.z` can be deduced by running `cz bump --dry-run` and observing the printed version. This is an automatically generated [Semantic Version](https://semver.org/) from conventional commits. 

After implementing all changes and having the PR approved, update the version in `cz.yaml` and `pubspec.yaml` and also update the changelog all in a single command by running

```bash
cz bump
```

This will update these three files and create a commit `chore: bump version a.b.c to x.y.z`, along with an annotated git tag `x.y.z`. The PR should be then merged into `dev` (and also `main`) with the merge commit message `chore: release x.y.z`.

<!--
TODO: Rewrite this using just `main` after getting rid of `dev` and `main`.
-->

To release _a signed version_ of the Gibsonify android app via an `apk`, you need to have the Gibsonify java signing key on your machine. This key was generated using instructions found [here](https://docs.flutter.dev/deployment/android#signing-the-app) and [here](https://fahadjameel.com/2020/09/07/how-to-properly-sign-your-flutter-apps-before-uploading-to-the-android-app-store/) on 30 January 2022 and has the id `7c909176`. You then need to have a `key.properties` file in the `android` subdirectory of Gibsonify, which includes the path and password to the key. Only trusted developers should be able to build signed releases of Gibsonify, and this key should only be circulated amongst them.

Having satisfied this, an Android `apk` can be generated by running

```bash
flutter build apk --release
```

This will output `app-release.apk` to `gibsonify/build/app/outputs/apk/release`. Do not rename this file as this would break download links from GitHub releases. This is a [fat `apk`](https://docs.flutter.dev/deployment/android#what-is-a-fat-apk) that should run on most Android architectures.

The SHA256 checksum for the `app-release.apk` file should then be generated by running
`shasum -a 256 app-release.apk > app-release-checksum.txt` on Mac or `sha256sum release.apk > app-release-checksum.txt` on Linux. These files can then also be signed by the PGP key of the developer making the release.

<!--
TODO: Ditch checksums and just sign the release with Gibsonify's PGP key and upload the `.sig` file.`
-->

Finally, a GitHub release from the final commit with the `a.b.c` tag in the `main` branch should be made, and the `app-release.apk` and `app-release-checksum.txt` files uploaded (and possibly their PGP signatures). The changelog from previous version should be included in the GitHub release text field.
