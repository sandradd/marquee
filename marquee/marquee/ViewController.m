//
//  ViewController.h
//  marquee
//
//  Created by copy on 2019/1/3.
//  Copyright © 2019年 programmingIsCopy. All rights reserved.
//


#import "ViewController.h"
#import "Masonry.h"
#import "UIColor+ColorHelper.h"
#import "VerticalView.h"
#import "VerticalModel.h"
#import "WebViewController.h"
#import "HorizontalMarqueeLabel.h"

#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic, strong) VerticalView *VerticalView;
@property (nonatomic, strong) NSMutableArray *adsArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.VerticalView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.VerticalView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //上下滚动
    [self setupInit];
    [self buildUI];
    
    //横向滚动
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 280, ScreenWidth-30, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self.view addSubview:bgView];
    //公告image
    UIImageView *HorizontalImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AD"]];
    [bgView addSubview:HorizontalImage];
    
    [HorizontalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(7);
    }];
    
    //分割线
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"ececec" alpha:1.0].CGColor;
    line.frame = CGRectMake(47, 5, 1, 30);
    [bgView.layer addSublayer:line];
    HorizontalMarqueeLabel *label =[[HorizontalMarqueeLabel alloc] init];
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(48+5);
        make.right.equalTo(bgView.mas_right);
    }];
    label.text = @"模仿html5的marquee标签，实现长标题的一个滚动的效果，那么这种效果是怎样实现的呢？";
    label.marqueeLabelType = HorizontalMarqueeLabelTypeLeft;
    label.stopTime = 0;
    label.speed = 0.3;
    label.textColor = [UIColor colorWithHexString:@"666666" alpha:1.0];
    label.font = [UIFont systemFontOfSize:12];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
    [label addGestureRecognizer:tap];
    
    
}
- (void)labelTap:(UITapGestureRecognizer *)tap
{
    WebViewController *web = [[WebViewController alloc] initWithUrl:@"https://www.cnblogs.com/jianmeng/p/7022288.html" title:@"marquee标签详解"];
    [self.navigationController pushViewController:web animated:YES];
    NSLog(@"点击了: marquee标签详情");
}

- (void)setupInit {
    
    self.title = @"滚动公告";
    self.adsArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3" alpha:1.0];
    
}

- (void)buildUI {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 200, ScreenWidth-30, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self.view addSubview:bgView];
    
    //公告image
    UIImageView *adImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AD"]];
    [bgView addSubview:adImage];
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(7);
    }];
    
    //分割线
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"ececec" alpha:1.0].CGColor;
    line.frame = CGRectMake(47, 5, 1, 30);
    [bgView.layer addSublayer:line];
    
    //VerticalView
    self.VerticalView = [[VerticalView alloc] initWithFrame:CGRectMake(48, 0, ScreenWidth-30-48, 40)];
    [self.VerticalView setVerticalShowDataArr:[self getData]];
    
    //点击公告内容
    __weak __typeof(self)weakSelf = self;
    self.VerticalView.clickBlock = ^(NSInteger index) {
        VerticalModel *model = weakSelf.adsArray[index];
        WebViewController *adWeb = [[WebViewController alloc] initWithUrl:model.urlString title:model.noticeTitle];
        [weakSelf.navigationController pushViewController:adWeb animated:YES];
        NSLog(@"点击了: %@", model.noticeTitle);
    };
    
    [bgView addSubview:self.VerticalView];
    
}

- (NSMutableArray *)getData {
    
    NSArray *adTypeArray = @[@"看点", @"深入", @"总结"];
    NSArray *titleArray = @[@"【JAVA框架】Mybatis和Hibernate的区别", @"全方位深入理解JavaScript面向对象", @"OC优缺点"];
    NSArray *timeArray = @[@"2018-06-21", @"2018-03-30", @"2015-10-12"];
    NSArray *urlArray = @[@"https://blog.csdn.net/j15533415886/article/details/80766341", @"https://blog.csdn.net/lihangxiaoji/article/details/79753473", @"https://blog.csdn.net/baidu_31170383/article/details/49079269"];
    
    for (int i = 0; i < adTypeArray.count; i++) {
        VerticalModel *model = [[VerticalModel alloc] init];
        model.noticeType = adTypeArray[i];
        model.noticeTitle = titleArray[i];
        model.addTime = timeArray[i];
        model.urlString = urlArray[i];
        [self.adsArray addObject:model];
    }
    
    return self.adsArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
