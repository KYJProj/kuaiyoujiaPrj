//
//  UserCenterVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//
#import "AppSetMgr.h"
#import "UserCenterVC.h"
#import "MoreVC.h"
@interface UserCenterVC()

@end

@implementation UserCenterVC{
    NSArray *titles;
}



-(instancetype)init{
    self = [super init];
    if (self == nil)
        return nil;
    self.isGroup= YES;
    titles = @[@"微聊",@"站内信",@"我的账户", @"我开通的服务" ,@"更多"];
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([AppSetMgr shareInstance].isLogin) {
       
    }
    else{

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.tableView.bounces = NO;
    [self initWithTopView];
    
}

-(void)initWithTopView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH ,213/2)];
    imageView.image = [UIImage imageNamed:@"iphone_login"];
    self.tableView.tableHeaderView = imageView;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SCREEN_WIDTH-159)/2,106,159, 42);
    [button setTitle:@"登录 / 注册" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor hexChangeFloat:@"ff9900"];
    button.titleLabel.textColor = [UIColor whiteColor];
    __weak UserCenterVC *bself = self;
    void (^senderBlock)(UIButton *sender) = ^(UIButton *sender) {
        //[bself.navigationController pushViewController:VC animated:YES];
    };
    [self.view addSubview:button];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MoreCell";
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    UIImage *img = nil;
    NSString *title = nil;
    if(indexPath.section == 0) {
        title = titles[indexPath.row];
        img = [UIImage imageNamed:[NSString stringWithFormat:@"iphone_user_%ld",(indexPath.row +1)]];
    } else if (indexPath.section == 1){
        title = titles[indexPath.row + 3];
        img = [UIImage imageNamed:[NSString stringWithFormat:@"iphone_user_%ld",(indexPath.row +4)]];
        
    }else {
        title = titles[indexPath.row + 4];
        img = [UIImage imageNamed:@"iphone_user_6"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName: @"helvetica" size:16];
    cell.textLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    cell.imageView.image = img;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2){
        MoreVC *vc = [[MoreVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }else if(section == 1){
        return 1;
    }else {
        return 1;
    }
}


@end
