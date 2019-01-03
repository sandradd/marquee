//
//  UIColor+ColorHelper.h
//  marquee
//
//  Created by copy on 2019/1/3.
//  Copyright © 2019年 programmingIsCopy. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIColor (ColorHelper)

//UIColor 转16进制字符串
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//UIColor 转UIImage
+ (UIImage*) imageWithColor: (UIColor*) color;

@end
