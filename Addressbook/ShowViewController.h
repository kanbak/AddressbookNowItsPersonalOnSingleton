//
//  ShowViewController.h
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDelegate.h"
@interface ShowViewController : UIViewController <EditDelegate>

@property (strong, nonatomic) NSString *firstNameString;
@property (strong, nonatomic) NSString *lastNameString;
@property (strong, nonatomic) NSString *emailAddressString;
@property (strong, nonatomic) NSString *phoneNumberString;

@end
