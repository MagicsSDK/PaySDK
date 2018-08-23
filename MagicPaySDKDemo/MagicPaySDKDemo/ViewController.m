//
//  ViewController.m
//  WebPaydemo
//
//  Created by 刘铭 on 2018/4/16.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <MagicSDK/MagicSDK.h>
#import "UIView+Toast.h"

@interface ViewController () <MagicLoginDelegate,MagicPayDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
//    return;
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


    self.closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 400, 80, 80)];
    self.closeBtn.backgroundColor = [UIColor redColor];
    [self.closeBtn setTitle:@"上传" forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(putInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)putInfo{
    if (![[MagicManager sharedManager]isLogin]) {
        [[[UIApplication sharedApplication] delegate].window makeToast:@"📱请先登录📱" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    NSDictionary *info = @{
                           @"role_id" : @"123",
                           @"role_name" : @"张三",
                           @"role_grade" : @"75",
                           @"server_id" : @"11890",
                           @"server_name" : @"游戏服务器",
                           @"extra" : @"这是拓展字段"
                           };
    [[MagicManager sharedManager]putUserInfo:info success:^(id responseObject) {
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}

- (void)loginBtn{
    [[MagicManager sharedManager]MagicManagerInitializeByAppKey:@"97ad057fdd7df1112260dda2cbd0f8fc" andAppSecret:@"d8b412202889d82ab97cdf8c8f7244fa" andChannel:@"appMagics" andPlatform:@"2"];
    
    [MagicManager sharedManager].delegate = self;
    [[MagicManager sharedManager]startManager];
    
    
}

- (void)payClick{
    if (![[MagicManager sharedManager]isLogin]) {
         [[[UIApplication sharedApplication] delegate].window makeToast:@"📱请先登录📱" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    int x = arc4random() % 10000;
    MagicOrder *order = [MagicOrder new];
    order.order_num = [@"" stringByAppendingFormat:@"%d",x];
    order.order_sum = @"1";
    order.goods_name = @"迈吉客测试001";
    order.goods_des = @"迈吉客测试";
    order.goods_id = @"12";
    order.game_zone = @"大中华区";

    MagicPayViewController *payVC = [[MagicPayViewController alloc]init];
    payVC.delegate = self;
    [self presentViewController:payVC animated:YES completion:nil];
    [payVC buyWithOrder:order];
}

- (void)paymentSuccessWithOrder:(MagicOrder *)order{
    [[[UIApplication sharedApplication] delegate].window makeToast:[@"📱支付成功📱 == " stringByAppendingFormat:@"%@",order.goods_name] duration:1.0 position:CSToastPositionCenter];
}

- (void)cancelPayment{
     [[[UIApplication sharedApplication] delegate].window makeToast:@"📱取消支付📱" duration:1.0 position:CSToastPositionCenter];

}



- (void)paymentFiledWithErrorInfo:(NSDictionary *)errorInfo{

     [[[UIApplication sharedApplication] delegate].window makeToast:[@"支付失败🐱🐱🐱🐱" stringByAppendingFormat:@"%@",errorInfo[@"error"]] duration:1.0 position:CSToastPositionCenter];
}

- (void)getPhoneCaptchaSuccess{
     [[[UIApplication sharedApplication] delegate].window makeToast:@"获取验证码成功🐱🐱🐱🐱" duration:1.0 position:CSToastPositionCenter];
}

- (void)loginFiledWithErrorCode:(NSInteger)code andError:(NSError *)error{
    [[[UIApplication sharedApplication] delegate].window makeToast:@"登录失败🐱🐱🐱🐱" duration:1.0 position:CSToastPositionCenter];
}

- (void)loginSuccessWithUserInfo:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
    [[[UIApplication sharedApplication] delegate].window makeToast:@"登录成功🤪" duration:1.0 position:CSToastPositionCenter];
    
}

- (void)logOut{
    NSLog(@"注销登录============");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
