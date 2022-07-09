
# kiliaroPhotoGallery
A small mobile app that shows a few photos using the [Kiliaro API](https://docs.kiliaro.io/resources/shares).

## Features

- [x] Asynchronous image downloading and caching.
- [x] Cached all data on memory and disk, and the app worked clearly offline.
- [x] Modern Collection Views with `Compositional Layouts`.
- [x] Remove Cache from the app.
- [x] `MVVM` Architecture.
- [x] Use Combine framework.
- [x] Use `Builder` design pattern.
- [x] Use `URLSession` to fetch data from the network.
- [x] Reales on the App Store with `Fastlane`.
- [x] Write Unit Test with `XCTest`.


## Requirements

- iOS 14.0+ 
- Swift 5.0+
- xcode 13+
- Cocoapods

## Dependencies

To install dependencies use the `pod install` command in the root of project from the Terminal app.

##### Cocoapods
``` ruby
 pod 'Kingfisher', '~> 7.1.1'
 pod 'Cache'
 pod 'SPIndicator'
```

Fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### create_app

```sh
[bundle exec] fastlane create_app
```

Create on developer portal and App Store Connect

----


## iOS

### ios signing

```sh
[bundle exec] fastlane ios signing
```

Sync singing. create a new distribution certificate

### ios build

```sh
[bundle exec] fastlane ios build
```

Build

### ios release

```sh
[bundle exec] fastlane ios release
```

Release

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
