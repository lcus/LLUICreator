//
//  LLTextFieldCreator.h
//  LearnSD
//
//  Created by lcus on 2018/5/11.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLViewCreator.h"



@interface LLTextFieldCreator : LLViewCreator


@property(nonatomic,copy,readonly) LLTextFieldCreator * (^text)(NSString*text);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^font)(UIFont *font);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^fontSize)(CGFloat fontSize);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^textColor)(UIColor *textColor);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^attributedText)(NSAttributedString *attributedText);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^textAlignment)(NSTextAlignment alignment);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^borderStyle)(UITextBorderStyle style);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^placeholder)(NSString *placeholder);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^attributedPlaceholder)(NSAttributedString *str);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^clearsOnBeginEditing)(BOOL isclear);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^delegate)(id<UITextFieldDelegate> delegate);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^background)(UIImage *background);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^clearButtonMode)(UITextFieldViewMode model);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^rightView)(UIView *rightView);
@property(nonatomic,copy,readonly) LLTextFieldCreator * (^leftView)(UIView *leftView);
@end

@interface UITextField (LLTextFieldCreator)

+(UITextField*)ll_textFieldMaker:(void(^)(LLTextFieldCreator*maker))maker;

@end

