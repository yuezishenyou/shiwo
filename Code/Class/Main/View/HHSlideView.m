//
//  HHSlideView.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSlideView.h"

#define kW  ([[UIScreen mainScreen]bounds].size.width / 3 * 2 )


@interface HHSlideView ()

/** 记录是否打开侧边栏 */
@property (nonatomic, assign) BOOL openSlide;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UITableView *tbView;


@end


@implementation HHSlideView
{
    CGFloat width ;
    CGFloat height;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        width = [[UIScreen mainScreen]bounds].size.width;
        height = [[UIScreen mainScreen]bounds].size.height;
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.frame = CGRectMake(-kW, 0, kW, height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self addGestureRecognizer:tap];
    
    
    //表格
//    self.tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
//
//    self.tbView.delegate = self;
//
//    self.tbView.dataSource = self;
//
//    [self addSubview:self.tbView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}

- (void)hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(-kW, 0, kW, height);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, kW, height);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)btnAction
{
    if (_block) {
        _block(1);
    }
    
    [self hidden];
}














@end
