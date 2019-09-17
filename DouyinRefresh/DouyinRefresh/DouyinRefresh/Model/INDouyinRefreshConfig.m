//
//  INDouyinRefreshConfig.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshConfig.h"

@implementation INDouyinRefreshConfig

#pragma mark - SETTER/GETTER
- (NSMutableArray *)groupDatasources {
    if (!_groupDatasources) {
        _groupDatasources = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger index = 0; index < 10; index ++) {
            INDouyinRefreshModel *model = [[INDouyinRefreshModel alloc] init];
            model.showName = @"你的名字";
            model.avatarUrl = @"http://g.hiphotos.baidu.com/image/pic/item/0b46f21fbe096b6340b5e86c01338744ebf8ac5a.jpg";
            model.timeString = @"2019/08/01 13:51";
            model.announcementText = @"Today,I consider myself the luckiest man on the face of the earth.";
            if (index% 4 == 0) {
                model.contentImage = [UIImage imageNamed:@"p190415_128k.jpg"];
            } else if (index% 4 == 1) {
                model.contentImage = [UIImage imageNamed:@"p1393354_128k.jpg"];
            } else if (index% 4 == 2) {
                model.contentImage = [UIImage imageNamed:@"p1458183_128k.jpg"];
            } else if (index% 4 == 3) {
                model.contentImage = [UIImage imageNamed:@"p966452_128k.jpg"];
            }
            [_groupDatasources addObject:model];
        }
    }
    return _groupDatasources;
}

- (void)addMoreData {
    // 模拟数据
    for (NSInteger index = 0; index < 10; index ++) {
        INDouyinRefreshModel *model = [[INDouyinRefreshModel alloc] init];
        model.showName = @"你的名字";
        model.avatarUrl = @"http://g.hiphotos.baidu.com/image/pic/item/0b46f21fbe096b6340b5e86c01338744ebf8ac5a.jpg";
        model.timeString = @"2019/08/01 13:51";
        model.announcementText = @"Today,I consider myself the luckiest man on the face of the earth.";
        if (index% 4 == 0) {
            model.contentImage = [UIImage imageNamed:@"p190415_128k.jpg"];
        } else if (index% 4 == 1) {
            model.contentImage = [UIImage imageNamed:@"p1393354_128k.jpg"];
        } else if (index% 4 == 2) {
            model.contentImage = [UIImage imageNamed:@"p1458183_128k.jpg"];
        } else if (index% 4 == 3) {
            model.contentImage = [UIImage imageNamed:@"p966452_128k.jpg"];
        }
        [self.groupDatasources addObject:model];
    }
}

@end
