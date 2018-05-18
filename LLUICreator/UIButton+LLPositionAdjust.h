//
//  UIButton+LDPositionAdjust.h
//  SingleTest
//
//  Created by lcus on 2018/4/10.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LLDirection) {
    LLDirectionLeft = 0,              //图片在左，文字在右，默认
    LLDirectionRight = 1,             //图片在右，文字在左
    LLDirectionTop = 2,               //图片在上，文字在下
    LLDirectionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (LLPositionAdjust)


- (void)setImagePosition:(LLDirection)postion spacing:(CGFloat)spacing;

@end
