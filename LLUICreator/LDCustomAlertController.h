//
//  LDCustomAlertController.h
//  SubProject
//
//  Created by lcus on 2018/5/7.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LDCustomAlertController : UIViewController

@property(nonatomic,strong) NSString * maintitle;
@property(nonatomic,strong) NSString * subTitle;
@property(nonatomic,strong) NSString * cancleTitle;
@property(nonatomic,strong) NSString * actionTitle;




+(instancetype)initWithMainTitle:(NSString*)mainTitle
                        subTitle:(NSString*)subTitle
                     actionTitle:(NSString*)actionTitle
                          action:(void(^)(UIButton*sender))action;


+(instancetype)initWithMainTitle:(NSString*)mainTitle
                     actionTitle:(NSString*)actionTitle
                          action:(void(^)(UIButton*sender))action;





+(instancetype)initWithMainTitle:(NSString*)mainTitle
                    subTitle:(NSString*)subTitle
                 cancleTitle:(NSString*)cancelTitle
                 actionTitle:(NSString*)actionTitle
                      cancle:(void(^)(UIButton* sender))cancle
                      action:(void(^)(UIButton*sender))action;

@end
