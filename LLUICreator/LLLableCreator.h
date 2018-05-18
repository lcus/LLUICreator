//
//  LLLableCreator.h
//  LearnSD
//
//  Created by lcus on 2018/5/10.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLViewCreator.h"



@interface LLLableCreator : LLViewCreator

@property(nonatomic,copy,readonly) LLLableCreator * (^text)(NSString*text);
@property(nonatomic,copy,readonly) LLLableCreator * (^font)(UIFont*font);
@property(nonatomic,copy,readonly) LLLableCreator * (^fontSize)(CGFloat fontSize);
@property(nonatomic,copy,readonly) LLLableCreator * (^textColor)(UIColor *textColor);
@property(nonatomic,copy,readonly) LLLableCreator * (^textAlignment)(NSTextAlignment textAlignment);
@property(nonatomic,copy,readonly) LLLableCreator * (^numberOfLines)(NSInteger numberOfLines);
@property(nonatomic,copy,readonly) LLLableCreator * (^adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);
@property(nonatomic,copy,readonly) LLLableCreator * (^lineBreakMode)(NSLineBreakMode lineBreakMode);
@property(nonatomic,copy,readonly) LLLableCreator * (^attributedText)(NSAttributedString *attributedText);

@end

@interface UILabel (LLLableCreator)

+(UILabel*)ll_labelMaker:(void(^)(LLLableCreator * maker))maker;

//两端对齐
-(void)ll_alignmentJustified;


@end
