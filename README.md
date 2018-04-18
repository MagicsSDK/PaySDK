# PaySDK

## 概述
  本文档用于指导 iOS 开发者快速接入  SDK,本 SDK 为 iOS 应用提供登录、注册等功 能。主要包含如下:
  
#### (1) 登录 
  用户登录注册
  
#### (2) 充值 
  用户充值
  
#### (3) 开发注意事项
  联系Magics获取appId和appKey,在SDK的初始化时使用；
  
#### (4) SDK的构成
  SDK 主要由MagicSDK.framework构成；
  SDK 支持armv7、arm64、armv7s架构，IOS 8.0及以上版本；
  
## 开发环境搭建

#### (1) 添加framework
  在工程中找到 Target->Build Phases->Link Binary With Libraries 
  添加以下框架：
  WebKit.framework
  
#### （2）添加SDK 的framework
  MagicSDK.framework
  
#### (3) 配置网络
   在`App Transport Security Settings`下添加`Allow Arbitrary Loads`类型`Boolean`,值设为`YES`
   
   如图:
   ![](https://github.com/MagicsSDK/PaySDK/blob/master/ImageCache/屏幕快照%202018-04-18%20下午3.48.00.png)

## 接入SDK

#### (1) 导入头文件并添加delegate
  #import <MagicSDK/MagicSDK.h>
  #import <WebKit/WebKit.h>
  <MagicLoginDelegate,MagicPayDelegate>

#### (2) 初始化SDK、登录、支付模块
 
##### （1）初始化SDK并登录
  `[[MagicLoginManager sharedManager]MagicManagerInitializeByAppKey:@"97ad057fdd7df1112260dda2cbd0f8fc" andAppSecret:@"d8b412202889d82ab97cdf8c8f7244fa" andChannel:@"appMagics" andPlatform:@"2"];`

    `[MagicLoginManager sharedManager].delegate = self;`
    
    `[[MagicLoginManager sharedManager]startManager];`
    

 ##### (2)初始化MagicOrder模型、初始化MagicPayManager并购买

    `MagicOrder *order = [MagicOrder new];`
    
    `order.order_num = @"10";`
    
    `order.order_sum = @"1";`
    
    `order.goods_name = @"迈吉客测试001";`
    
    `order.goods_des = @"迈吉客测试";`
    
    `order.goods_id = @"12";`
    
    `order.game_zone = @"大中华区";`

    `MagicPayManager *payVC = [[MagicPayManager alloc]init];`
    
    `payVC.delegate = self;`
    
    `[payVC buyWithOrder:order];`
 
 #### (3) 登录 delegate
   `- (void)getPhoneCaptchaSuccess{`
       ` NSLog(@"");`
   `}`

   `- (void)loginFiledWithErrorCode:(NSInteger)code andError:(NSError *)error{`
       `NSLog(@"");`
   `}`

   `- (void)loginSuccess{`
    `NSLog(@"");`
   `}`
  
 #### (4) 支付 delegate
   `- (void)paymentFiledWithErrorInfo:(NSDictionary *)errorInfo{`

   `}`


