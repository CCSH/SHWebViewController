//
//  SHPopMenu.h
//  SHPopMenuDemo
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 陈胜辉. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  下拉菜单
 **/
typedef enum {
    SHPopMenuArrowPositionCenter = 0,
    SHPopMenuArrowPositionLeft = 1,
    SHPopMenuArrowPositionRight = 2
} SHPopMenuArrowPosition;

@interface SHPopMenu : UIView

//是否有遮罩
@property (nonatomic, assign) BOOL dimBackground;
//方向
@property (nonatomic, assign) SHPopMenuArrowPosition arrowPosition;
//内容
@property (nonatomic, strong) NSArray *mList;
//宽度
@property (nonatomic, assign) CGFloat menuW;
//内容高度
@property (nonatomic, assign) CGFloat contentH;

/**
 *  显示菜单
 */
- (void)showInRectX:(int)x rectY:(int)y block:(void (^)(SHPopMenu *menu,NSInteger index))block;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end
