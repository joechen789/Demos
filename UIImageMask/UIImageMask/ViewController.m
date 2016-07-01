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
    UIImage *image = [UIImage imageNamed:@"height"];
    UIImage *mask = [UIImage imageNamed:@"FIMbubble"];
    
    NSLog(@"image Rect: --- %@", NSStringFromCGSize(image.size));
    NSLog(@"mask Rect: --- %@", NSStringFromCGSize(mask.size));
    // result of the masking method
//    UIImage *maskedImage = [self maskImage:image withMask:mask];
    UIImage *maskedImage = [self maskedImage:image mask:mask];
    NSLog(@"maskedIamge Rect: --- %@", NSStringFromCGSize(maskedImage.size));
    UIImageView *imageView = [[UIImageView alloc] initWithImage:maskedImage];
    imageView.frame = CGRectMake(100, 100, imageView.frame.size.width, imageView.frame.size.height);
    [self.view addSubview:imageView];
}

- (UIImage *)maskedImage:(UIImage *)image mask:(UIImage *)maskImage {
    
    if (image.size.height >= image.size.width && image.size.height / image.size.width > 3) {
        
    } else if (image.size.height >= image.size.width && image.size.height / image.size.width < 3 && image.size.height / image.size.width > 1) {
        
    }
    
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
//    CGFloat maskedImageHeight = CGImageGetHeight(maskedImage);
//    CGFloat maskedImageWidth = CGImageGetWidth(maskedImage);
//    if (maskedImageHeight > maskedImageWidth) {
//        CGFloat scale = maskedImageHeight / 150;
//        cgimage
//    }
    UIImage *returnImage = [UIImage imageWithCGImage:maskedImage];
    
    CGImageRelease(maskedImage);
    CGImageRelease(mask);
    
    return returnImage;
}

@end
