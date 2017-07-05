//
//  ZYPhotoBrowserController.h
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYPhotoBrowserDelegate <NSObject>

- (NSInteger)countOfShowImages;

//show images
- (NSArray *)photoBrowserImages;

//local image PHAsset
- (NSArray *)photoBrowserAssets;

- (NSArray *)photoBrowserImageUrls;

//根据index 拿到上一个视图中 imageView
- (UIView *)getStartViewWithIndex:(NSInteger)index;



@end


@interface ZYPhotoBrowser : UIViewController


+ (void)photoBroswerShowWithIndex:(NSInteger)currentIndex
                        startView:(UIImageView *)startView
                        presentVc:(UIViewController *)presentVc
             photoBrowserDelegate:(id<ZYPhotoBrowserDelegate>)delegate;

@end
