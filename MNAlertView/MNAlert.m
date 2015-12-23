//
//  MNAlert.m
//  MNAlertView
//
//  Created by mnn on 15/12/14.
//  Copyright © 2015年 mnn. All rights reserved.
//

#import "MNAlert.h"

@interface MNAlert ()
{
    UIView   *backView;
    UILabel  *titleText;
    UILabel  *messageText;
    UIButton *cancel;
    UIButton *enter;
}

@property (nonatomic,copy) void (^dialogViewCompleteHandle)(MNAlert *, NSInteger);

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *cancelBtn;
@property (nonatomic) NSString *enterBtn;

@end

@implementation MNAlert

-(id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)cancelButton andEnter:(NSString *)enterButton clickButton:(AlertViewBlock)block{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        self.title     = title;
        self.message   = message;
        self.cancelBtn = cancelButton;
        self.enterBtn  = enterButton;
        _block = block;
        [self setup];
    }
    return self;
}

/**
 *  弹出Alert的样式  自定义 
 */
- (void) setup{
    backView = [[UIView alloc]initWithFrame:CGRectMake(MN_WIDTH/4, MN_HEIGHT/4, MN_WIDTH/2, 120)];
    backView.layer.cornerRadius  = 8;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor blueColor];
    [self addSubview:backView];
    
    titleText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MN_WIDTH/2, 30)];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.text = self.title;
    [backView addSubview:titleText];
    
    messageText = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MN_WIDTH/2, 60)];
    messageText.numberOfLines = 0;
    messageText.textAlignment = NSTextAlignmentCenter;
    messageText.text = self.message;
    [backView addSubview:messageText];
    
    
    cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 80, MN_WIDTH/4, 40);
    cancel.tag = 1;
    [cancel setTitle:self.cancelBtn forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancel];
    
    enter = [UIButton buttonWithType:UIButtonTypeCustom];
    enter.frame = CGRectMake(MN_WIDTH/4, 80, MN_WIDTH/4, 40);
    enter.tag = 2;
    [enter setTitle:self.enterBtn forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:enter];
}



/**
 *  点击按钮tag值回调
 */
- (void)click:(UIButton *)button{
    if (_block != nil) {
        _block(button.tag);
        [self closeView];
    }
}



-(void)showInView:(UIView *)baseView completion:(void (^)(MNAlert *, NSInteger))completeBlock
{
    self.dialogViewCompleteHandle = completeBlock;
    if(!_seriesAlert)
    {
        for (UIView *subView in baseView.subviews) {
            if([subView isKindOfClass:[MNAlert class]])
            {
                return;
            }
        }
    }
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:self];
    
    NSArray *view_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    NSArray *view_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    [baseView addConstraints:view_H];
    [baseView addConstraints:view_V];
    
    backView.alpha = 0;
    backView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3f animations:^{
        backView.alpha = 1.0;
        backView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

/**
 *  显示弹出框
 */
-(void)showWithCompletion:(void (^)(MNAlert *, NSInteger))completeBlock
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow completion:completeBlock];
}


/**
 *  关闭视图
 */
-(void)closeView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [UIView animateWithDuration:0.3f animations:^{
        backView.alpha = 0;
        backView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
