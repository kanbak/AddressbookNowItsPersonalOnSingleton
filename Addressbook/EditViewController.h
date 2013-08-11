//
//  EditViewController.h
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"
#import "MySingleton.h"


@interface EditViewController : UIViewController 
@property (strong, nonatomic) Person *person;

@end
