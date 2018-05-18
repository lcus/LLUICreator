//
//  LLViewCreator.m
//  LearnSD
//
//  Created by lcus on 2018/5/10.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLViewCreator.h"


@implementation LLViewCreator{
    
    @package Class viewClass;
}

@synthesize targetView=_targetView;


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        LLWeakSelf(self)
        _superview = ^LLViewCreator *(UIView *superview) {
            LLStrongSelf(self)
            if (superview) {
                [superview addSubview:self.targetView];
            }
            return self;
        };
        _backgroundColor = ^LLViewCreator *(UIColor *backgroundColor) {
            LLStrongSelf(self)
            self.targetView.backgroundColor = backgroundColor;
            return self;
        };
        _frame = ^LLViewCreator *(CGRect frame) {
            LLStrongSelf(self)
            self.targetView.frame = frame;
            return self;
        };
        _borderWidth = ^LLViewCreator *(CGFloat borderWidth) {
            LLStrongSelf(self);
            self.targetView.layer.borderWidth = borderWidth;
            return self;
        };
        _borderColor = ^LLViewCreator *(UIColor *borderColor) {
            LLStrongSelf(self);
            self.targetView.layer.borderColor=borderColor.CGColor;
            return self;
        };
        _cornerRadius = ^LLViewCreator *(CGFloat cornerRadius) {
            LLStrongSelf(self);
            self.targetView.layer.cornerRadius =cornerRadius;
            return self;
        };
        _masksToBounds = ^LLViewCreator *(BOOL masksToBounds) {
            LLStrongSelf(self);
            self.targetView.layer.masksToBounds=masksToBounds;
            return self;
        };
        _maskView = ^LLViewCreator *(UIView *maskView) {
            LLStrongSelf(self);
            self.targetView.maskView = maskView;
            return self;
        };
    }
    return self;
}
-(UIView *)targetView{
    if (!_targetView) {
        
        _targetView =[self->viewClass new];
    }
    return _targetView;
}
@end

@implementation UIView(LLViewCreator)

+(UIView *)ll_viewMaker:(void (^)(LLViewCreator *maker))maker{
    
    return [self ll_viewMakeWithViewClass:[LLViewCreator class] maker:maker];
    
}
+(instancetype)ll_viewMakeWithViewClass:(Class)viewClass maker:(void (^)(LLViewCreator *))maker{
    
    if (![viewClass isKindOfClass:[LLViewCreator class]]&&![viewClass isSubclassOfClass:[LLViewCreator class]]) {
        return nil;
    }
    LLViewCreator * uimaker =(LLViewCreator*)[[viewClass alloc]init];
    uimaker->viewClass =self;
    if (maker) {
        maker(uimaker);
    }
    return (id)uimaker.targetView;
}

@end
