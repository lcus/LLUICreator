//
//  NSObject+MethodCollection.m
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "NSObject+MethodCollection.h"
#import <CommonCrypto/CommonDigest.h>

@import ObjectiveC.message;
@import ObjectiveC.runtime;

@implementation NSObject (MethodCollection)



void LD_callBlackMessage(id target,NSString*actionName,id pramer,void(*callback)){
    
    
    int (*func)(id,SEL,id,void(*))=(__typeof__(func))objc_msgSend;
    
    
    
    SEL action = NSSelectorFromString(actionName);
    
    if ([target respondsToSelector:action]) {
        
        func(target,action,pramer,callback);
    }else{
        if (DEBUG) {
            NSLog(@"%@ 没有实现方法 %@",[target class],actionName);
        }
    }
}
void LD_addSubViews(UIView *target,NSArray<UIView*>* views){
    
    for (UIView*temp in views) {
        
        [target addSubview:temp];
    }
}

UIColor* LD_color(CGFloat r, CGFloat g,CGFloat b,CGFloat a){
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

UIFont *LD_sysFont(CGFloat size){
    
    return [UIFont systemFontOfSize:size];
}
UIFont *LD_sysBoldFont(CGFloat size){
    
    return [UIFont boldSystemFontOfSize:size];
}

BOOL LD_validateEmail(NSString *email){
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

BOOL LD_validatePhone(NSString *phoneNumber){
    NSString *phoneRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

BOOL LD_emptyString(NSString *string){
    
    if (string == nil || string == NULL||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

BOOL LD_emptyArray(NSArray * array){
    
    if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
        
        return NO;
    }
    return YES;
}

BOOL LD_emptyDiction(NSDictionary *dict){
    
    if (dict != nil && ![dict isKindOfClass:[NSNull class]] && dict.count != 0){
        return NO;
    }
    return YES;
}

UIColor* LD_RandomColor(){
    
    return [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                      saturation:( arc4random() % 128 / 256.0 ) + 0.5
                      brightness:( arc4random() % 128 / 256.0 ) + 0.5
                           alpha:1];
};

NSString *LD_homePath(){
    
    return NSHomeDirectory();
}
NSString *LD_documentPaht(){
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
NSString *LD_libraryPath(){
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
NSString *LD_cachePath(){
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return  [paths objectAtIndex:0];
}
NSString *LD_tempPath(){
    
    return NSTemporaryDirectory();
}

NSString *LD_md5(NSString *str){
    
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]
            ];
}

NSString *LD_random32char(){
    
    char data[31];
    for (int x=0;x<31;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *str=[[NSString alloc] initWithBytes:data length:31 encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"1%@",str];
}


void LD_userDefaultsSaveValue(NSString *key,id value){
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
id  LD_userDefaultGetValue(NSString*key){
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

@end
