//
//  DynamicImageTableViewCellLayout.h
//  DynamicLoadingImages
//
//  Created by Broccoli on 16/7/6.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DynamicImageTableViewCellLayout : NSObject

@property (nonatomic, strong) UIImage *cachedImage;
@property (nonatomic, assign) CGFloat cachedImageHeight;
@property (nonatomic, assign) CGFloat cachedImageWidth;

- (instancetype)initWithImageURL:(NSURL *)url forIndexPath:(NSIndexPath *)indexPath;

@end
