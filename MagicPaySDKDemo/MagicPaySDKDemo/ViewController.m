//
//  ViewController.m
//  WebPaydemo
//
//  Created by 刘铭 on 2018/4/16.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import "ViewController.h"
#import <MagicSDK/MagicSDK.h>
#import <WebKit/WebKit.h>

@interface ViewController () <MagicLoginDelegate,MagicPayDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testBtn.backgroundColor = [UIColor redColor];
    [testBtn setTitle:@"登录" forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];

    UIButton *testBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    testBtn1.backgroundColor = [UIColor redColor];
    [testBtn1 setTitle:@"支付" forState:UIControlStateNormal];
    [testBtn1 addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn1];


    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 80, 80)];
    self.closeBtn.backgroundColor = [UIColor redColor];
    [self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loginBtn{
    [[MagicLoginManager sharedManager]MagicManagerInitializeByAppKey:@"97ad057fdd7df1112260dda2cbd0f8fc" andAppSecret:@"d8b412202889d82ab97cdf8c8f7244fa" andChannel:@"appMagics" andPlatform:@"2"];

    [MagicLoginManager sharedManager].delegate = self;
    [[MagicLoginManager sharedManager]startManager];
}

- (void)payClick{
    int x = arc4random() % 10000;
    MagicOrder *order = [MagicOrder new];
    order.order_num = [@"" stringByAppendingFormat:@"%d",x];
    order.order_sum = @"1";
    order.goods_name = @"迈吉客测试001";
    order.goods_des = @"迈吉客测试";
    order.goods_id = @"12";
    order.game_zone = @"大中华区";

    MagicPayManager *payVC = [[MagicPayManager alloc]init];
    payVC.delegate = self;
    [payVC buyWithOrder:order];
}

- (void)paymentSuccessWithUrl:(NSString *)url{
    //根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [WKUserContentController new];
    [config.userContentController addScriptMessageHandler:self name:@"NativeMethod"];
    [config.userContentController addScriptMessageHandler:self name:@"close"];
//
//    WKPreferences *preferences = [WKPreferences new];
//    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    preferences.minimumFontSize = 40.0;
//    config.preferences = preferences;

    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view insertSubview:self.webView belowSubview:self.closeBtn];

//    [self.view addSubview:_webView];
}

#pragma mark - MessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"ActionName==== %@",message.name);
    NSLog(@"");
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{

    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);

    NSString* reqUrl = navigationAction.request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
        // NOTE: 跳转支付宝App
        BOOL bSucc = [[UIApplication sharedApplication]openURL:navigationAction.request.URL];

        // NOTE: 如果跳转失败，则跳转itune下载支付宝App
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"未检测到支付宝客户端，请安装后重试。"
                                                          delegate:self
                                                 cancelButtonTitle:@"立即安装"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }else if ( [reqUrl hasPrefix:@"weixin://"]){
        BOOL bSucc = [[UIApplication sharedApplication]openURL:navigationAction.request.URL];

        // NOTE: 如果跳转失败，则跳转itune下载支付宝App
        if (!bSucc) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"未检测到微信客户端，请安装后重试。"
                                                          delegate:self
                                                 cancelButtonTitle:@"立即安装"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}











- (void)closeWebView{
    [self.webView removeFromSuperview];
}

- (void)paymentFiledWithErrorInfo:(NSDictionary *)errorInfo{

}

- (void)getPhoneCaptchaSuccess{
    NSLog(@"");
}

- (void)loginFiledWithErrorCode:(NSInteger)code andError:(NSError *)error{
    NSLog(@"");
}

- (void)loginSuccess{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
