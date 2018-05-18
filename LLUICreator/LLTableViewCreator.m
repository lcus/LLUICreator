//
//  LLTableViewCreator.m
//  testFramWork
//
//  Created by lcus on 2018/5/14.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLTableViewCreator.h"
#import "LLViewCreator.h"
@interface LLTableViewCreator ()

@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,assign) UITableViewStyle style;

@end

@implementation LLTableViewCreator


- (instancetype)init
{
    self = [super init];
    if (self) {
        LLWeakSelf(self)
        _frameStyle = ^LLTableViewCreator *(CGRect frame, UITableViewStyle style) {
            LLStrongSelf(self)
            self.tableView =[[UITableView alloc]initWithFrame:frame style:style];
            self.tableView.estimatedSectionHeaderHeight = 0;
            self.tableView.estimatedSectionFooterHeight = 0;
            self.tableView.estimatedRowHeight = 100;
            self.tableView.rowHeight = UITableViewAutomaticDimension;
    
            return self;
        };
        _delegate = ^LLTableViewCreator *(id<UITableViewDelegate> delegate) {
            LLStrongSelf(self);
            self.tableView.delegate = delegate;
            return self;
        };
        _dataSource = ^LLTableViewCreator *(id<UITableViewDataSource> delegate) {
            LLStrongSelf(self)
            self.tableView.dataSource = delegate;
            return self;
        };
       _separatorStyle = ^LLTableViewCreator *(UITableViewCellSeparatorStyle style) {
            LLStrongSelf(self)
           self.tableView.separatorStyle =style;
           return self;
       };
        _rowHeight = ^LLTableViewCreator *(CGFloat rowHeight) {
            LLStrongSelf(self)
            self.tableView.rowHeight =rowHeight;
            return self;
        };
        _frame = ^LLTableViewCreator *(CGRect rect) {
            LLStrongSelf(self)
            self.tableView.frame = rect;
            return self;
        };
        _superView = ^LLTableViewCreator *(UIView *superView) {
          LLStrongSelf(self)
            if (superView) {
                
                [superView addSubview:self.tableView];
            }
            return self;
        };
        _scrollEnabled =^LLTableViewCreator*(BOOL scrollEnabled){
            
            LLStrongSelf(self)
            self.tableView.scrollEnabled = scrollEnabled;
            return self;
        };
        
    }
    return self;
}

-(UITableView*)tableView{
    
    if (!_tableView) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}


@end


@implementation UITableView(LLTableViewCreator)


+(UITableView *)ll_tableViewWithMaker:(void (^)(LLTableViewCreator *))maker{
    
    LLTableViewCreator * uimaker =[[LLTableViewCreator alloc]init];
    if (maker) {
        maker(uimaker);
    }
    return (id)uimaker.tableView;
}

@end

