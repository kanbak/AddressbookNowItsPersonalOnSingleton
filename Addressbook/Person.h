//
//  Person.h
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (strong, nonatomic)NSString *firstName;
@property (strong, nonatomic)NSString *lastName;
@property (strong, nonatomic)NSString *emailAddress;
@property (strong, nonatomic)NSString *phoneNumber;

@end
