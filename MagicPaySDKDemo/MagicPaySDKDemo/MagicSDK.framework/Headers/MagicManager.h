//
//  MagicManager.h
//  MagicSDK
//
//  Created by 村长在开会～ on 2018/8/1.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MagicLoginDelegate <NSObject>

@optional
- (void)loginFiledWithErrorCode:(NSInteger)code andError:(NSError *)error; //失败

- (void)loginSuccessWithUserInfo:(NSDictionary *)userInfo;

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

@end

NS_ASSUME_NONNULL_END
