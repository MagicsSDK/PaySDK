//
//  MagicManager.h
//  MagicSDK
//
//  Created by 村长在开会～ on 2018/8/1.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MagicLoginDelegate <NSObject>

- (void)loginFiledWithInfo:(NSDictionary *)info; //失败

- (void)loginSuccessWithUserInfo:(NSDictionary *)userInfo;

- (void)logOut;
@end

@interface MagicManager : NSObject

@property (nonatomic, assign)id<MagicLoginDelegate>delegate;

+ (instancetype)sharedManager;

/**
 @bref 初始化登录引擎
 
 @param appKey appKey
 @param secret secret
 @param channel 渠道号
 @param platform 平台 IOS 2
 */
- (void)MagicManagerInitializeByAppKey:(NSString *)appKey andAppSecret:(NSString *)secret andChannel:(NSString *)channel andPlatform:(NSString *)platform;


/**
 @bref 上传角色信息
 
 @param info info  （@"role_id"/角色id   @"role_name"/角色名称  @"role_grade"/角色等级  @"server_id"/服务器id @"server_name"/服务器名称  @"extra" /扩展字段 若信息多余提供的传json字符串） 示例 ：
 {
    @"role_id" : @"123",
    @"role_name" : @"张三",
    @"role_grade" : @"75",
    @"server_id" : @"11890",
    @"server_name" : @"游戏服务器",
    @"extra" : @"这是拓展字段"
 }
 */
- (void)putUserInfo:(NSDictionary *)info success:(void (^)( id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 @bref 开启引擎
 */
- (void)startManager;

/**
 @bref 关闭引擎
 */
//- (void)stopManager;

/**
 @bref 是否登录
 */
- (BOOL)isLogin;

/**
 @bref 销毁引擎
 */
- (void)destroyManager;
@end

