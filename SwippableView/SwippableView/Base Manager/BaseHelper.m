//
//  BaseHelper.m
//  ePazer
//
//  Created by akshay on 8/31/16.
//  Copyright © 2016 ruby. All rights reserved.
//

#import "BaseHelper.h"

@interface BaseHelper()
@end

@implementation BaseHelper


#pragma mark - Archive and Unarchive objects.
/**Only stores object to User default and wait to call synchronize method by system*/
+(void)archivedObject:(id)object key:(NSString *)key {
    @synchronized(object) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key];
    }
}

/**stores object to User default and synchronize the user default*/
+(void)archivedObjectWithSynchronize:(id)object key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**unarchieved Object With Key*/
+(id)unarchievedObjectWithKey:(NSString *)key {
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSData *savedData        = [userDefault objectForKey:key];
    if (savedData != nil) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    }
    return nil;
}

/**Remove userInfo from archiver when user logout from app*/
+(void)removeObjectFromArchiveWithKey:(NSString *) key   {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey: key];
    userDefault = nil;
}

/***Write logs to phone doucment directory's Textfile****/
/**To access the singleton methods*/
+(BaseHelper*)BaseHelper    {
    static BaseHelper *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BaseHelper alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    if ((self = [super init])) {
        // initialize the singleton object
        }
    return self;
}



@end
