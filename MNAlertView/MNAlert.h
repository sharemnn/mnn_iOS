//
//  MNAlert.h
//  MNAlertView
//
//  Created by mnn on 15/12/14.
//  Copyright © 2015年 mnn. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - 屏幕长宽

#define MN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MNAlert : UIView

typedef void(^AlertViewBlock)(NSInteger index);

@property (nonatomic,copy)AlertViewBlock block;

@property (nonatomic) BOOL seriesAlert;

/**
 *  调用时方法  提供alert上的内容
 */
-(id)initWithTitle:(NSString *)title message:(NSString *)message  buttonTitles:(NSString *)cancelButton andEnter:(NSString *)enterButton clickButton:(AlertViewBlock)block;

-(void)showInView:(UIView *)baseView completion:(void (^)(MNAlert *alertView ,NSInteger selectIndex))completeBlock;

/**
 *  显示视图
 */
-(void)showWithCompletion:(void (^)(MNAlert *alertView ,NSInteger selectIndex))completeBlock;
/**
 *  关闭视图
 */
-(void)closeView;

@end
