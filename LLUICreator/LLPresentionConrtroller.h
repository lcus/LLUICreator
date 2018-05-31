//
//  CustomPresentionConrtroller.h
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LLPresentStyle) {
    LLPresentStyleBottom,
    LLPresentStyleCenter,
};

@interface LLPresentionConrtroller : UIPresentationController<UIViewControllerTransitioningDelegate>

@property(nonatomic,assign) BOOL   touchBgViewShouldHide;
@property(nonatomic,assign) LLPresentStyle  style;
@property(nonatomic,strong) id<UIViewControllerAnimatedTransitioning> animatedControl;
@property(nonatomic,strong) id<UIViewControllerInteractiveTransitioning> interactionControl;
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer * pan;
@end
