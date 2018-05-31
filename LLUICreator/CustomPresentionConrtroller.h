//
//  CustomPresentionConrtroller.h
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LDPresentStyle) {
    LDPresentStyleBottom,
    LDPresentStyleCenter,
};

@interface CustomPresentionConrtroller : UIPresentationController<UIViewControllerTransitioningDelegate>

@property(nonatomic,assign) BOOL   touchBgViewShouldHide;
@property(nonatomic,assign) LDPresentStyle  style;
@property(nonatomic,strong) id<UIViewControllerAnimatedTransitioning> animatedControl;
@property(nonatomic,strong) id<UIViewControllerInteractiveTransitioning> interactionControl;
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer * pan;
@end
