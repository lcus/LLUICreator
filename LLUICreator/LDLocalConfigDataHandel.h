//
//  LDLocalConfigDataHandel.h
//  SubProject
//
//  Created by lcus on 2018/4/16.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDLocalConfigDataHandel : NSObject



+(NSArray*)LD_getLocalDataWithFiele:(NSString*)file fileKey:(NSString*)fileKey valueKey:(NSString*)valueKey;

+(NSArray*)LD_getLocalDataWithFile:(NSString*)file key:(NSString*)key;

+(NSArray*)LD_handelData:(NSArray<NSArray*>*)data jsonData:(NSDictionary*)json keyPath:(NSString*)keyPath;

+(NSArray*)LD_enumItemToMutial:(NSArray*)data;

+(NSArray*)LD_instertToMutialValue:(NSArray*)data key:(NSString*)keyPath;

+(NSArray*)LD_instertToMutialValue:(NSArray *)data keys:(NSArray<NSString*>*)keys;

@end
