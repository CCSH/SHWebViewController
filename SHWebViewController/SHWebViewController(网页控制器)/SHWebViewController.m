//
//  SHWebViewController.m
//  SHWebViewController
//
//  Created by CSH on 2018/8/10.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWebViewController.h"
#import <WebKit/WebKit.h>
#import "SHPopMenu.h"

#define kStatusH [[UIApplication sharedApplication] statusBarFrame].size.height

@interface SHWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
//进度条
@property (nonatomic, strong) CALayer *progressLayer;
//下拉气泡
@property (nonatomic, strong) SHPopMenu *menu;
//提示文字
@property (nonatomic, strong) UILabel *prompt;

@end

@implementation SHWebViewController

#pragma mark - 懒加载
- (SHPopMenu *)menu{
    
    if (!_menu) {
        _menu = [[SHPopMenu alloc]init];
        _menu.dimBackground = YES;
        _menu.arrowPosition = SHPopMenuArrowPositionRight;
        _menu.contentH = 40;
        //图片+文字
        _menu.mList = @[@{@"icon":@"刷新"},@{@"icon":@"分享"},@{@"icon":@"复制链接"}];
    }
    return _menu;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置提示
    [self configconPrompt];
    //设置进度条
    [self configProgress];
    //设置web
    [self configWeb];
    //设置观察者
    [self configKVO];
    //设置导航栏
    [self configNav];
}

#pragma mark - 导航栏点击事件
- (void)backAction{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self closeAction];
    }
}

- (void)closeAction{
    
    if (self.navigationController.viewControllers) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)moreAction{
    //显示菜单
    [self.menu showInRectX:self.view.frame.size.width - self.menu.menuW - 15 rectY:64 block:^(SHPopMenu *menu, NSInteger index) {
        //消失
        [menu dismiss];
        
        NSLog(@"点击了 --- %ld",(long)index);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 设置web
- (void)configWeb{
    
    CGFloat web_y = kStatusH + (self.isNoUserNav?0:self.navigationController.navigationBar.frame.size.height);
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,web_y,self.view.frame.size.width,self.view.frame.size.height - web_y) configuration:[self configWebView]];

    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    //最后将webView添加到界面
    [self.view addSubview:self.webView];

    if (self.isLocal) {//本地

    }else{//网络
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
    }
}

#pragma mark 设置环境
- (WKWebViewConfiguration *)configWebView{
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    return config;
}

#pragma mark 设置进度条
- (void)configProgress{
    
    CGFloat progress_y = self.navigationController.navigationBar.frame.size.height + kStatusH;
    
    self.progressLayer = [CALayer layer];
    self.progressLayer.frame = CGRectMake(0, progress_y, 0, 3);
    self.progressLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.progressLayer];
    
    
}

#pragma mark 设置提示
- (void)configconPrompt{
    
    if (!self.isLocal) {
        self.prompt = [[UILabel alloc]init];
        self.prompt.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + kStatusH, CGRectGetWidth(self.view.frame), 30);
        self.prompt.textColor = [UIColor lightGrayColor];
        self.prompt.textAlignment = NSTextAlignmentCenter;
        self.prompt.font = [UIFont systemFontOfSize:14];
        self.prompt.text = [NSString stringWithFormat:@"此网页由 %@ 提供",[NSURL URLWithString:self.url].host];
        [self.view addSubview:self.prompt];
    }
}

#pragma mark 设置导航栏
- (void)configNav{

    if (self.navigationController) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
        
        //左边
        if ([self.webView canGoBack]) {//有返回
            
            self.navigationItem.leftBarButtonItems = @[backItem,closeItem];
        }else{
            
            self.navigationItem.leftBarButtonItems = @[backItem];
        }
        
        //右边
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
        
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
}

#pragma mark 设置监听
- (void)configKVO{
    
    //添加观察者
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    //存在优先显示
    if (self.customTitle) {
        self.title = self.customTitle;
    }else{
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    //是否可以返回
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    //提示文字
    [self.webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO回馈
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {//加载进度
        
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {//新的进度小 不处理
            return;
        }
        
        self.progressLayer.opacity = 1;
        self.progressLayer.frame = CGRectMake(0, self.progressLayer.frame.origin.y, self.view.frame.size.width*[change[@"new"] floatValue], 3);
        if ([change[@"new"]floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, self.progressLayer.frame.origin.y, 0, 3);
            });
        }
    }else if ([keyPath isEqualToString:@"title"]){//标题
        
        self.title = change[@"new"];
    }else if ([keyPath isEqualToString:@"canGoBack"]){//是否可以返回
        //设置导航栏
        [self configNav];
    }else if ([keyPath isEqualToString:@"contentOffset"]){//提示文字
        CGPoint point = [change[@"new"] CGPointValue];
        if (!self.isLocal) {
            NSLog(@"---%f",point.y);
            self.prompt.alpha = point.y/30;
        }
    }
}

#pragma mark - WKNavigationDelegate
#pragma mark 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载");
}

#pragma mark 开始获取网页内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"开始获取网页内容");
}

#pragma mark 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation*)navigation{
    NSLog(@"加载完成");
    
    //整个页面是否可以滚动
//    if (self.isRoll) {
//        webView.scrollView.bounces = YES;
//    }else{
//        webView.scrollView.bounces = NO;
//    }
    //JS交互
}

#pragma mark 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
    
}

#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKScriptMessageHandler
#pragma mark 收到脚本信息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"收到脚本信息");
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}

#pragma mark - WKUIDelegate
#pragma mark 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    NSLog(@"创建一个新的WebView");
    return [[WKWebView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height) configuration:configuration];
}

#pragma mark 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *__nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入" message:prompt preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *tf = [alert.textFields firstObject];
        
        completionHandler(tf.text);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(@"");
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"我知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 选择框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不同意" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - VC周期
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
