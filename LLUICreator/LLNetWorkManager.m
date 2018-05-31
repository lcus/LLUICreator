//
//  LLNetWorkManager.m
//  SubProject
//
//  Created by lcus on 2018/5/18.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLNetWorkManager.h"
#import "LLNetWorkWidget.h"
#import "AFNetworking.h"
@interface LLNetWorkManager ()

@property(nonatomic,strong) LLNetWorkEncryptWidget * encrypt;
@property(nonatomic,strong) LLNetWorkCacheHandleWidget * cache;
@property(nonatomic,strong) AFHTTPSessionManager * sessionManager;

@end

@implementation LLNetWorkManager

+(instancetype)shareManager{
    
    static LLNetWorkManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc]init];
      
        manager.encrypt =[LLNetWorkEncryptWidget new];
        manager.cache =[LLNetWorkCacheHandleWidget new];
        manager.sessionManager =[AFHTTPSessionManager manager];
        manager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
//        [manager.sessionManager.reachabilityManager startMonitoring];
        
    });
    
    return manager;
}

-(void)ll_requestWithConfig:(LLNetWorkGetConfig *)config
                  cacheData:(void(^)(NSDictionary *))cacheData
                   progress:(void (^)(NSProgress *))progress
                    success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success{
    
    
    NSDictionary *paramer =[self.encrypt ll_EncryptParamer:config.paramer isNeedToken:config.tokenNeed];
    
    if (cacheData) {
       NSDictionary*tempData =[self.cache ll_getCacheDataWithKey:config.url];
       tempData?cacheData(tempData):nil;
    }
    
    if (self.sessionManager.reachabilityManager.reachable) {
        
        [self.sessionManager POST:config.url parameters:paramer progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject[@"msg"]);
            
            if (responseObject[@"success"]) {
                
                success(task,responseObject);
            }else{
                
                [config.error ll_handleWithWrongResponse:responseObject view:config.showHudView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [config.error ll_handleWithError:error view:config.showHudView];
        }];
    }else{
        
        [config.error ll_handleWithError:[NSError errorWithDomain:@"网络无链接" code:-1024 userInfo:@{NSLocalizedDescriptionKey:@"网络无连接请稍后再试"}] view:config.showHudView];
    }
    
}

-(void)ll_uploadWithConig:(LLNetWorkPostConfig *)config progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success{
    
    NSDictionary *paramer =[self.encrypt ll_EncryptParamer:config.paramer isNeedToken:config.tokenNeed];
    
    [self.sessionManager POST:config.url parameters:paramer constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
      
        
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(void)ll_downLoadWithConig:(LLNetWorkGetConfig *)config progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, NSDictionary *))success{
    
    
    NSURL *url =[NSURL URLWithString:config.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [self.sessionManager downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fullpath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
//        NSLog(@"fullpath == %@",fullpath);
        return [NSURL fileURLWithPath:fullpath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
    
        
    }];
    
}







@end
