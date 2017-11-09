//
//  ViewController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "ViewController.h"
#import "HHAnimatedController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"vc";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"push" style:UIBarButtonItemStyleDone target:self action:@selector(pushAction)];
}

- (void)pushAction
{
    HHAnimatedController *vc = [[HHAnimatedController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}







@end
