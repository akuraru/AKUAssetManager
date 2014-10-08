# AKUAssetManager

[![Version](https://img.shields.io/cocoapods/v/AKUAssetManager.svg?style=flat)](http://cocoadocs.org/docsets/AKUAssetManager)
[![License](https://img.shields.io/cocoapods/l/AKUAssetManager.svg?style=flat)](http://cocoadocs.org/docsets/AKUAssetManager)
[![Platform](https://img.shields.io/cocoapods/p/AKUAssetManager.svg?style=flat)](http://cocoadocs.org/docsets/AKUAssetManager)

Easy to check authorizationStatus of Camera/Photo.

if not allow to access camera or photo, this library show warning alert.

![screenshot](http://monosnap.com/image/EogZjR69i2R0GwSs4zKCR8CAEeFfS4.png)

## Feature

- Easy to check authorizationStatus of Camera/Photo.
- iPad support
- Jump to app's config directly (iOS8〜)

## Usage

Try to example project : `pod try AKUAssetManager`

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[AKUImagePickerManager alloc] init];
}
// if allow to use camera, present UIImagePickerController
- (IBAction)openCamera:(id)sender {
    [self.manager openCameraWithDelegate:self];
}
// if allow to use photo, open UIImagePickerController
- (IBAction)openPhoto:(id)sender {
    [self.manager openPhotoAlbumWithDelegate:self inView:sender];
}
```

## Installation

AKUAssetManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "AKUAssetManager"


## TODO

- Localization

## Author

akuraru, akuraru@gmail.com

## License

AKUAssetManager is available under the MIT license. See the LICENSE file for more info.

