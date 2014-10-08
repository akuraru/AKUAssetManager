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

+ (void)askForPermission:(void (^)(AVAuthorizationStatus)) complete {
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

+ (NSString *)stringForStatus:(AVAuthorizationStatus) status {
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            return @"カメラへのアクセスダイアログ出たことない";
        case AVAuthorizationStatusRestricted:
            return @"機能制限(ペアレンタルコントロール)によりカメラへのアクセスが許可されていません。";
        case AVAuthorizationStatusDenied:{
            NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
            return [NSString stringWithFormat:@"カメラへのアクセスが許可されていません。\n"
                                                  "設定アプリ → プライバシー → カメラ → %@ を許可してください。",
                                              appName];
        }
        case AVAuthorizationStatusAuthorized:
            return @"カメラへのアクセスが許可されています";
    }
    return nil;
}
@end
