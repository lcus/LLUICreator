//
//  LDCustomAlertController.m
//  SubProject
//
//  Created by lcus on 2018/5/7.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDCustomAlertController.h"

@interface LDCustomAlertController ()

@property(nonatomic,strong) UILabel * titleLable;
@property(nonatomic,strong) UILabel * subTitleLable;
@property(nonatomic,strong) UIButton * cancleButton;
@property(nonatomic,strong) UIButton * actionButton;
@property(nonatomic,copy)   void(^cancle)(UIButton*);
@property(nonatomic,copy)   void(^action)(UIButton*);

@end

@implementation LDCustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIView *bgView = [UIView ll_viewMaker:^(LLViewCreator *maker) {
        maker.backgroundColor([UIColor whiteColor])
        .cornerRadius(6).masksToBounds(YES).superview(self.view);
    }];
    
    self.titleLable =[UILabel ll_labelMaker:^(LLLableCreator *maker) {
        maker.fontSize(20).text(self.maintitle).textAlignment(NSTextAlignmentCenter)
        .textColor([UIColor blackColor]).backgroundColor([UIColor whiteColor]).superview(bgView);
    }];
    
    
    self.subTitleLable =[UILabel ll_labelMaker:^(LLLableCreator *maker) {
            maker.fontSize(14).text(self.subTitle).textAlignment(NSTextAlignmentCenter)
            .numberOfLines(0).superview(bgView);
        }];
    
    UIView *lineView =[UIView ll_viewMaker:^(LLViewCreator *maker) {
        maker.backgroundColor([UIColor lightGrayColor]).superview(bgView);
    }];
    
    if (self.cancleTitle) {
        
        self.cancleButton =[UIButton ll_buttonMaker:^(LLButtonCreator *maker) {
            
            maker.normalTitle(_cancleTitle).normalTitleColor([UIColor blackColor]).backgroundColor([UIColor whiteColor]).superview(bgView);
            
        }];
        
        [self.cancleButton ll_actionForControlEvents:UIControlEventTouchUpInside action:self.cancle];
        
    }
    
    self.actionButton =[UIButton ll_buttonMaker:^(LLButtonCreator *maker) {
        
        maker.backgroundColor([UIColor colorWithRed:0.00 green:0.54 blue:0.49 alpha:1.00]).superview(bgView);
        maker.normalTitle(_actionTitle).normalTitleColor([UIColor whiteColor]);
        
    }];
    [self.actionButton ll_actionForControlEvents:UIControlEventTouchUpInside action:self.action];

    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-d_size(56));
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bgView).insets(UIEdgeInsetsMake(d_size(50), 0, 0, 0));
        make.height.mas_equalTo(_titleLable.font.lineHeight);
    }];
    
    [self.subTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLable);
        make.top.equalTo(self.titleLable.mas_bottom).offset(d_size(20));
    }];
    
    [self.subTitleLable setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(bgView);
        make.top.equalTo(self.subTitle?self.subTitleLable.mas_bottom:self.titleLable.mas_bottom).offset(d_size(40));
        make.height.mas_equalTo(SepLineHeight);
    }];
    
    if (self.cancleTitle) {
        
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView);
            make.top.equalTo(lineView.mas_bottom);
            make.width.equalTo(bgView).multipliedBy(0.5);
            make.height.mas_equalTo(d_size(44));
        }];
    }
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.cancleTitle?self.cancleButton.mas_right:bgView);
        make.right.equalTo(bgView);
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(d_size(44));
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.actionButton.mas_bottom);
    }];
    
    [bgView layoutIfNeeded];
    
   
    self.preferredContentSize = CGSizeMake(CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.bounds));
}




+(instancetype)initWithMainTitle:(NSString *)mainTitle actionTitle:(NSString *)actionTitle action:(void (^)(UIButton *))action{
    
    return [self initWithMainTitle:mainTitle subTitle:nil actionTitle:actionTitle action:action];

}

+(instancetype)initWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle actionTitle:(NSString *)actionTitle action:(void (^)(UIButton *))action{
    
    return [self initWithMainTitle:mainTitle subTitle:subTitle cancleTitle:nil actionTitle:actionTitle cancle:nil action:action];
    
}
+(instancetype)initWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle cancleTitle:(NSString *)cancelTitle actionTitle:(NSString *)actionTitle cancle:(void (^)(UIButton *))cancle action:(void (^)(UIButton *))action{
    LDCustomAlertController *conttoller = [[LDCustomAlertController alloc]init];
    if (conttoller) {
        conttoller.maintitle = mainTitle;
        conttoller.subTitle = subTitle;
        conttoller.cancleTitle = cancelTitle;
        conttoller.actionTitle = actionTitle;
        conttoller.cancle = [cancle copy];
        conttoller.action = [action copy];
    }
    return conttoller;
}
-(void)dealloc{
    
    NSLog(@"销毁了");
}



@end
