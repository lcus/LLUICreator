//
//  LLNetWorkConfig.h
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLNetWorkWidget.h"

@interface LLNetWorkGetConfig : NSObject

@property(nonatomic,strong) NSString     * url;
@property(nonatomic,strong) NSDictionary * paramer;
@property(nonatomic,strong) UIView       * showHudView;
@property(nonatomic,assign) BOOL         tokenNeed;
@property(nonatomic,assign) BOOL         cacheNeed;
@property(nonatomic,strong) LLNetWorkErrorHandleWidget * error;



-(instancetype)initWithUrl:(NSString*)url paramer:(NSDictionary*)paramer;
-(instancetype)initWithURL:(NSString*)url paramer:(NSDictionary*)paramer showHudView:(UIView*)showHudView;

-(instancetype)initWithUrl:(NSString*)url paramer:(NSDictionary*)paramer errorHandel:(LLNetWorkErrorHandleWidget*)errorHandel;

-(instancetype)initWithURL:(NSString*)url paramer:(NSDictionary*)paramer showHudView:(UIView*)showHudView errorHandel:(LLNetWorkErrorHandleWidget*)errorHandel;


@end

@interface LLNetWorkPostConfig : LLNetWorkGetConfig

@property(nonatomic,strong) NSArray<NSDictionary<NSString*,UIImage*>*> * postValues;
//压缩比
@property(nonatomic,assign) CGFloat compressionRatio;

@end
