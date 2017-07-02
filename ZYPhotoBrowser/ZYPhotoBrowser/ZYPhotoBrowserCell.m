//
//  ZYPhotoBrowserCell.m
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ZYPhotoBrowserCell.h"

@interface ZYPhotoBrowserCell()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;


@end

@implementation ZYPhotoBrowserCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _photoImgView = [[UIImageView alloc] init];
        _photoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImgView.userInteractionEnabled = YES;
        [self.scrollView addSubview:_photoImgView];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scalePhotoImageView)];
        doubleTap.numberOfTapsRequired = 2;
        [_photoImgView addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    self.photoImgView.image = image;
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat imgH = image.size.height * winSize.width/image.size.width;
    self.scrollView.frame = self.bounds;
    self.scrollView.zoomScale = 1.0;
    self.photoImgView.frame = CGRectMake(0, 0, winSize.width, imgH);
    self.photoImgView.center = CGPointMake(winSize.width/2, winSize.height/2);
}

- (CGPoint)photoImgVCenter{
    CGFloat y = self.scrollView.contentSize.height/2;
    if (self.scrollView.zoomScale == 1. || self.scrollView.contentSize.height < CGRectGetHeight(self.scrollView.bounds)) {
        y = CGRectGetHeight(self.scrollView.bounds)/2;
    }
    return CGPointMake(self.scrollView.contentSize.width/2, y);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photoImgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    self.photoImgView.center = [self photoImgVCenter];
}

- (void)scalePhotoImageView{
    float scale = self.scrollView.maximumZoomScale;
    if (self.scrollView.zoomScale == self.scrollView.maximumZoomScale) {
        scale = 1.0;
    }
    [self.scrollView setZoomScale:scale animated:YES];
}

- (void)singleTapAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserDismiss)]) {
        [self.delegate photoBrowserDismiss];
    }
}

@end
