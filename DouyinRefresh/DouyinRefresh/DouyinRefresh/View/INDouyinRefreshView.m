//
//  INDouyinRefreshView.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshView.h"
#import "UIColor+Addition.h"

#define KMaxScrollRefreshHeight 50

//屏幕宽度和高度
#define kStatusBarHeight CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])

@interface INDouyinRefreshView ()<UIGestureRecognizerDelegate, INDouyinRefreshUpwardRefreshViewDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView; // 虚幻控件

@end

@implementation INDouyinRefreshView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.image = [UIImage imageNamed:@"ic_complete_img_videoImg_default"];
        [self addSubview:_bgImageView];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_bgImageView addSubview:_effectView];
        
        self.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        
        _tableView = [[INDouyinRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        _tableView.pagingEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        [self addSubview:_tableView];

        _upwardRefreshView = [[INDouyinRefreshUpwardRefreshView alloc] initWithTarget:_tableView];
        _upwardRefreshView.delegate = self;
        
        _navbarView = [[INDouyinRefreshNavView alloc] initWithFrame:CGRectZero];
        _navbarView.backgroundColor = [UIColor clearColor];
        _navbarView.alpha = 1.0;
        [self addSubview:_navbarView];
        
        _refreshStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _refreshStateLabel.backgroundColor = [UIColor clearColor];
        _refreshStateLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _refreshStateLabel.font = [UIFont systemFontOfSize:16.0];
        _refreshStateLabel.textAlignment = NSTextAlignmentCenter;
        _refreshStateLabel.clipsToBounds = YES;
        _refreshStateLabel.alpha = 0.0;
        [self addSubview:_refreshStateLabel];
        
        self.startPoint = CGPointZero;
        self.isInLoading = NO;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandle:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 1;
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;
    self.effectView.frame = self.bgImageView.bounds;
    
    self.tableView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.navbarView.frame = CGRectMake(0.0, kStatusBarHeight, CGRectGetWidth(self.bounds), 44.0);
    
    self.refreshStateLabel.frame = CGRectMake(0.0, kStatusBarHeight + 5.0, CGRectGetWidth(self.bounds), 44.0);
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    _tableView.delegate = delegate;
    _tableView.dataSource = delegate;
    self.actionDelegate = delegate;
}

#pragma mark - DFMUPullUpwardRefreshViewDelegate
- (void)pullUpwardRefreshDidFinish {
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(moreLoadingData)]) {
        [self.actionDelegate moreLoadingData];
    }
}

#pragma mark - 下拉刷新
- (void)endRefreshingSuccess {
    self.isInLoading = NO;
    self.startPoint = CGPointZero;
    self.refreshStateLabel.text = @"";
    self.navbarView.alpha = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.refreshStateLabel.text = @"";
    });
    [self.upwardRefreshView endRefreshing];
}

- (void)endRefreshingFailed {
    self.isInLoading = NO;
    self.startPoint = CGPointZero;
    self.refreshStateLabel.text = @"";
    self.navbarView.alpha = 1.0;
    [self.upwardRefreshView endRefreshing];
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)pan{
    if (self.tableView.contentOffset.y > 0) {
        return;
    }
    
    NSLog(@"panGestureHandle");
    if (self.isInLoading) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        self.startPoint = [pan translationInView:self];
        self.tableView.scrollEnabled = NO;
    } if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
        CGPoint point = [pan translationInView:self];
        CGFloat distance = point.y - self.startPoint.y;
        if (distance > 0) {
            self.refreshStateLabel.text = @"下拉刷新";
            CGFloat scale = distance/KMaxScrollRefreshHeight;
            if (scale > 1.0) {
                scale = 1.0;
            }
            
            self.refreshStateLabel.alpha = scale;
            self.navbarView.alpha = (1-scale);
            self.refreshStateLabel.frame = CGRectMake(0.0, scale*kStatusBarHeight + 5.0, CGRectGetWidth(self.bounds), 44.0);
            if (distance > KMaxScrollRefreshHeight) {
                NSLog(@"可以下拉刷新");
            }
        } else {
            NSLog(@"上拉操作");
            self.refreshStateLabel.alpha = 0.0;
        }
        
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
        NSLog(@"UIGestureRecognizerStateEnded");
        self.tableView.scrollEnabled = YES;
        CGPoint point = [pan translationInView:self];
        CGFloat distance = point.y - self.startPoint.y;
        self.refreshStateLabel.text = @"";
        if (distance > 0) {
            if (distance > KMaxScrollRefreshHeight) {
                NSLog(@"加载中...");
                self.refreshStateLabel.text = @"加载中...";
                self.refreshStateLabel.alpha = 1.0;
                self.isInLoading = YES;
                if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(refreshLoadingData)]) {
                    [self.actionDelegate refreshLoadingData];
                }
            } else {
                self.isInLoading = NO;
                self.startPoint = CGPointZero;
                self.refreshStateLabel.text = @"";
                self.navbarView.alpha = 1.0;
            }
        } else {
            self.isInLoading = NO;
            self.startPoint = CGPointZero;
            self.refreshStateLabel.text = @"";
            self.navbarView.alpha = 1.0;
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// 给加的手势设置代理, 并实现此协议方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint pos = [pan velocityInView:pan.view];
        if (pos.y > 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
