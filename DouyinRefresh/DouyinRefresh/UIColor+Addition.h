//
//  UIColor+Addition.h
//  DFace
//
//  Created by guobingwei on 2017/9/30.
//  Copyright © 2017年 DFace. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 通过RGB创建颜色 rgb(173.0,23.0,11.0)

 @param red <CGFloat> <范围:0~255.0>
 @param green <CGFloat> <范围:0~255.0>
 @param blue <CGFloat> <范围:0~255.0>
 @return UIColor
 */
UIColor *rgb(CGFloat red, CGFloat green, CGFloat blue);

/**
 通过RGB以及alpha创建颜色，rgbA(173.0,23.0,11.0,0.5)

 @param red <CGFloat> <范围:0~255.0>
 @param green <CGFloat> <范围:0~255.0>
 @param blue <CGFloat> <范围:0~255.0>
 @param alpha <CGFloat> <范围:0~1.0>
 @return UIColor
 */
UIColor *rgbA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

@interface UIColor (Addition)

/**
 传入16进制的hex，返回颜色UIColor

 @param hexString hexString 16进制
 @param alpha 透明度
 @return UICOlor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 传入16进制的hex，返回颜色UIColor

 @param hexString 16进制
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 传入16进制的hex，包含透明度，返回颜色UIColor

 @param hex hex
 @return UIColor
 */
+ (UIColor *)colorWithAlphaFromHex:(NSString *)hex;

/**
 随机颜色值

 @return UIColor
 */
+ (UIColor *)randomColor;

/**
 调节颜色的明亮度
 
 @param color 颜色
 @param delta 明亮度
 @return UIColor
 */
+ (UIColor *)colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;


/**
 调整颜色的透明度
 
 @param color 颜色
 @param delta 透明度
 @return UIColor
 */
+ (UIColor *)colorRGBonvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;

@end
