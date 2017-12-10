//
//  RootVCTool.h
//  MPSS
//
//  Created by miaomiaokeji on 2017/6/14.
//  Copyright © 2017年 miaoYXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootVCTool : NSObject
/**
 *  选择根控制器
 */
+ (void)chooseRootController;
/**
 *  无网
 */
+(UIImageView*)setViewPlaceHoldImage:(CGFloat)maxY WithBgView:(UIView*)bgView;

-(void)showHoldImg;

-(void)hideHoldImg;
@end
