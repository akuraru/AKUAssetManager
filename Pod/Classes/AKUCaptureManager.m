//
// Created by akuraru on 2014/10/08.
// Copyright (c) 2014 akuraru. All rights reserved.
//

#import "AKUCaptureManager.h"

@interface AKUCaptureManager ()
@end

@implementation AKUCaptureManager {
}
+ (AVAuthorizationStatus)status {
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

+ (void)askForPermission:(void (^)(AVAuthorizationStatus))complete {
    AVAuthorizationStatus status = [self status];
    if (status == AVAuthorizationStatusNotDetermined) {
        __weak typeof(self) this = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete([this status]);
            });
        }];
    } else {
        complete(status);
    }
}

+ (NSString *)stringForStatus:(AVAuthorizationStatus)status {
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            return @"まだ許可ダイアログ出たことない";
        case AVAuthorizationStatusRestricted:
            return @"機能制限(ペアレンタルコントロール)で許可されてない";
        case AVAuthorizationStatusDenied:
            if ([self iosVersionOver8]) {
                return @"許可ダイアログで\"いいえ\"が押されています\n"
                        "設定アプリ -> アプリ -> カメラをオンにする必要があります。";
            } else {
                return @"許可ダイアログで\"いいえ\"が押されています\n"
                        "設定アプリ -> プライバシー -> カメラ -> 該当アプリを\"オン\"する必要があります";
            }
        case AVAuthorizationStatusAuthorized:
            return @"カメラへのアクセスが許可されています";
    }
}
@end
