//
//  AddViewController.h
//  Addressbook
//
//  Created by Umut Kanbak on 8/7/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"
@interface AddViewController : UIViewController
@property (strong, nonatomic) Person *person;
@end
