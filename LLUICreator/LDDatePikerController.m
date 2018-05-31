//
//  LDDatePikerController.m
//  SubProject
//
//  Created by lcus on 2018/5/7.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDDatePikerController.h"

@interface LDDatePikerController ()

@property(nonatomic,strong) UIToolbar * toolBar;
@property(nonatomic,strong) UIDatePicker * datePiker;

@end

@implementation LDDatePikerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.datePiker];
    
    self.preferredContentSize =CGSizeMake(CGRectGetWidth(self.view.frame), 280);
    
    
}
-(UIToolbar*)toolBar{
    if (!_toolBar) {
        _toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        lab.center=_toolBar.center;
        lab.text = @"请选择";
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        UIBarButtonItem * titleButton = [[UIBarButtonItem alloc]initWithCustomView:lab];
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 50, 44);
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(didClickEnter:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,titleButton,fixedButton,rightBarButton,nil];
        [_toolBar setItems: array];
    }
    return _toolBar;
}



-(UIDatePicker*)datePiker{
    
    if (!_datePiker) {
        _datePiker=[[UIDatePicker alloc]init];
        _datePiker.backgroundColor = [UIColor whiteColor];
        NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        [_datePiker setLocale:locale];
        _datePiker.datePickerMode = UIDatePickerModeDate;
        _datePiker.frame=CGRectMake(0,44,CGRectGetWidth(self.view.frame),216);
        
    }
    return _datePiker;
}

-(void)setMiniDate:(NSDate *)miniDate{
    [self.datePiker setMinimumDate:miniDate];
}
-(void)setMaxDate:(NSDate *)maxDate{
    
    [self.datePiker setMaximumDate:maxDate];
    
}

-(void)didClickEnter:(UIButton*)sender{
    
    NSDate * date = [_datePiker date];
    //显示用的
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    NSInteger seconds=[timeZone secondsFromGMTForDate:date];
    NSDate *newDate=[date dateByAddingTimeInterval:seconds];
    NSDateFormatter * dateFormatter1= [[NSDateFormatter alloc] init];
    [dateFormatter1 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];//location置为中国
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString * time1 = [dateFormatter1 stringFromDate:date];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
