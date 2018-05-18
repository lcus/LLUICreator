//
//  LLTextViewCreator.m
//  UICreatorEdit
//
//  Created by lcus on 2018/5/14.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLTextViewCreator.h"
#import "UITextView+ZWPlaceHolder.h"
@interface LLTextViewCreator ()

@property(nonatomic,strong) UITextView * targetTextView;
@end

@implementation LLTextViewCreator


- (instancetype)init
{
    self = [super init];
    if (self) {
        LLWeakSelf(self)
        _font = ^LLTextViewCreator *(UIFont *font) {
            LLStrongSelf(self)
            self.targetTextView.font = font;
            return self;
        };
        _fontSize = ^LLTextViewCreator *(CGFloat fontSize) {
            LLStrongSelf(self)
            self.targetTextView.font =[UIFont systemFontOfSize:fontSize];
            return self;
        };
        _textColor = ^LLTextViewCreator *(UIColor *textColor) {
            LLStrongSelf(self)
            self.targetTextView.textColor =textColor;
            return self;
        };
        _textAlignment = ^LLTextViewCreator *(NSTextAlignment alignment) {
            LLStrongSelf(self)
            self.targetTextView.textAlignment =alignment;
            return self;
        };
        _editable = ^LLTextViewCreator *(BOOL editable) {
            LLStrongSelf(self)
            self.targetTextView.editable =editable;
            return self;
        };
        _placehodel = ^LLTextViewCreator *(NSString *placeHodel) {
            LLStrongSelf(self)
            self.targetTextView.placeholder = placeHodel;
            self.targetTextView.zw_placeHolder = placeHodel;
            return self;
        };
        _placeHodelColor = ^LLTextViewCreator *(UIColor *placeHodelColor) {
            LLStrongSelf(self);
            self.targetTextView.zw_placeHolderColor = placeHodelColor;
            return self;
        };
        
    }
    return self;
}

-(UITextView *)targetTextView{
    
    return (UITextView*)self.targetView;
}

@end

@implementation UITextView(LLTextViewCreator)

+(UITextView*)ll_textViewMaker:(void(^)(LLTextViewCreator*maker))maker{
    
    void (^changeMaker)(LLViewCreator *maker) =(void(^)(LLViewCreator *))maker;
    return [super ll_viewMakeWithViewClass:[LLTextViewCreator class] maker:changeMaker];
}

-(void)ll_setPlaceHodel:(NSString *)placeHodel{
    
    self.placeholder =placeHodel;
    self.zw_placeHolder = placeHodel;
}

-(void)ll_setPlaceHodelColor:(UIColor *)placeHodelColor{
    
    self.zw_placeHolderColor = placeHodelColor;
}


@end
