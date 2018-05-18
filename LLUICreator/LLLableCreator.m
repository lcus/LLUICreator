//
//  LLLableCreator.m
//  LearnSD
//
//  Created by lcus on 2018/5/10.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLLableCreator.h"

@interface LLLableCreator ()

@property(nonatomic,strong) UILabel * targetLabel;

@end

@implementation LLLableCreator

- (instancetype)init
{
    self = [super init];
    if (self) {
        LLWeakSelf(self)
        _text = ^LLLableCreator *(NSString *text) {
            LLStrongSelf(self)
            self.targetLabel.text =text;
            return self;
        };
        _font = ^LLLableCreator *(UIFont *font) {
            LLStrongSelf(self)
            self.targetLabel.font = font;
            return self;
        };
        _textColor = ^LLLableCreator *(UIColor *textColor) {
            LLStrongSelf(self)
            self.targetLabel.textColor = textColor;
            return self;
        };
        _textAlignment = ^LLLableCreator *(NSTextAlignment textAlignment) {
            LLStrongSelf(self)
            self.targetLabel.textAlignment = textAlignment;
            return self;
        };
        _numberOfLines = ^LLLableCreator *(NSInteger numberOfLines) {
            LLStrongSelf(self);
            self.targetLabel.numberOfLines = numberOfLines;
            return self;
        };
        _lineBreakMode = ^LLLableCreator *(NSLineBreakMode lineBreakMode) {
            LLStrongSelf(self);
            self.targetLabel.lineBreakMode =lineBreakMode;
            return self;
        };
        _adjustsFontSizeToFitWidth = ^LLLableCreator *(BOOL adjustsFontSizeToFitWidth) {
            LLStrongSelf(self);
            self.targetLabel.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
            return self;
        };
        _attributedText = ^LLLableCreator *(NSAttributedString *attributedText) {
            LLStrongSelf(self);
            self.targetLabel.attributedText = attributedText;
            return self;
        };
        _fontSize = ^LLLableCreator *(CGFloat fontSize) {
            LLStrongSelf(self);
            self.targetLabel.font =[UIFont systemFontOfSize:fontSize];
            return self;
        };
    }
    return self;
}

-(UILabel *)targetLabel{
 
    return (UILabel*)self.targetView;
}
@end

@implementation UILabel(LLLableCreator)

+(UILabel *)ll_labelMaker:(void (^)(LLLableCreator * maker))maker{
    
    void (^changeMaker)(LLViewCreator *maker) =(void(^)(LLViewCreator *))maker;
    return [super ll_viewMakeWithViewClass:[LLLableCreator class] maker:changeMaker];
}
-(void)ll_alignmentJustified{
    
    [self textAlignmentJustifiedWithWidth:CGRectGetWidth(self.frame)];
    
}
- (void)textAlignmentJustifiedWithWidth:(CGFloat)labelWidth{
    
    if (self.text==nil||labelWidth==0) return;
  
    UIFont *font =[UIFont systemFontOfSize:self.font.pointSize];
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :font}  context:nil].size;
    
    CGFloat margin = floor((labelWidth - size.width)/(self.text.length - 1));
    NSNumber *number = [NSNumber  numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString  alloc]  initWithString:self.text];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,self.text.length -1 )];
    
    self.attributedText = attribute;
}
- (void)textAlignmentLeftAndRight{
    
    [self textAlignmentJustifiedWithWidth:CGRectGetWidth(self.frame)];
}
@end
