//
//  AKUImagePickerManager.m
//  LoveChildcare
//
//  Created by P.I.akura on 2013/06/17.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKUImagePickerManager.h"
#import "AKUAssetManager.h"
#import "AKUCaptureManager.h"

@interface AKUImagePickerManager ()
@property(nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation AKUImagePickerManager {
    UIPopoverController *imagePopController;
}

- (void)openCameraWithDelegate:(__weak id<AKUImageManagerProtocol>)this item:(UIBarButtonItem *)item view:(UIView *)view {
    __weak typeof(self) that = self;
    [AKUCaptureManager askForPermission:^(AVAuthorizationStatus status) {
        if (status == AVAuthorizationStatusAuthorized) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [that openCamera:this item:item view:view];
            } else {
                [that openErrorAlertWithString:[AKUCaptureManager stringForStatus:AVAuthorizationStatusRestricted] controller:this];
            }
        } else {
            [that openErrorAlertWithString:[AKUCaptureManager stringForStatus:status] controller:this];
        }
    }];
}

- (void)openCamera:(__weak id<AKUImageManagerProtocol>)this item:(UIBarButtonItem *)item view:(UIView *)view {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = this;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;

    self.imagePickerController.popoverPresentationController.barButtonItem = item;
    self.imagePickerController.popoverPresentationController.sourceView = view;
    self.imagePickerController.popoverPresentationController.sourceRect = view.bounds;

    [this presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)openPhotoAlbumWithDelegate:(__weak id<AKUImageManagerProtocol>)this item:(UIBarButtonItem *)item view:(UIView *)view {
    __weak typeof(self) that = self;
    [self askForPermission:^{
        [that openPhoto:this item:item view:view];
    }];
}

- (void)openPhoto:(__weak id<AKUImageManagerProtocol>)this item:(UIBarButtonItem *)item view:(UIView *)view {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = this;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    self.imagePickerController.popoverPresentationController.barButtonItem = item;
    self.imagePickerController.popoverPresentationController.sourceView = view;
    self.imagePickerController.popoverPresentationController.sourceRect = view.bounds;

    [this presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)dismissPickerView:(__weak id<AKUImageManagerProtocol>)this {
    if (imagePopController) {
        [imagePopController dismissPopoverAnimated:YES];
    } else {
        [this dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)selectViewToOpen:(__weak id<AKUImageManagerProtocol>)controller item:(UIBarButtonItem *)item view:(UIView *)view {
    __weak typeof(self) this = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"写真を撮影" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [this openCameraWithDelegate:controller item:item view:view];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"写真を選択" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [this openPhotoAlbumWithDelegate:controller item:item view:view];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:nil]];

    alertController.popoverPresentationController.barButtonItem = item;
    alertController.popoverPresentationController.sourceView = view;
    alertController.popoverPresentationController.sourceRect = view.bounds;

    [controller presentViewController:alertController animated:YES completion:nil];
}

- (void)openErrorAlertWithStatus:(ALAuthorizationStatus)status {
    NSString *title = [AKUAssetManager stringForStatus:status];
    [self openErrorAlertWithString:title controller:nil];
}

- (void)openErrorAlertWithString:(NSString *)message controller:(__weak id <AKUImageManagerProtocol>)controller {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"設定エラー" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"設定を開く" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AKUAssetManager openSetting];
    }]];
    [controller presentViewController:alertController animated:YES completion:nil];
}

- (void)askForPermission:(void (^)())complete {
    __weak typeof(self) this = self;
    [AKUAssetManager askForPermission:^(ALAuthorizationStatus status) {
        if (status == ALAuthorizationStatusAuthorized) {
            complete();
        } else {
            [this openErrorAlertWithStatus:status];
        }
    }];
}
@end
