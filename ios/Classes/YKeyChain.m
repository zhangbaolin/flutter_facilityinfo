//
//  YKeyChain.m
//  ReadBrowser
//
//  Created by niko on 15/1/6.
//  Copyright (c) 2015年 YangYiYu. All rights reserved.
//

#import "YKeyChain.h"

@implementation YKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            
            service, (__bridge id)kSecAttrService,
            
            service, (__bridge id)kSecAttrAccount,
            
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            
            nil];
    
}



+ (void)save:(NSString *)service data:(id)data {
    
    //Get search dictionary
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Delete old item before add new item
    
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    
    SecItemAdd((CFDictionaryRef)CFBridgingRetain(keychainQuery), NULL);
    
}



+ (id)load:(NSString *)service {
    
    id ret = nil;
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Configure the search setting
    
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        
        @try {
            
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
            
        } @catch (NSException *e) {
            
//            DebugLog(@"Unarchive of %@ failed: %@", service, e);
            
        } @finally {
            
        }
        
    }
    
    if (keyData)
        
        CFRelease(keyData);
    
    return ret;  
    
}  



+ (void)delete:(NSString *)service {  
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];  
    
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);  
    
}

+(NSString *)identifierForVendor{
    
    NSString * key  = [NSString stringWithFormat:@"%@.uuid",[[NSBundle mainBundle]bundleIdentifier] ];
    
    NSString * idstring = [self load:key];
    
    if(idstring && idstring !=0){
        return idstring;
    }
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    [self save:key data:identifierForVendor];
    
    return identifierForVendor;
}

@end
