//
//  LLNetWorkManager.h
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLNetWorkConfig.h"
#import "LLNetWorkWidget.h"

@interface LLNetWorkManager : NSObject


+(instancetype)shareManager;



-(void)ll_requestWithConfig:(LLNetWorkGetConfig *)config
                  cacheData:(void(^)(NSDictionary *))cacheData
                   progress:(void(^)(NSProgress *progress))progress
                    success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success;



-(void)ll_uploadWithConig:(LLNetWorkPostConfig*)config
                 progress:(void(^)(NSProgress *progress))progress
                  success:(void(^)(NSURLSessionDataTask *task,NSDictionary*responseObject))success;



-(void)ll_downLoadWithConig:(LLNetWorkGetConfig*)config
                   progress:(void(^)(NSProgress *progress))progress
                    success:(void(^)(NSURLSessionDataTask *task,NSDictionary*responseObject))success;

@end
