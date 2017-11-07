//
//  YDHeaderView.m
//  shiwo
//
//  Created by maoziyue on 2017/11/6.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "YDHeaderView.h"

@interface YDHeaderView ()



@end

@implementation YDHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"YDHeaderView" owner:nil options:nil]lastObject];
        self.frame = frame;
        
        [self setup];
    }
    return self;
}


- (void)setup
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeaderAction)];
    self.headerImageV.userInteractionEnabled = YES;
    [self.headerImageV addGestureRecognizer:tap];
}


- (void)tapHeaderAction
{
    if (_didSelectePhoto) {
        _didSelectePhoto();
    }
}









@end
