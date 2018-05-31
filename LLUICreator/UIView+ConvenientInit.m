//
//  UIView+ConvenientInit.m
//  SingleTest
//
//  Created by lcus on 2018/4/2.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "UIView+ConvenientInit.h"

@implementation UIView (ConvenientInit)

UITableView *LD_TableView(CGRect rect){
    
    UITableView *listTablview =[[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];

    listTablview.estimatedSectionHeaderHeight = 0;
    listTablview.estimatedSectionFooterHeight = 0;
    listTablview.estimatedRowHeight = 100;
    listTablview.rowHeight = UITableViewAutomaticDimension;
    return listTablview;
};

UIView * LD_ColorView(UIColor *backgroundColor){
    UIView *view =[UIView new];
    view.backgroundColor=backgroundColor;
    
   
    return view;
}

UIButton *LD_fillButton(UIColor* fileColor,NSString*text,NSInteger cornerRaius){

    UIButton *relust =[UIButton new];
    
    if (!fileColor) {
        [relust setBackgroundColor: [UIColor colorWithRed:0.00 green:0.55 blue:0.49 alpha:1.00]];
    }else{
        [relust setBackgroundColor:fileColor];
    }
    
    [relust setTitle:text forState:UIControlStateNormal];
    [relust setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    LD_ViewCorner(relust, cornerRaius, false);
    
    return relust;
}

UIButton *lD_borderButton(UIButton*button,UIColor* bordeColor,NSString*text,NSInteger cornerRaius){
    
    UIButton *result= [UIButton new];
    
    LD_ViewBorder(button, bordeColor, 1);
    LD_ViewCorner(button, cornerRaius, false);
    [result setTitle:text forState:UIControlStateNormal];
    [result setTitleColor:LD_color(25, 120, 107, 1) forState:UIControlStateNormal];
    return result;
}


void LD_ViewBorder(UIView *target,UIColor*borderColor,CGFloat borderWidth){
    
    if (!target) return;
    target.layer.borderColor = borderColor.CGColor;
    target.layer.borderWidth =borderWidth;
 
};


void LD_ViewCorner(UIView *target,CGFloat cornerRadius,BOOL clip){
    if (!target)return;
    target.layer.cornerRadius=cornerRadius;
    target.layer.masksToBounds=clip;
}


void LD_evaluteLabel(UILabel *target,UIColor *bgColor,UIFont *font,UIColor*textColor,NSTextAlignment aligment,NSInteger lines){
    
    if (!target) return;
    target.backgroundColor=bgColor;
    target.font = font;
    target.textColor = textColor;
    target.textAlignment= aligment;
    target.numberOfLines=lines;
}

void LD_evaluteTextField(UITextField *target,NSString* placeholder,UIColor *bgColor,UIFont *font,UIColor*textColor,NSTextAlignment aligment){
    if(!target)return;
    
    target.placeholder =placeholder;
    target.backgroundColor=bgColor;
    target.font =font;
    target.textColor =textColor;
    target.textAlignment=aligment;
};

void LD_evaluteButtonTitle(UIButton*target,NSString*title,NSString* selectTitle,UIColor *bgColor){
    if (!target) return;
    [target setTitle:title forState:UIControlStateNormal];
    [target setTitle:selectTitle forState:UIControlStateSelected];
    [target setBackgroundColor:bgColor];
    [target setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
};
void LD_evaluteButtonImage(UIButton *target,NSString *imageName,NSString*selctImageName,NSString*bgImageName,NSString*selectBgImageName){
    
    if (!target) return;
    
    [target setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [target setImage:[UIImage imageNamed:selctImageName] forState:UIControlStateSelected];
    if (bgImageName) {
        
        [target setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (selctImageName) {
        
        [target setBackgroundImage:[UIImage imageNamed:selctImageName] forState:UIControlStateSelected];
    }
    
}








@end




