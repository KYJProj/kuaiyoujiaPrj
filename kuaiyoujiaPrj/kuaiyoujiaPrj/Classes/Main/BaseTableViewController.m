//
//  BaseTableViewController.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "BaseTableViewController.h"


#ifdef ISAsyncDisplayKit
@interface BaseTableViewController()<ASTableViewDataSource,ASTableViewDelegate>
@end

#else

@interface BaseTableViewController()<UITableViewDataSource,UITableViewDelegate>

@end

#endif

@implementation BaseTableViewController


-(instancetype)init{
    
    if (!(self = [super init]))
        return nil;
    self.mRows = 10;
    self.mStart = 1;
    self.isGroup = NO;
    self.isAllRefresh = YES;
    return self;
}
//数据的懒加载

-(NSMutableArray*)items{
    if(!_items){
        self.items = [NSMutableArray array];
    }
    return _items;
}
#ifdef ISAsyncDisplayKit
-(ASTableView*)tableView{
    if(!_tableView){
        if(!self.isGroup){
            self.tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        }
        else{
            self.tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //
        _tableView.asyncDataSource = self;
        _tableView.asyncDelegate = self;
        
        _tableView.sectionHeaderHeight = 0;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#else
-(UITableView*)tableView{
    if(!_tableView){
        if(!self.isGroup){
            self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        }
        else{
            self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor hexChangeFloat:@"f5f5f5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#endif
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.frame = self.view.frame;
    [self.view addSubview:self.tableView];
    
}

-(void)setupRefresh{
        [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.tableView headerBeginRefreshing];
        self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
        self.tableView.headerReleaseToRefreshText = @"松开刷新";
        self.tableView.headerRefreshingText = @"正在刷新中";
        if(self.isAllRefresh){
            [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
            self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
            self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
            self.tableView.footerRefreshingText = @"正在加载中...";
        }
}
//MARK :下拉刷新
- (void)headerRereshing{
    _requestMode = Refresh_Mode;
    self.mStart = 1;
}
//MARK:上拉加载更多
-(void)footerRereshing{
    _requestMode = More_Mode;
    self.mStart++;
}

//MARK: UITableViewDelegate && UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did.....");
}
/**
 *  子类需要重载该方法
 *
 *  @param ASCellNode node节点
 *
 *  @return ASCellNode node节点
 */
//- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ASCellNode *node = nil;
//    if(node == nil){
//        node = [[ASCellNode alloc]init];
//    }
//    return node;
//}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.rowHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
