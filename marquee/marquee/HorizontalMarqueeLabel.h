//
//  HorizontalMarqueeLabel.h
//  marquee
//
//  Created by copy on 2019/1/3.
//  Copyright © 2019年 programmingIsCopy. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HorizontalMarqueeLabelType) {
    HorizontalMarqueeLabelTypeLeft = 0,//向左边滚动
    HorizontalMarqueeLabelTypeLeftRight = 1,//先向左边，再向右边滚动
};

@interface HorizontalMarqueeLabel : UILabel
@property(nonatomic,unsafe_unretained)HorizontalMarqueeLabelType marqueeLabelType;
@property(nonatomic,unsafe_unretained)CGFloat speed;//速度
@property(nonatomic,unsafe_unretained)CGFloat secondLabelInterval;
@property(nonatomic,unsafe_unretained)NSTimeInterval stopTime;//滚到顶的停止时间

@end

