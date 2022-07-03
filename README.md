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
- [ ] Write Unit Test with `XCTest`.

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

