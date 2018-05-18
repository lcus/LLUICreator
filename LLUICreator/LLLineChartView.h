//
//  LLLineChartView.h
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLineChartView : UIView

@property(nonatomic,strong) NSString * chartTitle;
@property(nonatomic,strong) NSArray  * yAxisTitles;
@property(nonatomic,strong) NSArray  * xAxisTitles;
@property(nonatomic,strong) NSArray  *  values;
@property(nonatomic,strong) NSArray  * lineColors;
@property(nonatomic,strong) UIColor  * lineColor;
@property(nonatomic,assign) CGFloat   yAxisMaxValue;
//x轴单位长度
@property(nonatomic,assign) CGFloat   xUnitLength;



-(void)setValus:(NSArray*)values key:(NSString*)key;


-(void)beginDraw;

-(void)reloadDraw;

@end
