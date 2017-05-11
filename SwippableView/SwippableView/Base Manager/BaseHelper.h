//
//  BaseHelper.h
//  ePazer
//
//  Created by akshay on 8/31/16.
//  Copyright © 2016 ruby. All rights reserved.
//

#import "BaseObject.h"


@interface BaseHelper : BaseObject

#pragma mark - Date and time conversation and Timestamp.


+(BaseHelper*)BaseHelper;
#pragma mark - Archive and Unarchive objects.
/**Only stores object to User default and wait to call synchronize method by system*/
+(void)archivedObject:(id)object key:(NSString *)key;
/**stores object to User default and synchronize the user default*/
+(void)archivedObjectWithSynchronize:(id)object key:(NSString *)key;
/**unarchieved Object With Key*/
+(id)unarchievedObjectWithKey:(NSString *)key;
/**Remove userInfo from archiver when user logout from app*/
+(void)removeObjectFromArchiveWithKey:(NSString *) key;
@end
