//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CoreText/CoreText.h"

@interface CoreTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *linkArray;

@end
