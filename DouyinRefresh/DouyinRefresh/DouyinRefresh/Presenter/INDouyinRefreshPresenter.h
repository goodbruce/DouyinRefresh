//
//  INDouyinRefreshPresenter.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INDouyinRefreshView.h"
#import "INDouyinRefreshCell.h"
#import "INDouyinRefreshInteractor.h"

@interface INDouyinRefreshPresenter : NSObject

@property (nonatomic, strong) INDouyinRefreshView *teamAnnounceView;
@property (nonatomic, strong) INDouyinRefreshInteractor *teamAnnounceInteractor;
@property (nonatomic, strong) INDouyinRefreshConfig *teamAnnounceConfig;

@property (nonatomic, weak) UIViewController *controller;

@end
