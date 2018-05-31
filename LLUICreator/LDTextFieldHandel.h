//
//  LDTextFieldHandel.h
//  SubProject
//
//  Created by lcus on 2018/4/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LDTextFieldHandel : NSObject

@property(nonatomic,strong,readonly) NSMutableString * dynamicString;

-(instancetype)initWithTextField:(UITextField*)textField NS_DESIGNATED_INITIALIZER;
//最大限制输入
-(void)setMaxLimitNumber:(NSUInteger)max;



-(void)ld_textFieldTextDidChangeWithUpdata:(void(^)(NSString* str))update;

-(void)ld_textFieldTextDidChangeWithUpdata:(void(^)(NSString* str))update fitter:(BOOL (^)(NSString *fitter))fitter;


-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;



@end
