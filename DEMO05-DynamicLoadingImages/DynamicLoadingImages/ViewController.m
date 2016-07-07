//
//  ViewController.m
//  DynamicLoadingImages
//
//  Created by Broccoli on 16/7/5.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ViewController.h"
#import "DynamicImageTableViewCell.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "DynamicImageTableViewCellLayout.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, strong) NSMutableArray<DynamicImageTableViewCellLayout *> *dataSource;
@property (nonatomic, strong) NSMutableArray *cachedImages;
@property (nonatomic, strong) NSMutableArray *cachedImageHeight;
@property (nonatomic, strong) NSMutableArray *cachedImageWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupImageURLs];
    [self setupDataSource];
    [self setupClearItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"kDynamicLoadingImages" object:nil];
}

- (void)reloadData:(NSNotification *)notif {
    NSIndexPath *indexPath = notif.userInfo[@"indexPath"];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
//    [self.tableView reloadData];
}

#pragma mark -- setup method
- (void)setupClearItem {
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearSDWebImageCache)];
    self.navigationItem.rightBarButtonItem = clearItem;
}

- (void)setupDataSource {
    self.dataSource = [NSMutableArray array];
    self.cachedImages = [NSMutableArray array];
    self.cachedImageHeight = [NSMutableArray array];
    self.cachedImageWidth = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i++) {
        DynamicImageTableViewCellLayout *layout = [[DynamicImageTableViewCellLayout alloc] initWithImageURL:self.imageURLs[arc4random() % 9] forIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.dataSource addObject:layout];
        [self.cachedImages addObject:[NSNull null]];
        [self.cachedImageHeight addObject:@(0.0)];
        [self.cachedImageWidth addObject:@(0.0)];
    }
}

- (void)setupImageURLs {
    self.imageURLs = @[@"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/-Users-Broccoli-Desktop-image%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.33.38.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8A%E5%8D%8811.34.51.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8A%E5%8D%8811.35.57.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.32.14.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.32.37.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.33.59.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/Finder%20Finder%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.34.06.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/fatHeight.png",
                       @"https://raw.githubusercontent.com/broccolii/Demos/master/DEMO04-UIImageMask/image/iPhone%206s%20-%20iPhone%206s%20-%20iOS%209.3%20(13E230)%20Simulator%2C%20%E4%BB%8A%E5%A4%A9%20at%20%E4%B8%8B%E5%8D%884.33.48.png"];
}

#pragma mark -- private method
- (void)clearSDWebImageCache {
    [[SDImageCache sharedImageCache] clearDisk];
}

#pragma mark -- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

NSString *const DynamicImageTableViewCelldentifier = @"DynamicImageTableViewCelldentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath 找最后一个错误第 %ld 行 cachedImageHeight: --- %@", (long)indexPath.row, self.cachedImageHeight[indexPath.row]);
    DynamicImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicImageTableViewCelldentifier];
    cell.countLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell setLayout:self.dataSource[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"heightForRowAtIndexPath 找最后一个错误第 %ld 行 cachedImageHeight: --- %@", (long)indexPath.row, self.cachedImageHeight[indexPath.row]);
    if (self.dataSource[indexPath.row].cachedImageHeight != 0.0) {
        return self.dataSource[indexPath.row].cachedImageHeight;
    } else {
        return 60;
    }
}

@end
