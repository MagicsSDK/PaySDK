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
   如图
   ![](https://github.com/MagicsSDK/PaySDK/blob/master/ImageCache/屏幕快照%202018-04-18%20下午3.48.00.png)

 
 


