//
//  LLineCharBaseView.h
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLineCharBaseView : UIView

@property(nonatomic,strong) NSArray * yAxisTitles;

@property(nonatomic,strong) NSArray * xAxisTitles;

@property(nonatomic,assign) CGFloat   ySpaceUnitLength;
@property(nonatomic,assign) CGFloat   xSpaceUnitLength;

@property(nonatomic,assign) CGPoint   startPoint;

@property(nonatomic,assign) CGFloat   xAxisLength;

@property(nonatomic,assign) CGFloat   yAxisLength;

/**
 x轴标签的大小
 */
@property(nonatomic,assign) CGSize    xMarkSize;

/**
 y轴标签大小
 */
@property(nonatomic,assign) CGSize    yMarkSize;

/**
 x轴标签距离x轴的距离
 */
@property(nonatomic,assign) CGFloat   xMarkSpceXAxis;

/**
 y轴标签距离y轴的距离
 */
@property(nonatomic,assign) CGFloat   yMarkSpceYAxis;


@property(nonatomic,strong) UIColor * xAxisColor;

@property(nonatomic,strong) UIColor * yAXisColor;

@property(nonatomic,strong) UIColor * gridLineColor;


-(void)startDraw;

-(void)reloadDraw;

@end
