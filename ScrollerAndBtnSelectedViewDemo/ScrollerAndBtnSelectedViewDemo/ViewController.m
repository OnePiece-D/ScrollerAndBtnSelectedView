//
//  ViewController.m
//  ScrollerAndBtnSelectedViewDemo
//
//  Created by ycd9 on 16/3/11.
//  Copyright © 2016年 YCD. All rights reserved.
//

#import "ViewController.h"

#import "WYLNextPageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSMutableArray * contentArray = [NSMutableArray array];
    
    NSArray * colorArray = @[[UIColor grayColor],[UIColor redColor],[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor]];
    NSArray * titleArray = @[@"first",@"second",@"thrid",@"4",@"5"];
    for (int i = 0; i < 5; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        view.backgroundColor = colorArray[i];
        [contentArray addObject:view];
    }
    
    WYLNextPageScrollView * nextView = [[WYLNextPageScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    nextView.topButtonTitles = titleArray;
    nextView.contentPages = contentArray;
    
    nextView.animationPage = NO;
    nextView.animationSlide = NO;
    nextView.pageEnable = NO;
    
    [self.view addSubview:nextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
