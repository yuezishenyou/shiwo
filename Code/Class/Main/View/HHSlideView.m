//
//  HHSlideView.m
//  shiwo
//
//  Created by maoziyue on 2017/10/30.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSlideView.h"
#import "HHContentView.h"

#define headerPath  [NSString stringWithFormat:@"%@/HeaderImage.jpeg", kDocumentPath]

#define kW  ([[UIScreen mainScreen]bounds].size.width / 3 * 2 )


@interface HHSlideView ()<UITableViewDelegate,UITableViewDataSource>

/** 记录是否打开侧边栏 */
@property (nonatomic, assign) BOOL openSlide;

@property (nonatomic,strong) UIView *supView;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UITableView *tbView;

@property (nonatomic,strong) UIView *tableHeaderView;

@property (nonatomic,strong) UIImageView *photoImageV;

@property (nonatomic,copy)   NSString *photoUrl;


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


- (void)hiddenAnimated:(BOOL)animated
{
    if (!animated)
    {
        self.frame = CGRectMake(-kW, 0, kW, height);
        self.bgView.alpha = 0.0;
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(-kW, 0, kW, height);
        self.bgView.alpha = 0.0;

    } completion:^(BOOL finished) {
      
    }];
    
}

- (void)showAnimated:(BOOL)animated
{
    if (!animated) {
        self.frame = CGRectMake(0, 0, kW, height);
        self.bgView.alpha = 1.0;
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, kW, height);
        self.bgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapBackgroundView
{
    [self hiddenAnimated:YES];
}

- (void)tapHeadAction
{
    if (_slideUserCtrolBlock) {
        _slideUserCtrolBlock(@"11");
    }
    //[self hiddenAnimated:NO];
}

















- (void)setup
{
    
    self.frame = CGRectMake(-kW, 0, kW, height);
    self.backgroundColor = [UIColor whiteColor];

    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.bgView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    self.bgView.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackgroundView)];
    [self.bgView addGestureRecognizer:tap];
    
    [_supView addSubview:self.bgView];
    [_supView addSubview:self];
    
    
    
    //表格
    self.tbView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self addSubview:self.tbView];
    
    //透视图
    self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kW, 200)];
    self.tableHeaderView.backgroundColor = [UIColor redColor];
    self.tbView.tableHeaderView = self.tableHeaderView;
    
    //photoImageV
    self.photoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 80, 80)];
    self.photoImageV.layer.cornerRadius = 40;
    self.photoImageV.layer.masksToBounds = YES;
    self.photoImageV.backgroundColor = [UIColor whiteColor];
    self.photoImageV.userInteractionEnabled = YES;
    [self.tableHeaderView addSubview:self.photoImageV];
    
    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadAction)];
    [self.photoImageV addGestureRecognizer:tapHead];


}

- (void)setHeaderImageWithFirstLoad:(BOOL)first
{
    _photoUrl = @"http://114.215.208.42:8098/h_way/gate?sid=2013&uid=1484";
    
    UIImage *image = nil;
    
    if (!first)
    {
        image = [UIImage imageWithContentsOfFile:headerPath];
        NSLog(@"----不是第一次---");
    }
    
    if (image)
    {
        self.photoImageV.image = image;
        NSLog(@"---有图片---");
    }
    else
    {
        //NSLog(@"---没图片---");
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_photoUrl]]];
            
            [UIImageJPEGRepresentation(image, 1)writeToFile:headerPath atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.photoImageV.image = image;
                
            });
        });
        
    }
    
}










#pragma mark --delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"--abc--";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

















@end
