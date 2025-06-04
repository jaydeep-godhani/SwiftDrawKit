# SwiftDrawKit

![GitHub repo size](https://img.shields.io/github/repo-size/jaydeep-godhani/SwiftDrawKit)
![GitHub stars](https://img.shields.io/github/stars/jaydeep-godhani/SwiftDrawKit?style=social)
![GitHub forks](https://img.shields.io/github/forks/jaydeep-godhani/SwiftDrawKit?style=social)
![Platform](https://img.shields.io/badge/platform-iOS%2013.0%2B-blue.svg?style=flat)
![Language](https://img.shields.io/badge/language-swift%205-4BC51D.svg?style=flat)
![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)

## Overview

SwiftDrawKit is a simple, light-weight drawing framework written in Swift. SwiftDrawKit is built using Core Gaphics and is very easy to implement.

## Requirements

- iOS 13.0+
- Swift 5
- Xcode 12 or higher

## Installation

This is an Xcode project, so you can directly clone or download the project into your workspace.

### Clone the Repository

```bash
git clone https://github.com/jaydeep-godhani/SwiftDrawKit.git
```
Alternatively, you can download the project as a ZIP file from the GitHub repository page.

### Integrating into Your Project

To integrate the `SwiftDrawView` into your own Xcode project:

1. Download or clone the repository.
2. Copy the contents of the `DrawKit` folder into your project.
3. Add `SwiftDrawView` to your storyboard or use it programmatically in your view controllers.

## Usage

Using SwiftDrawKit is very simple:

### Getting Started:

Create a SwiftDrawView and add it to your ViewController:

```swift
let drawView = SwiftDrawView(frame: self.view.frame)
self.view.addSubview(drawView)
```

By default, the view will automatically respond to touch gestures and begin drawing. The default brush is `.default`, which has a **black** color.

To disable drawing, simply set the `isEnabled` property to `false`:

```swift
drawView.isEnabled = false
```

## Brushes

For drawing, we use `Brush` to keep track of styles like `width`, `color`, etc.. We have multiple different default brushes, you can use as follows:

```swift
drawView.brush = Brush.default
```

The default brushed are:

```swift
public static var `default`: Brush { get } // black, width 3
public static var thin     : Brush { get } // black, width 2
public static var medium   : Brush { get } // black, width 7
public static var thick    : Brush { get } // black, width 10
public static var marker   : Brush { get } // flat red-ish, width 10
public static var eraser   : Brush { get } // clear, width 8; uses CGBlendMode to erase things
```

### Adjusted Width Factor

`SwiftDrawView` supports drawing-angle-adjusted brushes. This effectively means, if the user (using an Pencil) draws with the tip of the pencil, the brush will reduce its width a little. If the user draws at a very low angle, with the side of the pencil, the brush will be a little thicker.
You can modify this behavior by setting `adjustedWidthFactor` of a brush. If you increase the number (to, say, `5`) the changes will increase. If you reduce the number to `0`, the width will not be adjusted at all.
The default value is `1` which causes a slight de-/increase in width.

This is an opt-in feature. That means, in `shouldBeginDrawingIn`, you need to call `drawingView.brush.adjustWidth(for: touch)`.

## Further Customization:

For more customization, you can modify the different properties of a brush to fit your needs.

### Line Color:

The color of a line stroke can be changed by adjusting the `color` property of a brush. SwiftDrawKit accepts any `Color`:

```swift
drawView.brush.color = Color(.red)
```
    
<p align="center">
  or
</p>

```swift
drawView.brush.color = Color(UIColor(colorLiteralRed: 0.75, green: 0.50, blue: 0.88, alpha: 1.0))
```

We have our own implementation of `UIColor` – `Color` – to be able to de-/encode it.

### Line Width:

The width of a line stroke can be changed by adjusting the `width` property of a brush. SwiftDrawKit accepts any positive `CGFloat`:

```swift
drawView.brush.width = 5.0
```

### Line Opacity:

The opacity of a line stroke can be changed by adjusting the `lineOpacity` property. SwiftDrawKit accepts any `CGFloat` between `0` and `1`:

```swift
drawView.brush.opacity = 0.5
```
    
## Editing

### Clear All:

If you wish to clear the entire canvas, simply call the `clear` function:

```swift
drawView.clear()
``` 

### Drawing History:

```swift
drawView.undo()
``` 

...and redo:

```swift
drawView.redo()
``` 

To en-/disable custom un- & redo buttons, you can use `.canUndo` and `.canRedo`.

## Apple Pencil Integration
Apple Pencil can be used for drawing in a SwiftDrawView, just like a finger.  
Special features, however, regarding Apple Pencil 2 are only supported on iOS 12.1 and above versions.

### Apple Pencil 2 Double Tap action
#### Enable/ Disable pencil interaction
Apple Pencil interaction is enabled by default, but you can set `drawView.isPencilInteractive` to change that setting.
#### Pencil Events
When double tapping the pencil, SwiftDrawKit will check the user preferences set in the system. If the preference is set to switch to eraser, SwiftDrawKit will switch between normal and erasing mode; if set to last used tool, SwiftDrawKit will switch between current and previous brush.

## Delegate

SwiftDrawKit has delegate functions to notify you when a user is interacting with a SwiftDrawView. To access these delegate methods, have your View Controller conform to the `SwiftDrawViewDelegate` protocol:

```swift
class ViewController: UIViewController, SwiftDrawViewDelegate
```

### Delegate methods

```swift
func swiftDraw(shouldBeginDrawingIn drawingView: SwiftDrawView, using touch: UITouch) -> Bool

func swiftDraw(didBeginDrawingIn drawingView: SwiftDrawView, using touch: UITouch)

func swiftDraw(isDrawingIn drawingView: SwiftDrawView, using touch: UITouch)
    
func swiftDraw(didFinishDrawingIn drawingView: SwiftDrawView, using touch: UITouch)
    
func swiftDraw(didCancelDrawingIn drawingView: SwiftDrawView, using touch: UITouch)
```

---

## Contributions

We welcome contributions! If you find a bug, have an idea for a new extension, or want to improve the documentation, feel free to fork the repo and create a pull request.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
