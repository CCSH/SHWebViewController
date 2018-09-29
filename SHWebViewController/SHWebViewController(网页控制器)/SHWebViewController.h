//
//  SHWebViewController.h
//  SHWebViewController
//
//  Created by CSH on 2018/8/10.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 网页控制器
 */
@interface SHWebViewController : UIViewController

//网址
@property (nonatomic, copy) NSString *url;
//自定义标题(存在的话就优先显示)
@property (nonatomic, copy) NSString *customTitle;
//不使用导航栏
@property (nonatomic, assign) BOOL isNoUserNav;
//整个页面是否可以滚动(默认是NO)
@property (nonatomic, assign) BOOL isRoll;
//是否是本地
@property (nonatomic, assign) BOOL isLocal;

@end
