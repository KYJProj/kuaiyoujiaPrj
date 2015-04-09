//
//  SuggestionVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "SuggestionVC.h"
#import "TTTextView.h"
@interface SuggestionVC ()<UITextViewDelegate>

@end

@implementation SuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    [self setLayout];
}
-(void)setLayout{
    
    self.view.backgroundColor = [UIColor hexChangeFloat:@"f5f5f5"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64 +  5, SCREEN_WIDTH, 210)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //    CALayer *layer = [CALayer layer];
    //    layer.bounds = CGRectMake(0, 5, SCREEN_WIDTH, 170);
    //    layer.backgroundColor = [UIColor whiteColor].CGColor;
    //    [self.view.layer addSublayer:layer];
    
    TTTextView *textView = [[TTTextView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, view.frame.size.height-60)];
    textView.placeholder=@"请尽可能详细的描述您的意见和建议...";
    textView.font = [UIFont fontWithName: @"helvetica" size:14];
    textView.delegate = self;
    textView.textColor = [UIColor hexChangeFloat:@"666666"];
    textView.backgroundColor = [UIColor hexChangeFloat:@"f5f5f5"];
    textView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    [view addSubview:textView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment= NSTextAlignmentLeft;
    label.textColor = [UIColor hexChangeFloat:@"666666"];
    NSString *phone = @"139-1027-9269";
    label.text = [NSString stringWithFormat:@"您的手机号:%@",phone];
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    label.frame = CGRectMake(20, view.frame.size.height -30 - 10, size.width, 30);
    [view addSubview:label];
    //
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH-270)/2, view.frame.origin.y + view.frame.size.height + 30, 270, 37);
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor hexChangeFloat:@"70c601"]];
    [btn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)sendAction:(UIButton*)sender{
    
}

@end
