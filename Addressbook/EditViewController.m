//
//  EditViewController.m
//  Addressbook
//
//  Created by Umut Kanbak on 7/22/13.
//  Copyright (c) 2013 Umut Kanbak. All rights reserved.
//

#import "EditViewController.h"
#import "AppDelegate.h"
#import "MySingleton.h"


@interface EditViewController ()
{
    __weak IBOutlet UITextField *firstNameTextField;
    __weak IBOutlet UITextField *lastNameTextField;
    __weak IBOutlet UITextField *emailAddressTextField;
    __weak IBOutlet UITextField *phoneNumberTextField;
    NSManagedObjectContext *managedObjectContext;

}

- (IBAction)updateTextFields:(id)sender;

@end

@implementation EditViewController
@synthesize person;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
    

- (void)viewDidLoad
{
    managedObjectContext=[MySingleton sharedInstance].managedObjectContext;
    [super viewDidLoad];
    firstNameTextField.text=person.firstName;
    lastNameTextField.text=person.lastName;
    emailAddressTextField.text=person.emailAddress;
    phoneNumberTextField.text=person.phoneNumber;
    self.navigationItem.title=@"edit contact";
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateTextFields:(id)sender {
    
    //managedObjectContext=[MySingleton sharedInstance].managedObjectContext;
    NSError *error;
    person.firstName=firstNameTextField.text;
    person.lastName=lastNameTextField.text;
    person.emailAddress=emailAddressTextField.text;
    person.phoneNumber=phoneNumberTextField.text;
    
    if (![[MySingleton sharedInstance].managedObjectContext save:&error]) {
        NSLog(@"Error:%@",error);
    }

}
@end
