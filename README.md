# ImageGridView

### A drag and drop, reorderable, image grid suitable for a profile picture selector.

This Cocoa Pod gives you an image grid view which displays images. Images can be dragged and dropped to be reordered. There are buttons to delete images and add new images. The grid automatically resizes when more images are added. You can hook in delegate methods to control the behaviour when the user taps delete or add. This was originally designed for a profile picture selector on an edit profile screen.

[![CI Status](http://img.shields.io/travis/miraan/ImageGridView.svg?style=flat)](https://travis-ci.org/miraan/ImageGridView)
[![Version](https://img.shields.io/cocoapods/v/ImageGridView.svg?style=flat)](http://cocoapods.org/pods/ImageGridView)
[![License](https://img.shields.io/cocoapods/l/ImageGridView.svg?style=flat)](http://cocoapods.org/pods/ImageGridView)
[![Platform](https://img.shields.io/cocoapods/p/ImageGridView.svg?style=flat)](http://cocoapods.org/pods/ImageGridView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![alt text](https://github.com/miraan/ImageGridView/blob/master/Example/recording.gif "Drag and drop images, add and delete.")

## Usage

It's as simple as:

```swift
let imageGridView = ImageGridView(frame: self.imageGridViewContainer.bounds)
imageGridView.delegate = self
imageGridView.datasource = self
imageGridViewContainer.addSubview(imageGridView)
imageGridView.reload()
```

Just implement the delegate methods:

```swift
func imageGridView(_ imageGridView: ImageGridView, didTapDeleteForImage index: Int)
func imageGridViewDidTapAddImage(_ imageGridView: ImageGridView)
func imageGridView(_ imageGridView: ImageGridView, didMoveImage fromIndex: Int, toIndex: Int)
```

And the datasource method:

```swift
func imageGridViewImages(_ imageGridView: ImageGridView) -> [UIImage]
```

You can also set additional options to override the defaults:

```swift
imageGridView.maxCapacity = 7
```

## Installation

ImageGridView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ImageGridView'
```

## Author

miraan, miraan@triprapp.com

## License

ImageGridView is available under the MIT license. See the LICENSE file for more info.
