//
//  UITextField+LDDynamicText.m
//  SubProject
//
//  Created by lcus on 2018/4/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "UITextField+LDDynamicText.h"
#import "LDTextFieldHandel.h"
@import ObjectiveC.runtime;


@interface UITextField ()

@property(nonatomic,strong) LDTextFieldHandel * datahandel;

@end

@implementation UITextField (LDDynamicText)

-(NSMutableString *)dynamicText{
    
    
    return  self.datahandel.dynamicString;
}

-(LDTextFieldHandel *)datahandel{
    
    LDTextFieldHandel *hanlde = objc_getAssociatedObject(self, "setDatahandel:");
    
    if(!hanlde){
        
        hanlde = [[LDTextFieldHandel alloc]initWithTextField:self];
        
        [self setDatahandel:hanlde];
    }
    return hanlde;
    
}
-(void)setDatahandel:(LDTextFieldHandel *)datahandel{
    
    objc_setAssociatedObject(self, _cmd, datahandel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
