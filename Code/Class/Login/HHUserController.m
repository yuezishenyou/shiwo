//
//  HHUserController.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHUserController.h"
#import "YDHeaderView.h"
#import "YDNetworking.h"
#import "Global.h"

@interface HHUserController ()

@property (nonatomic, strong) YDHeaderView *headerView;

@property (nonatomic, assign) BOOL flag;

@end

@implementation HHUserController

- (void)backClick
{
    [super backClick];
    

}

- (void)loadView
{
    [super loadView];
    self.view.frame = [[UIScreen mainScreen]bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleString = @"个人中心";
    
    [self initSubViews];

    [self addBlock];
}


- (void)addBlock
{
    __weak typeof (self) weakSelf = self;
    
    [self.headerView setDidSelectePhoto:^{
        
        UIImage *image;
        if (weakSelf.flag == YES) {
            image = [UIImage imageNamed:@"7"];
            weakSelf.flag = NO;
        }
        else
        {
            image = [UIImage imageNamed:@"6"];
            weakSelf.flag = YES;
        }
        
        
        
        weakSelf.headerView.headerImageV.image = image;
        
        NSLog(@"----新图片本地:%@-----",headerPath);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            if ([UIImageJPEGRepresentation(image, 1)writeToFile:headerPath atomically:YES])
            {
                [weakSelf changeImageActionWithImage:image];
            }
            else
            {
                [weakSelf changeImageActionWithImage:image];
            }
            
        });
        
    }];
}


- (void)changeImageActionWithImage:(UIImage *)image
{
    
    NSLog(@"-----上传网络-----");
    NSDictionary *dict = @{
                           @"token":@"a3316c0b88854cfb9478e02ad2d0db2b"
                           };
    
    [YDNetworking changHeaderImageWihtImage:image dictionary:dict resultBlock:^(id data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"-----事件开始-----");
            if (self.changeHeaderImage) {
                self.changeHeaderImage();
            }
        });
        
//        if (!error) {
//            if (data[@"status"][@"code"] == 0)
//            {
//                //http://114.215.208.42:8098/h_way/gate?sid=2013&uid=1484
//                //http://114.215.208.42:8098/h_way/gate?sid=2013&uid=1484
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"-----事件开始-----");
//                    if (self.changeHeaderImage) {
//                        self.changeHeaderImage();
//                    }
//                });
//
//            }
//        }
    }];
    
        
   
    
    

}












- (void)initSubViews
{
    self.headerView = [[YDHeaderView alloc]initWithFrame:CGRectMake(0, KNavigationH, kScreenW, 200)];
    
    [self.view addSubview:self.headerView];
}




















@end
