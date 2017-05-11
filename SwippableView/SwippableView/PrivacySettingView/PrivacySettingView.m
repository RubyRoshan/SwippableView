//
//  PrivacySettingView.m
//  ePazer
//
//  Created by Ruby  on 5/11/17.
//  Copyright © 2017 indianrenters. All rights reserved. on 12/6/16.
//

#import "PrivacySettingView.h"
#import "UIHelper.h"
@interface PrivacySettingView() <UIScrollViewDelegate> {
    
}
@property (nonatomic, strong) UILabel                               *_TitleLbl;
@property (nonatomic, strong) UIScrollView                          *_PrivacySettingScrollView;
@property (nonatomic, assign) NSInteger                             _PreviousView;
/*these view name should be changed According TO Functionality Of View */
@property (nonatomic, strong) UIView                                *_View1;
@property (nonatomic, strong) UIView                                *_View2;

@property (nonatomic, strong) UIView                                *_View3;
@property (nonatomic, strong) UIView                                *_View4;
/*these view name should be changed According TO Functionality Of View */
@property (nonatomic, strong) CAShapeLayer                          *_BubbleLayer;
@property (nonatomic, assign) BOOL                                  _TextSet;


@end

@implementation PrivacySettingView
@synthesize     _TitleLbl;
@synthesize     _PrivacySettingScrollView;
@synthesize     _PreviousView;
@synthesize     _View1;
@synthesize     _View2;
@synthesize     _View3;
@synthesize     _View4;
@synthesize     _BubbleLayer;
@synthesize     _TextSet;


#pragma  mark - Init Methods
/* Initiate the Wizard View */
+(PrivacySettingView *)viewWithFrame:(CGRect)frame {
    static PrivacySettingView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PrivacySettingView alloc] initWithFrame:frame];
    });
    return sharedInstance;
}

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setUpView];
    }
    return self;
}

-(void)dealloc {
    _PrivacySettingScrollView.delegate       = nil;
    _PrivacySettingScrollView                = nil;
    _TitleLbl                                = nil;
    _View1                                   = nil;
    _View2                                   = nil;
    _View3                                   = nil;
    _View4                                   = nil;

   
}

#pragma  mark - SetUp Method
-(void)setUpView {
    CGFloat height = 0.0,pageWidth = 0.0;
    switch (UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPad:{
            pageWidth = 320;
            height = 568;
        }
            break;
        case UIUserInterfaceIdiomPhone:{
            pageWidth = self.frame.size.width;
            height    =  self.frame.size.height-40;
        }
            break;
        default:
            break;
    }
   
    if (!_PrivacySettingScrollView) {
        _PrivacySettingScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, pageWidth, height)];
        _PrivacySettingScrollView.delegate = self;
       _PrivacySettingScrollView.alwaysBounceHorizontal = YES;
        [self._PrivacySettingScrollView setContentSize:CGSizeMake((pageWidth)*4, pageWidth)];
        [self._PrivacySettingScrollView setShowsVerticalScrollIndicator:NO];
        [self._PrivacySettingScrollView setShowsHorizontalScrollIndicator:YES];
        [self._PrivacySettingScrollView setPagingEnabled:YES];
        _PrivacySettingScrollView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_PrivacySettingScrollView];
       _View1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, pageWidth, height)];
        _View1.backgroundColor = [UIColor yellowColor];
        [self._PrivacySettingScrollView addSubview:_View1];
        _View2 = [[UIView alloc]initWithFrame:CGRectMake((pageWidth),0, pageWidth, height)];
        _View2.backgroundColor = [UIColor greenColor];
        [self._PrivacySettingScrollView addSubview:_View2];
        _View3 = [[UIView alloc]initWithFrame:CGRectMake(2*(pageWidth),0, pageWidth, height)];
        _View3.backgroundColor = [UIColor redColor];
        [self._PrivacySettingScrollView addSubview:_View3];
        _View4 = [[UIView alloc]initWithFrame:CGRectMake(3*(pageWidth),0, pageWidth, height)];
        _View4.backgroundColor = [UIColor blueColor];
        [self._PrivacySettingScrollView addSubview:_View4];
    }
    _PreviousView  = 1;
    [self setPrivacySettingView:_PreviousView];
}

#pragma  mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        float fractionalPage = scrollView.contentOffset.x / self.frame.size.width;
        NSInteger page = lround(fractionalPage)+1;
        if (_PreviousView == page) {
            return;
        }
        [self setPrivacySettingView:page];
        _PreviousView = page;
}

#pragma  mark - Custom Methods
/* This method is used to set active Wizard Page  */
-(void)setPrivacySettingView:(NSInteger)activeView {
    switch (UI_USER_INTERFACE_IDIOM()) {
        case UIUserInterfaceIdiomPad: {
           [self createPrivacyCircle:CGRectMake(75,5,25,25) color:[UIColor orangeColor] withActivePage:activeView];
        }
            break;
        case UIUserInterfaceIdiomPhone:{
            [self createPrivacyCircle:CGRectMake(65,5,25,25) color:[UIColor orangeColor] withActivePage:activeView];
        }
            break;
        default:
            break;
    }
    if (activeView == 1) {
        
    }
 }

/*This method is used to create the shape bubble  using CAShapeLayer */
-(void)createPrivacyCircle:(CGRect)rect color:(UIColor*)colorName withActivePage:(NSInteger)activeWizard{
    if(_BubbleLayer)    {
        [_BubbleLayer removeFromSuperlayer];
        _BubbleLayer = nil;
    }
    CGFloat bubbleWidth  = rect.size.width;
    CGFloat xPosition    = rect.origin.x;
    int yForLine =CGRectGetMidY(rect);
   
    /*first Circle  */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: yForLine];
    /*first Circle  */
   
    /*Calculate point for 1stLine*/
    int firstPoint = xPosition+bubbleWidth;
    /*Calculate point for 1stLine*/
    
    [path moveToPoint:CGPointMake(firstPoint, yForLine)];
    [path addLineToPoint:CGPointMake(firstPoint+20,yForLine)];
   
    /*Second Circle  */
    int circleStartingPoint = firstPoint+20;
    [path moveToPoint:CGPointMake(circleStartingPoint, yForLine)];
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(circleStartingPoint, rect.origin.y, rect.size.width, rect.size.height) cornerRadius: yForLine]];
    /*Second Circle  */

    /*Calculate point for 2ndLine*/
    int circleEndPoint = circleStartingPoint+bubbleWidth;
    [path moveToPoint:CGPointMake(circleEndPoint, yForLine)];
    [path addLineToPoint:CGPointMake(circleEndPoint+20, yForLine)];
    /*Calculate point for 2ndLine*/

    /*Third Circle  */
    int circleStart = circleEndPoint+20;
    [path moveToPoint:CGPointMake(circleStart, yForLine)];
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(circleStart, rect.origin.y, rect.size.width, rect.size.height) cornerRadius: yForLine]];
    /*Third Circle  */
 
    /*Calculate point for 3rdLine*/
    int circleEnd = circleStart+bubbleWidth;
    [path moveToPoint:CGPointMake(circleEnd, yForLine)];
    [path addLineToPoint:CGPointMake(circleEnd+20, yForLine)];
   /*Calculate point for 3rdLine*/
  
    /*Fourth Circle  */
    int lineEnd = circleEnd+20;
    [path moveToPoint:CGPointMake(lineEnd, yForLine)];
    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(lineEnd, rect.origin.y, rect.size.width, rect.size.height) cornerRadius: yForLine]];
    /*Fourth Circle  */
    /* Closing the Path */
    [path closePath];
    /* Closing the Path */

    _BubbleLayer = [[CAShapeLayer alloc] init];
    _BubbleLayer.path = path.CGPath;
    _BubbleLayer.fillColor = [UIColor clearColor].CGColor;
    _BubbleLayer.lineWidth = 2.0;
    _BubbleLayer.strokeColor = colorName.CGColor;
    [[self layer]addSublayer:_BubbleLayer];
    [path removeAllPoints];

    for (int i = 0; i<4; i++) {
       if ((activeWizard-1)  == i) {
           [self setText:[NSString stringWithFormat:@"%ld",(long)activeWizard] onPosition:CGRectMake((i*45)+xPosition,rect.origin.y+2,bubbleWidth,bubbleWidth) color:[UIColor greenColor]];
       }
       else {
            [self setText:[NSString stringWithFormat:@"%d",i+1] onPosition:CGRectMake((i*45)+xPosition,rect.origin.y+2,bubbleWidth,bubbleWidth) color:[UIColor orangeColor]];

       }
    }
    _TextSet = true;
}

/*This method is used  */
-(void)setText:(NSString*)text onPosition:(CGRect)rect color:(UIColor*)colorName {
    /*This is used  to  remove all the CATextLayer objects to avoid overlapping of Old text with new one */
    if (_TextSet == true) {
            [[[self layer].sublayers copy] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                CALayer * subLayer = obj;
                if([subLayer isKindOfClass:[CATextLayer class]]){
                    [subLayer removeFromSuperlayer];
                }
            }];
        _TextSet = false;
    }
 /*This is used  to  remove all the CATextLayer objects to avoid overlapping of Old text with new one */
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = rect;
    [textLayer setString:text];
    textLayer.foregroundColor = colorName.CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.fontSize = 15.0;
    textLayer.cornerRadius= rect.size.width/2;
    textLayer.masksToBounds=YES;
    [[self layer] addSublayer:textLayer];
}

@end
