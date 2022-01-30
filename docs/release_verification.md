# Release Verification

This document outlines how to verify the integrity of the Gibsonify release, to make sure it is the correct file that hasn't been tampered with.

## APK Signing Key Verification

To verify the integrity of the downloaded file, you can use `keytool` to [check that the `apk` is signed by Gibsonify's keystore key](https://trinitytuts.com/tips/how-we-can-check-sha1-or-signature-of-apk-and-keystore-file/), which has serial number `7c909176` and SHA256 fingerprint `EA:89:22:26:2F:DB:35:4E:37:7D:8B:CA:FF:30:8C:09:36:23:97:99:68:87:23:18:75:5D:75:86:21:B9:0E:64`. In short, check that `keytool` is in your path by making sure `keytool -help` runs successfuly, and then running `keytool -printcert -jarfile app-release.apk` and checking the values mentioned above match.

## Checksum Verification

To check that the SHA256 checksum of the release file matches the checksum PGP-signed by Gibsonify developers in the [releases section of Gibsonify's GitHub page](https://github.com/DigitalNutritionalAssessment/Gibsonify/releases/latest), you can follow [this tutorial]. In short, to check the checksum itself, run `shasum --check app-release-checksum.txt` on Mac or `sha256sum --check app-release-checksum.txt` on Linux.

_TODO: Migrate to signing releases with a central Gibsonify PGP key instead of checksums._
<!-- Just as git-cliff does it.-->
