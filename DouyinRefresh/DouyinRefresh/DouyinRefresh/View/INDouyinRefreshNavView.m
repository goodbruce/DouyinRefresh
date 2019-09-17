//
//  INDouyinRefreshNavView.m
//  AppDemo
//
//  Created by Dface on 2019/9/17.
//  Copyright © 2019 dface. All rights reserved.
//

#import "INDouyinRefreshNavView.h"

static CGFloat kPadding = 10.0;
static CGFloat kleftWidth = 60.0;
static CGFloat kRightWidth = 60.0;
static CGFloat kBtnHeight = 35.0;

@implementation INDouyinRefreshNavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtnBGImageView];
        [self addSubview:self.rightBtnBGImageView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftBtnBGImageView.frame = CGRectMake(-kPadding, CGRectGetHeight(self.bounds) - kBtnHeight, kleftWidth, kBtnHeight);
    self.rightBtnBGImageView.frame = CGRectMake(CGRectGetWidth(self.bounds) - kRightWidth + kPadding/2, CGRectGetHeight(self.bounds) - kBtnHeight, kRightWidth, kBtnHeight);
    
    self.leftBtn.frame = CGRectMake(kPadding/2, CGRectGetHeight(self.bounds) - kBtnHeight, kleftWidth - 2*kPadding, kBtnHeight);
    self.rightBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - kRightWidth + kPadding + kPadding/2, CGRectGetHeight(self.bounds) - kBtnHeight, kRightWidth - 2*kPadding, kBtnHeight);
}


#pragma Action
- (void)backBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backBtnDidClick)]) {
        [self.delegate backBtnDidClick];
    }
}

- (void)rightBtnClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightBtnDidClick)]) {
        [self.delegate rightBtnDidClick];
    }
}

#pragma SETTER/GETTER
- (UIImageView *)leftBtnBGImageView {
    if (!_leftBtnBGImageView) {
        _leftBtnBGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftBtnBGImageView.backgroundColor = [UIColor blackColor];
        _leftBtnBGImageView.alpha = 0.25;
        _leftBtnBGImageView.layer.masksToBounds = YES;
        _leftBtnBGImageView.layer.cornerRadius = 4;
    }
    return _leftBtnBGImageView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setImage:[UIImage imageNamed:@"w_back"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"w_back"] forState:UIControlStateHighlighted];
        [_leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.exclusiveTouch = YES;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setTitle:@"我的" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.exclusiveTouch = YES;
    }
    return _rightBtn;
}

- (UIImageView *)rightBtnBGImageView {
    if (!_rightBtnBGImageView) {
        _rightBtnBGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightBtnBGImageView.backgroundColor = [UIColor blackColor];
        _rightBtnBGImageView.alpha = 0.25;
        _rightBtnBGImageView.layer.masksToBounds = YES;
        _rightBtnBGImageView.layer.cornerRadius = 4;
    }
    return _rightBtnBGImageView;
}

@end
