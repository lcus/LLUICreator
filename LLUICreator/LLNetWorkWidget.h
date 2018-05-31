//
//  LLNetWorkWidget.h
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLNetWorkEncryptWidget : NSObject

-(NSDictionary*)ll_EncryptParamer:(NSDictionary*)paramer isNeedToken:(BOOL)isNeedToken;


@end

@interface LLNetWorkErrorHandleWidget : NSObject

@property(nonatomic,assign) NSInteger  errorCode;


+(instancetype)defaultHandle;

-(void)ll_handleWithError:(NSError*)error view:(UIView*)view;

-(void)ll_handleWithWrongResponse:(NSDictionary*)dict view:(UIView*)view;

@end

@interface LLNetWorkCacheHandleWidget : NSObject

-(void)ll_cacheDataWithKey:(NSString*)key;

-(NSDictionary*)ll_getCacheDataWithKey:(NSString*)key;


@end




