//
//  AchDetailViewController.m
//  Authorizations
//
//  Created by Casey Egan on 5/14/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AchDetailViewController.h"
#import "DetailTableViewCell.h"
#import "NotesViewController.h"
#import "ContactInformationViewController.h"
#import "DetailLabel.h"
#import "Constants.h"
#import "StringUtilities.h"
#import "CalendarUtilities.h"
#import "CustomColoredAccessory.h"
#import "Enums.h"
#import "BlockActionSheet.h"



@interface AchDetailViewController()

- (void) installUserInterfaceProperties;
- (void) installDelegates;
- (void) installBackButton;
- (void) installApproveButton;
- (void) sendApprovalRequest:(ApprovalDetailBase *) detail;

@end

@implementation AchDetailViewController

@synthesize detail                  = _detail;
@synthesize detailsTableView        = _detailsTableView;
@synthesize ApproveAchButton        = _ApproveAchButton;
@synthesize noteView                = _notesView;



- (IBAction) onAchBackButtonTouch:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) onApproveButtonTouched:(id)sender {
    
     [self showActionSheet:self];
}
- (IBAction) showActionSheet:(id)sender {
    
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"Approve Ach"];
    
    [sheet addButtonWithTitle:@"Approve" atIndex:0 block:^{
        
        [self sendApprovalRequest:_detail]; 
    }];
    
    [sheet setDestructiveButtonWithTitle:@"Cancel" block:nil];
    [sheet showInView:self.view];

}


- (void) installUserInterfaceProperties{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailsTitle.png"]];
    
    [self setBackgroundForRootView];
    [self installBackButton];
    [self installApproveButton];
    [self setDetailsTableViewProperties];
}

- (void) setBackgroundForRootView{
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]];
    backgroundImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backgroundImage];
    [self.view bringSubviewToFront:_detailsTableView];
}

- (void) setDetailsTableViewProperties{
    
    _detailsTableView.layer.borderColor     = BROWN_BORDER_COLOR;
    _detailsTableView.layer.cornerRadius    = 5;
    _detailsTableView.layer.borderWidth     = 1.0;
    _detailsTableView.backgroundColor       = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    _detailsTableView.separatorColor        = BROWN_TEXT_COLOR;
    _detailsTableView.separatorStyle        = UITableViewCellSeparatorStyleSingleLine;
}

- (void) sendApprovalRequest:(ApprovalDetailBase *) detail{
    
    detail.isSelected = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"achApprovalRequested" object:nil userInfo:[NSDictionary dictionaryWithObject:detail forKey:@"detail"]];
}

- (void) viewDidLoad{
    
  [self installUserInterfaceProperties];
  [self installDelegates];
  [super viewDidLoad];
    
}

- (void) viewDidUnload{
    
    [self setApproveAchButton:nil];
    [super viewDidUnload];
    
}

- (void) installDelegates{
    
    _detailsTableView.delegate = self;
    _detailsTableView.dataSource = self;
}

- (void) installBackButton{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 30);
    [backButton addTarget:self action:@selector(onAchBackButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"AchsBrown.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];    
}

- (void) installApproveButton{
    
    UIBarButtonItem *approveButton = [[UIBarButtonItem alloc] init];
    
    UIButton *customButtonView  = [UIButton buttonWithType:UIButtonTypeCustom];
    customButtonView.frame      = CGRectMake(0, 0, 75, 30);
    [customButtonView addTarget:self action:@selector(onApproveButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [customButtonView setBackgroundImage: [UIImage imageNamed:@"ApproveBrownWithText.png"] forState:UIControlStateNormal];
    
    [approveButton setCustomView:customButtonView];
    
    self.navigationItem.rightBarButtonItem = approveButton;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactInformationViewController *contactInformationView = [[[NSBundle mainBundle] loadNibNamed:@"ContactInformation" owner:self options:nil] objectAtIndex:0];
    
    switch (indexPath.row) {
            
        case kNotes:
            _notesView = [[NotesViewController alloc] init];
            _notesView.approvalDetail = _detail;
            [self.navigationController pushViewController:_notesView animated:YES];
            break;
            

        case kContactInformation:
            contactInformationView.contactInformation = self.detail.contactInformation;
            [self.navigationController pushViewController:contactInformationView animated:YES];
            break;
                        
        default:
            break;
    }
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"DetailCellIdentifier";
    
    DetailTableViewCell *cell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        NSArray *customAchTableCellView = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil];
        
        cell = [customAchTableCellView objectAtIndex:0];
    }
    
    
    switch (indexPath.row) {
            
        case kName:
            [cell bindDetail:@"Customer" withValue:_detail.name];
            break;
            
        case kAmount:
            [cell bindDetail:@"Amount" withValue:[StringUtilities formatDoubleAsCurrency:_detail.amount]];
            break;
            
        case kIssuedOn:
            [cell bindDetail:@"Submitted On" withValue:[CalendarUtilities getLongDateFormatForDate:_detail.arrivalDate]];
            break;
            
        case kSubmittedBy:
            [cell bindDetail:@"Submitted By" withValue:@"Casey Egan"];
            break;
            
        case kAccount:
            [cell bindDetail:@"Account" withValue:_detail.accountNumber];
            break;
            
        case kOriginatingSystem:
            [cell bindDetail:@"Originating System" withValue:@"Transact"];
            break;
            
        case kContactInformation:
            [cell bindDetail:@"Contact Information" withValue:@""];
            cell.accessoryView = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0]];
            break;
       
        case kNotes:
            [cell bindDetail:@"Notes" withValue:@""];
            cell.accessoryView = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0]];
            break;
        
        default:
            break;
    }

    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    return kAchDetailsTotalRows;
}


@end
