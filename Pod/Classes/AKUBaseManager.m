//
// Created by akuraru on 2014/10/08.
// Copyright (c) 2014 akuraru. All rights reserved.
//

#import "AKUBaseManager.h"

@interface AKUBaseManager ()
@end

@implementation AKUBaseManager {
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
