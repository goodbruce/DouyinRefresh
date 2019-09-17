//
//  INDouyinRefreshInteractor.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshInteractor.h"

@implementation INDouyinRefreshInteractor

#pragma mark - SETTER/GETTER
- (INDouyinRefreshConfig *)teamAnnounceConfig {
    if (!_teamAnnounceConfig) {
        _teamAnnounceConfig = [[INDouyinRefreshConfig alloc] init];
    }
    return _teamAnnounceConfig;
}

@end
