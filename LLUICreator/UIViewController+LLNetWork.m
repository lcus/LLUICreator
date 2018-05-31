//
//  UIViewController+LLNetWork.m
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "UIViewController+LLNetWork.h"
#import "LLNetWorkManager.h"

@implementation UIViewController (LLNetWork)


-(void)ll_requestWithConnfig:(LLNetWorkGetConfig *)config success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success{
    
    [[LLNetWorkManager shareManager]ll_requestWithConfig:config cacheData:nil progress:nil success:success];
}

-(void)ll_requestWithConnfig:(LLNetWorkGetConfig *)config cache:(void(^)(NSDictionary *))cache success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success{
    
     [[LLNetWorkManager shareManager]ll_requestWithConfig:config cacheData:nil progress:nil success:success];
}

-(void)ll_uploadWithConfig:(LLNetWorkPostConfig *)congig success:(NSArray *)success{
    
//    [[LLNetWorkManager shareManager]ll_uploadWithConig:congig progress:nil success:success];
}

-(void)ll_uploadWithConfig:(LLNetWorkPostConfig *)congig progress:(void (^)(NSProgress *))process success:(NSArray *)success{
    
//    [[LLNetWorkManager shareManager]ll_uploadWithConig:congig progress:process success:success];
}



@end
