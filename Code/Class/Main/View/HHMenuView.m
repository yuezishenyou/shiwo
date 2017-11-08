//
//  HHMenuView.m
//  shiwo
//
//  Created by maoziyue on 2017/11/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMenuView.h"

@interface HHMenuView ()

@property (nonatomic, strong) UIButton *submitOrderBtn;
@property (nonatomic, strong) UIButton *cancelOrderBtn;

@end

@implementation HHMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.submitOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitOrderBtn.frame = CGRectMake(0, 0, 100, 40);
    [self.submitOrderBtn setTitle:@"派单" forState:UIControlStateNormal];
    [self.submitOrderBtn addTarget:self action:@selector(submitOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    self.submitOrderBtn.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.submitOrderBtn];
    
    
    self.cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelOrderBtn.frame = CGRectMake(150, 0, 100, 40);
    [self.cancelOrderBtn setTitle:@"派单" forState:UIControlStateNormal];
    [self.cancelOrderBtn addTarget:self action:@selector(cancelOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelOrderBtn.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.cancelOrderBtn];
    
    
    
}


- (void)submitOrderAction:(UIButton *)btn
{
    if (_submitOrderBlock) {
        _submitOrderBlock();
    }
}

- (void)cancelOrderAction:(UIButton *)btn
{
    if (_cancelOrderBlock) {
        _cancelOrderBlock();
    }
}












@end
