//
//  MySingleton.m
//  Addressbook
//
//  Created by Umut Kanbak on 8/8/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "MySingleton.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Person.h"
    
NSManagedObjectContext* managedObjectContext;
NSFileManager *fileManager;
NSURL *documentsDirectory;
NSFetchedResultsController* fetchedResultController;

@implementation MySingleton
@synthesize managedObjectContext, managedObjectModel, persistentStoreCoordinator;

static MySingleton *smySingleton; 

+(MySingleton * )sharedInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        smySingleton=[[MySingleton alloc]init];
        [smySingleton configureCoreData];
        
           });
   
    return smySingleton;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Instantiating MySingleton %@", self);
    }
    return self;
}
-(void)configureCoreData
{
    NSURL* documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSURL* sqliteURL = [documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"];
    NSError* error;
    
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
    
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:&error]) {
        
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    }
}
-(NSArray *)fetchFromCoreData{
    NSSortDescriptor* sortDescriptorlastName;
    NSSortDescriptor* sortDescriptorfirstName;
    NSArray* sortsDescriptors;
    NSError *error;
    fileManager = [NSFileManager defaultManager];
    documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:managedObjectContext];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    sortDescriptorlastName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    sortDescriptorfirstName= [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    sortsDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorlastName, sortDescriptorfirstName, nil];
    
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setSortDescriptors:sortsDescriptors];
    
    fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [fetchedResultController performFetch:&error];
}

@end
