//
//  IntroductoryPagesView.m
//  YMTools
//
//  Created by longxian on 2018/9/25.
//  Copyright © 2018年 YM. All rights reserved.
//

#import "IntroductoryPagesView.h"
@interface IntroductoryPagesView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray<NSString *> *imagesArray;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (weak, nonatomic) UIScrollView *scrollView;
@end
@implementation IntroductoryPagesView

+ (instancetype)pagesViewWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images
{
    IntroductoryPagesView *pagesView = [[self alloc] initWithFrame:frame];
    pagesView.imagesArray = images;
    return pagesView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    // 添加手势
    UITapGestureRecognizer *singleRecongnizer;
    singleRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleRecongnizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:singleRecongnizer];
}

-(void)handleSingleTap
{
    if (_pageControl.currentPage == self.imagesArray.count-1) {
        [self removeFromSuperview];
    }
}

-(void)setImagesArray:(NSArray<NSString *> *)imagesArray {
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imagesArray.count + 1) * kWidth, kHeight);
    self.pageControl.numberOfPages = self.imagesArray.count;
    
    [self.imagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(idx * kWidth, 0, kWidth, kHeight);
        imageView.image = [UIImage imageNamed:obj];
        [self.scrollView addSubview:imageView];
    }];
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kWidth / 2.0, kHeight - 60, 0, 40)];
        pageControl.backgroundColor = [UIColor randomFlatColor];
        pageControl.pageIndicatorTintColor = [UIColor randomFlatColor];
        pageControl.currentPageIndicatorTintColor = [UIColor randomFlatColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = (offset.x / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = page;
    self.pageControl.hidden = (page > self.imagesArray.count - 1);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= (_imagesArray.count) * kWidth) {
        [self removeFromSuperview];
    }
}
@end
