//
//  INDouyinRefreshUpwardRefreshView.h
//  AppDemo
//
//  Created by Dface on 2019/9/17.
//  Copyright © 2019 dface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

NS_ASSUME_NONNULL_BEGIN

@protocol INDouyinRefreshUpwardRefreshViewDelegate;

@interface INDouyinRefreshUpwardRefreshView : UIView

@property (nonatomic, weak) id<INDouyinRefreshUpwardRefreshViewDelegate>delegate;
@property (nonatomic, strong) UIScrollView *scrollView;

- (instancetype)initWithTarget:(UIScrollView *)scrollView;

- (void)endRefreshing;

@end

@protocol INDouyinRefreshUpwardRefreshViewDelegate <NSObject>

- (void)pullUpwardRefreshDidFinish;

@end


NS_ASSUME_NONNULL_END
