//
//  LLLineChartView.m
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.

// how to use
//   LLLineChartView *chartView=[[LLLineChartView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 300)];
//chartView.yAxisMaxValue = 100.f;
//chartView.yAxisTitles =@[@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100"];
//chartView.xAxisTitles =@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
////    chartView.xUnitLength =26;
////    [chartView setValus:@[@[@{@"value":@"86.4"},@{@"value":@"32.8"},@{@"value":@"66.5"},@{@"value":@"44.8"},@{@"value":@"67"},@{@"value":@"97"},@{@"value":@"43"},@{@"value":@"69"},@{@"value":@"87"},@{@"value":@"12"},@{@"value":@"8"},@{@"value":@"94"}],
////  @[@{@"value":@"26.4"},@{@"value":@"52.8"},@{@"value":@"16.5"},@{@"value":@"84.8"},@{@"value":@"27"},@{@"value":@"91"},@{@"value":@"53"},@{@"value":@"69"},@{@"value":@"27"},@{@"value":@"16.9"},@{@"value":@"11"},@{@"value":@"67"}]
////                          ,@[@{@"value":@"16.4"},@{@"value":@"12.8"},@{@"value":@"26.5"},@{@"value":@"44.8"},@{@"value":@"87"},@{@"value":@"47"},@{@"value":@"40"},@{@"value":@"19"},@{@"value":@"3.87"},@{@"value":@"82"},@{@"value":@"18"},@{@"value":@"74"}]] key:@"value"];
//
//[chartView setValus:@[@{@"value":@"86.4"},@{@"value":@"32.8"},@{@"value":@"66.5"},@{@"value":@"44.8"},@{@"value":@"67"},@{@"value":@"97"},@{@"value":@"43"},@{@"value":@"69"},@{@"value":@"87"},@{@"value":@"12"},@{@"value":@"8"},@{@"value":@"94"}] key:@"value"];
//
//[chartView beginDraw];
//
//self.line =chartView;
//[self.view addSubview:chartView];

#import "LLLineChartView.h"
#import "LLLineCharContentView.h"
@interface LLLineChartView ()

@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) LLLineCharContentView * chartView;

@end

@implementation LLLineChartView



-(void)setValus:(NSArray *)values key:(NSString *)key{
    
    NSAssert(values.count, @"data is nil");
    
    NSMutableArray *temValues =@[].mutableCopy;
    Class tempClass = [values[0] class];
    
    if ([tempClass isKindOfClass:[NSArray class]]||[tempClass isSubclassOfClass:[NSArray class]]) {
        
        for (NSArray *data in values) {
            [temValues addObject:[self praseDataArray:data key:key]];
        }
        self.values =[temValues copy];
    }else{
        
        self.values =[self praseDataArray:values key:key];
    }
}

-(NSArray*)praseDataArray:(NSArray*)data key:(NSString*)key{
    
    NSMutableArray *temValues =@[].mutableCopy;
    for (NSDictionary *dict in data) {
        
        [temValues addObject:dict[key]];
    }
    return [temValues copy];
}


-(void)beginDraw{
    
    static CGFloat topTocontainView = 0.0f;
    
    if (self.chartTitle) {
        
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame), 20)];
        titleLab.text = self.chartTitle;
        titleLab.font = [UIFont systemFontOfSize:15];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLab];
        topTocontainView = 25;
    }
    
    if (_yAxisMaxValue == 0) {
        
    }
    self.scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, topTocontainView, self.frame.size.width, self.frame.size.height-topTocontainView)];
    self.scrollView.showsVerticalScrollIndicator =NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    self.chartView =[[LLLineCharContentView alloc]initWithFrame:self.scrollView.bounds];
    self.chartView.yAxisTitles = self.yAxisTitles;
    self.chartView.xAxisTitles = self.xAxisTitles;
    self.chartView.values = self.values;
    self.chartView.maxValue = self.yAxisMaxValue;
    self.chartView.xSpaceUnitLength =self.xUnitLength;
    [self.scrollView addSubview:self.chartView];
    [self.chartView beginDraw];
    self.scrollView.contentSize = self.chartView.bounds.size;
}

-(void)reloadDraw{
    
    [self.chartView reloadDraw];
}



@end
