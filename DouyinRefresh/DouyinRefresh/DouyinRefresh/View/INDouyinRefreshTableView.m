//
//  INDouyinRefreshTableView.m
//  AppDemo
//
//  Created by Dface on 2019/9/17.
//  Copyright © 2019 dface. All rights reserved.
//

#import "INDouyinRefreshTableView.h"

@implementation INDouyinRefreshTableView

//UIScrollView不能响应UITouch事件的解决办法
// UIScrollView 下的子View，手势滑动中，无法获取touchesBegan等事件 问题

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}


- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

/**
 重新设置contentSize
 contentSize，如果contentSize的高度小于frame的高，则ScrollView无法滚动，则需要重新设置contentSize
 @param contentSize contentSize
 */
- (void)setContentSize:(CGSize)contentSize {
    if (contentSize.height > self.frame.size.height) {
        [super setContentSize:contentSize];
    } else {
        [super setContentSize:CGSizeMake(contentSize.width, self.frame.size.height + 1.0)];
    }
}

@end
