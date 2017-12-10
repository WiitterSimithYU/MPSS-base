//
//  RootVCTool.m
//  MPSS
//
//  Created by miaomiaokeji on 2017/6/14.
//  Copyright © 2017年 miaoYXH. All rights reserved.
//

#import "RootVCTool.h"
#import "LeadVC.h"
#import "LSLaunchAD.h"
#import "BXTabBarController.h"

@interface RootVCTool ()

@property(nonatomic,strong)UIImageView  * holdImg;
@end

@implementation RootVCTool
/**
 *  选择根控制器
 */
+ (void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion    = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        
        NSString *adUrl = UserDefaultObjectForKey(LOCALADURL);
        if (adUrl&&![adUrl isEqualToString:@""]) {
            [LSLaunchAD showWithWindow:KEYWINDOW
                             countTime:3
                 showCountTimeOfButton:YES
                        showSkipButton:YES
                        isFullScreenAD:NO
                        localAdImgName:nil
                              imageURL:adUrl
                            canClickAD:YES
                               aDBlock:^(BOOL clickAD) {
                                   
                                   if (clickAD) {
//                                       DLog(@"点击了广告");
                                   } else {
                                       [UIApplication sharedApplication].statusBarHidden = NO;
                                       UIApplication *al = [UIApplication sharedApplication];
                                       al.delegate.window.rootViewController = [[BXTabBarController alloc]init];
                                       [al.delegate.window makeKeyAndVisible];
                                   }
                               }];
        }else
        {
            [UIApplication sharedApplication].statusBarHidden = NO;
            UIApplication *al = [UIApplication sharedApplication];
            al.delegate.window.rootViewController = [[BXTabBarController alloc]init];
            [al.delegate.window makeKeyAndVisible];
        }
    }
    else  { // 新版本
        [UIApplication sharedApplication].statusBarHidden = YES;
        UIApplication *al = [UIApplication sharedApplication];
        al.delegate.window.rootViewController = [LeadVC new];
        [al.delegate.window makeKeyAndVisible];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }


}

/**
 *  无网
 */
+(UIImageView*)setViewPlaceHoldImage:(CGFloat)maxY WithBgView:(UIView*)bgView{
    UIImageView *holdimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bgView.boundsHeight)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, maxY, SCREEN_WIDTH-100, 30)];
    label.font = Font(17);
    label.tag = 101;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"网络出错，请检查网络设置";
    label.textColor =UIColorFromRGB(0x333333);
    [holdimgView addSubview:label];
    
    UILabel *onceAgainLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, label.maxY+20, 100, 50)];
    onceAgainLab.font = Font(17);
    onceAgainLab.text = @"重新加载";
    onceAgainLab.tag = 100;
    onceAgainLab.layer.borderWidth = 1;
    onceAgainLab.layer.borderColor = COLOR_GRAY_.CGColor;
    onceAgainLab.textColor =UIColorFromRGB(0x333333);
    onceAgainLab.textAlignment = NSTextAlignmentCenter;
    [holdimgView addSubview:onceAgainLab];
    
    [bgView addSubview:holdimgView];
    return holdimgView;

}
-(void)showHoldImg
{
    self.holdImg = [[UIImageView alloc]initWithFrame:KEYWINDOW.bounds];
    
    self.holdImg.image = [UIImage imageNamed:@"LaunchImage"];
    
    [KEYWINDOW addSubview:self.holdImg];
}

-(void)hideHoldImg
{
 [self.holdImg removeFromSuperview];
}

@end
