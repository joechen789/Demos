//
//  CoreTextLinkData.h
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/29.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSRange range;

@end
