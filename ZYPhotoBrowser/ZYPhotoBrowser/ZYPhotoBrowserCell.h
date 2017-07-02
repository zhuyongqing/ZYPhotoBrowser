//
//  ZYPhotoBrowserCell.h
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYPhotoBrowserCellDelegate <NSObject>

- (void)photoBrowserDismiss;

@end

@interface ZYPhotoBrowserCell : UICollectionViewCell

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,strong) UIImageView *photoImgView;

@property(nonatomic,assign) id<ZYPhotoBrowserCellDelegate> delegate;


@end
