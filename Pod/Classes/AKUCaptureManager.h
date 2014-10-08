//
// Created by akuraru on 2014/10/08.
// Copyright (c) 2014 akuraru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AKUBaseManager.h"

@interface AKUCaptureManager : AKUBaseManager

+ (AVAuthorizationStatus)status;

+ (void)askForPermission:(void (^)(AVAuthorizationStatus))complete;

+ (NSString *)stringForStatus:(AVAuthorizationStatus)status;
@end
