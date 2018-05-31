//
//  LDTextFieldHandel.m
//  SubProject
//
//  Created by lcus on 2018/4/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LDTextFieldHandel.h"

#define LDTYPENUM @"0123456789"
#define LDTYPEALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define LDTYPEALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//inlie bool LD_compare(NSString*str){
//
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    return [string isEqualToString:filtered];
//}

@interface LDTextFieldHandel ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField * target;
@property(nonatomic,assign) NSUInteger    maxlimit;
@property(nonatomic,copy) void (^changeBlock)(NSString*str);
@property(nonatomic,copy) BOOL (^changFitter)(NSString *str);

@end

@implementation LDTextFieldHandel


@synthesize dynamicString=_dynamicString;

-(void)setMaxLimitNumber:(NSUInteger)max{
    
    self.maxlimit = max;
}

- (instancetype)initWithTextField:(UITextField *)textField
{
    self = [super init];
    if (self) {
        
        self.target = textField;
        self.target.delegate = self;
        _dynamicString =[NSMutableString string];
        
        [self.target addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}


-(void)ld_textFieldTextDidChangeWithUpdata:(void (^)(NSString *))update{
    
    [self ld_textFieldTextDidChangeWithUpdata:update fitter:nil];
    
}


-(void)ld_textFieldTextDidChangeWithUpdata:(void (^)(NSString *))update fitter:(BOOL (^)(NSString *))fitter{
    
    self.changeBlock = update;
    self.changFitter = fitter;
}


-(void)textFieldDidChange:(UITextField*)textField{
    
    [self.dynamicString replaceCharactersInRange:NSMakeRange(0, self.dynamicString.length) withString:textField.text];

    if (self.changFitter) {
        
        BOOL isNeedBlock =self.changFitter(textField.text);
        
        if (isNeedBlock) {
            
            self.changeBlock(textField.text);
        }
    }else{
        
        self.changeBlock(textField.text);
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
     [self.dynamicString replaceCharactersInRange:NSMakeRange(0, self.dynamicString.length) withString:textField.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_maxlimit>0) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > _maxlimit) {
            return NO;
        }
    }
    
    return YES;
}


@end
