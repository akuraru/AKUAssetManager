//
//  AKUAssetManager.m
//  AKUAssetManager
//
//  Created by akuraru on 10/07/2014.
//  Copyright (c) 2014 akuraru. All rights reserved.
//

#import "AKUAssetManager.h"

@interface AKUAssetManager ()
@end

@implementation AKUAssetManager {
}
+ (ALAuthorizationStatus)status {
    return [ALAssetsLibrary authorizationStatus];
}

+ (void)askForPermission:(void (^)(ALAuthorizationStatus))complete {
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusNotDetermined) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            *stop = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                complete([ALAssetsLibrary authorizationStatus]);
            });
        } failureBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete([ALAssetsLibrary authorizationStatus]);
            });
        }];
    } else {
        complete(status);
    }
}

+ (NSString *)stringForStatus:(ALAuthorizationStatus)status {
    switch (status) {
        case ALAuthorizationStatusNotDetermined:
            return @"まだ許可ダイアログ出たことない";
        case ALAuthorizationStatusRestricted:
            return @"機能制限(ペアレンタルコントロール)で許可されてない";
        case ALAuthorizationStatusDenied:
            if ([self iosVersionOver8]) {
                return @"許可ダイアログで\"いいえ\"が押されています\n"
                        "設定アプリ -> アプリ -> 写真を音にする必要があります。";
            } else {
                return @"許可ダイアログで\"いいえ\"が押されています\n"
                        "設定アプリ -> プライバシー -> 写真 -> 該当アプリを\"オン\"する必要があります";
            }
        case ALAuthorizationStatusAuthorized:
            return @"写真へのアクセスが許可されています";
    }
}

+ (void)openSetting {
    if ([self iosVersionOver8]) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (BOOL)iosVersionOver8 {
    return 8.0 <= [[[UIDevice currentDevice] systemVersion] doubleValue];
}
@end
