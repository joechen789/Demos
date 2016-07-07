
//
//  DynamicImageTableViewCellLayout.m
//  DynamicLoadingImages
//
//  Created by Broccoli on 16/7/6.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "DynamicImageTableViewCellLayout.h"
#import "SDWebImageManager.h"

@implementation DynamicImageTableViewCellLayout

- (instancetype)initWithImageURL:(NSURL *)url forIndexPath:(NSIndexPath *)indexPath {
    self = [super init];
    if (self) {
        [self loadImageWith:url forIndexPath:indexPath];
    }
    return self;
}

- (void)loadImageWith:(NSURL *)url forIndexPath:(NSIndexPath *)indexPath {
    SDWebImageManager *sd = [[SDWebImageManager alloc] init];
    [sd downloadImageWithURL:url
                     options:0
                    progress:nil
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                       if (image) {
                           NSLog(@"url --- :%@", url);
                           NSLog(@"indexPath.row --- :%ld", (long)indexPath.row);
                           UIImageView *imageView = [[UIImageView alloc] init];
                           imageView.contentMode = UIViewContentModeScaleAspectFill;
                           imageView.image = image;
                           if (image.size.height >= image.size.width && image.size.height / image.size.width > 3) {
                               imageView.bounds = CGRectMake(0, 0, 50, 150);
                           } else if (image.size.height >= image.size.width && image.size.height / image.size.width < 3 && image.size.height / image.size.width > 1) {
                               imageView.bounds = CGRectMake(0, 0, image.size.width / image.size.height * 150, 150);
                           } else if (image.size.width >= image.size.height && image.size.width / image.size.height > 3) {
                               imageView.bounds = CGRectMake(0, 0, 150, 50);
                           } else {
                               imageView.bounds = CGRectMake(0, 0, 150, image.size.height / image.size.width * 150);
                           }
                           
                           self.cachedImage = image;
                           self.cachedImageHeight = imageView.bounds.size.height + 42;
                           self.cachedImageWidth = imageView.bounds.size.width;
                           
                           NSLog(@"cachedImageHeight --- :%f", imageView.bounds.size.height);
                           NSLog(@"cachedImageWidth --- :%f", imageView.bounds.size.width);
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"kDynamicLoadingImages" object:nil userInfo:@{@"indexPath":indexPath}];
                       }
                   }];
}
@end
