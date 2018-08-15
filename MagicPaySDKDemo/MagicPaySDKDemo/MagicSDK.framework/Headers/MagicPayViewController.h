//
//  MagicPayViewController.h
//  MagicSDK
//
//  Created by 刘铭 on 2018/4/19.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicOrder.h"

@protocol MagicPayDelegate <NSObject>

- (void)paymentSuccessWithOrder:(MagicOrder *)order;

- (void)paymentFiledWithErrorInfo:(NSDictionary *)errorInfo; //失败

- (void)cancelPayment;//关闭

@end

@interface MagicPayViewController : UIViewController

@property (nonatomic, assign)id<MagicPayDelegate>delegate;

- (void)buyWithOrder:(MagicOrder *)order;

@end
