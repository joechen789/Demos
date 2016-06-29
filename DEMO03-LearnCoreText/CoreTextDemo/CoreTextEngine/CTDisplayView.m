//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextData.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"
#import "CoreTextUtils.h"

@interface CTDisplayView()<UIGestureRecognizerDelegate>

@end

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (void)setupEvents {
    UIGestureRecognizer * tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(userTapGestureDetected:)];
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
}

- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    for (CoreTextImageData * imageData in self.data.imageArray) {
        // 翻转坐标系，因为 imageData 中的坐标是 CoreText 的坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        // 检测点击位置 Point 是否在 rect 之内
        if (CGRectContainsPoint(rect, point)) {
            // 在这里处理点击后的逻辑
            NSLog(@"bingo");
            break;
        }
    }
    
    CoreTextLinkData *linkData = [CoreTextUtils touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        NSLog(@"hint link!");
        return;
    }
}

@end
