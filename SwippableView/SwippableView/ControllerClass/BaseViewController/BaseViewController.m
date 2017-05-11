//
//  BaseViewController.m
//  SwippableView
//
//  Created by Ruby  on 5/11/17.
//  Copyright © 2017 indianrenters. All rights reserved.
//

#import "BaseViewController.h"
#import "Masonry.h"
#import "PrivacySettingView.h"

@interface BaseViewController ()

@property (nonatomic,strong)    PrivacySettingView              *_PrivacySettingView;
@property (nonatomic,strong)    UIView                          *_BackGroundView;
@end

@implementation BaseViewController
@synthesize     _PrivacySettingView;
@synthesize     _BackGroundView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/* This method is used to show WizardView  */
-(void)showPrivacySettingViewOnSuperView:(UIView*)superView {
    CGFloat width = 0.0,height = 0.0;
    switch (UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPad:{
            width = 320;
            height = 568;
        }
            break;
        case UIUserInterfaceIdiomPhone:{
            width = 280;
            height = self.view.frame.size.height-40;
        }
            break;
        default:
            break;
    }
    _BackGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _BackGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:.4f];
    UITapGestureRecognizer *tapGesture  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismiss:)];
    [_BackGroundView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = false;
    [self.view addSubview:_BackGroundView];
    
    _PrivacySettingView = [PrivacySettingView viewWithFrame:CGRectMake(self.view.frame.origin.x+20,self.view.center.y, width, height)];
    [_PrivacySettingView setCenter:_BackGroundView.center];
    [_BackGroundView addSubview:_PrivacySettingView];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setImage:[UIImage imageNamed:@"IconCancel"] forState:UIControlStateNormal];
    cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [cancelBtn addTarget:self action:@selector(hidePrivacySettingView) forControlEvents:UIControlEventTouchUpInside];
    [_BackGroundView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.right.equalTo(@5);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    [self presentViewWithDumpingEffect:_PrivacySettingView];
    [self._BackGroundView bringSubviewToFront:_PrivacySettingView];
}

/* This method is used to present the view  with animation */
-(void)presentViewWithDumpingEffect:(UIView *)superView {
    superView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.6f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        superView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:^(BOOL finished) {
        superView.transform = CGAffineTransformIdentity;
    }];
}

/* This method is used to hide the hide the wizardView from the screen */
-(void)hidePrivacySettingView   {
    if (_PrivacySettingView == nil) {
        return;
    }
    else {
        [_PrivacySettingView removeFromSuperview];
        _PrivacySettingView = nil;
        [_BackGroundView removeFromSuperview];
        _BackGroundView = nil;
    }
}

-(void)tapDismiss:(UIGestureRecognizer*)tap {
    CGPoint location = [tap locationInView:self._PrivacySettingView];
    BOOL withinBounds = CGRectContainsPoint(self._BackGroundView.bounds, location);
    if(!withinBounds){
        [self hidePrivacySettingView];
        [tap.view removeFromSuperview];
    }
}



@end
