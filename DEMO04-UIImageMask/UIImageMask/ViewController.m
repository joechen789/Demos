//
//  ViewController.m
//  UIImageMask
//
//  Created by Broccoli on 16/6/29.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *heightImage = [UIImage imageNamed:@"height"];
    UIImageView *heightImageView = [[UIImageView alloc] initWithImage:heightImage];
    [self maskImageView:heightImageView];
    heightImageView.frame = CGRectMake(40, 40, heightImageView.bounds.size.width, heightImageView.bounds.size.height);
    [self.view addSubview:heightImageView];
    
    UIImage *widthImage = [UIImage imageNamed:@"width"];
    UIImageView *widthImageView = [[UIImageView alloc] initWithImage:widthImage];
    [self maskImageView:widthImageView];
    widthImageView.frame = CGRectMake(200, 40, widthImageView.bounds.size.width, widthImageView.bounds.size.height);
    [self.view addSubview:widthImageView];
    
    UIImage *fatHeightImage = [UIImage imageNamed:@"fatHeight"];
    UIImageView *fatHeightImageView = [[UIImageView alloc] initWithImage:fatHeightImage];
    [self maskImageView:fatHeightImageView];
    fatHeightImageView.frame = CGRectMake(40, 200, fatHeightImageView.bounds.size.width, fatHeightImageView.bounds.size.height);
    [self.view addSubview:fatHeightImageView];
    
    UIImage *squareImage = [UIImage imageNamed:@"square"];
    UIImageView *squareImageView = [[UIImageView alloc] initWithImage:squareImage];
    [self maskImageView:squareImageView];
    squareImageView.frame = CGRectMake(200, 200, squareImageView.bounds.size.width, squareImageView.bounds.size.height);
    [self.view addSubview:squareImageView];
}

- (void)maskImageView:(UIImageView *)backgroundImageView {
   
    UIImage *maskImage = [UIImage imageNamed:@"FIMbubble"];
    
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *image = backgroundImageView.image;
    
    if (image.size.height >= image.size.width && image.size.height / image.size.width > 3) {
        backgroundImageView.bounds = CGRectMake(0, 0, 50, 150);
    } else if (image.size.height >= image.size.width && image.size.height / image.size.width < 3 && image.size.height / image.size.width > 1) {
        backgroundImageView.bounds = CGRectMake(0, 0, image.size.width / image.size.height * 150, 150);
    } else if (image.size.width >= image.size.height && image.size.width / image.size.height > 3) {
        backgroundImageView.bounds = CGRectMake(0, 0, 150, 50);
    } else {
        backgroundImageView.bounds = CGRectMake(0, 0, 150, image.size.height / image.size.width * 150);
    }
    
    UIEdgeInsets BubbleRightCapInsets = UIEdgeInsetsMake(maskImage.size.height * 0.5, maskImage.size.width * 0.5, maskImage.size.height * 0.5, maskImage.size.width * 0.5);
    UIImage *rightBubbleBackground = [maskImage
                                      resizableImageWithCapInsets:UIEdgeInsetsZero
                                      resizingMode:UIImageResizingModeStretch];
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[rightBubbleBackground CGImage];
    mask.frame = backgroundImageView.layer.bounds;
    mask.contentsScale = rightBubbleBackground.scale;
    mask.contentsCenter =
    CGRectMake(BubbleRightCapInsets.left/rightBubbleBackground.size.width,
               BubbleRightCapInsets.top/rightBubbleBackground.size.height,
               1.0/rightBubbleBackground.size.width,
               1.0/rightBubbleBackground.size.height);
    backgroundImageView.layer.mask = mask;
    backgroundImageView.layer.masksToBounds = YES;
}

- (UIImage *)maskedImage:(UIImage *)image mask:(UIImage *)maskImage {
    
    
    
    CGImageRef maskImageRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImageRef),
                                        CGImageGetHeight(maskImageRef),
                                        CGImageGetBitsPerComponent(maskImageRef),
                                        CGImageGetBitsPerPixel(maskImageRef),
                                        CGImageGetBytesPerRow(maskImageRef),
                                        CGImageGetDataProvider(maskImageRef), NULL, false);
    
    CGImageRef sourceImage = image.CGImage;
    CGImageRef maskedImage;
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(sourceImage);
    
    if (alpha != kCGImageAlphaFirst && alpha != kCGImageAlphaLast && alpha != kCGImageAlphaPremultipliedFirst && alpha != kCGImageAlphaPremultipliedLast) {
        size_t width = CGImageGetWidth(sourceImage);
        size_t height = CGImageGetHeight(sourceImage);
        
        CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                              8, 0, CGImageGetColorSpace(sourceImage),
                                                              kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
        
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
        maskedImage = CGImageCreateWithMask(imageRefWithAlpha, mask);
        CGImageRelease(imageRefWithAlpha);
        
        CGContextRelease(offscreenContext);
    } else {
        maskedImage = CGImageCreateWithMask(sourceImage, mask);
    }
    
    NSLog(@"CGImageGetWidth(maskedIamge) Rect: --- %zu", CGImageGetWidth(maskedImage));
    NSLog(@"CGImageGetHeight(maskedIamge) Rect: --- %zu", CGImageGetHeight(maskedImage));
    UIImage *returnImage = [UIImage imageWithCGImage:maskedImage];
    
    CGImageRelease(maskedImage);
    CGImageRelease(mask);
    
    return returnImage;
}

@end
