//
//  LLViewCreator.h
//  LearnSD
//
//  Created by lcus on 2018/5/10.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LLWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LLStrongSelf(type)  __strong typeof(type) type = weak##type;

@interface LLViewCreator : NSObject

@property(nonatomic,strong,readonly) UIView * targetView;

@property(nonatomic,copy,readonly) LLViewCreator * (^superview)(UIView *superview);
@property(nonatomic,copy,readonly) LLViewCreator * (^backgroundColor)(UIColor *backgroundColor);
@property(nonatomic,copy,readonly) LLViewCreator * (^frame)(CGRect frame);
@property(nonatomic,copy,readonly) LLViewCreator * (^borderWidth)(CGFloat borderWidth);
@property(nonatomic,copy,readonly) LLViewCreator * (^borderColor)(UIColor*borderColor);
@property(nonatomic,copy,readonly) LLViewCreator * (^cornerRadius)(CGFloat cornerRadius);
@property(nonatomic,copy,readonly) LLViewCreator * (^masksToBounds)(BOOL masksToBounds);
@property(nonatomic,copy,readonly) LLViewCreator * (^maskView)(UIView* maskView);

@end

@interface UIView (LLViewCreator)
//view class or subclass of View
+(UIView*)ll_viewMaker:(void(^)(LLViewCreator *maker))maker ;


+(instancetype)ll_viewMakeWithViewClass:(Class)viewClass maker:(void(^)(LLViewCreator*maker))maker;

@end
