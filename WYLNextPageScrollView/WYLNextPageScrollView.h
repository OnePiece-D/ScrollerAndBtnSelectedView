//
//  NextPageScrollView.h
//  IntroductionView
//
//  Created by ycd9 on 16/2/22.
//  Copyright © 2016年 ycd9. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 
 
 集成方法:
 
 
 CGFloat width = [UIScreen mainScreen].bounds.size.width;
 CGFloat height = [UIScreen mainScreen].bounds.size.height;
 NSMutableArray * contentArray = [NSMutableArray array];
 
 NSArray * colorArray = @[[UIColor grayColor],[UIColor greenColor],[UIColor redColor]];
 NSArray * titleArray = @[@"first",@"second",@"thrid"];
 for (int i = 0; i < 3; i++) {
 UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
 view.backgroundColor = colorArray[i];
 [contentArray addObject:view];
 }
 
 NextPageScrollView * nextView = [[NextPageScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
 nextView.topButtonTitles = titleArray;
 nextView.contentPages = contentArray;
 [self.view addSubview:nextView];
 
 
 
 注意:1.可能位置大小需要调整
     2.注意两个数组count需要保持一致
     3.需要时添加功能top按钮的宽度可以设置根据字体多少来自适应
 
 */


@interface WYLNextPageScrollView : UIView

/**
 *  topButtonTitles
 */
@property (nonatomic, strong) NSArray * topButtonTitles;
/**
 *  contentViews
 */
@property (nonatomic, strong) NSArray * contentPages;

/**
 *  back And Next Button Set, Default is font the view
 */
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * nextButton;

@property (nonatomic, assign) BOOL animationSlide;  //Defalut is YES;
@property (nonatomic, assign) BOOL animationPage;   //Default is YES;
@property (nonatomic, assign) BOOL pageEnable;      //Defalut is YES;

- (void)setBackButtonHidden:(BOOL)backHidden nextButtonHidden:(BOOL)nextButtonState;

@end
