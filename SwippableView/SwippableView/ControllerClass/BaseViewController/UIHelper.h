//
//  ViewHelper.h
//  ePazer
//
//  Created by akshay on 8/31/16.
//

#import "Masonry.h"
#import "BaseHelper.h"
#import "UIConstant.h"

#define DEGREES_IN_RADIANS(x) (M_PI * x / 180.0)

@interface UIHelper : BaseHelper

#pragma mark Class Methods

+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**Get Font with size.*/
+(UIFont *)fontWithSize:(float)fontSize family:(FontFamily) family;

@end
