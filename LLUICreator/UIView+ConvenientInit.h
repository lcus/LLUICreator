//
//  UIView+ConvenientInit.h
//  SingleTest
//
//  Created by lcus on 2018/4/2.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConvenientInit)


UIView * LD_ColorView(UIColor *backgroundColor);
UITableView *LD_TableView(CGRect rect);

UIButton *LD_fillButton(UIColor* fileColor,NSString*text,NSInteger cornerRaius);

UIButton *lD_borderButton(UIButton*button,UIColor* bordeColor,NSString*text,NSInteger cornerRaius);



void LD_ViewBorder(UIView *target,UIColor*borderColor,CGFloat borderWidth);
void LD_ViewCorner(UIView *target,CGFloat cornerRadius,BOOL clip);


void LD_evaluteLabel(UILabel *target,UIColor *bgColor,UIFont *font,UIColor*textColor,NSTextAlignment aligment,NSInteger lines);

void LD_evaluteTextField(UITextField *target,NSString* placeholder,UIColor *bgColor,UIFont *font,UIColor*textColor,NSTextAlignment aligment);


void LD_evaluteButtonTitle(UIButton*target,NSString*title,NSString* selectTitle,UIColor *bgColor);
void LD_evaluteButtonImage(UIButton *target,NSString *imageName,NSString*selctImageName,NSString*bgImageName,NSString*selectBgImageName);




@end











