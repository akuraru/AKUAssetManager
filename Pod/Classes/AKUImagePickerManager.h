//
//  ImagePickerManager.h
//  LoveChildcare
//
//  Created by P.I.akura on 2013/06/17.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKUImagePickerManager : NSObject

- (void)openCameraWithDeledate:(__weak id)controller;

- (void)openPhotoAlbumWithDelegate:(__weak id)this inView:(UIView *)view;

- (void)openPickerController:(__weak id)this view:(UIView *)view imagePickerCtrl:(UIImagePickerController *)imagePickerCtrl;

- (void)dismissPickerView:(UIViewController *)controller;

- (void)selectViewToOpen:(__weak id)controller inView:(id)view;
@end
