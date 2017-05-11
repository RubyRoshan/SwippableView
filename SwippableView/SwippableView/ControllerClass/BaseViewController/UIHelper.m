//
//  ViewHelper.m
//  ePazer
//
//  Created by akshay on 8/31/16.
//

#import "UIHelper.h"

#pragma mark - font name and family
static NSString *const  kFontName                               = @"Helvetica Neue - ";
static NSString *const  kFontFamilyLight                        = @"Light";
static NSString *const  kFontFamilyRegular                      = @"Regular";
static NSString *const  kFontFamilyMedium                       = @"Medium";
static NSString *const  kFontFamilyBold                         = @"Bold";

@implementation UIHelper


/**Convert Hax color string to UIColor Object*/
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    if(hexString && (![hexString isEqualToString: kEmptyString]))   {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    }
    return nil;
}

/**Get Font with size.*/
+(UIFont *)fontWithSize:(float)fontSize family:(FontFamily) family  {
    switch (family) {
        case FontFamilyLight:
            return [UIFont systemFontOfSize:fontSize];
            break;
        case FontFamilyRegular:
            return [UIFont systemFontOfSize:fontSize];
            break;
        case FontFamilyMedium:
            return [UIFont systemFontOfSize:fontSize];
            break;
        case FontFamilyBold:
            return [UIFont boldSystemFontOfSize: fontSize];
            break;
    
        default:
            return [UIFont systemFontOfSize:fontSize];
            break;
    }

}
@end
