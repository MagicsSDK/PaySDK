//
//  MagicHeader.h
//  MagicSDK
//
//  Created by 村长在开会～ on 2018/8/1.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#ifndef MagicHeader_h
#define MagicHeader_h

typedef NS_ENUM(NSInteger, LoginFiledCode) {
    /**
     *  手机号错误
     */
    LoginFiledCode_PHONENUM = 0,
    
    /**
     *  验证码错误
     */
    LoginFiledCode_CAPTCHA = 1,
    
    /**
     *  网络错误
     */
    LoginFiledCode_NETWORKING = 2,
    /**
     *  登录失败
     */
    LoginFiledCode_LOGIN = 3,
    /**
     *  注册失败
     */
    RegisterFiledCode_LOGIN = 4,
};

#endif /* MagicHeader_h */
