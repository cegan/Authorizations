//
//  ContactInformationViewController.m
//  Authorizations
//
//  Created by Casey Egan on 4/3/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "ContactInformationViewController.h"
#import "BlockActionSheet.h"

@interface ContactInformationViewController ()

- (void) setBackButton;
- (void) setDelegates;

@end

@implementation ContactInformationViewController

@synthesize contactCustomer     = _contactCustomer;
@synthesize contactInfoTable    = _contactInfoTable;
@synthesize contactInformation  = _contactInformation;


- (void) installUserInterface{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ContactTitle.png"]];
    
    [self setBackButton];
    [self setContactCustomer];
    [self setRootBackgroundViewImage];
    [self setDetailsTableViewProperties];
}

- (void) setRootBackgroundViewImage{
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]];
    
    [self.view addSubview:backgroundImage];
    [self.view bringSubviewToFront:_contactInfoTable];
}

- (void) setBackButton{
    
    UIButton *backButton = [AuthorizationUIUtilities getAuthorizationDetailsBackButton];
    [backButton addTarget:self action:@selector(onDetailsButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
}

- (void) setContactCustomer{

    self.contactCustomer = [UIButton buttonWithType:UIButtonTypeCustom];
    self.contactCustomer.layer.borderColor = BROWN_BORDER_COLOR;
    self.contactCustomer.layer.borderWidth = 1.0;
    [self.contactCustomer.layer setCornerRadius:5.0];
    [self.contactCustomer setBackgroundImage: [UIImage imageNamed:@"ContactCustomer.png"] forState:UIControlStateNormal];
    [self.contactCustomer addTarget:self action:@selector(onContactCustomerTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.contactCustomer.frame  = CGRectMake(5, 345, 310, 35);
    [self.view addSubview:self.contactCustomer];
    
    [self.view bringSubviewToFront:_contactCustomer];    
}

- (void) setDelegates{
    
    _contactInfoTable.delegate = self;
    _contactInfoTable.dataSource = self;
}

- (void) setDetailsTableViewProperties{
    
    _contactInfoTable.layer.borderColor     = BROWN_BORDER_COLOR;
    _contactInfoTable.layer.cornerRadius    = 5;
    _contactInfoTable.layer.borderWidth     = 1.0;
    _contactInfoTable.backgroundColor       = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    _contactInfoTable.separatorColor        = BROWN_TEXT_COLOR;
    _contactInfoTable.separatorStyle        = UITableViewCellSeparatorStyleSingleLine;
}



- (IBAction) showActionSheet:(id)sender {
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Contact Customer"];
    
    [sheet addButtonWithTitle:@"Mobile Phone" atIndex:0 block:^{
        
        [self callCustomer:_contactInformation.mobilePhone];
    }];
    
    [sheet addButtonWithTitle:@"Home Phone" atIndex:1 block:^{
        
        [self callCustomer:_contactInformation.homePhone];
    }];
    
    [sheet addButtonWithTitle:@"Email" atIndex:2 block:^{
        
        [self emailCustomer:_contactInformation.emailAddress];
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];
}


- (void) emailCustomer:(NSString *) emailAddress{
    
   
}

- (void) callCustomer:(NSString *) phoneNumber{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]]];
}

- (void) willPresentActionSheet:(UIActionSheet *)actionSheet {
   // [[actionSheet layer] setBackgroundColor:[UIColor redColor].CGColor];
    UIImageView *df = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    [actionSheet addSubview:df];
}

- (IBAction) onDetailsButtonTouch:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) onContactCustomerTouch:(id)sender {
    
    [self showActionSheet:self];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setDelegates];
    [self installUserInterface];
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"ContactDetailCellIdentifier";
    
    DetailTableViewCell *cell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        NSArray *customAchTableCellView = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil];
        
        cell = [customAchTableCellView objectAtIndex:0];
    }
    
    
    switch (indexPath.row) {
            
        case kAddress:
            [cell bindDetail:@"Address" withValue:_contactInformation.address];
            break;
        
        case kCity:
            [cell bindDetail:@"City" withValue:_contactInformation.city];
            break;
            
        case kState:
            [cell bindDetail:@"State" withValue:_contactInformation.state];
            break;
            
        case kZipCode:
            [cell bindDetail:@"ZipCode" withValue:_contactInformation.zipCode];
            break;
            
        case kHomePhone:
            [cell bindDetail:@"Home Phone" withValue:_contactInformation.homePhone];
            break;
            
        case kMobilePhone:
            [cell bindDetail:@"Mobile Phone" withValue:_contactInformation.mobilePhone];
            break;
            
        case kEmailAddress:
            [cell bindDetail:@"Email" withValue:_contactInformation.emailAddress];
            break;
    }

    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 7;
}



@end
