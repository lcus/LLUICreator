//
//  LLTextViewCreator.h
//  UICreatorEdit
//
//  Created by lcus on 2018/5/14.
//  Copyright © 2018年 lcus. All rights reserved.
//


#import "LLViewCreator.h"

@interface LLTextViewCreator : LLViewCreator


@property(nonatomic,copy,readonly) LLTextViewCreator * (^font)(UIFont *font);
@property(nonatomic,copy,readonly) LLTextViewCreator * (^fontSize)(CGFloat fontSize);
@property(nonatomic,copy,readonly) LLTextViewCreator * (^textColor)(UIColor *textColor);
@property(nonatomic,copy,readonly) LLTextViewCreator * (^textAlignment)(NSTextAlignment alignment);
@property(nonatomic,copy,readonly) LLTextViewCreator * (^editable)(BOOL editable);

@property(nonatomic,copy,readonly) LLTextViewCreator * (^placehodel)(NSString*placeHodel);
@property(nonatomic,copy) LLTextViewCreator * (^placeHodelColor)(UIColor *placeHodelColor);

@end


@interface UITextView (LLTextViewCreator)

+(UITextView*)ll_textViewMaker:(void(^)(LLTextViewCreator*maker))maker;
-(void)ll_setPlaceHodel:(NSString*)placeHodel;
-(void)ll_setPlaceHodelColor:(UIColor *)placeHodelColor;

@end
