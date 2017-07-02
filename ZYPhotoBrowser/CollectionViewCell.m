//
//  CollectionViewCell.m
//  ZYPhotoBrowser
//
//  Created by zhuyongqing on 2017/7/2.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()




@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.masksToBounds = YES;
        [self addSubview:_imageV];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageV.frame = self.bounds;
}

- (void)setImage:(UIImage *)image{
    self.imageV.image = image;
}

@end
