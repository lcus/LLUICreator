//
//  LLPhotoPiker.h
//  SubProject
//
//  Created by lcus on 2018/5/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPhotoPiker : NSObject

-(instancetype)initWithPresetndViewContorller:(UIViewController*)viewContorller selected:(void(^)(UIImage *image))selected;

-(void)show;


@end
