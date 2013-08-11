//
//  MySingleton.h
//  Addressbook
//
//  Created by Umut Kanbak on 8/8/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Person.h"

@interface MySingleton : NSObject

@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

+(MySingleton *)sharedInstance;

-(void)configureCoreData;

-(NSArray *)fetchFromCoreData;

@end
