//
//  Global.h
//  shiwo
//
//  Created by maoziyue on 2017/10/29.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReadChangeHeaderImage)(void);

typedef void (^ChangeHeaderImageBlock)(void);


@interface Global : NSObject

+ (instancetype)manager;

@property (nonatomic, copy) ChangeHeaderImageBlock changeHeaderImageBlock;

- (void)readChangeHeaderImage:(ChangeHeaderImageBlock)block;
- (void)setChangeHeaderImage:(UIImage *)image;




@end
