//
//  ZYPhotoBrowserController.m
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ZYPhotoBrowser.h"
#import "ZYPhotoBrowserCell.h"
#import "ZYPhotoBrowserAnimate.h"
@interface ZYPhotoBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource
,UIViewControllerTransitioningDelegate,ZYPhotoBrowserCellDelegate>{
   
}

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) ZYPhotoBrowserAnimate *animate;

@property(nonatomic,strong) NSArray *images;

@property(nonatomic,assign) NSInteger currentIndex;

@property(nonatomic,strong) UIImageView *startView;

@property(nonatomic,assign) id<ZYPhotoBrowserDelegate> delegate;

@end

#define KLineSpace 10

static NSString *const photoCellId = @"photoCellId";

@implementation ZYPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    if ([self.delegate respondsToSelector:@selector(photoBrowserImages)]) {
        self.images = [self.delegate photoBrowserImages];
    }
    [self initSubviews];
    
    
    
    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * (CGRectGetWidth(self.view.frame) + KLineSpace), 0)];
}

- (void)initSubviews{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, KLineSpace);
    layout.minimumLineSpacing = KLineSpace;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)+KLineSpace, CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;

    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ZYPhotoBrowserCell class] forCellWithReuseIdentifier:photoCellId];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-50, CGRectGetWidth(self.view.frame), 10);
    _pageControl.numberOfPages = self.images.count;
    _pageControl.currentPage = self.currentIndex;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_pageControl];
    
}

- (void)setStartView:(UIImageView *)startView{
    _startView = startView;
    self.animate.startView = startView;
}

#pragma mark - collectionView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    _pageControl.currentPage = self.currentIndex;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZYPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellId forIndexPath:indexPath];
    cell.image = self.images[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark  - collectionCell delegate
- (void)photoBrowserDismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.animate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    ZYPhotoBrowserCell *cell = (ZYPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    self.animate.startView = cell.photoImgView;
    if ([self.delegate respondsToSelector:@selector(getStartViewWithIndex:)]) {
        self.animate.endView = (UIImageView *)[self.delegate getStartViewWithIndex:self.currentIndex];
    }

    return self.animate;
}



- (ZYPhotoBrowserAnimate *)animate{
    if (!_animate) {
        _animate = [[ZYPhotoBrowserAnimate alloc] init];
        _animate.duration = .3;
    }
    return _animate;
}


+ (void)photoBroswerShowWithIndex:(NSInteger)currentIndex startView:(UIImageView *)startView presentVc:(UIViewController *)presentVc photoBrowserDelegate:(id<ZYPhotoBrowserDelegate>)delegate{
    
    ZYPhotoBrowser *browser = [[ZYPhotoBrowser alloc] init];
    browser.currentIndex = currentIndex;
    browser.startView = startView;
    browser.delegate = delegate;
    [presentVc presentViewController:browser animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
