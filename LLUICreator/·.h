//
//  LLRoute.h
//  JLRDemo
//
//  Created by lcus on 2018/7/25.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface LLRoute : NSObject


+(instancetype)shareInstance;


-(void)registerClassWithParamers:(NSDictionary*)paramers;


-(UIViewController*)ll_controllerWithKey:(NSString*)key paramer:(NSDictionary*)paramer;

-(UIViewController*)ll_controllerWithClazz:(Class)clazz paramer:(NSDictionary*)paramer;

-(void)ll_presentController:(UIViewController*)present key:(NSString*)key paramer:(NSDictionary*)paramer;
-(void)ll_presentController:(UIViewController *)present clazz:(Class)clazz paramer:(NSDictionary *)paramer;

//远程调用
+(void)ll_openWithURL:(NSURL*)url;


+(void)ll_messageToTarget:(id)target action:(NSString*)action;
+(void)ll_messageToTarget:(id)target action:(NSString*)action callBack:(void*)callBack;
+(void)ll_messageToTarget:(id)target action:(NSString*)action paramer:(NSDictionary*)paramer;
+(void)ll_messageToTarget:(id)target action:(NSString*)action paramer:(NSDictionary*)paramer callBack:(void*)callBack;



@end
