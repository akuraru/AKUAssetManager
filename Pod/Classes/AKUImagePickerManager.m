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

@implementation AKUImagePickerManager {
    UIPopoverController *imagePopController;
}

- (void)openCameraWithDelegate:(__weak id)controller {
    __weak typeof(self) this = self;
    [self askForPermission:^{
        [this openCamera:controller];
    }];
}

- (void)openCamera:(__weak id)this {
    UIImagePickerController *imagePickerCtrl = [[UIImagePickerController alloc] init];
    [imagePickerCtrl setDelegate:this];
    imagePickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    [this presentViewController:imagePickerCtrl animated:YES completion:nil];
}

- (void)openPhotoAlbumWithDelegate:(__weak id)controller inView:(UIView *)view {
    __weak typeof(self) this = self;
    [self askForPermission:^{
        [this openPhoto:controller inView:view];
    }];
}

- (void)openPhoto:(__weak id)this inView:(UIView *)view {
    UIImagePickerController *imagePickerCtrl = [self imagePicker:this];
    [self openPickerController:this view:view imagePickerCtrl:imagePickerCtrl];
}

- (void)openPickerController:(__weak id)this view:(UIView *)view imagePickerCtrl:(UIImagePickerController *)imagePickerCtrl {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        imagePopController = [[UIPopoverController alloc] initWithContentViewController:imagePickerCtrl];
        [imagePopController presentPopoverFromRect:view.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [this presentViewController:imagePickerCtrl animated:YES completion:nil];
    }
}

- (UIImagePickerController *)imagePicker:(id)this {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = this;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return imagePickerController;
}

- (void)dismissPickerView:(UIViewController *)this {
    if (imagePopController) {
        [imagePopController dismissPopoverAnimated:YES];
    } else {
        [this dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)selectViewToOpen:(__weak id)controller inView:(id)view {
    [self askForPermission:^{
        CCActionSheet *sheet = [self createSheet:controller view:view];
        [sheet showInView:[controller view]];
    }];
}

- (void)openErrorAlert:(ALAuthorizationStatus)status {
    CCAlertView *view = [[CCAlertView alloc] initWithTitle:[AKUAssetManager stringForStatus:status] message:nil];
    [view addButtonWithTitle:@"確認" block:^{
    }];
    if ([AKUAssetManager iosVersionOver8]) {
        [view addButtonWithTitle:@"設定" block:^{
            [AKUAssetManager openSetting];
        }];
    }
    [view show];
}

- (CCActionSheet *)createSheet:(__weak id)controller view:(id)view {
    __weak typeof(self) this = self;
    CCActionSheet *sheet = [[CCActionSheet alloc] initWithTitle:nil];
    [sheet addButtonWithTitle:@"写真を撮影" block:^{
        [this openCameraWithDelegate:controller];
    }];
    [sheet addButtonWithTitle:@"写真を選択" block:^{
        [this openPhotoAlbumWithDelegate:controller inView:view];
    }];
    [sheet addCancelButtonWithTitle:@"キャンセル"];
    return sheet;
}

- (void)askForPermission:(void(^)())complete {
    __weak typeof(self) this = self;
    [AKUAssetManager askForPermission:^(ALAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == ALAuthorizationStatusAuthorized) {
                complete();
            } else {
                [this openErrorAlert:status];
            }
        });
    }];
}
@end
