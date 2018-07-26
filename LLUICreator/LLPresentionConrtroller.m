//
//  CustomPresentionConrtroller.m
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLPresentionConrtroller.h"

@interface LLPresentionConrtroller ()

@property(nonatomic,strong) UIVisualEffectView * visualView;
@property(nonatomic,assign) CGRect presentViewFrame;

@end

@implementation LLPresentionConrtroller

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        
        self.touchBgViewShouldHide = true;
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        presentedViewController.transitioningDelegate = self;
    }
    
    return self;
}

-(UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return self;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    return self.interactionControl;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    return self.interactionControl;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return self.animatedControl;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.animatedControl;
}


-(void)presentationTransitionWillBegin{
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _visualView=[[UIVisualEffectView alloc]initWithEffect:blur];
    _visualView.frame = self.containerView.bounds;

    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClick)];
    
    [_visualView addGestureRecognizer:tap];
    
    _visualView.backgroundColor=[UIColor blackColor];
    [self.containerView addSubview:_visualView];
    
    id<UIViewControllerTransitionCoordinator> transitCoordinator= self.presentingViewController.transitionCoordinator;
    _visualView.alpha =0.f;
    
    [transitCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self->_visualView.alpha = 0.4f;
    } completion:NULL];
    
    
}

-(void)gestureClick{
    
    if (_touchBgViewShouldHide) {
        
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
        
    }
}

-(void)presentationTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        
        [_visualView removeFromSuperview];
        _visualView = nil;
    }
    
}
-(void)dismissalTransitionWillBegin{
    
    id<UIViewControllerTransitionCoordinator> transitCoordinator= self.presentingViewController.transitionCoordinator;
    [transitCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self->_visualView.alpha =0.f;
    } completion:NULL];
    
}

-(void)dismissalTransitionDidEnd:(BOOL)completed{
    
    if (completed) {
        
        [_visualView removeFromSuperview];
        _visualView = nil;
    }
}
-(CGRect)frameOfPresentedViewInContainerView{
    
    
    CGRect containerViewBounds = self.containerView.bounds;
    
    CGSize presentViewContenSize =[self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    CGRect presentedViewRect = CGRectMake((CGRectGetWidth(containerViewBounds)-presentViewContenSize.width)/2, 0, presentViewContenSize.width, presentViewContenSize.height);
    
    switch (self.style) {
        case LLPresentStyleBottom:
            
            presentedViewRect.origin.y =CGRectGetMaxY(containerViewBounds)-presentViewContenSize.height;
            break;
            
        case LLPresentStyleCenter:
            
            presentedViewRect.origin.y =(CGRectGetMaxY(containerViewBounds)-presentViewContenSize.height)/2;
    }
    
    return presentedViewRect;
    
}
//计算控制器view frame
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}


@end
