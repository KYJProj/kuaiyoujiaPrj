//
//  BaseTableViewController.h
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//


#import "BaseViewController.h"
#import "TTRefresh.h"

/*
 *抽象的TableView基类(如果需要上拉_下拉刷新 需要在子类中调用.h中的方法)
 */
@interface BaseTableViewController : BaseViewController
@property(nonatomic,assign)BOOL isAllRefresh;//上拉刷新&&下拉更多,默认为YES
@property(nonatomic,assign)BOOL isGroup;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,assign)int  mStart ;
@property(nonatomic,assign)int  mRows; //本地请求每次获取的长度(自定义的限制,默认10)
@property(nonatomic,assign)int  sum; //服务器返回的总长度
#ifdef ISAsyncDisplayKit
@property(strong,nonatomic)ASTableView *tableView;
#else
@property(strong,nonatomic)UITableView *tableView;
#endif
@property(nonatomic)REQUEST_MODE requestMode;
-(void)setupRefresh;
-(void)headerRereshing;
-(void)footerRereshing;
@end
