//
//  LLNetWorkWidget.m
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLNetWorkWidget.h"
#import "SVProgressHUD.h"

#define ld_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@implementation LLNetWorkEncryptWidget

-(NSDictionary *)ll_EncryptParamer:(NSDictionary *)paramer isNeedToken:(BOOL)isNeedToken{
    
    
    NSMutableDictionary *dict = [paramer mutableCopy];
    
    if (isNeedToken) {
        
        dict[@"token"] = @"app1364134245513641342455Bkr5Bq9F2YJZafOVkqkoJWRzT31j3Koz";
    }
    
    return dict;
}

@end

@implementation LLNetWorkCacheHandleWidget

-(NSDictionary *)ll_getCacheDataWithKey:(NSString *)key{
    
    return [NSDictionary dictionary];
}

-(void)ll_cacheDataWithKey:(NSString *)key{
    
    
}

@end

@interface LLNetWorkErrorHandleWidget ()


@property(nonatomic,strong) NSString * errorMessag;

@end

@implementation LLNetWorkErrorHandleWidget

+ (instancetype)defaultHandle{
    
    return (id)[[LLNetWorkErrorHandleWidget alloc]init];
    
}

-(void)ll_handleWithError:(NSError *)error view:(UIView *)view{
    
 
    void (^block)(void) =^{
        
       [SVProgressHUD showImage:nil status:[error localizedDescription]];
    };
    
    ld_dispatch_main_async_safe(block)

}

-(void)ll_handleWithWrongResponse:(NSDictionary *)dict view:(UIView *)view{
    
    if (!dict) return;
    
    self.errorCode = [dict[@"errorcode"] integerValue];
    self.errorMessag = dict[@"msg"];
    
   [SVProgressHUD showImage:nil status:self.errorMessag];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


@end
