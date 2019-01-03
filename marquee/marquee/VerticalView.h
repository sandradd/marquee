//
//  VerticalView.h
//  marquee
//
//  Created by copy on 2019/1/3.
//  Copyright © 2019年 programmingIsCopy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalModel.h"

@interface VerticalView : UIView

@property (nonatomic,copy) void (^clickBlock)(NSInteger index);//第几个数据被点击

//数组内部数据需要是GBTopLineViewModel类型
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr;

//开始滚动
- (void)start;

//停止定时器(界面消失前必须要停止定时器否则内存泄漏)
- (void)stopTimer;

@end
