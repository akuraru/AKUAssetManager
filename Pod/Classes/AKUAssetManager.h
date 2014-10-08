//
//  AKUAssetManager.m
//  AKUAssetManager
//
//  Created by akuraru on 10/07/2014.
//  Copyright (c) 2014 akuraru. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface AKUAssetManager : NSObject
+ (ALAuthorizationStatus)status;

+ (void)askForPermission:(void (^)(ALAuthorizationStatus))complete;

+ (NSString *)stringForStatus:(ALAuthorizationStatus)status;

+ (void)openSetting NS_AVAILABLE_IOS(8_0);

+ (BOOL)iosVersionOver8;
@end