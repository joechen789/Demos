//
//  DynamicImageTableViewCell.h
//  DynamicLoadingImages
//
//  Created by Broccoli on 16/7/5.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DynamicImageTableViewCellLayout;
@interface DynamicImageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) UIImageView *bubbleImageView;

- (void)setLayout:(DynamicImageTableViewCellLayout *)layout;

@end
