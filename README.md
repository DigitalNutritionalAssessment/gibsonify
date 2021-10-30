# Gibsonify

Gibsonify is a Flutter app designed to follow [Gibson's 24-hour methodology](https://www.gov.uk/research-for-development-outputs/an-interactive-24-hour-recall-for-assessing-the-adequacy-of-iron-and-zinc-intakes-in-developing-countries) for nutritional data collection.

_TODO Add demo gif_

## Description

The app follows the structure of the four passes of Gibson's methodology. It has been designed with prompts to help the enumerator carrying out the survey to make the process as intuitive as possible. Having been designed with offline usage in mind, it uses a local database of the recipes and recent data collected.

## Installation

_TODO Add installation instructions_

<!--
Probably direct (PGP-signed) apk download from GitHub releases (and tags?), then maybe Google Play Store & F-droid links?
-->

## Development

### Dev Environment Set up

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

### Running

Before running Gibsonify for the first time, fetch all the dependencies

```bash
fvm flutter pub get
```

You can run the app in debug mode from Android Studio, from VSCode/VSCodium by pressing `F5` or from the terminal with

```bash
fvm flutter run
```

### App structure

Gibsonify uses a feature-driven directory structure, where the app is broken down into multiple self-contained features, each having its own subdirectory in the `lib` directory e.g. `collection` or `recipe`. Each feature is acessible in other parts of the app by importing its barrel file (e.g. `collection.dart`), for example

```dart
import 'package:gibsonify/navigation/navigation.dart';
```

For [state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro), Gibsonify uses the [BLoC pattern](https://www.flutterclutter.dev/flutter/basics/what-is-the-bloc-pattern/2021/2084/) with the help of the [flutter_bloc](https://bloclibrary.dev) library. Each feature has one BLoC, located in the `bloc` subdirectory of each feature, along with its states and events. To easily implement new BLoCs, the BLoC extension for [VSCode/VSCodium](https://bloclibrary.dev/#/blocvscodeextension) or [Android Studio](https://bloclibrary.dev/#/blocintellijextension) is handy.

The underlying classes used by the BLoC of each feature are in the `models` subdirectory of each feature, and the UI of the feature is in the `view` subdirectory, utilizing modular widgets in the `widgets` subdirectory.

### Contributing

This project follows a conventional branch structure and [Conventional Commits](https://www.conventionalcommits.org/). The stable branch is `main`, which shouldn't be directly commited to. The main development branch, `dev`, is merged into `main` after checks pass, but `dev` also shouldn't be directly commited to. Commits should be made into branches branched out from the `dev` branch, e.g. `feat/my-awesome-feature`.

To contribute, open a pull request from your branch to the `dev` branch, naming your pull request according to Conventional Commits and including a changelog in the description (see below). Ideally, your commits should also follow Conventional Commits, perhaps with the help of [Commitizen](https://commitizen-tools.github.io/commitizen/). For major changes, please open an issue first to discuss what you would like to change.

All changes are documented in `CHANGELOG.md`, which is generated with the help of [git-cliff](https://github.com/orhun/git-cliff/). After installing git-cliff and commiting your last changes to your PR, simply run the following command to update the changelog (and then commit this as well!)

```bash
git cliff --sort newest --output CHANGELOG.md
```

For the description of your PR, generate the changelog from the latest commit before your commits, which can be generated using the hash of this latest commit, for example

```bash
git cliff f5d5f263870b559e347824700956646501ae48ff..
```

This should also be the message body of the merge commit of the PR, with the commit title being the name of the PR (in Conventional Commit format).

_TODO Add testing instructions once a testing suite is implemented_

<!--
Probably using bloc_test and mockito or mocktail.
-->

## Authors and Acknowledgements

Gibsonify is being developed by [Shazril Suhail](https://github.com/sshazril) and [Adam Sroka](https://adamsroka.io), who have taken on the previous work of [Greg Chu](https://github.com/gregchu6), [Juan Rodgers](https://github.com/rodgersjuan), and [Choon Kiat Lee](https://github.com/choonkiatlee).

The development of the project is supervised by Alexandre Kabla ([University of Cambridge](https://www.cam.ac.uk), [Engineering Department](http://www.eng.cam.ac.uk/)) and Lara Allen ([Centre for Global Equality](https://centreforglobalequality.org)), in collaboration with Padmaja Ravula and Kavitha Kasala ([ICRISAT](https://www.icrisat.org/)). The project received support from [TIGR2ESS](https://www.globalfood.cam.ac.uk/keyprogs/TIGR2ESS).

## License

The source code of this project and all other content is licensed under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.
