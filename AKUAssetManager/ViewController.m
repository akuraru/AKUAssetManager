//
//  ViewController.m
//  AKUAssetManager
//
//  Created by akuraru on 10/07/2014.
//  Copyright (c) 2014 akuraru. All rights reserved.
//

#import <AKUAssetManager/AKUImagePickerManager.h>
#import <AKUAssetManager/AKUAssetManager.h>
#import "ViewController.h"
#import "AKUAssetManager.h"
#import "AKUImagePickerManager.h"

@interface ViewController () <AKUImageManagerProtocol>
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(nonatomic, strong) AKUImagePickerManager *manager;
@end

@implementation ViewController

- (void)updateView {
    self.statusLabel.text = [self message:[AKUAssetManager status]];
}

- (NSString *)message:(ALAuthorizationStatus)status {
    return [AKUAssetManager stringForStatus:status];
}

- (IBAction)openSetting:(id)sender {
    if (8.0 <= [[[UIDevice currentDevice] systemVersion] doubleValue]) {
        [AKUAssetManager openSetting];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iOS7では開けません" message:nil delegate:nil cancelButtonTitle:@"確認" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)askForPermission:(id)sender {
    __weak typeof(self) this = self;
    [AKUAssetManager askForPermission:^(ALAuthorizationStatus status) {
        [this alert:status];
    }];
}

- (IBAction)openCamera:(id)sender {
    [self.manager openCameraWithDelegate:self item:nil view:sender];
}

- (IBAction)openPhoto:(id)sender {
    [self.manager openPhotoAlbumWithDelegate:self item:nil view:sender];
}

- (IBAction)chooseAsset:(id)sender {
    [self.manager selectViewToOpen:self item:nil view:sender];
}

- (void)alert:(ALAuthorizationStatus)status {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:[self message:status] message:nil delegate:nil cancelButtonTitle:@"確認" otherButtonTitles:nil];
    [view show];
    [self updateView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
    self.manager = [[AKUImagePickerManager alloc] init];
}
@end
