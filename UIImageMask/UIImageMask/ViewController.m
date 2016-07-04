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
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self maskedImage];
}

- (void)maskedImage {
    UIImage *heightImage = [UIImage imageNamed:@"height"];
    UIImage *maskImage = [UIImage imageNamed:@"FIMbubble"];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:heightImage];
    
    backgroundImageView.frame = CGRectMake(10, 40, 50, 150);
    
    UIEdgeInsets BubbleRightCapInsets = UIEdgeInsetsMake(maskImage.size.height * 0.5, maskImage.size.width * 0.5, maskImage.size.height * 0.5, maskImage.size.width * 0.5);
    NSLog(@"BubbleRightCapInsets Rect: --- %@", NSStringFromUIEdgeInsets(BubbleRightCapInsets));
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
    NSLog(@"contentsCenter Rect: --- %@", NSStringFromCGRect(mask.contentsCenter));
    backgroundImageView.layer.mask = mask;
    backgroundImageView.layer.masksToBounds = YES;
    
    [self.view addSubview:backgroundImageView];
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
