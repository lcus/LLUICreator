//
//  LLCycleScrollView.h
//  SubProject
//
//  Created by lcus on 2018/5/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCycleScrollView : UIView

@property(nonatomic,strong) NSArray * imageURLS;
@property(nonatomic,strong) NSArray * images;
@property(nonatomic,copy) void (^didClickIndexImage)(NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll;


@end
