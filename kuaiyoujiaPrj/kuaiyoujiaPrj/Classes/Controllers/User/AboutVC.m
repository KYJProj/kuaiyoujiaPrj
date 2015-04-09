//
//  AboutVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//
#import "AboutVC.h"
#import "LineView.h"
@implementation AboutVC



-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"关于我们";
    [self setLayout];
    
    
}

-(void)setLayout{
    
    
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.scrollsToTop = NO;
    
    [self.view addSubview:scrollV];
    //353,104
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-353/2)/2, 30, 353/2, 104/2)];
    logo.image = [UIImage imageNamed:@"iphone_logo"];
    [scrollV addSubview:logo];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"about" ofType:@"txt"];
    NSString *content = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0,logo.frame.origin.y + logo.frame.size.height + 30,SCREEN_WIDTH,560/2)];
    textView.editable = NO;
    textView.text = content;
    textView.font = [UIFont fontWithName: @"helvetica" size:14];
    textView.textColor = [UIColor hexChangeFloat:@"666666"];
    textView.backgroundColor = [UIColor whiteColor];
    [scrollV addSubview:textView];
    
    
    LineView *lineV = [[LineView alloc]initWithFrame:CGRectMake(10,textView.frame.origin.y+ textView.frame.size.height, SCREEN_WIDTH-20, 10)];
    lineV.backgroundColor = [UIColor whiteColor];
    [scrollV addSubview:lineV];
    
    CGFloat labelY = lineV.frame.origin.y + lineV.frame.size.height ;
    CGFloat labelH = 15;
    CGFloat padding = 5;
    int length = 12;
    for(int i = 1 ; i <= length ;i++){
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment= NSTextAlignmentLeft;
        label.textColor = [UIColor hexChangeFloat:@"000000"];
        switch (i) {
            case 1:
                label.textColor = [UIColor hexChangeFloat:@"000000"];
                label.text = @"客户服务";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 2:
                label.textColor = [UIColor hexChangeFloat:@"ffffff"];
                label.backgroundColor = [UIColor hexChangeFloat:@"70c601"];
                label.text = @"北京总部";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                
                break;
            case 3:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"地址：北京市朝阳区光华路SOHO一单元7层";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 4:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"电话：86-10-5900 6330";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 5:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"传真：86-10-5900 6330";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 6:
                label.textColor = [UIColor hexChangeFloat:@"ffffff"];
                label.backgroundColor = [UIColor hexChangeFloat:@"70c601"];
                label.text = @"上海分公司";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 7:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"地址：上海市长宁区中山西路1065号313室";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 8:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"电话：021 - 6031 9911";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 9:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"传真：021 - 6031 9815";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 10:
                label.textColor = [UIColor hexChangeFloat:@"000000"];
                label.text = @"客户服务";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 11:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"电话: 400-999-3535";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
            case 12:
                label.textColor = [UIColor hexChangeFloat:@"666666"];
                label.text = @"邮箱:service@kuaiyoujia.com";
                label.font = [UIFont fontWithName: @"helvetica" size:14];
                break;
        }
        CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        label.frame = CGRectMake(20, labelY + padding*i +labelH*i, size.width, labelH);
        [scrollV addSubview:label];
        if(i == length){
            scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, label.frame.origin.y + label.frame.size.height  + 20);
        }
    }
}



@end
