//
//  BXTabBar.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "BXTabBar.h"
#import "BXTabBarButton.h"
#import "BXTabBarController.h"

@interface BXTabBar ()
/**
 *  选中的按钮
 */
@property (nonatomic, weak) UIButton *selButton;

/** 需要选中第几个 */
@property (nonatomic, assign) NSUInteger currentSelectedIndex;
@end

@implementation BXTabBar
/** tabBarTag */
static NSInteger const BXTabBarTag = 12000;

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // UITabBarItem保存按钮上的图片
    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        
            BXTabBarButton *btn = [BXTabBarButton buttonWithType:UIButtonTypeCustom];
            
            btn.tag = self.subviews.count + BXTabBarTag;
            
            // 设置图片
            [btn setImage:item.image forState:UIControlStateNormal];
            [btn setImage:item.selectedImage forState:UIControlStateSelected];
            btn.adjustsImageWhenHighlighted = NO;
            // 设置文字
            [btn setTitle:item.title forState:UIControlStateNormal];
            btn.item = item;
            [btn setTitleColor:RGBCOLOR(113, 109, 104) forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR(51, 135, 255) forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:btn];
            // 子控件的个数
            NSInteger subViewsCount = 1;
            if (self.seletedIndex) {
                subViewsCount = self.seletedIndex + 1;
            }
            if (self.subviews.count == subViewsCount) {
                self.currentSelectedIndex = self.subviews.count - 1;
                // 默认选中第一个
                [self btnClick:btn];
            
            // 添加观察者
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(btn)];
        }
    }
}

- (void)dealloc {
    for (int i=0; i<self.items.count; i++) {
        if (i != 2) {
            [self.items[i] removeObserver:self forKeyPath:@"badgeValue"];
        }
    }
}

/**
 *  实现数字的显示
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    BXTabBarButton *btn = (__bridge BXTabBarButton *)(context);
    UITabBarItem *item = object;
    btn.item = item;
}

- (void)setDelegate:(id<BXTabBarDelegate>)delegate{
    _delegate = delegate;
    [self btnClick:(BXTabBarButton *)[self viewWithTag:self.currentSelectedIndex + BXTabBarTag]];
}


- (void)btnClick:(UIButton *)button
{
    _selButton.selected = NO;
    
    button.selected = YES;
    
    _selButton = button;
    
    // 通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [_delegate tabBar:self didClickBtn:button.tag - BXTabBarTag];
    }
}

/**
 *  外界设置索引页跟着跳转
 */
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    UIButton *button = [self viewWithTag:(BXTabBarTag + seletedIndex)];
    [self btnClick:button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    
    CGFloat h = self.height;
#warning 在这里修改位置
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        if (i == 2) {
            y = -12;
            h = self.height + 12;
        } else {
            y = 0;
            h = self.height;
        }
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
