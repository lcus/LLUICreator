//
//  LLineCharBaseView.m
//  LLLineCharCreator
//
//  Created by lcus on 2018/5/17.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLineCharBaseView.h"
//         哈哈哈
//        margintop 12
// 1  xspace=10  |
// 2             |
// 3             |
// 4             |
// 5             |______________
//              yscpe =10
//               1 2 3 4 5 6


@implementation LLineCharBaseView{
    
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat topMargin;
    CGFloat rightMargin;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        viewWidth = frame.size.width;
        viewHeight = frame.size.height;
        
        self.xMarkSize =CGSizeMake(40, 16);
        self.xMarkSpceXAxis = 5;
        self.yMarkSize = CGSizeMake(25, 16);
        self.yMarkSpceYAxis = 10;
    
        topMargin = 12.f;
        rightMargin =20;
        
    }
    return self;
}

-(void)startDraw{
    
    [self configLocation];
    [self drawYMarks];
    [self drawXMarks];
    [self drawYAxis];
    [self drawXAxis];
    [self drawGridLineX];
    [self drawGridLineY];
    
}

-(void)drawYMarks{
    
    for (int i=0; i<self.yAxisTitles.count; i++) {
        
            CATextLayer *mark = [CATextLayer layer];
            mark.frame =CGRectMake(0,_startPoint.y+i*_ySpaceUnitLength-_yMarkSize.height/2, _yMarkSize.width, _yMarkSize.height);
            mark.contentsScale =[UIScreen mainScreen].scale;
            mark.fontSize =12;
            mark.alignmentMode =kCAAlignmentRight;
            mark.foregroundColor =[UIColor blackColor].CGColor;
            mark.string =[NSString stringWithFormat:@"%@", self.yAxisTitles[self.yAxisTitles.count - 1 - i]];
            [self.layer addSublayer:mark];
    }
}
-(void)drawXMarks{
    

    for (int i=0; i<self.xAxisTitles.count; i++) {
        
         @autoreleasepool{
             CATextLayer *mark = [CATextLayer layer];
             
             CGFloat s_x = _startPoint.x -(_xMarkSize.width/2);
             
             mark.frame =CGRectMake(s_x+(i*_xSpaceUnitLength),_startPoint.y+_yAxisLength+_xMarkSpceXAxis, _xMarkSize.width, _xMarkSize.height);
             mark.contentsScale =[UIScreen mainScreen].scale;
             mark.fontSize =12;
             mark.alignmentMode =kCAAlignmentCenter;
             mark.foregroundColor =[UIColor blackColor].CGColor;
//            mark.backgroundColor =[UIColor yellowColor].CGColor;
             mark.string =[NSString stringWithFormat:@"%@",_xAxisTitles[i]];
             [self.layer addSublayer:mark];
        }
    }
}
-(void)drawXAxis{
    
    UIBezierPath *xAxisPath =[[UIBezierPath alloc]init];
    
    [xAxisPath moveToPoint:CGPointMake(_startPoint.x, _startPoint.y+_yAxisLength)];
    
    [xAxisPath addLineToPoint:CGPointMake(_startPoint.x+_xAxisLength, _startPoint.y+_yAxisLength)];
    
    CAShapeLayer *xAxisLayer =[CAShapeLayer layer];
//    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.strokeColor =[UIColor greenColor].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
}

-(void)drawYAxis{
    
    UIBezierPath *yAxisPath = [[UIBezierPath alloc]init];
    
    [yAxisPath moveToPoint:CGPointMake(_startPoint.x,_yAxisLength+_startPoint.y)];
    
    [yAxisPath addLineToPoint:CGPointMake(_startPoint.x,_startPoint.y)];
    
    CAShapeLayer *yAxisLayer =[CAShapeLayer layer];
//
//    [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    yAxisLayer.strokeColor =[UIColor greenColor].CGColor;
    yAxisLayer.path = yAxisPath.CGPath;
    [self.layer addSublayer:yAxisLayer];

}

-(void)drawGridLineX{
    
    for (int i=0; i<self.yAxisTitles.count-1; i++) {
        
        CGFloat cunrrenty = self.ySpaceUnitLength*i;
        
        UIBezierPath *xaxispth =[[UIBezierPath alloc]init];
        [xaxispth moveToPoint:CGPointMake(_startPoint.x, cunrrenty+_startPoint.y)];
        [xaxispth addLineToPoint:CGPointMake(_startPoint.x+_xAxisLength,  cunrrenty+_startPoint.y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        xAxisLayer.path = xaxispth.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
}

-(void)drawGridLineY{
    
    
    for (int i=0; i<self.xAxisTitles.count-1; i++) {
        
        CGFloat currentx =self.xSpaceUnitLength*(i+1)+_startPoint.x;
        
        UIBezierPath *xaxispth =[[UIBezierPath alloc]init];
        [xaxispth moveToPoint:CGPointMake(currentx, _yAxisLength+_startPoint.y)];
        [xaxispth addLineToPoint:CGPointMake(currentx, _startPoint.y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        xAxisLayer.path = xaxispth.CGPath;
        [self.layer addSublayer:xAxisLayer];
        
    }
    
    
    
}



-(void)configLocation{
    if (self.ySpaceUnitLength == 0) {

        self.ySpaceUnitLength = (CGRectGetHeight(self.frame)-topMargin-_xMarkSize.height-_xMarkSpceXAxis)/(self.yAxisTitles.count-1);
        viewHeight = self.frame.size.height;
    }else{
        
        viewHeight = self.ySpaceUnitLength *(self.xAxisTitles.count-1)+_xMarkSize.height+topMargin+_xMarkSpceXAxis;
        
    }
    self.yAxisLength = self.ySpaceUnitLength *(self.yAxisTitles.count-1);
    
    if (self.xSpaceUnitLength == 0) {
        self.xSpaceUnitLength = (CGRectGetWidth(self.frame)-_yMarkSize.width-_yMarkSpceYAxis-rightMargin)/(self.xAxisTitles.count-1);
        viewWidth =self.frame.size.width-rightMargin;
    }else{
        
        viewWidth =self.xSpaceUnitLength*(self.xAxisTitles.count-1)+_yMarkSize.width+_yMarkSpceYAxis+_xMarkSize.width/2;
    }
    
    self.xAxisLength = self.xSpaceUnitLength*(self.xAxisTitles.count-1);
    
    self.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    
    CGFloat star_x =_yMarkSpceYAxis+_yMarkSize.width;
    CGFloat star_y = topMargin;
    self.startPoint = CGPointMake(star_x, star_y);
}

-(void)reloadDraw{
    
    [self clear];
    
    [self startDraw];
    
}

-(void)clear{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
}



@end
