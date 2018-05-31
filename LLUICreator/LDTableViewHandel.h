//
//  LCZDataModel.h
//  SingleTest
//
//  Created by lcus on 2018/3/29.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LCTableViewDataSource;
@class LCTableViewDelegate;
@class LCTableViewCellConfig;


typedef void  (^TableViewCellConfigureBlock)(UITableView *target,id cell,id cellData);
typedef double (^TableViewCellHeight)(UITableView *tabview,NSIndexPath *indexPath);

typedef void(^TableViewDidSelect)(UITableView *tabview,id cell,NSIndexPath *indexPath);

typedef LCTableViewCellConfig*(^TableViewMultitCellConfig)(UITableView *tabView,NSIndexPath *indexPath);

typedef Class *(^TableViewMultitCellClassConfig)(UITableView *tabView,NSIndexPath *indexPath);

typedef void(^CellWillDisplay)(UITableView *tablview,UITableViewCell*cell,NSIndexPath *indexPaht);

typedef double(^TabViewHeaderHeightBlock)(NSInteger section);
typedef double(^TabviewFooterHeightBlock)(NSInteger section);

typedef UITableViewCellEditingStyle(^cellEditStype)(NSIndexPath *indexpath);

typedef BOOL(^canEdit)(UITableView *,NSIndexPath*);


@interface LCTableViewDataSource : NSObject<UITableViewDataSource>
//单行
-(instancetype)initWithData:(NSArray<NSArray*>*)data
                 mutalCellConfig:(TableViewMultitCellConfig)mutalCellConfig
             tableViewCellConfig:(TableViewCellConfigureBlock)configBlock;

//多行
-(instancetype)initWithData:(NSArray<NSArray*>*)dataArray
                  cellClass:(Class)cellClass
        tableViewCellConfig:(TableViewCellConfigureBlock)configBlock;

//reload
-(void)setReloadData:(NSArray<NSArray*>*)data;
//indexpath data
-(NSDictionary*)getIndexData:(NSIndexPath*)index;
//update
-(void)updateIndexData:(NSIndexPath*)index data:(NSDictionary*)data;

-(void)deleteIndexsData:(NSArray<NSIndexPath*>*)indexs;


@end


@interface LCTableViewDelegate : NSObject <UITableViewDelegate>

@property(nonatomic,copy) TableViewCellHeight heightBlock;
@property(nonatomic,copy) TableViewDidSelect didSelectBlock;
@property(nonatomic,copy) TabViewHeaderHeightBlock headerHeightBlock;
@property(nonatomic,copy) TabviewFooterHeightBlock footerHeightBlock;
@property(nonatomic,copy) CellWillDisplay willDisplay;
@property(nonatomic,copy) cellEditStype cellEditStyle;
@property(nonatomic,copy) canEdit canEdit;
@property(nonatomic,copy) UIView* (^headerView)(UITableView *tableView,NSInteger section);

@end


@interface LCTableViewCellConfig : NSObject

-(instancetype)initWithCellClass:(Class)cellClass;

-(instancetype)initWithCellIdentifier:(NSString*)Identifier cellClass:(Class)cellClass;

@property(nonatomic,copy) NSString * cellIdentifier;
@property(nonatomic,assign) Class  cellClass;
@property(nonatomic,strong) NSString *publicKey;

@end









