# MGFormatter

[![CI Status](http://img.shields.io/travis/lm2343635/MGFormatter.svg?style=flat)](https://travis-ci.org/lm2343635/MGFormatter)
[![Version](https://img.shields.io/cocoapods/v/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)
[![License](https://img.shields.io/cocoapods/l/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)
[![Platform](https://img.shields.io/cocoapods/p/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)

MGFormatter can format code(JSON, XML, HTML..,) in a view with customized keyword color and font.

<img src="https://raw.githubusercontent.com/lm2343635/MGFormatter/master/screenshot/demo-dark.png" width="340px">

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- Xcodw 9.0+

## Usage

Just create a **FormatterView** and set the code you want to format.

```Swift
formatterView.format(string: utf8Text, style: .dark)
```

### About style

The follow style can be customized be the developers.

- Color of key words.
- Font.
- Line spacing.

Dark and light style can be used directly.

### Supported code style

- JSON

## Installation

MGFormatter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MGFormatter', '~> 0.1'
```

## Author

lm2343635, lm2343635@126.com

## License

MGFormatter is available under the MIT license. See the LICENSE file for more info.
