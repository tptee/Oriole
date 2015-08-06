# Oriole

[![CI Status](http://img.shields.io/travis/Tyler Thompson/Oriole.svg?style=flat)](https://travis-ci.org/Tyler Thompson/Oriole)
[![Version](https://img.shields.io/cocoapods/v/Oriole.svg?style=flat)](http://cocoapods.org/pods/Oriole)
[![License](https://img.shields.io/cocoapods/l/Oriole.svg?style=flat)](http://cocoapods.org/pods/Oriole)
[![Platform](https://img.shields.io/cocoapods/p/Oriole.svg?style=flat)](http://cocoapods.org/pods/Oriole)

Oriole is a set of protocol extensions that add useful helper methods to Swift collections. Oriole resembles libraries like Dollar and ExSwift (which in turn take inspiration from Lodash), but with some ideological differences:

- Oriole uses Swift 2.0's new protocol extensions to provide more natural APIs.
- Oriole strives to be as generic as possible. Most methods extend CollectionType. Oriole extends concrete collections like Array, Set, and Dictionary only if necessary.
- Oriole fills in gaps in the Swift standard library. If a method is trivially reproducible by methods in the standard library, it is not included.
- Oriole prefers to implement functional solutions to problems. However, if an imperative solution is elegant and significantly more performant, it will replace the functional solution.

Oriole is in its infancy, but is growing rapidly. I aim to add at least one new tested extension a day until the project is complete. Detailed documentation is forthcoming and will accelerate once [Jazzy](https://github.com/realm/jazzy/pull/261) works with Swift 2.0.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
This library is Swift 2.0 only due to its reliance on protocol extensions.

## Installation

Oriole is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Oriole"
```

## Author

Tyler Thompson, tyler@tylerpaulthompson.com

## License

Oriole is available under the MIT license. See the LICENSE file for more info.
