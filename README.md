# Gibsonify

Gibsonify is a Flutter-based app designed to follow Gibson's 24-hour Methodology for nutritional data collection.

## Description

The app follows the structure of the four passes for the [Gibson 24-hour methodology](https://www.gov.uk/research-for-development-outputs/an-interactive-24-hour-recall-for-assessing-the-adequacy-of-iron-and-zinc-intakes-in-developing-countries). It has been designed with prompts to help the enumerator carrying out the survey to make the process as intuitive as possible. Having been designed with offline usage in mind, it uses a local database of the recipes and recent data collected.

## Installation

_TODO Add installation instructions_

<!--
Probably direct (signed) apk download from GitHub releases, then maybe Google Play Store & F-droid links?
-->

## Development

### Dev Environment Set up

For development, it is recommended to run the app on an Android emulator using a Flutter SDK. You can run the app using the SDK from the command line, or from an IDE such as VSCode/VSCodium (with the [Flutter extension](https://open-vsx.org/extension/Dart-Code/flutter)) or Android Studio.

Currently, it is attempted to carry out development on the latest Flutter [stable](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) SDK [release](https://flutter.dev/docs/development/tools/sdk/releases). However, due to the rapid development of Flutter, this might fail in the future, which is why the last tested SDK version is noted in the `fvm_config.json` file within the `.fvm` directory.

Developing can be done using the Flutter SDK, which can be installed from [here](https://flutter.dev/docs/get-started/install), by following all the commands below while omitting `fvm ` from them e.g. running `flutter doctor` instead of `fvm flutter doctor` (and also skipping `fvm install`). If the latest stable Flutter SDK doesn't work, it is recommended to use [Flutter Version Management (fvm)](https://fvm.app) with the Flutter SDK version specified in `fvm_config.json`. First, install fvm using the [official instructions](https://fvm.app/docs/getting_started/installation). Then, after cloning this project and navigating into its directory in terminal, install the required Flutter SDK version

```bash
fvm install
```

After installing, you can optionally disable Flutter and Dart analytics

```bash
fvm flutter config --no-analytics && fvm dart --disable-analytics
```

Afterwards, make sure to correctly set up the Android toolchain, Android studio, or anything else that will be missing until Flutter stops complaining after running doctor

```bash
fvm flutter doctor
```

Finally, configure the correct Flutter version to be used in this project

```bash
fvm use
```

### Running

Before running for the first time, fetch all the dependencies

```bash
fvm flutter pub get
```

You can run the app in debug mode from Android Studio, from VSCode/VSCodium by pressing `F5` or from the terminal with

```bash
fvm flutter run
```

### App structure

_TODO add repo structure_

### Contributing

This project follows a conventional branch structure and [Conventional Commits](https://www.conventionalcommits.org/). The stable branch is `main`, which shouldn't be directly commited to. The main development branch, `dev`, is merged into `main` after checks pass, but `dev` also shouldn't be directly commited to. Commits should be made into branches branched out from the `dev` branch, e.g. `feat/my-awesome-feature`.

To contribute, open a pull request from your branch to the `dev` branch. For better versioning, make sure to use Conventional Commits, perhaps with the help of [Commitizen](https://commitizen-tools.github.io/commitizen/). For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Authors and Acknowledgements

This project was forked from the [original](https://github.com/choonkiatlee/ICRISAT-mobile) by [Choon Kiat Lee](https://github.com/choonkiatlee) and it was taken on by [Greg Chu](https://github.com/gregchu6) & [Juan Rodgers](https://github.com/rodgersjuan).

## License

[Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)