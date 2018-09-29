//
//  ViewController.m
//  SHWebViewController
//
//  Created by CSH on 2018/8/10.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHWebViewController.h"
#import <SHToast.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    @"SELECT * FROM DynamicList WHERE user_id = ? AND dynamic_type = ? LIMIT ?,?;";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SHWebViewController *web = [[SHWebViewController alloc]init];
    web.url = @"https://news.163.com/";
//    web.isNoUserNav = YES;
//    [self pres/Users/csh/Desktop/nav_more@3x.pngentViewController:web animated:YES completion:nil];
    [self.navigationController pushViewController:web animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
