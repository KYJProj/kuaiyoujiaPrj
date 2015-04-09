//
//  TTPickerView.m
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import "TTPickerView.h"

@interface TTPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickView;
@end
@implementation TTPickerView{
    UIButton *confimBtn;
    UIButton *cancelBtn;
    int  titleW;
    int  titleH;
    int  btnH;
    
}
+(instancetype)newPickerView:(CGRect)frame titles:(NSArray*)titles items:(NSDictionary*)items{
    return [[TTPickerView alloc]initWithFrame:frame titles:titles items:items];
}
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles items:(NSDictionary*)items{
    if (!(self = [super initWithFrame:frame]))
        return nil;
    self.backgroundColor = [UIColor whiteColor];
    self.titles = titles;
    self.items  = items;
    self.rowWidth = (float)SCREEN_WIDTH/[self.titles count];
    self.rowHeight = 44.0f;
    titleW = 10;
    titleH = 40;
    btnH = 40;
    [self setLayout];
    return self;
}
-(UIPickerView *)pickView{
    if (!_pickView) {
        self.pickView =[[UIPickerView alloc] initWithFrame:CGRectZero];
        self.pickView.tintColor = self.tintColor;
        self.pickView.showsSelectionIndicator= YES;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
    }
    return _pickView;
}

-(void)layoutSubviews{
    [_pickView setFrame:CGRectMake(0, 0, self.frame.size.width, 216.0f)];
}

-(void)setLayout{
   [self addSubview:self.pickView];
   int count =  [self.titles count];
    for(int i = 0 ; i < count ; i++ ){
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleW + i * _rowWidth, 0, _rowWidth, titleH)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:FONT size:20.0f];
        titleLabel.text = [self.titles objectAtIndex:i];
        [self addSubview:titleLabel];
    }
    
    cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - btnH, SCREEN_WIDTH/2, btnH)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor hexChangeFloat:@"f5f5f5"]];
    [cancelBtn setTitleColor:[UIColor hexChangeFloat:@"999999"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(canceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];

    confimBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.frame.size.height - btnH, SCREEN_WIDTH/2, btnH)];
    [confimBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confimBtn setTitleColor:[UIColor hexChangeFloat:@"ffffff"] forState:UIControlStateNormal];
    [confimBtn setBackgroundColor:[UIColor hexChangeFloat:@"70c601"]];
    [confimBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confimBtn];
}

-(void)saveAction{
//    [confimBtn setBackgroundColor:[UIColor hexChangeFloat:@"f5f5f5"]];
//    [cancelBtn setBackgroundColor:[UIColor hexChangeFloat:@"70c601"]];

}
-(void)canceAction{
//    [cancelBtn setBackgroundColor:[UIColor hexChangeFloat:@"f5f5f5"]];
//    [confimBtn setBackgroundColor:[UIColor hexChangeFloat:@"70c601"]];
}

//MARK: UIPickerViewDelegate && UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  self.titles.count ;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSString *key = [self.titles objectAtIndex:component];
    return  [[self.items objectForKey:key] count];
  
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *key = [self.titles objectAtIndex:component];
    return   [[self.items objectForKey:key] objectAtIndex:row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.rowWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.rowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"row===%d    component ===%d",row,component);
}


- (void)drawRect:(CGRect)rect{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
    
    CGContextMoveToPoint(context, 0, self.bounds.origin.y + _rowHeight);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.origin.y + _rowHeight);
    CGContextMoveToPoint(context, 0, self.bounds.size.height - btnH -1);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.frame.size.height - btnH -1);
    CGContextStrokePath(context);
    
}
@end
