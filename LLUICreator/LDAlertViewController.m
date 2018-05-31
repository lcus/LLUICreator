//
//  LDAlertViewController.m
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDAlertViewController.h"

typedef void(^actionHandel)(UIAlertAction *action);

@interface LDAlertDataConfig: NSObject
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * subTitle;
@property(nonatomic,assign) UIAlertControllerStyle  style;
@end

@interface LDAlertActionConfig : NSObject

@property(nonatomic,strong) NSString * title;
@property(nonatomic,assign) UIAlertActionStyle style;
@property(nonatomic,copy)   actionHandel handel;
@end


@interface LDAlertViewController ()
@property(nonatomic,strong) UIAlertController * alert;
@end

@implementation LDAlertViewController




@end
