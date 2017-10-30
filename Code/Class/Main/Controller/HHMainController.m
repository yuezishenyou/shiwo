//
//  HHMainController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"

@interface HHMainController ()

@property (nonatomic, strong) UIView *slideView;

@end

@implementation HHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"main";
    
    
    [self initSubView];
}


- (void)initSubView
{
    self.slideView = [[UIView alloc]init];
    self.slideView.frame = CGRectMake(0, 0, 0, 0 );
    
}













@end
