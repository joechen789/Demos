//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1.0];
    }
    return self;
}

@end
