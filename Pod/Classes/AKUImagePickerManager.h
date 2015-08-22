//
//  ImagePickerManager.h
//  LoveChildcare
//
//  Created by P.I.akura on 2013/06/17.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKUImageManagerProtocol <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,retain) UIView *view;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;
@end

@interface AKUImagePickerManager : NSObject

// Open the camera roll.
// If the terminal where the camera does not have, and does not do anything.
// If the camera is not allowed, it will show the alert. In the case of iOS8 later, it will prompt to open the setting.
- (void)openCameraWithDelegate:(__weak id<AKUImageManagerProtocol>)this;

// It will open the Photo Album.
// If the Photo Album is not allowed, it will show the alert. In the case of iOS8 later, it will prompt to open the setting.
- (void)openPhotoAlbumWithDelegate:(__weak id<AKUImageManagerProtocol>)this inView:(UIView *)view;

// It is displayed in UIPopoverController as needed UIImagePickerController.
- (void)openPickerController:(__weak id<AKUImageManagerProtocol>)this view:(UIView *)view imagePickerCtrl:(UIImagePickerController *)imagePickerCtrl;

// Hide the ViewController that was displayed in openPickerController:view:imagePickerCtrl:.
- (void)dismissPickerView:(__weak id<AKUImageManagerProtocol>)this;

// View the UIActionSheet, and then select whether from camera or album to get a photo.
- (void)selectViewToOpen:(__weak id<AKUImageManagerProtocol>)this inView:(id)view;
@end
