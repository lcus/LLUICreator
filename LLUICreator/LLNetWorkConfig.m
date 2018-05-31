//
//  LLNetWorkConfig.m
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLNetWorkConfig.h"

@interface LLNetWorkGetConfig()

@property(nonatomic,strong) NSString * baserUrl;
@end

@implementation LLNetWorkGetConfig



-(instancetype)initWithUrl:(NSString*)url paramer:(NSDictionary*)paramer{
    
    return [self initWithURL:url paramer:paramer showHudView:nil errorHandel:[LLNetWorkErrorHandleWidget defaultHandle]];
};
-(instancetype)initWithURL:(NSString*)url paramer:(NSDictionary*)paramer showHudView:(UIView*)showHudView;{
    
     return [self initWithURL:url paramer:paramer showHudView:showHudView errorHandel:[LLNetWorkErrorHandleWidget defaultHandle]];
}
-(instancetype)initWithUrl:(NSString*)url paramer:(NSDictionary*)paramer errorHandel:(LLNetWorkErrorHandleWidget*)errorHandel{
    
        return [self initWithURL:url paramer:paramer showHudView:nil errorHandel:errorHandel];
};

-(instancetype)initWithURL:(NSString*)url paramer:(NSDictionary*)paramer showHudView:(UIView*)showHudView errorHandel:(LLNetWorkErrorHandleWidget*)errorHandel{
    
    self = [super init];
    if (self) {
        self.url = url;
        self.paramer = paramer;
        self.baserUrl =@"http://10.10.10.148/front/app/";
        self.error = errorHandel;
        self.tokenNeed = YES;
        self.cacheNeed = NO;
        self.showHudView = showHudView;
    }
    return self;
}

-(NSString*)url{
    
    return [NSString stringWithFormat:@"%@%@",_baserUrl,_url];
}




@end

@implementation LLNetWorkPostConfig


@end


