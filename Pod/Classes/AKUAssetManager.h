//
//  AKUAssetManager.m
//  AKUAssetManager
//
//  Created by akuraru on 10/07/2014.
//  Copyright (c) 2014 akuraru. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "AKUBaseManager.h"

@interface AKUAssetManager : AKUBaseManager
+ (ALAuthorizationStatus)status;

+ (void)askForPermission:(void (^)(ALAuthorizationStatus))complete;

+ (NSString *)stringForStatus:(ALAuthorizationStatus)status;
@end