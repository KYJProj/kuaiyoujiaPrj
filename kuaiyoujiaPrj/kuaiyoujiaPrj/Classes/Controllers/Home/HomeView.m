//
//  HomeView.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "HomeView.h"
#import "TTIntroView.h"
#import "TTPageControl.h"
@interface HomeView()<TTIntroDelegate,UIScrollViewDelegate>
@end

@implementation HomeView{
    NSArray *titles;
    NSArray *imagesData;
    TTPageControl *pageControl;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor hexChangeFloat:@"ffffff"];
        titles = [NSArray arrayWithObjects:@"租房秘书",@"独家委托",@"广告推广",@"租房银行",@"房模代言",@"快有家VIP",@"首页", @"微聊", @"发布", @"我的", nil];
        imagesData = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3", nil];
        [self initTopView];
        [self initCenterView];
        [self initBottomView];
    }
    return self;
}


-(void)initTopView{
   

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH ,130)];
    scrollView.scrollsToTop = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.alwaysBounceVertical = NO;
    scrollView.delegate = self;
    scrollView.bounces = YES;
    scrollView.scrollEnabled = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * [imagesData count],0)];

    [self addSubview:scrollView];
    
   
    [imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * idx, -64, SCREEN_WIDTH, 130)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
    }];
   
    pageControl = [[TTPageControl alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2, scrollView.frame.size.height + scrollView.frame.origin.y-10, 40, 40)];
    pageControl.numberOfPages = [imagesData count];
    [self addSubview:pageControl];
}



-(void)initCenterView{
    int row = 2;
    int col = 3;
    for (int i = 1; i <= row; i++) {
        for (int j = 1; j <= col; j++) {
            int index = (i-1)*col + j;
            int padH = 0;
            if(i == 3) padH = 0;
            NSString *imgNames = [NSString stringWithFormat:@"%d@2x.png",index];
            CGRect rect = CGRectMake( j* (SCREEN_WIDTH-44 *3)/4 + (j-1)*44  ,198 + (i-1) * 44  + 20 *(i -1) + padH , 44,495/2/3);
            UIButton *btn = [UIButton creatButton:rect img:[UIImage imageNamed:imgNames] title:[titles objectAtIndex:index-1]  imgEdgeInsets:UIEdgeInsetsMake(-30, -20.0, 0.0, 0.0) titleEdgeInsets:UIEdgeInsetsMake( 35, -70.0, 0.0, 0.0) sel:@selector(onClickAction:) target:self];
            
            btn.tag = index* 1000  +1;
            [self addSubview:btn];
        }
    }
}

-(void)initBottomView{
    
 
    UIView *imagView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 58  - 150,SCREEN_WIDTH,150)];
    imagView.backgroundColor = [UIColor redColor];
    [self addSubview:imagView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -58 - 350/2, SCREEN_WIDTH ,350/2)];
    imageView.image = [UIImage imageNamed:@"iphone_home_bottom"];
    [self addSubview:imageView];
    
    UIButton *rentBtn = [UIButton creatButton:CGRectMake((SCREEN_WIDTH-163)/2, imageView.frame.size.height + imageView.frame.origin.y - 43 - 10, 163, 43) img:nil title:nil imgEdgeInsets:UIEdgeInsetsZero titleEdgeInsets:UIEdgeInsetsZero sel:@selector(onClickAction:) target:self];
    [rentBtn setBackgroundImage:[UIImage imageNamed:@"iphone_home_rent"] forState:UIControlStateNormal];
    rentBtn.titleLabel.font = [UIFont fontWithName: @"helvetica" size:20];
    [rentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rentBtn.tag = 1002;
    [self addSubview:rentBtn];

    
    UIView* bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 30)];
    for (int i = 0; i < 4; i++) {
        CGRect rect = CGRectMake(20 + i*SCREEN_WIDTH / 4.0 , 0, SCREEN_WIDTH / 4.0 , 45 + 40);
        UIButton *btn = [UIButton creatButton:rect img:[UIImage imageNamed:[NSString stringWithFormat:@"iphone_home_tab%d",(i+1)]] title:[titles objectAtIndex:(6+i)]  imgEdgeInsets:UIEdgeInsetsMake(-40, -20.0, 0.0, 0.0) titleEdgeInsets:UIEdgeInsetsMake(0, -60.0, 0.0, 0.0) sel:@selector(onClickAction:) target:self];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"iphone_home_tab%ded",(i+1)]] forState:UIControlStateSelected];
        btn.tag =  (i+1)* 1000 ;
        [bottonView addSubview:btn];
        if(i == 0) btn.selected = YES;
        else  btn.selected = NO;
    }
    [self addSubview:bottonView];
}


-(void)onClickAction:(UIButton*)sender{
    if(sender.tag%1000 == 0){
        sender.selected = YES;
        for(UIButton *btn  in  sender.superview.subviews){
            if(sender.tag != btn.tag){
                btn.selected = NO;
            }
        }
    }
    [self clickAction:sender];
}

-(void)clickAction:(UIButton*)sender{
    [_delegate clickAction:sender];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int width = (SCREEN_WIDTH);
    if(((int)scrollView.contentOffset.x  % width ) != 0 ){
        return;
    }
    int tmp = scrollView.contentOffset.x > (SCREEN_WIDTH*([imagesData count] -1)) ? 1 : 0;
    NSInteger pageIndex = scrollView.contentOffset.x / SCREEN_WIDTH + tmp;
    if(pageIndex >= [imagesData count]){
        pageIndex = 0;
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    pageControl.currentPage = pageIndex;
    
}


-(void)drawRect:(CGRect)rect{
    NSLog(@"---------");
    //
    //UIColor *color = [UIColor blueColor];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor hexChangeFloat:@"cccccc"].CGColor);
    
    
    //纵向
//    CGContextMoveToPoint(ctx, 44, SCREEN_HEIGHT - 49 - 9*2 - 39 - 175/2 - 160);
//    CGContextAddLineToPoint(ctx, 44, SCREEN_HEIGHT - 49 - 9*2 - 39);
    
    //横向
    
//    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49 - 9*2 - 39 - 175/2 - 160);
//    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 9*2 -39-175/2 -160);
//    
//    
//    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49 - 9*2 - 39 - 175/2);
//    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 9*2 -39-175/2);
//    
//    
//    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49 - 9*2 - 39);
//    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 9*2 -39);
//    
//    
//    
//    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49 - 9 - 39);
//    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 9 -39);
//    
//    
//    
//    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49 - 9);
//    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 9);
    
    
    CGContextMoveToPoint(ctx, 0, SCREEN_HEIGHT - 49);
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    
    for(int i = 0 ; i< 3;i++){
        CGContextMoveToPoint(ctx, (i+1)*SCREEN_WIDTH/4, SCREEN_HEIGHT - 43.5);
        CGContextAddLineToPoint(ctx, (i+1)*SCREEN_WIDTH/4, SCREEN_HEIGHT -6.5);
    }
    CGContextStrokePath(ctx);
    
}



@end
