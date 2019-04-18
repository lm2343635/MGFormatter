# MGFormatter

![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CI Status](http://img.shields.io/travis/lm2343635/MGFormatter.svg?style=flat)](https://travis-ci.org/lm2343635/MGFormatter)
[![Version](https://img.shields.io/cocoapods/v/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)
[![License](https://img.shields.io/cocoapods/l/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)
[![Platform](https://img.shields.io/cocoapods/p/MGFormatter.svg?style=flat)](http://cocoapods.org/pods/MGFormatter)

MGFormatter can format the JSON or HTML code in a view with customized keyword color and font.
<div>
<img src="https://raw.githubusercontent.com/lm2343635/MGFormatter/master/screenshot/json-dark.png" width="300">
<img src="https://raw.githubusercontent.com/lm2343635/MGFormatter/master/screenshot/html-dark.png" width="300">
</div>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 9.0+

## Usage

Just create a **FormatterView** and set the code you want to format.

```Swift
formatterView.format(string: utf8Text, style: .jsonDark)
```

### About style

The follow style can be customized be the developers.

- Formatter type(JSON or HTML) and the colors of key words.
- Font.
- Line spacing.

Dark and light style can be used directly.

### Supported code style and colors

The following colors of keywords can be customized.

- JSON type
	- normal
	- attribute
	- boolean
	- string
	- number
- HTML
	- normal
	- tag
	- attribute name
	- attribute value

Here is the demo code for customized style.

```Swift
let color = JSONColor(
    normal: .white,
    attribute: .yellow,
    boolean: .green,
    string: .cyan,
    number: .orange
)
let style = FormatterStyle(font: UIFont.systemFont(ofSize: 12), lineSpacing: 5, type: .json(JSONColor()))
self.formatterView.format(string: utf8Text, style: style)
```

## Installation

MGFormatter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MGFormatter', '~> 0.3'
```

## Author

Meng Li, lm2343635@126.com

## License

MGFormatter is available under the MIT license. See the LICENSE file for more info.
