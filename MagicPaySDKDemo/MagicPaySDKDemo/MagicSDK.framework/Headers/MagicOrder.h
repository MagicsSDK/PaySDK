//
//  MagicOrder.h
//  MagicNetWorking
//
//  Created by 刘铭 on 2018/4/13.
//  Copyright © 2018年 村长在开会～. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicOrder : NSObject
//订单号
@property (nonatomic, strong) NSString *order_num;
//订单金额
@property (nonatomic, strong) NSString *order_sum;
//商品名字
@property (nonatomic, strong) NSString *goods_name;
//商品描述
@property (nonatomic, strong) NSString *goods_des;
//商品ID
@property (nonatomic, strong) NSString *goods_id;
//游戏商品分区
@property (nonatomic, strong) NSString *game_zone;

@end
