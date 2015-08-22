//
//  AKUImagePickerManager.m
//  LoveChildcare
//
//  Created by P.I.akura on 2013/06/17.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "AKUImagePickerManager.h"
#import "CCActionSheet.h"
#import "AKUAssetManager.h"
#import "CCAlertView.h"
#import "AKUCaptureManager.h"

@interface AKUImagePickerManager ()
@property(nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation AKUImagePickerManager {
    UIPopoverController *imagePopController;
}

- (void)openCameraWithDelegate:(__weak id<AKUImageManagerProtocol>)this {
    __weak typeof(self) that = self;
    [AKUCaptureManager askForPermission:^(AVAuthorizationStatus status) {
        if (status == AVAuthorizationStatusAuthorized) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [that openCamera:this];
            } else {
                [that openErrorAlertWithString:[AKUCaptureManager stringForStatus:AVAuthorizationStatusRestricted]];
            }
        } else {
            [that openErrorAlertWithString:[AKUCaptureManager stringForStatus:status]];
        }
    }];
}

- (void)openCamera:(__weak id<AKUImageManagerProtocol>)this {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = this;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [this presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)openPhotoAlbumWithDelegate:(__weak id<AKUImageManagerProtocol>)this inView:(UIView *)view {
    __weak typeof(self) that = self;
    [self askForPermission:^{
        [that openPhoto:this inView:view];
    }];
}

- (void)openPhoto:(__weak id<AKUImageManagerProtocol>)this inView:(UIView *)view {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = this;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self openPickerController:this view:view imagePickerCtrl:self.imagePickerController];
}

- (void)openPickerController:(__weak id<AKUImageManagerProtocol>)this view:(UIView *)view imagePickerCtrl:(UIImagePickerController *)imagePickerCtrl {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imagePopController = [[UIPopoverController alloc] initWithContentViewController:imagePickerCtrl];
        [imagePopController presentPopoverFromRect:view.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [this presentViewController:imagePickerCtrl animated:YES completion:nil];
    }
}

- (void)dismissPickerView:(__weak id<AKUImageManagerProtocol>)this {
    if (imagePopController) {
        [imagePopController dismissPopoverAnimated:YES];
    } else {
        [this dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)selectViewToOpen:(__weak id<AKUImageManagerProtocol>)controller inView:(id)view {
    CCActionSheet *sheet = [self createSheet:controller view:view];
    [sheet showInView:[controller view]];
}

- (void)openErrorAlertWithStatus:(ALAuthorizationStatus)status {
    NSString *title = [AKUAssetManager stringForStatus:status];
    [self openErrorAlertWithString:title];
}

- (void)openErrorAlertWithString:(NSString *) message {
    CCAlertView *view = [[CCAlertView alloc] initWithTitle:@"設定エラー" message:message];
    [view addButtonWithTitle:@"確認" block:^{
    }];
    if ([AKUAssetManager iosVersionOver8]) {
        [view addButtonWithTitle:@"設定を開く" block:^{
            [AKUAssetManager openSetting];
        }];
    }
    [view show];
}

- (CCActionSheet *)createSheet:(__weak id)controller view:(id)view {
    __weak typeof(self) this = self;
    CCActionSheet *sheet = [[CCActionSheet alloc] initWithTitle:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addButtonWithTitle:@"写真を撮影" block:^{
            [this openCameraWithDelegate:controller];
        }];
    }
    [sheet addButtonWithTitle:@"写真を選択" block:^{
        [this openPhotoAlbumWithDelegate:controller inView:view];
    }];
    [sheet addCancelButtonWithTitle:@"キャンセル"];
    return sheet;
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
