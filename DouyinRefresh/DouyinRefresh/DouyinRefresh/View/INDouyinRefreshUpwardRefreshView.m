//
//  INDouyinRefreshUpwardRefreshView.m
//  AppDemo
//
//  Created by Dface on 2019/9/17.
//  Copyright © 2019 dface. All rights reserved.
//

#import "INDouyinRefreshUpwardRefreshView.h"

NSString *const RefreshUpKeyPathContentOffset = @"contentOffset";
NSString *const RefreshUpKeyPathContentSize = @"contentSize";

CGFloat const FooterUpHeight = 80;

@interface INDouyinRefreshUpwardRefreshView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *stateLable;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) CGFloat lastOffSet;

@end

@implementation INDouyinRefreshUpwardRefreshView

- (instancetype)initWithTarget:(UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _scrollView = scrollView;
        
        self.frame = CGRectMake(0, 0, 0, FooterUpHeight);
        [_scrollView addSubview:self];
        
        [self addObserver];
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //CGSize statelabelSize = [self.stateLable.text sizeWithFont:self.stateLable.font forMaxSize:CGSizeMake(MAXFLOAT, 40)];
    
    self.stateLable.frame = CGRectMake((CGRectGetWidth(self.bounds) - 60.0)/2 + 10.0, 0.0, 60, 40);
    
    self.arrowView.frame = CGRectMake(CGRectGetMinX(self.stateLable.frame) - CGRectGetWidth(self.arrowView.frame) - 10.0, 0.0, CGRectGetWidth(self.arrowView.frame), 40);
    
    self.activityView.frame = CGRectMake(CGRectGetMinX(self.stateLable.frame) - CGRectGetWidth(self.arrowView.frame) - 10.0, (40.0 - 20.0)/2, 20, 20);
}

- (void)setCurrentFrame {
    [self setFrame:CGRectMake(0, MAX(self.scrollView.contentSize.height, CGRectGetHeight(self.scrollView.frame)), self.scrollView.frame.size.width, FooterUpHeight)];
    [self setNeedsLayout];
}

- (void)setFrameHeight:(CGFloat)height {
    [self setFrame:CGRectMake(0, MAX(self.scrollView.contentSize.height, CGRectGetHeight(self.scrollView.frame)), self.scrollView.frame.size.width, height)];
    NSLog(@"frameHeight:%f",height);
}

#pragma mark setter
- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
    }
    return _activityView;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _arrowView.image = [UIImage imageNamed:@"refresh_up_arrow"];
        //[self addSubview:_arrowView];
    }
    return _arrowView;
}

- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
        _stateLable.backgroundColor = [UIColor clearColor];
        _stateLable.font = [UIFont systemFontOfSize:12];
        _stateLable.textAlignment = NSTextAlignmentLeft;
        _stateLable.textColor = [UIColor whiteColor];
        [self addSubview:_stateLable];
    }
    return _stateLable;
}

#pragma mark private
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    _stateLable.hidden = NO;
    CGFloat yOffSet = _scrollView.contentOffset.y;
    NSLog(@"yOffSet:%f",yOffSet);
    CGFloat contentSizeHeight = _scrollView.contentSize.height;
    CGFloat frameHeight = CGRectGetHeight(_scrollView.frame);
    if (contentSizeHeight > 0 && contentSizeHeight <= frameHeight) {
        CGFloat insetTop = frameHeight - contentSizeHeight;
        if (yOffSet+insetTop > 0.0) {
            //正在拖拽中
            if (self.scrollView.isDragging) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.arrowView.hidden = NO;
                    if (yOffSet+insetTop > 100.0) {
                        self.arrowView.transform =  CGAffineTransformMakeRotation(M_PI);
                        self.stateLable.text = @"松开加载";
                    }else{
                        self.arrowView.transform =  CGAffineTransformMakeRotation(M_PI*2);
                        self.stateLable.text = @"继续滑动";
                    }
                }];
                
                [self setFrameHeight:(yOffSet+insetTop)];
            } else {
                if (yOffSet+insetTop > 100.0) {
                    [self beginRefreshing];
                }
            }
        }
        
    } else {
        //正在拖拽中
        CGFloat aYBottom = yOffSet - (contentSizeHeight - frameHeight);
        if (self.scrollView.isDragging) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.arrowView.hidden = NO;
                if (aYBottom > 100.0) {
                    self.arrowView.transform =  CGAffineTransformMakeRotation(M_PI);
                    self.stateLable.text = @"松开加载";
                }else{
                    self.arrowView.transform =  CGAffineTransformMakeRotation(M_PI*2);
                    self.stateLable.text = @"继续滑动";
                }
            }];
            
            [self setFrameHeight:yOffSet];
        } else {
            if (contentSizeHeight > 0 && aYBottom > 100.0) {
                [self beginRefreshing];
            }
        }
    }
}

#pragma mark publick
- (void)beginRefreshing{
    [self setFrameHeight:FooterUpHeight];
    
    if (!_isRefresh) {
        
        _isRefresh = YES;
        CGFloat insetTop = _scrollView.contentInset.top;
        //设置偏移量,衔接加载的更多数据
        [UIView animateWithDuration:0.35 animations:^{
            //[self.scrollView setContentInset:UIEdgeInsetsMake(insetTop, 0, FooterUpHeight, 0)];
            [self.activityView startAnimating];
            self.arrowView.hidden = YES;
            self.stateLable.text = @"加载中";
        } completion:^(BOOL finished) {
            [self startBeginRefresh];
        }];
    }
}

- (void)startBeginRefresh {
    // Refresh action!
    if ([self.delegate respondsToSelector:@selector(pullUpwardRefreshDidFinish)]) {
        [self.delegate performSelector:@selector(pullUpwardRefreshDidFinish) withObject:nil];
    }
}

- (void)endRefreshing {
    _isRefresh = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.activityView stopAnimating];
        self.arrowView.hidden = YES;
        self.arrowView.transform =  CGAffineTransformMakeRotation(M_PI*2);
    }];
}

#pragma mark KVO
- (void)addObserver{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_scrollView addObserver:self forKeyPath:RefreshUpKeyPathContentOffset options:options context:nil];
    
    [_scrollView addObserver:self forKeyPath:RefreshUpKeyPathContentSize options:options context:nil];
}

- (void)removeObserver{
    [_scrollView removeObserver:self forKeyPath:RefreshUpKeyPathContentOffset];
    [_scrollView removeObserver:self forKeyPath:RefreshUpKeyPathContentSize];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:RefreshUpKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:RefreshUpKeyPathContentSize]) {
        [self setCurrentFrame];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self removeObserver];
}

@end
