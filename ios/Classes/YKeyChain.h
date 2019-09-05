//
//  YKeyChain.h
//  ReadBrowser
//
//  Created by niko on 15/1/6.
//  Copyright (c) 2015年 YangYiYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface YKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

+(NSString *)identifierForVendor;

@end
