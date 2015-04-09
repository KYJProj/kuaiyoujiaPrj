//
//  CityListVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "CityListVC.h"
#import "MainData.h"
#import "MapUtils.h"
@interface CityListVC ()

@end

@implementation CityListVC{
    
    NSDictionary *dict;
}


-(instancetype)init{
    if(self = [super init]){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"openCity" ofType:@"json"];
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        dict = [data objectFromJSONData];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
}
- (CAAnimation *)animationRotate{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 0.5, -0.5,0.5);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue         = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration        = 0.3;
    animation.autoreverses    = YES;
    animation.cumulative      = YES;
    animation.repeatCount     = 1;
    animation.beginTime       = 0.1;
    animation.delegate        = self;
    return animation;
}

-(void)stopAnimation:(UIButton*)sender{
    [sender.layer removeAnimationForKey:@"animationXYRotate"];
}

-(void)startAnimation:(UIButton *)sender{
    NSLog(@"startAnimation--");
    CATransform3D rotationTransform  = CATransform3DMakeRotation(-M_PI_4, 0,0,1);
    //        rotationTransform = CATransform3DScale(rotationTransform, 0.8, 0.8, 1.0);
    CABasicAnimation *animationXYRotate = [CABasicAnimation animationWithKeyPath:@"transform"];
    animationXYRotate.delegate = self;
    animationXYRotate.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animationXYRotate.duration = 0.1;
    animationXYRotate.autoreverses = NO;
    animationXYRotate.cumulative = YES;
    animationXYRotate.removedOnCompletion = NO;
    animationXYRotate.fillMode = kCAFillModeForwards;  //nice
    animationXYRotate.repeatCount = HUGE_VALF;
    [sender.layer addAnimation:animationXYRotate forKey:@"animationXYRotate"];
}

//MARK:UITableViewDelegate && UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CityListTableViewCell";
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = @"北京";
        
        
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //[refreshBtn setEnlargeEdge:20];
        
        refreshBtn.frame = CGRectMake(cell.frame.size.width - 50 ,10, 22,22);
        [refreshBtn setBackgroundImage:[UIImage imageNamed:@"iphone_citylist_refresh"] forState:UIControlStateNormal];
        
        [refreshBtn addTarget:self
                       action:@selector(locationAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:refreshBtn];
    }
    else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSArray *cityArr = [dict objectForKey:@"hotCity"];
        cell.textLabel.text = [[cityArr objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *cityArr = [dict objectForKey:@"hotCity"];
    NSDictionary *cityDict = [cityArr objectAtIndex:indexPath.row];
    [[MainData shareInstance] initCityData:cityDict];
    [[MainData shareInstance] archive];
    
    
    [self.navigationController  popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    return [[dict objectForKey:@"hotCity"] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"当前定位城市";
    return @"热门城市";
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor hexChangeFloat:@"ebebeb"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3,SCREEN_WIDTH , 30)];
    if(section == 0){
        label.text = @"当前定位城市";
    }else {
        label.text = @"热门城市";
    }
    [view addSubview:label];
    return view;
}




-(void)locationAction:(UIButton*)sender{
    [self startAnimation:sender];
    [[MapUtils shareInstance] startLocationService];
    [[MapUtils shareInstance] startGeoCodeSearchService];
    __weak CityListVC *weakSelf = self;
    [MapUtils shareInstance].getLocaltionInfoBlock = ^(CLLocationCoordinate2D locationPt,NSString *addressStr,BMKSearchErrorCode code){
        
        [self stopAnimation:sender];
        
        if(code == BMK_SEARCH_NO_ERROR || code == BMK_SEARCH_AMBIGUOUS_KEYWORD || code == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR || code == BMK_SEARCH_NOT_SUPPORT_BUS || code == BMK_SEARCH_NOT_SUPPORT_BUS_2CITY || code == BMK_SEARCH_RESULT_NOT_FOUND || code == BMK_SEARCH_ST_EN_TOO_NEAR){
            
        }
        else {
            NSLog(@"地址：%@",addressStr);
            NSLog(@"经度：%f  纬度： %f",locationPt.latitude,locationPt.longitude);
            
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
