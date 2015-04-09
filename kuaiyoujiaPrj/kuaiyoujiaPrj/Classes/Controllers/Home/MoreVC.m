//
//  MoreVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "Utils.h"
#import "MoreVC.h"
#import "NoticeVC.h"
#import "AboutVC.h"
#import "SuggestionVC.h"
@implementation MoreVC{
    NSArray *titles;
}



-(instancetype)init{
    if(self = [super init]){
        titles = @[@"消息设置",@"检查新版本",@"关于我们",@"意见反馈",@"400-999-3535"];
        self.isGroup= YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"更多";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MoreCell";
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    UIImage *img = nil;
    NSString *title = nil;
    if(indexPath.section == 0) {
        title = titles[indexPath.row];
        img = [UIImage imageNamed:[NSString stringWithFormat:@"iphone_more_img%ld",(indexPath.row +1)]];
        if(indexPath.row != 1){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 100, cell.frame.size.height)];
            label.font = [UIFont fontWithName: @"helvetica" size:12];
            label.textColor = [UIColor hexChangeFloat:@"666666"];
            label.text = @"当前版本V1.0.1";
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
        }
    }
    else {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 100, cell.frame.size.height)];
        label.font = [UIFont fontWithName: @"helvetica" size:12];
        label.textColor = [UIColor hexChangeFloat:@"666666"];
        label.text = @"每天9:00-20:00";
        [cell.contentView addSubview:label];
        title  = [titles lastObject];
        img = [UIImage imageNamed:[NSString stringWithFormat:@"iphone_more_img%ld",(indexPath.row +5)]];
    }
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName: @"helvetica" size:16];
    cell.textLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    cell.imageView.image = img;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1){
        NSString *phone = @"400-999-3535";
        TTAlertView *alert = [[TTAlertView alloc] initWithTitle:@"快速委托" contentText:[NSString stringWithFormat:@"买房卖房,租房出租,快速委托,\n快有家专业服务,%@",phone] leftButtonTitle:@"不,谢谢" rightButtonTitle:@"现在就委托"];
        [alert show];
        alert.rightBlock = ^() {
            [[Utils shareInstance] takePhoneCall:phone];
        };
    }
    else {
        UIViewController *VC = nil;
        if(indexPath.row == 0){
            VC = [[NoticeVC alloc]init];
        }else if(indexPath.row == 2){
            VC = [[AboutVC alloc]init];
        }else if (indexPath.row == 3){
            VC = [[SuggestionVC alloc]init];
            
        }
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 4;
    return 1;
}
@end
