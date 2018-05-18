//
//  LLButtonCreator.h
//  LearnSD
//
//  Created by lcus on 2018/5/11.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLViewCreator.h"

typedef NS_ENUM(NSInteger, LLAdjustDriection) {
    LLAdjustDriectionLeft = 0,              //图片在左，文字在右，默认
    LLAdjustDriectionRight = 1,             //图片在右，文字在左
    LLAdjustDriectionTop = 2,               //图片在上，文字在下
    LLAdjustDriectionBottom = 3,            //图片在下，文字在上
};

@interface LLButtonCreator : LLViewCreator

@property(nonatomic,copy,readonly) LLButtonCreator * (^font)(UIFont *font);
@property(nonatomic,copy,readonly) LLButtonCreator * (^fontSize)(CGFloat fontSize);
@property(nonatomic,copy,readonly) LLButtonCreator * (^normalTitle)(NSString*title);
@property(nonatomic,copy,readonly) LLButtonCreator * (^normalTitleColor)(UIColor *titleColor);
@property(nonatomic,copy,readonly) LLButtonCreator * (^normalImage)(UIImage *image);
@property(nonatomic,copy,readonly) LLButtonCreator * (^normalBgImage)(UIImage*image);
@property(nonatomic,copy,readonly) LLButtonCreator * (^setTitle)(NSString*title,UIControlState state);
@property(nonatomic,copy,readonly) LLButtonCreator * (^setTitleColor)(UIColor*titileColor,UIControlState state);
@property(nonatomic,copy,readonly) LLButtonCreator * (^setImage)(UIImage *image,UIControlState state);
@property(nonatomic,copy,readonly) LLButtonCreator * (^setBgImage)(UIImage*image,UIControlState state);
@property(nonatomic,copy,readonly) LLButtonCreator * (^imageEdgeInsets)(UIEdgeInsets imageEdgeInsets);
@property(nonatomic,copy,readonly) LLButtonCreator * (^titleEdgeInsets)(UIEdgeInsets titleEdgeInsets);
@property(nonatomic,copy,readonly) LLButtonCreator * (^contentEdgeInsets)(UIEdgeInsets contentEdgeInsets);
@property(nonatomic,copy,readonly) LLButtonCreator * (^adjustDriection)(LLAdjustDriection dirction,CGFloat space);

@end

@interface UIButton (LLButtonCreator)

+(UIButton*)ll_buttonMaker:(void(^)(LLButtonCreator*maker))maker;

-(void)ll_actionForControlEvents:(UIControlEvents)event action:(void(^)(UIButton*sender))action;


@end
