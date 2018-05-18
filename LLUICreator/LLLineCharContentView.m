//
//  LLLineCharContentView.m
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLLineCharContentView.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface LLLineCharContentView ()

@property(nonatomic,strong) NSMutableArray * pointsArray;

@property(nonatomic,assign) NSInteger    lastSelectIndex;
@property(nonatomic,strong) UIButton * popButton;


@property(nonatomic,assign) BOOL    singleLine;

@end

@implementation LLLineCharContentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lastSelectIndex = -1;
        _pointsArray =[NSMutableArray array];
        _cirleColor =[UIColor whiteColor];
        _cirleRadius =2;
        _cirleBordeWidth =1;
        _cirleBorderColor =[UIColor redColor];
    }
    return self;
}

-(void)beginDraw {
    
    [super startDraw];
    Class tempClass = [self.values[0] class];
    
    
    _singleLine =!([tempClass isKindOfClass:[NSArray class]]||[tempClass isSubclassOfClass:[NSArray class]]);
    
    
    if (!_singleLine) {
        for (NSArray *arry in self.values) {
            
            [self drawChartLineWithData:arry];
        }
        }else{
        
         [self drawChartLineWithData:self.values];
         [self drawGradient];
    }

     [self drawCircleViews];
  
}



-(void)drawChartLineWithData:(NSArray*)values{
    
    NSMutableArray *tempPointArray =[NSMutableArray array];
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc]init];
    
    for (int i=0; i<values.count; i++) {
        
        CGFloat point_x = self.startPoint.x+ i*self.xSpaceUnitLength;
        
        CGFloat value = [values[i] floatValue];
        
        CGFloat percent = value/_maxValue;
        
        CGFloat point_y = self.yAxisLength*(1-percent)+self.startPoint.y;
        
        CGPoint point = CGPointMake(point_x, point_y);
        
        [tempPointArray addObject:[NSValue valueWithCGPoint:point]];
        

        if (i==0) {
            
            [pAxisPath moveToPoint:point];
        }else{
            [pAxisPath addLineToPoint:point];
        }
    }
    if (_singleLine) {
        
        self.pointsArray = tempPointArray;
    }else{
        [self.pointsArray addObject:tempPointArray];
    }

    CAShapeLayer *pAxisLayer =[CAShapeLayer layer];
    pAxisLayer.lineWidth =1;
    pAxisLayer.strokeColor =randomColor.CGColor;
    pAxisLayer.fillColor =[UIColor clearColor].CGColor;
    pAxisLayer.path =pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
}

-(void)drawGradient{
    
    CAGradientLayer *grandientLayer =[CAGradientLayer layer];
    
    grandientLayer.frame =self.frame;
    grandientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
    grandientLayer.locations =@[@0.0,@1.0];
    
    grandientLayer.startPoint = CGPointMake(0, 0);
    
    grandientLayer.endPoint =CGPointMake(0.0, 1);
    
    UIBezierPath *gradientPath =[[UIBezierPath alloc]init];
    
    [gradientPath moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y+self.yAxisLength)];
    
    for (int i=0; i<_pointsArray.count; i++) {
        
        [gradientPath addLineToPoint:[_pointsArray[i] CGPointValue]];
        
    }
    CGPoint endPointValue =[[_pointsArray lastObject]CGPointValue];
    
    endPointValue = CGPointMake(endPointValue.x,self.yAxisLength+self.startPoint.y);
    
    [gradientPath addLineToPoint:endPointValue];
    
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.path = gradientPath.CGPath;
    
    grandientLayer.mask = layer;
    [self.layer addSublayer:grandientLayer];
    
}

-(void)drawCircleViews{
   
    if (_singleLine) {
        
        [self drawCircleViewsWithArray:self.pointsArray];
    }else{
        
        for (NSArray *temp in self.pointsArray) {
            
            [self drawCircleViewsWithArray:temp];
        }
    }
    
}

-(void)drawCircleViewsWithArray:(NSArray*)points{
    
    
    
    
    for (int i=0; i<points.count; i++) {
        CALayer *layer =[CALayer layer];
        layer.bounds =CGRectMake(0, 0, 8, 8);
        layer.backgroundColor =[UIColor whiteColor].CGColor;
        layer.borderColor =[UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1].CGColor;
        layer.borderWidth =1;
        layer.cornerRadius = 4;
        layer.masksToBounds = YES;
        layer.position = [points[i] CGPointValue];
        [self.layer addSublayer: layer];
    }
}


-(void)reloadDraw{
    
    [super reloadDraw];
    [self clearView];
    [self beginDraw];
    
}
-(void)clearView{
  
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!_singleLine) return;
    
    CGPoint point =[[touches anyObject]locationInView:self];
    
    
    CGRect rect = CGRectMake(self.startPoint.x, self.startPoint.y, self.xAxisLength, self.yAxisLength);
    
    
    if (CGRectContainsPoint(rect, point)) {
        
        CGFloat offSet = point.x-self.startPoint.x;
        
        NSInteger index = roundf(offSet/self.xSpaceUnitLength);
   
        [self addVlaueHubWithIndex:index];
        
    }
    
}

-(void)addVlaueHubWithIndex:(NSInteger)index{
    
    
    CGPoint point = [self.pointsArray[index] CGPointValue];
    
    self.popButton.frame = CGRectMake(point.x-13, point.y-15, 26, 15);
    [self.popButton setTitle:[NSString stringWithFormat:@"%@",self.values[index]] forState:(UIControlStateNormal)];
    [self addSubview:self.popButton];
}

-(UIButton *)popButton{
    
    if (!_popButton) {
        
        _popButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_popButton setBackgroundImage:[UIImage imageNamed:@"bgcolor"] forState:UIControlStateNormal];

        [_popButton setTitleEdgeInsets:UIEdgeInsetsMake(- 3, 0, 0, 0)];
        
        _popButton.titleLabel.font = [UIFont systemFontOfSize:10];
        
        _popButton.titleLabel.adjustsFontSizeToFitWidth =YES;
    }
    
    return _popButton;
}




@end
