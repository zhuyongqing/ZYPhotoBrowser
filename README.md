# ZYPhotoBrowser
图片浏览器

![image](https://github.com/zhuyongqing/ZYPhotoBrowser/raw/master/browser.gif)

##使用

把ZYPhotoBrowser文件夹加到项目中,加入第三方SDWebImage
```obj-c
+ (void)photoBroswerShowWithIndex:(NSInteger)currentIndex
startView:(UIImageView *)startView
presentVc:(UIViewController *)presentVc
photoBrowserDelegate:(id<ZYPhotoBrowserDelegate>)delegate;
```
传入当前图片的index,当前图片的UIImageView,当前的VC,ZYPhotoBrowserDelegate代理
然后要实现代理方法

```obj-c
@protocol ZYPhotoBrowserDelegate <NSObject>

- (NSInteger)countOfShowImages;

//local image UIImage
- (NSArray *)photoBrowserImages;

//local image PHAsset
- (NSArray *)photoBrowserAssets;

//NSString  url
- (NSArray *)photoBrowserImageUrls;

//根据index 拿到上一个视图中 imageView
- (UIView *)getStartViewWithIndex:(NSInteger)index;



@end
```

