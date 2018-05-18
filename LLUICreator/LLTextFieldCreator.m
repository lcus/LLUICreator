//
//  LLTextFieldCreator.m
//  LearnSD
//
//  Created by lcus on 2018/5/11.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLTextFieldCreator.h"
@interface LLTextFieldCreator ()
@property(nonatomic,strong) UITextField * targetTextField;
@end
@implementation LLTextFieldCreator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        LLWeakSelf(self)
        
        _text = ^LLTextFieldCreator *(NSString *text) {
            LLStrongSelf(self);
            self.targetTextField.text =text;
            return self;
        };
        _font = ^LLTextFieldCreator *(UIFont *font) {
            LLStrongSelf(self);
            self.targetTextField.font =font;
            return self;
        };
        _attributedText = ^LLTextFieldCreator *(NSAttributedString *attributedText) {
            LLStrongSelf(self);
            self.targetTextField.attributedText = attributedText;
            return self;
        };
        _textColor = ^LLTextFieldCreator *(UIColor *textColor) {
            LLStrongSelf(self);
            self.targetTextField.textColor =textColor;
            return self;
        };
        _textAlignment = ^LLTextFieldCreator *(NSTextAlignment alignment) {
            LLStrongSelf(self);
            self.targetTextField.textAlignment = alignment;
            return self;
        };
        _rightView = ^LLTextFieldCreator *(UIView *rightView) {
            LLStrongSelf(self)
            self.targetTextField.rightViewMode=UITextFieldViewModeAlways;
            self.targetTextField.rightView=rightView;
            return self;
        };
        _leftView = ^LLTextFieldCreator *(UIView *leftView) {
            LLStrongSelf(self)
            self.targetTextField.leftViewMode=UITextFieldViewModeAlways;
            self.targetTextField.leftView = leftView;
            return self;
        };
        _background = ^LLTextFieldCreator *(UIImage *background) {
            LLStrongSelf(self)
            self.targetTextField.background = background;
            return self;
        };
        _clearButtonMode = ^LLTextFieldCreator *(UITextFieldViewMode clearButtonMode) {
            LLStrongSelf(self)
            self.targetTextField.clearButtonMode=clearButtonMode;
            return self;
        };
        _delegate = ^LLTextFieldCreator *(id<UITextFieldDelegate> delegate) {
            LLStrongSelf(self)
            self.targetTextField.delegate = delegate;
            return self;
        };
        _clearButtonMode = ^LLTextFieldCreator *(UITextFieldViewMode model) {
            LLStrongSelf(self);
            self.targetTextField.clearButtonMode=model;
            return self;
        };
        _attributedPlaceholder = ^LLTextFieldCreator *(NSAttributedString *str) {
            LLStrongSelf(self);
            self.targetTextField.attributedPlaceholder=str;
            return self;
        };
        _placeholder = ^LLTextFieldCreator *(NSString *placeholder) {
            LLStrongSelf(self);
            self.targetTextField.placeholder = placeholder;
            return self;
        };
        _borderStyle = ^LLTextFieldCreator *(UITextBorderStyle style) {
            LLStrongSelf(self);
            self.targetTextField.borderStyle = style;
            return self;
        };
        _fontSize = ^LLTextFieldCreator *(CGFloat fontSize) {
            LLStrongSelf(self);
            self.targetTextField.font =[UIFont systemFontOfSize:fontSize];
            return self;
        };
    }
    return self;
}

-(UITextField *)targetTextField{
    
    return (UITextField*)self.targetView;
}

@end

@implementation UITextField(LLTextFieldCreator)

+(UITextField *)ll_textFieldMaker:(void (^)(LLTextFieldCreator *))maker{
    
    void (^changeMaker)(LLViewCreator *maker) =(void(^)(LLViewCreator *))maker;
    return [super ll_viewMakeWithViewClass:[LLTextFieldCreator class] maker:changeMaker];
}

@end
