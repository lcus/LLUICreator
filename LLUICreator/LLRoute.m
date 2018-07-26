//
//  LLRoute.m
//  JLRDemo
//
//  Created by lcus on 2018/7/25.
//  Copyright © 2018年 yuhao. All rights reserved.
//

#import "LLRoute.h"

@import ObjectiveC.runtime;
@import ObjectiveC.message;


#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define UNLOCK(lock) dispatch_semaphore_signal(lock);

@interface LLRoute ()

@property(nonatomic,strong) NSMutableDictionary * clazz;
@property(nonatomic,strong) dispatch_semaphore_t semaphore;

@end


@implementation LLRoute

+ (instancetype)shareInstance
{
    static LLRoute *route;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        route = [[LLRoute alloc] init];
    });
    return route;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.clazz =[NSMutableDictionary dictionary];
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}


-(void)registerClassWithParamers:(NSDictionary *)paramers{
    
    if (!paramers.count) return;
 
    LOCK(self.semaphore);
    [self.clazz addEntriesFromDictionary:paramers];
    UNLOCK(self.semaphore);
}

-(UIViewController *)ll_controllerWithKey:(NSString *)key paramer:(NSDictionary *)paramer{
    
    NSAssert(key.length!=0, @"key Invalid");
   
    Class viewControllerClass = NSClassFromString(self.clazz[key]);

    if (!viewControllerClass) {
        LOCK(self.semaphore);
        [self.clazz removeObjectForKey:key];
        UNLOCK(self.semaphore);
    }
    return [self ll_controllerWithClazz:viewControllerClass paramer:paramer];
}

- (UIViewController *)ll_controllerWithClazz:(Class)clazz paramer:(NSDictionary *)paramer{
    
    NSAssert(clazz != nil, @"class not found");
    Class viewControllerClass = clazz;
    id  controller =[[viewControllerClass alloc]init];
    if (![[controller class] isSubclassOfClass:[UIViewController class]]) return nil;
    [self ll_setPropertyWithTarget:controller paramers:paramer];
    
    return controller;
}

-(void)ll_presentController:(UIViewController *)present key:(NSString *)key paramer:(NSDictionary *)paramer{
    
    UIViewController *controller =[[LLRoute shareInstance]ll_controllerWithKey:key paramer:paramer];
    
    if (present.navigationController) {
        
        [present.navigationController pushViewController:controller animated:YES];
    }
    
}
-(void)ll_presentController:(UIViewController *)present clazz:(Class)clazz paramer:(NSDictionary *)paramer{
    
    UIViewController *controller =[[LLRoute shareInstance]ll_controllerWithClazz:clazz paramer:paramer];
    if (present.navigationController) {
        
        [present.navigationController pushViewController:controller animated:YES];
    }
}

+(void)ll_openWithURL:(NSURL*)url{
    
//    NSString *scheme = url.scheme;
    
    
    
}

+(void)ll_messageToTarget:(id)target action:(NSString *)action{
    
    [self ll_messageToTarget:target action:action paramer:nil callBack:nil];
}

+(void)ll_messageToTarget:(id)target action:(NSString *)action callBack:(void *)callBack{
    
    int (*func)(id,SEL,void(*))=(__typeof__(func))objc_msgSend;
    
    SEL actionSel = NSSelectorFromString(action);
    
    if ([target respondsToSelector:actionSel]) {
        
        func(target,actionSel,callBack);
    }else{
        
#ifdef DEBUG
        NSLog(@"%@ 没有实现方法 %@",[target class],action);
        
#endif
    }
    
}

+(void)ll_messageToTarget:(id)target action:(NSString *)action paramer:(NSDictionary *)paramer{
    
    [self ll_messageToTarget:target action:action paramer:paramer callBack:nil];
    
}

+(void)ll_messageToTarget:(id)target action:(NSString *)action paramer:(NSDictionary *)paramer callBack:(void*)callBack{
    
    
    int (*func)(id,SEL,id,void(*))=(__typeof__(func))objc_msgSend;
    
    SEL actionSel = NSSelectorFromString(action);
    
    if ([target respondsToSelector:actionSel]) {
        
        func(target,actionSel,paramer,callBack);
    }else{
       
#ifdef DEBUG
        NSLog(@"%@ 没有实现方法 %@",[target class],action);
        
#endif
        
    }
}

-(void)ll_setPropertyWithTarget:(id)target paramers:(NSDictionary*)paramers{
   
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(object_getClass(target), &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = paramers[key];
        if (param != nil) {
            [target setValue:param forKey:key];
        }
    }
}







@end
