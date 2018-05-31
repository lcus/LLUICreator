//
//  LCZDataModel.m
//  SingleTest
//
//  Created by lcus on 2018/3/29.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDTableViewHandel.h"




@interface LCTableViewDataItem : NSObject

@property(nonatomic,strong)NSMutableArray *itmesArray;

-(instancetype)initWithDataArray:(NSArray*)dataArray;

@end

@interface LCTableViewDataModel : NSObject

-(NSInteger)getSectionCount;
-(id )getSectionData:(NSInteger)index;

-(NSDictionary*)getIndexData:(NSIndexPath*)indexpath;

-(void)updateIndexData:(NSIndexPath*)index data:(NSDictionary*)dict;

-(instancetype)initWithDataArray:(NSArray<NSArray*>*)array;
-(void)removeDatasWithArray:(NSArray<NSIndexPath*>*)array;

@end


@interface LCTableViewDataSource ()

@property(nonatomic,strong) LCTableViewDataModel * model;
@property(nonatomic,strong) LCTableViewCellConfig * cellConfig;
@property(nonatomic,copy)   TableViewCellConfigureBlock configBlock;
@property(nonatomic,copy)   TableViewMultitCellConfig multicellConfig;

@end

@implementation LCTableViewDataSource



-(instancetype)initWithData:(NSArray<NSArray *> *)data mutalCellConfig:(TableViewMultitCellConfig)mutalCellConfig tableViewCellConfig:(TableViewCellConfigureBlock)configBlock{
    
    self = [super init];
    if (self) {
        
        self.model = [[LCTableViewDataModel alloc]initWithDataArray:data];;
        self.multicellConfig = mutalCellConfig;
        self.configBlock = configBlock;
    }
    return self;
    
}


-(instancetype)initWithData:(NSArray<NSArray *> *)dataArray cellClass:(Class)cellClass tableViewCellConfig:(TableViewCellConfigureBlock)configBlock{
    
    self = [super init];
    if (self) {
        
        self.model = [[LCTableViewDataModel alloc]initWithDataArray:dataArray];
        self.cellConfig = [[LCTableViewCellConfig alloc]initWithCellClass:cellClass];
        self.configBlock = configBlock;
    }
    return self;
    
}

-(void)setReloadData:(NSArray<NSArray *> *)data{
    
    self.model =[[LCTableViewDataModel alloc]initWithDataArray:data];
}

-(NSDictionary*)getIndexData:(NSIndexPath *)index{
    
    
    return [self.model getIndexData:index];
    
}

-(void)updateIndexData:(NSIndexPath *)index data:(NSDictionary *)data{
    
    [self.model updateIndexData:index data:data];
}

-(void)deleteIndexsData:(NSArray<NSIndexPath *> *)indexs{
    
    [self.model removeDatasWithArray:indexs];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return [self.model getSectionCount];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LCTableViewDataItem *item = (LCTableViewDataItem*)[self.model getSectionData:section];
    return item.itmesArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  LCTableViewDataItem *item = (LCTableViewDataItem*)[self.model getSectionData:indexPath.section];
    
   UITableViewCell *cell =[self _getCellWithTableView:tableView indexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setIndexPath:)]) {
        
        [cell performSelector:@selector(setIndexPath:) withObject:indexPath];
        
    }
    
    id cellData =item.itmesArray[indexPath.row];
    
    if (self.configBlock) {
        self.configBlock(tableView,cell, cellData);
    }
    
    return cell;
}

-(UITableViewCell*)_getCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    UITableViewCell *cell = nil;
    if (self.multicellConfig) {
        
        LCTableViewCellConfig* config = self.multicellConfig(tableView,indexPath);
        cell =[self _getCellWithConfig:config tableView:tableView];
        
    }else{
    
        cell =[self _getCellWithConfig:self.cellConfig tableView:tableView];
    }
    
    return cell;
    
}
-(UITableViewCell*)_getCellWithConfig:(LCTableViewCellConfig*)config tableView:(UITableView*)tableView{
    
   UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:config.cellIdentifier];
    if (!cell) {
        
        cell  =[[config.cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:config.cellIdentifier];
    }
    return cell;
}

@end


@implementation LCTableViewDelegate


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.willDisplay) {
        self.willDisplay(tableView, cell, indexPath);
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.headerView) {
        
        UIView * headeView = self.headerView(tableView,section);
        
        return headeView;
    }
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  self.heightBlock?self.heightBlock(tableView,indexPath):UITableViewAutomaticDimension;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.didSelectBlock) {
        
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        
        self.didSelectBlock(tableView, cell, indexPath);
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.headerHeightBlock) {
        
        return self.headerHeightBlock(section);
    }
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.footerHeightBlock) {
        
        return self.footerHeightBlock(section);
    }
    return CGFLOAT_MIN;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellEditStyle) {
        
        return  self.cellEditStyle(indexPath);
    }
    
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    if (self.canEdit) {
        
        return self.canEdit(tableView,indexPath);
    }
    return NO;
}




@end


@interface LCTableViewDataModel ()
@property(nonatomic,readonly) NSMutableArray <LCTableViewDataItem*>* sectionArray;
@end

@implementation LCTableViewDataModel

@synthesize sectionArray=_sectionArray;

-(NSInteger)getSectionCount{
    
    return self.sectionArray.count;
    
}

-(NSDictionary *)getIndexData:(NSIndexPath *)indexpath{
    
    LCTableViewDataItem *item = [self getSectionData:indexpath.section];
    
    return item.itmesArray[indexpath.row];
    
}

-(id)getSectionData:(NSInteger)index{
    
    return self.sectionArray[index];
}

-(void)removeDatasWithArray:(NSArray<NSIndexPath*>*)array{
    
  
    NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
    [array enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [insets addIndex:obj.row];
    }];
    
    LCTableViewDataItem *item = [self getSectionData:0];

    [item.itmesArray removeObjectsAtIndexes:insets];
    
}

-(void)updateIndexData:(NSIndexPath *)index data:(NSDictionary *)dict{
    
    LCTableViewDataItem *item =[self getSectionData:index.section];
    [item.itmesArray replaceObjectAtIndex:index.row withObject:dict];
}

-(instancetype)initWithDataArray:(NSArray<NSArray*>*)array{
    
    if (array.count==0) return nil;
    
    LCTableViewDataModel *modle =[[LCTableViewDataModel alloc]init];
    
    NSArray *data = [self handelConfigData:array];

    
    for (NSArray *temp in data) {
        
        LCTableViewDataItem *item =[[LCTableViewDataItem alloc]initWithDataArray:temp];
        [modle.sectionArray addObject:item];
    }
    return modle;
}

-(NSMutableArray<LCTableViewDataItem *> *)sectionArray{
    if (!_sectionArray) {
        
        _sectionArray =[NSMutableArray array];
    }
    return _sectionArray;
}

-(NSArray *)handelConfigData:(NSArray *)data{
    
    NSAssert(data.count>0, @"数据源不能为空");
    id indexData = data[0];
    
    if ([[indexData class]isKindOfClass:[NSArray class]]||[[indexData class] isSubclassOfClass:[NSArray class]]) {
        
        return data;
    }
    NSMutableArray *warp =[NSMutableArray array];
    
    [warp addObject:data];
    
    return warp;
}



@end



@implementation LCTableViewDataItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itmesArray=[NSMutableArray array];
    }
    return self;
}
-(instancetype)initWithDataArray:(NSArray *)dataArray{
    
    LCTableViewDataItem *item =[[LCTableViewDataItem alloc]init];
    [item.itmesArray addObjectsFromArray:dataArray];
    
    return item;
}

@end


@implementation LCTableViewCellConfig

-(instancetype)initWithCellClass:(Class)cellClass{
    
    self = [super init];
    if (self) {
        _cellClass=cellClass;
        _cellIdentifier =NSStringFromClass(cellClass);
    }
    return self;
    
}

- (instancetype)initWithCellIdentifier:(NSString *)Identifier cellClass:(Class)cellClass
{
    self = [super init];
    if (self) {
        
        _cellIdentifier = Identifier;
        _cellClass=cellClass;
    }
    return self;
}


@end


