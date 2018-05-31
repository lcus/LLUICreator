//
//  NSObject+MethodCollection.h
//  SingleTest
//
//  Created by lcus on 2018/3/30.
//  Copyright © 2018年 lcus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



@interface NSObject (MethodCollection)

void LD_callBlackMessage(id target,NSString*actionName,id pramer,void(*callback));

void LD_addSubViews(UIView *target,NSArray<UIView*>* views);

UIColor* LD_color(CGFloat r, CGFloat g,CGFloat b,CGFloat a);
UIColor* LD_RandomColor(void);

UIFont *LD_sysFont(CGFloat size);
UIFont *LD_sysBoldFont(CGFloat size);
//empty
BOOL LD_emptyString(NSString *string);
BOOL LD_emptyArray(NSArray * array);
BOOL LD_emptyDiction(NSDictionary *dict);

BOOL LD_validateEmail(NSString *email);
BOOL LD_validatePhone(NSString *phoneNumber);


NSString *LD_homePath(void);
NSString *LD_libraryPath(void);

NSString *LD_md5(NSString *str);
NSString *LD_random32char(void);


void LD_userDefaultsSaveValue(NSString *key,id value);
id  LD_userDefaultGetValue(NSString*key);

@end






