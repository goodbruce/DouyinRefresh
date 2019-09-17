//
//  INDouyinRefreshView.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"
#import "INDouyinRefreshNavView.h"
#import "INDouyinRefreshUpwardRefreshView.h"
#import "INDouyinRefreshTableView.h"

@protocol INDouyinRefreshViewDelegate;
@interface INDouyinRefreshView : UIView

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) id<INDouyinRefreshViewDelegate>actionDelegate;

@property (nonatomic, strong) INDouyinRefreshTableView *tableView;

@property (nonatomic, strong) INDouyinRefreshUpwardRefreshView *upwardRefreshView;

@property (nonatomic, strong) INDouyinRefreshNavView *navbarView;

@property (nonatomic, strong) UILabel *refreshStateLabel;

@property (nonatomic, assign) BOOL isInLoading;
@property (nonatomic) CGPoint startPoint;

- (id)initWithFrame:(CGRect)frame;

- (void)endRefreshingSuccess;
- (void)endRefreshingFailed;

@end

@protocol INDouyinRefreshViewDelegate <NSObject>

/**
 刷新加载数据
 */
- (void)refreshLoadingData;

/**
 加载更多数据
 */
- (void)moreLoadingData;

@end
