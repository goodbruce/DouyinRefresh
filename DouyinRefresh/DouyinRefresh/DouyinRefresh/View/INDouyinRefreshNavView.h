//
//  INDouyinRefreshNavView.h
//  AppDemo
//
//  Created by Dface on 2019/9/17.
//  Copyright © 2019 dface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

@protocol INDouyinRefreshNavViewDelegate;
@interface INDouyinRefreshNavView : UIView

@property (nonatomic, strong) UIImageView *leftBtnBGImageView;
@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIImageView *rightBtnBGImageView;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, weak) id<INDouyinRefreshNavViewDelegate>delegate;

@end

@protocol INDouyinRefreshNavViewDelegate <NSObject>

- (void)backBtnDidClick;

- (void)rightBtnDidClick;

@end
