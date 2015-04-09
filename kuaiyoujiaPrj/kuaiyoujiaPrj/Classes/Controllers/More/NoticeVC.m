//
//  NoticeVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "AppSetMgr.h"
#import "NoticeVC.h"
typedef enum {
    ALL_DAY = 0x01,
    NO_INTERRUPT
}PUSH_MODE_TAG;

@interface  NoticeTableViewCell: UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@end

@implementation NoticeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(nil != self){
        for(int i =0;i<2;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"iphone_notice"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"iphone_noticeEd"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            AppSetMgr *app = [AppSetMgr shareInstance];
            [app UnArchiveAppPro];
            if(i==0){
                btn.selected = app.push_Mode ?  YES : NO;
                btn.tag = NO_INTERRUPT;
                [btn setFrame:CGRectMake(150, 0, 22, self.frame.size.height)];
            }else {
                btn.selected = app.push_Mode ? NO : YES;
                btn.tag = ALL_DAY;
                [btn setFrame:CGRectMake(255, 0, 22, self.frame.size.height)];
            }
            
        }
        for(int i=0;i<3;i++){
            UILabel *label = [[UILabel alloc]init];
            label.textAlignment= NSTextAlignmentCenter;
            label.textColor = [UIColor hexChangeFloat:@"000000"];
            if (i==0){
                label.frame = CGRectMake(170, 5, 75, self.frame.size.height/2);
                label.text = @"免打扰";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                
            } else if(i==1){
                label.frame = CGRectMake(170, self.frame.size.height/2, 85, self.frame.size.height/2);
                label.text = @"21:00-9:00不推消息";
                label.font = [UIFont fontWithName: @"helvetica" size:7];
                label.textColor = [UIColor hexChangeFloat:@"666666"];
            }else {
                label.frame = CGRectMake(self.frame.size.width - 50, 0, 50, self.frame.size.height);
                label.text = @"全天";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                
            }
            [self.contentView addSubview:label];
        }
    }
    return self;
}

-(void)selectAction:(UIButton*)sender{
    sender.selected = YES;
    for(UIButton *btn  in  sender.superview.subviews){
        if([btn isKindOfClass:[UIButton class]] && sender.tag != btn.tag){
            btn.selected = NO;
        }
    }
    AppSetMgr *app = [AppSetMgr shareInstance];
    if(sender.tag == NO_INTERRUPT) app.push_Mode = YES;
    else app.push_Mode = NO;
    [app ArchiveAppPro];
}
-(void)drawRect:(CGRect)rect{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor hexChangeFloat:@"cccccc"].CGColor);
    CGContextMoveToPoint(ctx, 180, 26);
    CGContextAddLineToPoint(ctx, 245, 26);
    CGContextStrokePath(ctx);
}

@end

@implementation NoticeVC{
    NSArray *titles;
}

-(instancetype)init{
    if(self = [super init]){
        titles = @[@"接收推送消息",@"接收模式",@"铃声提醒",@"震动提醒"];
        self.isGroup= YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"消息设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString *identifier = @"MoreCell";
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }else {
            cell = [[NoticeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = titles[indexPath.row];
    }
    else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        if(indexPath.row == 0){
            cell.textLabel.text = titles[2];
        } else {
            cell.textLabel.text = [titles lastObject];
        }
    }
    
    cell.textLabel.font = [UIFont fontWithName: @"helvetica" size:16];
    cell.textLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    if(!(indexPath.section == 0 && indexPath.row == 1)){
        UISwitch *mSwitch = [[UISwitch alloc] init];
        // mSwitch.tag = indexPath.row;
        //[mSwitch addTarget:self action:@selector(mSwitchAction:) forControlEvents:UIControlEventValueChanged];
        __weak NoticeVC *  bSelf = self;
        void (^senderBlock)(UISwitch *sender) = ^(UISwitch *sender) {
            NSLog(@"sender.on==>%d indexPath.row==%ld indexPath.section==%ld ",sender.on,indexPath.row,indexPath.section);
            [bSelf saveChangeValue:sender.on indexPath:indexPath];
        };
        [self changeValueAction:mSwitch indexPath:indexPath];
        //[mSwitch bk_addEventHandler:senderBlock forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = mSwitch;
    }
    return cell;
}


-(void)changeValueAction:(UISwitch *)mSwitch indexPath:(NSIndexPath *)indexPath{
    AppSetMgr *app = [AppSetMgr shareInstance];
    [app UnArchiveAppPro];
    if(indexPath.row == 0 && indexPath.section == 1){
        mSwitch.on = app.isBellAlert_ON;
    }else if(indexPath.row == 1 && indexPath.section == 1){
        mSwitch.on = app.isVibration_ON;
    }else{
        mSwitch.on = app.isOpenPush;
    }
}

-(void)saveChangeValue:(BOOL)on indexPath:(NSIndexPath *)indexPath{
    AppSetMgr *app = [AppSetMgr shareInstance];
    if(indexPath.row == 0 && indexPath.section == 1){
        app.isBellAlert_ON = on;
    }else if(indexPath.row == 1 && indexPath.section == 1){
        app.isVibration_ON = on;
    }else{
        app.isOpenPush = on;
    }
    [app ArchiveAppPro];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void)mSwitchAction:(UISwitch*)sender{
    
}

@end
