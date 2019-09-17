//
//  INDouyinRefreshCell.m
//  AppDemo
//
//  Created by 1 on 2018/8/13.
//  Copyright © 2018年 dface. All rights reserved.
//

#import "INDouyinRefreshCell.h"
#import "UIColor+Addition.h"

@interface INDouyinRefreshCell ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView; // 虚幻控件
@property (nonatomic, strong) UIImageView *avatarImageView;

@end

@implementation INDouyinRefreshCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.backgroundColor = [UIColor whiteColor];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_backImageView];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [_backImageView addSubview:_effectView];
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.backImageView addSubview:_avatarImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.effectView.frame = self.backImageView.bounds;
    
    self.avatarImageView.frame = self.backImageView.bounds;
}

- (void)setContentImage:(UIImage *)contentImage {
    _contentImage = contentImage;
    self.backImageView.image = contentImage;
    self.avatarImageView.image = contentImage;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    } else {
        self.backImageView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc {
    
}

@end
