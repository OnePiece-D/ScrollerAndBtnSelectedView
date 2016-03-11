# ScrollerAndBtnSelectedView
左右滑动视图头部同步跟随选中相应按钮,也可点击相应按钮选中相应视图

使用示例:

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
    
    NextPageScrollView * nextView = [[NextPageScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    nextView.topButtonTitles = titleArray;
    nextView.contentPages = contentArray;
    
    nextView.animationPage = NO;
    nextView.animationSlide = NO;
    nextView.pageEnable = NO;
    
    [self.view addSubview:nextView];

 注意:1.可能位置大小需要调整
     2.注意两个数组count需要保持一致
     3.需要时添加功能top按钮的宽度可以设置根据字体多少来自适应
