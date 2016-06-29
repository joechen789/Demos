//
//  CoreTextUtils.h
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/29.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CoreTextLinkData, CoreTextData;
@interface CoreTextUtils : NSObject

+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end
