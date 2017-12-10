//
//  LeadVC.m
//  GoEarn
//
//  Created by Beyondream on 2016/9/23.
//  Copyright © 2016年 Beyondream. All rights reserved.
//

#import "LeadVC.h"

#import "BXTabBarController.h"

@interface LeadVC ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *startScrollView;
@property (strong, nonatomic)UIPageControl *pageControl;

@end

@implementation LeadVC
{
    UIButton *_buUon;
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createUI];
}

- (void)createUI
{
    _startScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _startScrollView.delegate = self;
    _startScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, 0);
    _startScrollView.showsVerticalScrollIndicator = NO;
    _startScrollView.showsHorizontalScrollIndicator = NO;
    _startScrollView.pagingEnabled = YES;
    _startScrollView.bounces = YES;
    _startScrollView.delegate = self;
    [self.view addSubview:_startScrollView];
    
    //后期添加跳不跳过/////////
    _buUon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buUon setTitle:@"跳过>" forState:UIControlStateNormal];
    [_buUon setTitleColor:UIColorFromRGB(0xa6a6a6) forState:UIControlStateNormal];
    _buUon.titleLabel.font  =  Font(14);
    [_buUon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buUon];
    [_buUon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-28);
        make.right.mas_equalTo(self.view).offset(-13);
    }];
    
    NSArray * startImageArr =nil;
    
    if (iPhone4)
    {  startImageArr=@[@"640-960_1",@"640-960_2",@"640-960_3",@"640-960_4"];
        
    }else if (iPhone5)
    {
      startImageArr=@[@"640-1136_1",@"640-1136_2",@"640-1136_3",@"640-1136_4"];
    }else if (iPhone6)
    {
       startImageArr=@[@"750-1334_1",@"750-1334_2",@"750-1334_3",@"750-1334_4"]; 
    }else if (iPhone6P)
    {
       startImageArr=@[@"1242-2208_1",@"1242-2208_2",@"1242-2208_3",@"1242-2208_4"];
    }

    else
    {
      startImageArr=@[@"750-1334_1",@"750-1334_2",@"750-1334_3",@"750-1334_4"];   
    }

    
    for (NSInteger index = 0; index < 4; index++) {
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:startImageArr[index]];
        //后期添加跳不跳过
        if (index == 3) {
            UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            goBtn.frame = CGRectMake((SCREEN_WIDTH-187*SCREEN_POINT)/2,SCREEN_HEIGHT -100*SCREEN_POINT, 187*SCREEN_POINT,45*SCREEN_POINT);
            [goBtn setImage:[UIImage imageNamed:@"bootpagebtn"] forState:UIControlStateNormal];
            [goBtn addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
            [imageV addSubview:goBtn];
        }
        
        [_startScrollView addSubview:imageV];
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.frame = CGRectMake(SCREEN_WIDTH/2-50*SCREEN_POINT, SCREEN_HEIGHT-50*SCREEN_POINT, 100*SCREEN_POINT, 20*SCREEN_POINT);
    _pageControl.numberOfPages = startImageArr.count;
    [_pageControl setValue:[UIImage imageNamed:@"bootpagedot1"] forKeyPath:@"pageImage"];
    [_pageControl setValue:[UIImage imageNamed:@"bootpagedot2"] forKeyPath:@"currentPageImage"];
    [self.view addSubview:_pageControl];
    
}

-(void)buttonClick:(UIButton *)btn
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    UIApplication *al = [UIApplication sharedApplication];

    al.delegate.window.rootViewController = [[BXTabBarController alloc]init];
    [al.delegate.window makeKeyAndVisible];
    
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = x/scrollViewW;
    if (x<=2*SCREEN_WIDTH) {
        _pageControl.hidden = NO;
        _buUon.hidden       = NO;
    }else
    {
        _pageControl.hidden = YES;
        _buUon.hidden       = YES;
    }
    _pageControl.currentPage = page;
    
    if (x > 3*SCREEN_WIDTH+SCREEN_WIDTH/4) {
        [self onTap:nil];
    }
}
- (void)onTap:(UIButton *)aTap
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    UIApplication *al = [UIApplication sharedApplication];
    al.delegate.window.rootViewController = [[BXTabBarController alloc]init];
    [al.delegate.window makeKeyAndVisible];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
