//
//  EditDelegate.h
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EditDelegate <NSObject>

-(void)updateFirst:(NSString *)firstName updateLast:(NSString *)lastName updateEmail:(NSString *)email updateNumber:(NSString *)phoneNumber;
@end
