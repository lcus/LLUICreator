//
//  LLCycleScrollView.m
//  SubProject
//
//  Created by lcus on 2018/5/25.
//  Copyright © 2018年 lcus. All rights reserved.
//

#import "LLCycleScrollView.h"
#import "UIImageView+AFNetworking.h"


@interface UIView (LL_EidtFrame)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@end

@implementation UIView(LL_EidtFrame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
@end



@interface LLCycleScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * scroller;
@property(nonatomic,strong) UIPageControl * pageControl;

@property(nonatomic,strong) NSMutableArray * imageViewArray;

@property(nonatomic,strong) NSTimer * timer;

@property(nonatomic,assign) BOOL    autoScroller;


@end

@implementation LLCycleScrollView{
  
    NSInteger    _imageCurrenIndex;
}



-(instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _autoScroller =autoScroll;
        _imageViewArray =[NSMutableArray array];
        _autoScroller = autoScroll;
        
        [self addSubview:self.scroller];
        [self addSubview:self.pageControl];
    }
    return self;
    
}

-(void)autoScroll{
    
    CGFloat targetX = _scroller.contentOffset.x + self.bounds.size.width;
    [_scroller setContentOffset:CGPointMake(targetX, 0) animated:YES];
    
}


-(void)setImages:(NSArray *)images{
    
    _images =images;
    _imageCurrenIndex = 0;
    
    [self creatImageViewWithCount:images.count];
    
    for (int i=0; i<_imageViewArray.count; i++) {
        
        UIImageView *imageView =[_imageViewArray objectAtIndex:i];
        
        NSInteger tempIndex =(i==0)?(_images.count-1):i-1;
        
        imageView.image =[_images objectAtIndex:tempIndex];
    }
    if (_autoScroller) {
        
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:5];
    }
    
}

-(void)setImageURLS:(NSArray *)imageURLS{
    
    _imageURLS = imageURLS;
    
    _imageCurrenIndex = 0;
    
    [self creatImageViewWithCount:imageURLS.count];
    
    for (int i=0; i<_imageViewArray.count; i++) {
        
        UIImageView *imageView =[_imageViewArray objectAtIndex:i];
        
        NSInteger tempIndex =(i==0)?(_imageURLS.count-1):i-1;
        
        [imageView setImageWithURL:[NSURL URLWithString:[_imageURLS objectAtIndex:tempIndex]]];
    }
    
    if (_autoScroller) {
        
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:5];
    }
    
    
}


-(void)creatImageViewWithCount:(NSInteger)count{
    
    if (count == 0) return;
    
    _pageControl.numberOfPages = count;
    
    if (count == 2 ) {
        
        _pageControl.numberOfPages = 2;
    }
    
    _pageControl.width = count*20;
    _pageControl.x= self.width/2 -_pageControl.width/2;
    
    NSInteger number =count>1?3:1;
    
    for (int i=0; i<number; i++) {
        
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*self.width, 0, self.width, self.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [_scroller addSubview:imageView];
        [_imageViewArray addObject:imageView];
        
    }
    
    [_scroller setContentSize:CGSizeMake(number*self.width, 0)];
    [_scroller setContentOffset:CGPointMake(number/3*self.width, 0)];
    
}


-(void)clickTap{
    
    self.didClickIndexImage? self.didClickIndexImage(_imageCurrenIndex):nil;
    
}

-(UIScrollView *)scroller{
    
    if (!_scroller) {
        
        _scroller =[[UIScrollView alloc]initWithFrame:self.bounds];
        _scroller.delegate =self ;
        _scroller.showsVerticalScrollIndicator =NO;
        _scroller.showsHorizontalScrollIndicator =NO;
        _scroller.pagingEnabled =YES;
        _scroller.bounces = NO;
        _scroller.scrollsToTop = NO;
        _scroller.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
        [_scroller addGestureRecognizer:tap];
    }
    
    return _scroller;
}
-(UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(10,self.height-20, self.width-10, 20)];
        _pageControl.hidesForSinglePage =YES;
        _pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
    }
    return _pageControl;
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
}
// 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (_images.count>0) {
        
        [self imagesCycelScrollView:scrollView];
    }else if (_imageURLS.count>0){
        
        [self urlImagesCycleScrollView:scrollView];
    }
    
    _pageControl.currentPage = _imageCurrenIndex%_pageControl.numberOfPages;
    
    [scrollView setContentOffset:CGPointMake(scrollView.width, 0)];
    if(_autoScroller)
    {[self performSelector:@selector(autoScroll) withObject:nil afterDelay:5];}
}

-(void)imagesCycelScrollView:(UIScrollView*)scrollView{
    //往左
    if (scrollView.contentOffset.x == 0) {
        
        _imageCurrenIndex =(_imageCurrenIndex ==0)?(self.images.count-1):_imageCurrenIndex-1;
        
      
        for (UIImageView *imageView in _imageViewArray) {
            
            
            imageView.x+= scrollView.width;
            
            if (imageView.x ==_scroller.width*3) {
                
                imageView.x= 0;
                
                NSInteger tempIndex = (_imageCurrenIndex ==0)?(_images.count-1):_imageCurrenIndex-1;
                
                imageView.image =[_images objectAtIndex:tempIndex];
            }
            
        }
        if (_imageViewArray.count>2) {
            
            [_imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
            [_imageViewArray exchangeObjectAtIndex:1 withObjectAtIndex:2];
        }
        
        
    }else if (scrollView.contentOffset.x ==scrollView.width*2){
        
        _imageCurrenIndex = (_imageCurrenIndex == (_images.count -1)) ? 0 : (_imageCurrenIndex + 1);
        for (UIImageView *imageView in _imageViewArray)
        {
            imageView.x -= scrollView.frame.size.width;
            if (imageView.x == -scrollView.frame.size.width)
            {
                imageView.x = scrollView.frame.size.width*2;
                NSInteger tmpIndex = (_imageCurrenIndex == (_images.count - 1)) ? 0 : (_imageCurrenIndex + 1);
                imageView.image = [_images objectAtIndex:tmpIndex];
            }
        }
        if (_imageViewArray.count > 2) {
            [_imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
            [_imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
        }
    }
    
}
-(void)urlImagesCycleScrollView:(UIScrollView*)scrollView{
    
    if (scrollView.contentOffset.x ==0) {
        
        _imageCurrenIndex = (_imageCurrenIndex ==0)?self.imageURLS.count-1:_imageCurrenIndex-1;
        
        for (UIImageView *imageView in _imageViewArray) {
            
            
            imageView.x+=scrollView.width;
            
            if (imageView.x ==_scroller.width*3) {
                
                imageView.x = 0;
                
                NSInteger tempIndex = (_imageCurrenIndex==0)?self.imageURLS.count-1:_imageCurrenIndex-1;

                
                
                [imageView setImageWithURL:[NSURL URLWithString:[_imageURLS objectAtIndex:tempIndex]]];
                 
                
            }
            
        }
        
        
    }else if (scrollView.contentOffset.x ==scrollView.width*2){
        
        
        _imageCurrenIndex = (_imageCurrenIndex == (_imageURLS.count -1)) ? 0 : (_imageCurrenIndex + 1);
        for (UIImageView *imageView in _imageViewArray)
        {
            imageView.x -= scrollView.frame.size.width;
            if (imageView.x == -scrollView.frame.size.width)
            {
                imageView.x = scrollView.frame.size.width*2;
                NSInteger tmpIndex = (_imageCurrenIndex == (_imageURLS.count - 1)) ? 0 : (_imageCurrenIndex + 1);
//                [imageView sd_setImageWithURL:[NSURL URLWithString:[_imageURLS objectAtIndex:tmpIndex]] placeholderImage:nil];
                [imageView setImageWithURL:[NSURL URLWithString:[_imageURLS objectAtIndex:tmpIndex]]];
            }
        }
        
    }
    

}




@end
