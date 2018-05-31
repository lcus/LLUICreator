//
//  LDDataPikerController.h
//  SubProject
//
//  Created by lcus on 2018/5/7.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDDataPikerController : UIViewController

-(instancetype)initWithDataSource:(NSArray*)dataSource selected:(void(^)(NSInteger index,NSString*value))selected;



@end
