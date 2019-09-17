//
//  INDouyinRefreshConfig.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INDouyinRefreshModel.h"

@interface INDouyinRefreshConfig : NSObject

/**
 通知消息列表
 */
@property (nonatomic, strong) NSMutableArray *groupDatasources;

- (void)addMoreData;

@end
