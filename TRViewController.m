//
//  TRViewController.m
//  Demo3_TMusic_Welcome
//
//  Created by tarena on 15-1-6.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation TRViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint  offset = scrollView.contentOffset;
    if (offset.x < 0 ) {
        scrollView.contentOffset = CGPointMake(0, offset.y);
    }
    if (offset.x > scrollView.frame.size.width*(self.imageNames.count -1)) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width*(self.imageNames.count-1) , offset.y);
    }
    NSUInteger  index = round(offset.x/scrollView.frame.size.width);
    //设置分页控件中处于被激活的提示符的下标
    self.pageControl.currentPage = index;
    NSLog(@"(%f,%f)",offset.x,offset.y);
}

-(NSArray *)imageNames{
    if (!_imageNames) {
        _imageNames  = @[@"welcome1.png",@"welcome2.png",@"welcome3.png",@"welcome4.png"];
    }
    return _imageNames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.frame;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*self.imageNames.count, scrollView.frame.size.height);
    // 向滚动视图添加图片子视图
    for (NSInteger i=0; i<self.imageNames.count; i++) {
        //创建ImageView
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageNames[i]]];
        CGRect  imageFrame  = CGRectZero;
        imageFrame.size =scrollView.frame.size;
        imageFrame.origin.y = 0;
        imageFrame.origin.x = i * scrollView.frame.size.width;
        image.frame = imageFrame;
        //将ImageView添加到滚动视图
        [scrollView addSubview:image];
    }
    //设置滚动视图为整页滚动
    scrollView.pagingEnabled = YES;
    //设置滚动视图的边缘不可以弹跳
    //scrollView.bounces = NO;
    //设置水平滚动条隐藏
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    //设置scrollView的代理对象为当前控制器
    scrollView.delegate = self;
    //将滚动视图添加到view中
    [self.view addSubview:scrollView];
    
    //配置分页控件
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(0, scrollView.frame.size.height-40, scrollView.frame.size.width, 30);
    pageControl.numberOfPages = self.imageNames.count;
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //关闭分页控件的用户交互功能
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
    //在scrollView的最后一幅图片的上面叠加一个按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((self.imageNames.count-1)*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [button addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
}

-(void)enterApp{
    NSLog(@"Enter  App");
}

@end









