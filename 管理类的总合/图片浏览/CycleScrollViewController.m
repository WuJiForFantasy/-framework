//
//  ViewController.m
//  test
//
//  Created by 张鹏 on 14-4-30.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "CycleScrollViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "PageLabel.h"
@interface CycleScrollViewController () <UIScrollViewDelegate,UIAlertViewDelegate> {
    
    NSMutableArray *_imageNames;
    NSMutableArray *_imageViews;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSInteger _currentPageIndex;
    PageLabel *_labelText;
    UIImageView *img;
    
    UIButton *delbtn;
}

@property (nonatomic,strong) UITapGestureRecognizer *singleTap;

@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic,assign) CGFloat zoomScale;

@property (nonatomic,strong) UIDynamicAnimator *animator;

@property (nonatomic) BOOL myself;

@property (nonatomic) BOOL deleted;

- (void)initializeUserInterface;

@end

@implementation CycleScrollViewController

- (instancetype)initWithMixids:(NSArray *)mixId currentIndex:(int)index myself:(BOOL)myself{
    
    self = [super init];
    if (self) {
        _myself=myself;
        _deleted=NO;
        _imageNames = [NSMutableArray arrayWithArray:mixId];
        _imageViews = [NSMutableArray array];
        _currentPageIndex = index;
        _hideDelete = YES;
    }
    return self;
}

- (void)dealloc {
    
    _imageNames = nil;
    _imageViews = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUserInterface];
}


- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.bounds, -4, 0)];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * _imageNames.count,
                                         CGRectGetHeight(_scrollView.bounds));
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds)*(_currentPageIndex), 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bouncesZoom = YES;
    _scrollView.bounces = YES;
    _scrollView.canCancelContentTouches = YES;
    _scrollView.delaysContentTouches = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    if (_imageNames.count == 1) {
        _scrollView.scrollEnabled = NO;
    }
    
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _imageNames.count; i++) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.bounds = self.view.frame;
        scrollView.center = CGPointMake(CGRectGetWidth(_scrollView.bounds) / 2 + CGRectGetWidth(_scrollView.bounds) * i,
                                        CGRectGetHeight(_scrollView.bounds) / 2);
        scrollView.contentSize = self.view.frame.size;
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 1.0;
        scrollView.zoomScale = 1.0;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView addSubview:scrollView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [_imageViews addObject:imageView];
        if (_imageNames) {
            if (_myself) {
                imageView.image = _imageNames[i];
            }else {
                [imageView sd_setImageWithURL:[NSURL URLWithString:_imageNames[i]]
                             placeholderImage:nil
                                      options:SDWebImageCacheMemoryOnly
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    }];
            }
           
        }
        [scrollView addSubview:imageView];
        
        
            self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
            self.singleTap.numberOfTapsRequired = 1;
            [imageView addGestureRecognizer:self.singleTap];
            
            self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
            self.doubleTap.numberOfTapsRequired = 2;
            [imageView addGestureRecognizer:self.doubleTap];
            
            [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    }
    _labelText = [[PageLabel alloc]init];
    _labelText.bounds = CGRectMake(0, 0, 320, 20);
    _labelText.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMaxY(self.view.bounds) - 50);
    if (_imageNames.count >1) {
        _labelText.numberOfPages = [_imageNames count];
    }
    else {
        _labelText.numberOfPages = 0;
    }
    [self.view addSubview:_labelText];
    _labelText.currentPage = _currentPageIndex;
    [_labelText labelText];
  
        img=[[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-20)/2, 40, 20, 20)];

        img.image=[UIImage imageNamed:@"ic_delete"];
        delbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 30)];
        delbtn.backgroundColor=[UIColor clearColor];
        [delbtn addTarget:self action:@selector(ButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:img];
        [self.view addSubview:delbtn];
    if (_hideDelete) {
        img.hidden = YES;
        delbtn.hidden = YES;
    }else {
        img.hidden = NO;
        delbtn.hidden = NO;
    }
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

}

- (void)popLastViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)ButtonPressed{
    UIAlertView *view=[[UIAlertView alloc] initWithTitle:nil message:@"确定要删除该照片?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [view show];
}

#pragma mark - tapGestureEvent

- (void)singleTap:(UITapGestureRecognizer *)tap {
    if (_deleted) {
        [_delegate updateui];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    
    UIScrollView *scrollView = (UIScrollView *)tap.view.superview;
    
    if (scrollView.zoomScale == scrollView.minimumZoomScale) {
        // Zoom in
        CGPoint center = [tap locationInView:scrollView];
        CGSize size = CGSizeMake(scrollView.bounds.size.width / scrollView.maximumZoomScale,
                                 scrollView.bounds.size.height / scrollView.maximumZoomScale);
        CGRect rect = CGRectMake(center.x - (size.width / 2.0), center.y - (size.height / 2.0), size.width, size.height);
        [scrollView zoomToRect:rect animated:YES];
    }
    else {
        // Zoom out
        [scrollView zoomToRect:scrollView.bounds animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index= scrollView.contentOffset.x/self.view.bounds.size.width;
    _currentPageIndex=index;
    [_labelText setCurrentPage:index];
    [_labelText labelText];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {

        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

        for (int i = 0; i < _imageNames.count; i ++) {
            if (i == _currentPageIndex) {
                [_imageNames removeObjectAtIndex:i];
            }
        }
        if ([_delegate respondsToSelector:@selector(cycleScrollViewDeletItem:)]) {
            [_delegate cycleScrollViewDeletItem:_imageNames];
        }
        if ([_delegate respondsToSelector:@selector(cycleScrollViewDidFinishCurrentPageIndex:)]) {
            [_delegate cycleScrollViewDidFinishCurrentPageIndex:_currentPageIndex];
        }
    }
}

@end
