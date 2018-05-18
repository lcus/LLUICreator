//
//  LLLineCharContentView.h
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLineCharBaseView.h"

@interface LLLineCharContentView : LLineCharBaseView

@property(nonatomic,strong) NSArray * values;

@property(nonatomic,assign) CGFloat    maxValue;

//设置圆点样式
@property(nonatomic,strong) UIColor * strockColor;
@property(nonatomic,strong) UIColor * cirleColor;
@property(nonatomic,assign) CGFloat   cirleRadius;
@property(nonatomic,assign) CGFloat  cirleBordeWidth;
@property(nonatomic,strong) UIColor * cirleBorderColor;


-(void)beginDraw;

-(void)reloadDraw;


@end
