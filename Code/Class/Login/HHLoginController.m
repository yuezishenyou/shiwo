//
//  HHLoginController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHLoginController.h"
#import "YDRegistController.h"

@interface HHLoginController ()

@end

@implementation HHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"login";
    
    [self initSubViews];
    
}


- (void)initSubViews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(regist)];
}

- (void)regist
{
    YDRegistController *vc = [[YDRegistController alloc]initWithNibVCName:@"YDRegistController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}







@end
