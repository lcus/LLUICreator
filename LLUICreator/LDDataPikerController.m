//
//  LDDataPikerController.m
//  SubProject
//
//  Created by lcus on 2018/5/7.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDDataPikerController.h"

@interface LDDataPikerController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,copy) void (^selectd)(NSInteger,NSString*);
@property(nonatomic,strong) UIPickerView * pikerView;
@property(nonatomic,strong) UIToolbar * toolBar;

@end

@implementation LDDataPikerController



- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view addSubview:self.toolBar];
    
    self.pikerView =[[UIPickerView alloc]initWithFrame:CGRectMake(0,44, [UIScreen mainScreen].bounds.size.width, 220)];
    self.pikerView.backgroundColor =[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    self.pikerView.dataSource =self;
    self.pikerView.delegate =self;
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_pikerView];
    [self.pikerView selectRow:0 inComponent:0 animated:YES];
    self.selectd?self.selectd(0,self.dataArray.firstObject):nil;
    self.preferredContentSize = CGSizeMake(CGRectGetWidth(self.pikerView.bounds), CGRectGetHeight(self.pikerView.bounds)+44);
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
-(void)didClickEnter:(UIButton*)enter{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(instancetype)initWithDataSource:(NSArray *)dataSource selected:(void (^)(NSInteger, NSString *))selected{
    
    self = [super init];
    if (self) {
        
        self.dataArray = [dataSource mutableCopy];
        self.selectd = [selected copy];
        
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 26.0f;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataArray[row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.selectd?self.selectd(row,self.dataArray[row]):nil;
}




@end
