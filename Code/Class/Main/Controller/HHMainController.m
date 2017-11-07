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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleString = @"main";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubView];
    
    [self addBlock];
    
    [self initMap];
    
    

}

- (void)initMap
{
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    
    mapView.showsUserLocation = YES;
    
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.view addSubview:mapView];
    
    [self.view sendSubviewToBack:mapView];
    
}


#pragma mark - 初始化侧栏按钮
-(void)initSubView
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    

    self.slideView = [[HHSlideView alloc]initWithSupView:self.view];
    
    
    
    
   
    
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
    
 
//    [self.personView setClickHeaderView:^{
//
//        YDPersonInfoController *vc = [[YDPersonInfoController alloc] initWithNibName:@"YDPersonInfoController" bundle:nil];
//        [vc setChangeHeaderImage:^{
//            [weakself.personView setHeaderImageWithFirstLoad:weakself.firstLoad];
//        }];
//        vc.model = weakself.personModel;
//        [weakself.navigationController pushViewController:vc animated:YES];
//    }];
    
    
    
}


//- (void)pushUserController
//{
//    HHUserController *vc = [[HHUserController alloc]init];
//
//    [vc setChangeHeaderImage:^{
//        NSLog(@"-----改变图片mainvc----");
//        [self.slideView setHeaderImageWithFirstLoad:YES];
//    }];
//
//    [self.navigationController pushViewController:vc animated:YES];
//}






- (void)leftAction
{
    //监视侧栏是否打开
    //NSLog(@"--开--");
    [self.slideView showAnimated:YES];
    [self.slideView setHeaderImageWithFirstLoad:YES];
   
}










@end
