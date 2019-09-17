//
//  UIColor+Addition.m
//  DFace
//
//  Created by guobingwei on 2017/9/30.
//  Copyright © 2017年 DFace. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)


/**
 传入16进制的hex，返回颜色UIColor
 
 @param hexString hexString 16进制
 @param alpha 透明度
 @return UICOlor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor blackColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (alpha > 1.0) {
        alpha = 1.0;
    }
    
    if (alpha < 0.0) {
        alpha = 0.0;
    }
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/**
 传入16进制的hex，返回颜色UIColor
 
 @param hexString 16进制
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0];
}

/**
 传入16进制的hex，包含透明度，返回颜色UIColor
 
 @param hex hex
 @return UIColor
 */
+ (UIColor *)colorWithAlphaFromHex:(NSString *)hex {
    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        NSString *red = [cleanString substringWithRange:NSMakeRange(0, 1)];
        NSString *green = [cleanString substringWithRange:NSMakeRange(1, 1)];
        NSString *blue = [cleanString substringWithRange:NSMakeRange(2, 1)];
        cleanString = [NSString stringWithFormat:@"ff%1$@%1$@%2$@%2$@%3$@%3$@", red, green, blue];
    }else if([cleanString length] == 6) {
        cleanString = [@"ff" stringByAppendingString:cleanString];
    }else{
        //do nothing
    }
    
    unsigned int rgba;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&rgba];
    
    CGFloat alpha = ((rgba & 0xFF000000) >> 24) / 255.0f;
    CGFloat red = ((rgba & 0x00FF0000) >> 16) / 255.0f;
    CGFloat green = ((rgba & 0x0000FF00) >> 8) / 255.0f;
    CGFloat blue = (rgba & 0x000000FF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 随机颜色值
 
 @return UIColor
 */
+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 调节颜色的明亮度
 
 @param color 颜色
 @param delta 明亮度
 @return UIColor
 */
+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}


/**
 调整颜色的透明度
 
 @param color 颜色
 @param delta 透明度
 @return UIColor
 */
+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    alpha += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

@end


/**
 通过RGB创建颜色 rgb(173.0,23.0,11.0)
 
 @param red <CGFloat> <范围:0~255.0>
 @param green <CGFloat> <范围:0~255.0>
 @param blue <CGFloat> <范围:0~255.0>
 @return UIColor
 */
UIColor *rgb(CGFloat red, CGFloat green, CGFloat blue) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

/**
 通过RGB以及alpha创建颜色，rgbA(173.0,23.0,11.0,0.5)
 
 @param red <CGFloat> <范围:0~255.0>
 @param green <CGFloat> <范围:0~255.0>
 @param blue <CGFloat> <范围:0~255.0>
 @param alpha <CGFloat> <范围:0~1.0>
 @return UIColor
 */
UIColor *rgbA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
