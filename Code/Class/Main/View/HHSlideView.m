//
//  HHSlideView.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSlideView.h"
#import "HHContentView.h"

#define kW  ([[UIScreen mainScreen]bounds].size.width / 3 * 2 )


@interface HHSlideView ()

/** 记录是否打开侧边栏 */
@property (nonatomic, assign) BOOL openSlide;

@property (nonatomic,strong) UIView *supView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic,strong) UITableView *tbView;

@property (nonatomic,strong) UIImageView *photoImageV;


@end


@implementation HHSlideView
{
    CGFloat width ;
    CGFloat height;
}

- (instancetype)initWithSupView:(UIView *)supView
{
    if (self = [super init])
    {
        width = [[UIScreen mainScreen]bounds].size.width;
        height = [[UIScreen mainScreen]bounds].size.height;
        _supView = supView;
        [self setup];
    }
    return self;
}


- (void)hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(-kW, 0, kW, height);
        self.bgView.alpha = 0.0;

    } completion:^(BOOL finished) {
      
    }];
    
}

- (void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, kW, height);
        self.bgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)setup
{
    self.frame = CGRectMake(-kW, 0, kW, height);
    self.backgroundColor = [UIColor whiteColor];

    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.bgView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    self.bgView.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self.bgView addGestureRecognizer:tap];
    
    [_supView addSubview:self.bgView];
    [_supView addSubview:self];
    
    //xib
    HHContentView *contentV = [HHContentView initView];
    contentV.frame = CGRectMake(0, 0, kW, height);
    
    [contentV setSelectedBlock:^(NSString *str) {
        [self btnAction:str];
    }];
    [self addSubview:contentV];

    
}


- (void)btnAction:(NSString *)str
{
    if (_block) {
        _block(str);
    }
    
    [self hidden];
}































@end
