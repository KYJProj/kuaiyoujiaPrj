//
//  HomeVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "HomeVC.h"

#import "Utils.h"
#import "HomeView.h"
#import "CityListVC.h"
#import "MoreVC.h"
#import "UserCenterVC.h"
#import "TTPageControl.h"

@interface HomeVC ()<HomeViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)HomeView *homeView;
@end

@implementation HomeVC{
    NSArray *imagesData;
    TTPageControl *pageControl;
    UIScrollView *scrollView;
}

-(instancetype)init{
    if(self = [super init]){
        imagesData = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3",@"banner4", nil];

    }
    return  self;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    scrollView.contentSize = CGSizeMake(375 * imagesData.count, CGRectGetHeight(scrollView.frame));
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    
    HomeView *tempView = [[HomeView alloc]initWithFrame:self.view.frame];
    tempView.delegate = self;
    [self.view addSubview:tempView];
    self.homeView = tempView;
}

-(void)initNavView{
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,98,33)];
    logo.image = [UIImage imageNamed:@"iphone_home_logo"];
    self.navigationItem.titleView = logo;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"北京" style:UIBarButtonItemStyleDone target:self action:@selector(locationAction:)];
    
    UIBarButtonItem *leftBtnDown = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iphone_home_left2"] style:UIBarButtonItemStylePlain target:self action:@selector(locationAction:)];
    leftBtnDown.imageInsets = UIEdgeInsetsMake(-10, -50, -16, -10);
    self.navigationItem.leftBarButtonItems = @[leftBtn,leftBtnDown];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iphone_home_phone"] style:UIBarButtonItemStylePlain target:self action:@selector(callAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}



-(void)locationAction:(id)sender{
    CityListVC *VC = [[CityListVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)callAction:(id)sender{
    NSString *phone = @"400-999-3535";
    TTAlertView *alert = [[TTAlertView alloc] initWithTitle:@"快速委托" contentText:[NSString stringWithFormat:@"买房卖房,租房出租,快速委托,\n快有家专业服务,%@",phone] leftButtonTitle:@"不,谢谢" rightButtonTitle:@"现在就委托"];
    [alert show];
    alert.rightBlock = ^() {
        [[Utils shareInstance] takePhoneCall:phone];
    };
}




//MARK:HomeViewDelegate
-(void)clickAction:(UIButton*)sender{
    NSLog(@"tag===>%ld",sender.tag);
    UIViewController *VC = nil;
    if(sender.tag%1000 == 0){
        switch ([sender tag]/1000) {
            case 1: {//tab1
                
                
            }
                break;
            case 2:{
                
            }
                break;
            case 3:{

            }
                break;
            case 4:{
                VC = [[UserCenterVC alloc]init];
            }
                break;
        }
    }else if(sender.tag%1000 == 1){
        switch (([sender tag] - 1)/1000) {
            case 1: {//tab1
                
                
            }
                break;
        }
        
    }
    else if(sender.tag%1000 == 2){
        
    }
    else{
        
    }
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
