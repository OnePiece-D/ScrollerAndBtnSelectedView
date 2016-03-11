//
//  NextPageScrollView.m
//  IntroductionView
//
//  Created by ycd9 on 16/2/22.
//  Copyright © 2016年 ycd9. All rights reserved.
//

#import "WYLNextPageScrollView.h"

#define kTopMinY 20
#define kSpaceTopBtn 0

#define kSliderHeight 2

#define buttonTag (2016 + 2 + 22 + 17)

@interface NextPageScrollView()<UIScrollViewDelegate>

{
    NSInteger _allCount;
    NSInteger _currentPage;
    NSInteger _lastSelectedPage;
    
    NSMutableArray * _topButtons;
    
    BOOL _topButtonClicked;
    BOOL _animationPageChange;
    BOOL _animationSlideChange;
}

@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIView * sliderView;

@end

@implementation NextPageScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        _allCount = 0;
        _currentPage = 0;
        _lastSelectedPage = 0;
        
        _topButtonClicked = NO;
        _animationPageChange = YES;
        _animationSlideChange = YES;
        
        _topButtons = [NSMutableArray array];
        
        [self addSubview:self.topView];
        [self addSubview:self.scrollView];
        [self addSubview:self.nextButton];
        
        [self addSubview:self.sliderView];
        
        [self bringSubviewToFront:self.nextButton];
        [self addSubview:self.backButton];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.topView.frame = CGRectMake(0, 0, size.width, 50);
        self.scrollView.frame = CGRectMake(0, CGRectGetHeight(self.topView.frame), size.width, size.height);
        
        self.nextButton.frame = CGRectMake(100, 300, 100, 30);
        self.backButton.frame = CGRectMake(100, 250, 100, 30);
        
        self.sliderView.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

- (void)setTopButtonTitles:(NSArray *)topButtonTitles {
    _topButtonTitles = topButtonTitles;
    
    CGFloat minX = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    for (int i = 0; i < topButtonTitles.count; i++) {
        //定下大小样式等信息
        UIButton * button = [self createButtonWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / topButtonTitles.count, 30)
                                                                      title:topButtonTitles[i]
                                                                 titleColor:[UIColor blackColor]
                                                              selectedTitle:nil
                                                         selectedTitleColor:[UIColor orangeColor]
                                                                      image:nil selectedImage:nil];
        button.tag = buttonTag + i;
        minX += width + kSpaceTopBtn;
        width = button.frame.size.width;
        height = button.frame.size.height;
        
        //重新排位
        button.frame = CGRectMake(minX, kTopMinY, width, height);
        
        if (i == 0) {
            _lastSelectedPage = 0;
            button.selected = YES;
            self.sliderView.frame = CGRectMake(0, CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), kSliderHeight);
        }
        
        [self addSubview:button];
        
        [button addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topButtons addObject:button];
    }
}

- (void)setContentPages:(NSArray *)contentPages {
    _contentPages = contentPages;
    
    _allCount = contentPages.count;
    
    CGFloat width = CGRectGetMaxX(self.scrollView.frame);
    for (int i = 0; i < contentPages.count; i++) {
        UIView * view = (UIView *)contentPages[i];
        CGSize size = view.frame.size;
        CGFloat minY = CGRectGetMinY(view.frame);
        view.frame = CGRectMake(width * i, minY, size.width, size.height);
        [self.scrollView addSubview:view];
        [self.scrollView setContentSize:CGSizeMake(width * (i + 1), 0)];
    }
}


- (void)setBackButtonHidden:(BOOL)backHidden nextButtonHidden:(BOOL)nextButtonState {
    if (backHidden == YES) {
        [self.backButton removeFromSuperview];
    }else if(backHidden == NO) {
        [self addSubview:self.backButton];
    }
    
    if (nextButtonState == YES) {
        [self.nextButton removeFromSuperview];
    }else if(nextButtonState == NO) {
        [self addSubview:self.nextButton];
    }
}

- (void)setAnimationPage:(BOOL)animationPage {
    _animationPageChange = animationPage;
}

- (void)setPageEnable:(BOOL)pageEnable {
    self.scrollView.scrollEnabled = pageEnable;
}

- (void)setAnimationSlide:(BOOL)animationSlide {
    _animationSlideChange = animationSlide;
}

#pragma mark -ScrollerViewDelegate-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (index != _currentPage && _topButtonClicked == NO) {
        _lastSelectedPage = _currentPage;
        _currentPage = index;
        
        [self topPageChange];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    _currentPage = index;
    
    _topButtonClicked = NO;
}

#pragma mark -点击事件-
/**
 *  topButtons点击
 */
- (void)topButtonAction:(UIButton *)button {
    if (button.selected) {
        return;
    }
    _topButtonClicked = YES;
    
    _currentPage = button.tag - buttonTag;
    _lastSelectedPage = _currentPage;
    
    [self topPageChange];
    [self contentPageChange];
}

/**
 *  上个页面
 */
- (void)backPage {
    if (_currentPage <= 0) {
        return;
    }
    _lastSelectedPage = _currentPage;
    _currentPage --;
    
    
    [self topPageChange];
    [self contentPageChange];
}

/**
 *  下一页面
 */
- (void)buttonAction {
    if (_currentPage >= _allCount - 1) {
        return;
    }
    _lastSelectedPage = _currentPage;
    _currentPage ++;
    
    [self topPageChange];
    [self contentPageChange];
    
}

#pragma mark -相应变更处理-

- (void)topPageChange {
    NSInteger topCount = 0;
    
    CGFloat minX = 0;
    for (UIButton * button in _topButtons) {
        minX += CGRectGetMinX(button.frame);
        
        if (topCount == _currentPage) {
            button.selected = YES;
            
            UIButton * lastSelectedBtn = (UIButton *)_topButtons[_lastSelectedPage];
            
            [self sliderMoveTo:CGRectGetMinX(lastSelectedBtn.frame) oldWidth:CGRectGetWidth(lastSelectedBtn.frame) newX:CGRectGetMinX(button.frame) newWidth:CGRectGetWidth(button.frame)];
        }else {
            button.selected = NO;
        }
        
        topCount ++;
    }
}

- (void)contentPageChange {
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    [self.scrollView setContentOffset:CGPointMake(_currentPage * width, 0) animated:_animationPageChange];
}


- (void)sliderMoveTo:(CGFloat)oldX oldWidth:(CGFloat)oldWidth newX:(CGFloat)newX newWidth:(CGFloat)newWidth {
    CGFloat minY = CGRectGetMinY(self.sliderView.frame);
    CGFloat height = CGRectGetHeight(self.sliderView.frame);
    
    CGFloat timeLong = 0;
    if (_animationSlideChange == YES) {
        timeLong = 0.328;
    }else if (_animationSlideChange == NO) {
        timeLong = 0;
    }
    
    [UIView animateWithDuration:timeLong animations:^{
        self.sliderView.frame = CGRectMake(newX, minY, newWidth, height);
    }];
}

#pragma mark -工厂方法-
- (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)normalTitle
                         titleColor:(UIColor *)normalTitleColor
                      selectedTitle:(NSString *)selectedTitle
                 selectedTitleColor:(UIColor *)selectedTitleColor
                              image:(UIImage *)image
                      selectedImage:(UIImage *)selectedImage {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    
    if (selectedTitle) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
    if (selectedTitleColor) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    
    if(image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
    
    
    //设置公共样式
    button.reversesTitleShadowWhenHighlighted = YES;
    
    return button;
}

#pragma mark -懒加载-
- (UIButton *)nextButton {
    if (!_nextButton) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"next" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _nextButton = button;
    }
    return _nextButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView * view = [[UIScrollView alloc] init];
        view.delegate = self;
        view.pagingEnabled = YES;
        _scrollView = view;
    }
    return _scrollView;
}

- (UIView *)topView {
    if (!_topView) {
        UIView * view = [[UIView alloc] init];
        _topView = view;
    }
    return _topView;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView * view = [[UIView alloc] init];
        _sliderView = view;
    }
    return _sliderView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
