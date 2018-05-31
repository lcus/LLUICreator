//
//  UIViewController+LLNetWork.h
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLNetWorkConfig.h"
@interface UIViewController (LLNetWork)

-(void)ll_requestWithConnfig:(LLNetWorkGetConfig*)config success:(void(^)(NSURLSessionDataTask *, NSDictionary *))success ;

-(void)ll_requestWithConnfig:(LLNetWorkGetConfig *)config cache:(void(^)(NSDictionary *))cache success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success;

-(void)ll_uploadWithConfig:(LLNetWorkPostConfig *)congig success:(NSArray*)success;

-(void)ll_uploadWithConfig:(LLNetWorkPostConfig *)congig progress:(void(^)(NSProgress*))process success:(NSArray *)success;
//
//
//-(void)ll_downloadWithConfig:(LLNetWorkPostConfig *)congig progress:(void(^)(NSProgress*))process success:(NSArray *)success;


@end
