//
//  ShowViewController.m
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ShowViewController.h"
#import "EditViewController.h"
#import "EditDelegate.h"

@interface ShowViewController ()
{
    __weak IBOutlet UILabel *firstNameLabel;
    __weak IBOutlet UILabel *lastNameLabel;
    __weak IBOutlet UILabel *emailAddressLabel;
    __weak IBOutlet UILabel *phoneNumberLabel;
    EditViewController *editViewController;
}
@end

@implementation ShowViewController

@synthesize firstNameString;
@synthesize lastNameString;
@synthesize emailAddressString;
@synthesize phoneNumberString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstNameLabel.text= firstNameString;
    lastNameLabel.text= lastNameString;
    emailAddressLabel.text= emailAddressString;
    phoneNumberLabel.text=phoneNumberString;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    editViewController = segue.destinationViewController;
    editViewController.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark EditDelegate

-(void)updateFirst:(NSString *)firstName updateLast:(NSString *)lastName updateEmail:(NSString *)email updateNumber:(NSString *)phoneNumber{
    firstNameLabel.text=firstName;
    lastNameLabel.text=lastName;
    emailAddressLabel.text=email;
    phoneNumberLabel.text=phoneNumber;
    
    
}

@end
