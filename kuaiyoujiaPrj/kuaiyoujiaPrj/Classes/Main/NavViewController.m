//
//  NavViewController.m
//  Rent_OC
//
//  Created by TTc on 14-10-13.
//  Copyright (c) 2014年 com.kuaiyoujia.rent. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController
+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if (iOS7) { // iOS7
        navBar.tintColor = [UIColor hexChangeFloat:@"ffffff"];
        
    } else { // 非iOS7
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    [navBar setTitleTextAttributes:@{
                                     UITextAttributeTextColor : [UIColor whiteColor]
                                     }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor hexChangeFloat:@"6bc30d"];
    self.navigationController.delegate = self;

}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
