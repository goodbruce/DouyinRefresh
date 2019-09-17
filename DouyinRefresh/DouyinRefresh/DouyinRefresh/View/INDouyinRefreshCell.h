//
//  INDouyinRefreshCell.h
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"

@protocol INDouyinRefreshCellDelegate;
@interface INDouyinRefreshCell : UITableViewCell

@property (nonatomic, weak) id<INDouyinRefreshCellDelegate> delegate;

@property (nonatomic, strong) UIImage *contentImage;

@end

@protocol INDouyinRefreshCellDelegate <NSObject>


@end
