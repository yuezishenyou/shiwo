//
//  HHMainController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"
#import "HHSlideView.h"
#import "HHLoginController.h"
#import "HHUserController.h"
#import <AFNetworking.h>
#import "UIView+animated.h"
#import "Global.h"

@interface HHMainController ()

@property (nonatomic, strong) HHSlideView *slideView;




@end

@implementation HHMainController

- (void)backClick
{
    [self leftAction];
}
- (void)leftAction
{
    [self.slideView showAnimated:YES];
    [self.slideView setHeaderImageWithFirstLoad:YES];
}

- (void)loadView
{
    [super loadView];
    self.view.frame = [[UIScreen mainScreen]bounds];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleString = @"main";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubViews];
    
    [self addBlock];
    
    [self locateMapViewInView:self.view frame:self.view.bounds completion:nil];
    

}




- (void)addBlock
{
    
    __weak typeof(self) weakSelf = self;
    
    
    [self.slideView setBlock:^(NSString *str) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        HHLoginController *vc = [[HHLoginController alloc]init];
        
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [self.slideView setSlideUserCtrolBlock:^(NSString *str) {

        HHUserController *vc = [[HHUserController alloc]init];
    
        
        [vc setChangeHeaderImage:^{
            NSLog(@"-----事件响应-----");
            [weakSelf.slideView setHeaderImageWithFirstLoad:NO];
        }];

        [weakSelf.navigationController pushViewController:vc animated:YES];

    }];
    
    
    
    
}





























#pragma mark - 初始化侧栏按钮
-(void)initSubViews
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    self.slideView = [[HHSlideView alloc]initWithSupView:self.view];
    
}




@end
