//
//  ShowViewController.m
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "ShowViewController.h"
#import "EditViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface ShowViewController () <UINavigationControllerDelegate>
{
    __weak IBOutlet UILabel *firstNameLabel;
    __weak IBOutlet UILabel *lastNameLabel;
    __weak IBOutlet UILabel *emailAddressLabel;
    __weak IBOutlet UILabel *phoneNumberLabel;
    EditViewController *editViewController;
}
@end

@implementation ShowViewController
@synthesize person;

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[ViewController class]]){
    }
}

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
    firstNameLabel.text = person.firstName;
    lastNameLabel.text = person.lastName;
    emailAddressLabel.text = person.emailAddress;
    phoneNumberLabel.text = person.phoneNumber;
    self.navigationItem.title=[NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    self.navigationController.delegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    editViewController = segue.destinationViewController;
    editViewController.person=person;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
