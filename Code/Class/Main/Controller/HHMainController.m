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

@interface HHMainController ()

@property (nonatomic, strong) HHSlideView *slideView;

/** 记录是否打开侧边栏 */
@property (nonatomic, assign) BOOL openSlide;


@end

@implementation HHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"main";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubView];
    
    [self addBlock];
    
}




#pragma mark - 初始化侧栏按钮
-(void)initSubView
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    
    
    self.slideView = [[HHSlideView alloc]initWithSupView:self.navigationController.view];
    
}

- (void)addBlock
{
    
    __weak typeof(self) weakSelf = self;
    
    
    [self.slideView setBlock:^(NSString *str) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        HHLoginController *vc = [[HHLoginController alloc]init];
        
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    //
    [self.slideView setSlideUserCtrolBlock:^(NSString *str) {
        
        HHUserController *vc = [[HHUserController alloc]init];
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    
}



- (void)leftAction
{
    //监视侧栏是否打开
    NSLog(@"--开--");
    [self.slideView showAnimated:YES];
    [self.slideView setHeaderImageWithFirstLoad:YES];
   
}















@end
