//
//  DynamicImageTableViewCell.m
//  DynamicLoadingImages
//
//  Created by Broccoli on 16/7/5.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "DynamicImageTableViewCell.h"
#import "DynamicImageTableViewCellLayout.h"

@implementation DynamicImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_bubbleImageView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_bubbleImageView];
    }
    
    return self;
}

- (void)setLayout:(DynamicImageTableViewCellLayout *)layout {
    if (layout.cachedImage != nil) {
        self.bubbleImageView.image = layout.cachedImage;
        [self maskImageView:self.bubbleImageView isSelf:YES];
        self.bubbleImageView.frame = CGRectMake(10, 10, layout.cachedImageWidth, layout.cachedImageHeight);
    }
}

- (void)maskImageView:(UIImageView *)imageView isSelf:(BOOL)isSelf {
    UIImage *maskImage = nil;
    if (isSelf) {
        maskImage = [UIImage imageNamed:@"FIMbubble_left"];
    } else {
        maskImage = [UIImage imageNamed:@"FIMbubble_right"];
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = imageView.image;
    if (!image) {
        return;
    }
    if (image.size.height >= image.size.width && image.size.height / image.size.width > 3) {
        imageView.bounds = CGRectMake(0, 0, 50, 150);
    } else if (image.size.height >= image.size.width && image.size.height / image.size.width < 3 && image.size.height / image.size.width > 1) {
        imageView.bounds = CGRectMake(0, 0, image.size.width / image.size.height * 150, 150);
    } else if (image.size.width >= image.size.height && image.size.width / image.size.height > 3) {
        imageView.bounds = CGRectMake(0, 0, 150, 50);
    } else {
        imageView.bounds = CGRectMake(0, 0, 150, image.size.height / image.size.width * 150);
    }
    
    UIEdgeInsets BubbleRightCapInsets = UIEdgeInsetsMake(maskImage.size.height * 0.5, maskImage.size.width * 0.5, maskImage.size.height * 0.5, maskImage.size.width * 0.5);
    UIImage *bubbleBackground = [maskImage
                                 resizableImageWithCapInsets:UIEdgeInsetsZero
                                 resizingMode:UIImageResizingModeStretch];
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[bubbleBackground CGImage];
    mask.frame = imageView.layer.bounds;
    mask.contentsScale = bubbleBackground.scale;
    mask.contentsCenter =
    CGRectMake(BubbleRightCapInsets.left/bubbleBackground.size.width,
               BubbleRightCapInsets.top/bubbleBackground.size.height,
               1.0/bubbleBackground.size.width,
               1.0/bubbleBackground.size.height);
    imageView.layer.mask = mask;
    imageView.layer.masksToBounds = YES;
}

@end
