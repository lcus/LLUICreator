//
//  LLButtonCreator.m
//  LearnSD
//
//  Created by lcus on 2018/5/11.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLButtonCreator.h"
#import "UIButton+LLPositionAdjust.h"
@import ObjectiveC.runtime;



@interface LLButtonCreator ()
@property(nonatomic,strong) UIButton * targetButton;
@end
@implementation LLButtonCreator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        LLWeakSelf(self)
        _font = ^LLButtonCreator *(UIFont *font) {
            LLStrongSelf(self);
            self.targetButton.titleLabel.font =font;
            return self;
        };
        _fontSize = ^LLButtonCreator *(CGFloat fontSize) {
            LLStrongSelf(self);
            self.targetButton.titleLabel.font =[UIFont systemFontOfSize:fontSize];
            return self;
        };
        _normalTitle = ^LLButtonCreator *(NSString *title) {
            LLStrongSelf(self);
            [self.targetButton setTitle:title forState:UIControlStateNormal];
            return self;
        };
       _normalImage = ^LLButtonCreator *(UIImage *image) {
            LLStrongSelf(self);
            [self.targetButton setImage:image forState:UIControlStateNormal];
            return self;
        };
       _normalTitleColor = ^LLButtonCreator *(UIColor *titleColor) {
            LLStrongSelf(self);
            [self.targetButton setTitleColor:titleColor forState:UIControlStateNormal];
            return self;
        };
        _normalBgImage = ^LLButtonCreator *(UIImage *image) {
            LLStrongSelf(self);
            [self.targetButton setBackgroundImage:image forState:UIControlStateNormal];
            return self;
        };
        _setTitle = ^LLButtonCreator *(NSString *title, UIControlState state) {
            LLStrongSelf(self);
            [self.targetButton setTitle:title forState:state];
            return self;
        };
        _setImage = ^LLButtonCreator *(UIImage *image, UIControlState state) {
            LLStrongSelf(self);
            [self.targetButton setImage:image forState:state];
            return self;
        };
        _setTitleColor = ^LLButtonCreator *(UIColor *titileColor, UIControlState state) {
            LLStrongSelf(self);
            [self.targetButton setTitleColor:titileColor forState:state];
            return self;
        };
        _setBgImage = ^LLButtonCreator *(UIImage *image, UIControlState state) {
            LLStrongSelf(self);
            [self.targetButton setBackgroundImage:image forState:state];
            return self;
        };
        _contentEdgeInsets = ^LLButtonCreator *(UIEdgeInsets contentEdgeInsets) {
            LLStrongSelf(self);
            self.targetButton.contentEdgeInsets = contentEdgeInsets;
            return self;
        };
        _imageEdgeInsets = ^LLButtonCreator *(UIEdgeInsets imageEdgeInsets) {
            LLStrongSelf(self);
            self.targetButton.imageEdgeInsets =imageEdgeInsets;
            return self;
        };
        _titleEdgeInsets = ^LLButtonCreator *(UIEdgeInsets titleEdgeInsets) {
            LLStrongSelf(self);
            self.targetButton.titleEdgeInsets = titleEdgeInsets;
            return self;
        };
        _adjustDriection = ^LLButtonCreator *(LLAdjustDriection dirction, CGFloat space) {
            LLStrongSelf(self)
            [self.targetButton setImagePosition:ll_changeDirction(dirction) spacing:space];
            return self;
        };
    }
    return self;
}

-(UIButton *)targetButton{
    
    return (UIButton*)self.targetView;
}

 LLDirection ll_changeDirction(LLAdjustDriection dirction){
    
    switch (dirction) {
        case LLAdjustDriectionTop:
            return LLDirectionTop;break;
        case LLAdjustDriectionLeft:
            return LLDirectionLeft;break;
        case LLAdjustDriectionRight:
            return LLDirectionRight;break;
        case LLAdjustDriectionBottom:
            return LLDirectionBottom;break;
        default:
            return LLDirectionLeft;break;
    }
}

@end


@implementation UIButton(LLButtonCreator)

+(UIButton *)ll_buttonMaker:(void (^)(LLButtonCreator *))maker{
    
    void (^changeMaker)(LLViewCreator *maker) =(void(^)(LLViewCreator *))maker;
    return [super ll_viewMakeWithViewClass:[LLButtonCreator class] maker:changeMaker];
}

-(void)ll_actionForControlEvents:(UIControlEvents)event action:(void (^)(UIButton *))action{
    
    objc_setAssociatedObject(self, @selector(didClickButton:), action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(didClickButton:) forControlEvents:event];
    
}

-(void)didClickButton:(UIButton*)sender{
    
    void (^block)(UIButton *) = objc_getAssociatedObject(self, _cmd);
    block?block(sender):nil;
    
}


@end
