//
//  LLTableViewCreator.h
//  testFramWork
//
//  Created by lcus on 2018/5/14.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LLTableViewCreator : NSObject

@property(nonatomic,copy,readonly) LLTableViewCreator * (^superView)(UIView *superView);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^frame)(CGRect rect);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^frameStyle)(CGRect frame,UITableViewStyle style);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^delegate)(id<UITableViewDelegate>delegate);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^dataSource)(id<UITableViewDataSource>delegate);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^separatorStyle)(UITableViewCellSeparatorStyle style);
@property(nonatomic,copy,readonly) LLTableViewCreator * (^rowHeight)(CGFloat rowHeight);


@end

@interface UITableView (LLTableViewCreator)

+(UITableView*)ll_tableViewWithMaker:(void(^)(LLTableViewCreator *maker))maker;


@end
