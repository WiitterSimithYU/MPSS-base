//
//  HomeViewController.m
//  MPSS
//
//  Created by miaomiaokeji on 2017/6/14.
//  Copyright © 2017年 miaoYXH. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = [UIColor yellowColor];
    baseView.layer.shadowColor = RGBCOLOR(18, 178, 136).CGColor;
    baseView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    baseView.layer.shadowRadius = 6;//阴影半径，默认3
    baseView.layer.shadowOffset = CGSizeMake(0,4);
    
    [self.view addSubview:baseView];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(0);
        make.size.mas_offset(CGSizeMake(200, 100));
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
