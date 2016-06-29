//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by Broccoli on 16/6/28.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"

@class CoreTextData;

@interface CTFrameParser : NSObject

+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;

+ (NSAttributedString *)loadTemplateFile:(NSString *)path
                                  config:(CTFrameParserConfig *)config
                              imageArray:(NSMutableArray *)imageArray
                               linkArray:(NSMutableArray *)linkArray;

+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;

+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
                                                        config:(CTFrameParserConfig *)config;

@end
