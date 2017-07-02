//
//  ViewController.m
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "ZYPhotoBrowser.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZYPhotoBrowserDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSArray *imgsArr;


@end

static NSString *const cellId = @"collectionCellId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSubviews];
    [self initDataSource];
    
}

- (void)initSubviews{
    CGFloat width = (CGRectGetWidth(self.view.frame) - 20)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
}

- (void)initDataSource{
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 0; i<9; i++) {
        NSString *imgName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"aima%i",i] ofType:@"jpeg"];
        UIImage *image = [UIImage imageWithContentsOfFile:imgName];
        [imgs addObject:image];
    }
    self.imgsArr = [imgs copy];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.image = self.imgsArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [ZYPhotoBrowser photoBroswerShowWithIndex:indexPath.item startView:cell.imageV presentVc:self photoBrowserDelegate:self];
}

#pragma mark - photobrowser delegate
- (UIView *)getStartViewWithIndex:(NSInteger)index{
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return cell.imageV;
}

- (NSArray *)photoBrowserImages{
    return self.imgsArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
