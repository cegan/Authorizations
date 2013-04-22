//
//  HistoryDetailViewController.m
//  Authorizations
//
//  Created by Casey Egan on 3/24/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HistoryDetailViewController.h"
#import "ContactInformationViewController.h"
#import "DetailTableViewCell.h"
#import "StringUtilities.h"
#import "CalendarUtilities.h"
#import "CustomColoredAccessory.h"
#import "Constants.h"
#import "Enums.h"
#import "AchDetail.h"

@interface HistoryDetailViewController ()

- (void) installBackButton;

@end

@implementation HistoryDetailViewController


@synthesize detail          = _detail;
@synthesize historyDetail   = _historyDetail;
@synthesize noteView        = _noteView;


- (IBAction) onHistoryBackButtonTouch:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) installDelegates{
    
    _historyDetail.delegate = self;
    _historyDetail.dataSource = self;
}

- (void) installBackButton{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 73, 30);
    [backButton addTarget:self action:@selector(onHistoryBackButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"historyBrown.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

- (void) setBackgroundForRootView{
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"DetailViewBackground.png"]];
    backgroundImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backgroundImage];
    [self.view bringSubviewToFront:_historyDetail];
}

- (void) setDetailsTableViewProperties{
    
    _historyDetail.layer.borderColor     = BROWN_BORDER_COLOR;
    _historyDetail.layer.cornerRadius    = 5;
    _historyDetail.layer.borderWidth     = 1.0;
    _historyDetail.backgroundColor       = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackgroundBrown.png"]];
    _historyDetail.separatorColor        = BROWN_TEXT_COLOR;
    _historyDetail.separatorStyle        = UITableViewCellSeparatorStyleSingleLine;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactInformationViewController *contactInformationView = [[[NSBundle mainBundle] loadNibNamed:@"ContactInformation" owner:self options:nil] objectAtIndex:0];
    
    switch (indexPath.row) {
            
        case kHistoryNotes:
            self.noteView = [[NotesViewController alloc] init];
            self.noteView.approvalDetail = _detail;
            [self.navigationController pushViewController:self.noteView animated:YES];
            break;
            
                  
        case kHistoryContactInformation:
            contactInformationView.contactInformation = self.detail.contactInformation;
            [self.navigationController pushViewController:contactInformationView animated:YES];
            break;
            
        default:
            break;
    }
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"HistoryDetailCellIdentifier";
    
    DetailTableViewCell *cell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        NSArray *customAchTableCellView = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil];
        
        cell = [customAchTableCellView objectAtIndex:0];
    }
    
    
    switch (indexPath.row) {
            
        case kHistoryName:
            [cell bindDetail:@"Name" withValue:_detail.name];
            break;
            
        case kHistoryAmount:
            [cell bindDetail:@"Amount" withValue:[StringUtilities formatDoubleAsCurrency:_detail.amount]];
            break;
            
        case kHistoryIssuedOn:
            [cell bindDetail:@"Issued On" withValue:[CalendarUtilities getLongDateFormatForDate:_detail.arrivalDate]];
            break;
            
        case kHistoryApprovedOnDate:
            [cell bindDetail:@"Approval Date" withValue:[CalendarUtilities getLongDateFormatForDate:_detail.approvedOnDate]];
            break;
        
        case kHistoryApprovedOnTime:
            [cell bindDetail:@"Approval Time" withValue:[CalendarUtilities getTimeFromDate:_detail.approvedOnDate]];
            break;
            
        case kHistoryAccount:
            [cell bindDetail:@"Account" withValue:_detail.accountNumber];
            break;
            
        case kHistoryOriginatingSystem:
            [cell bindDetail:@"Originating System" withValue:@"Transact"];
            break;
            
        case kHistoryContactInformation:
            [cell bindDetail:@"Contact Information" withValue:@""];
            cell.accessoryView = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:124.00/255.0 green:104.0/255.00 blue:76.0/255.00 alpha:1.0]];
            break;
            
        case kHistoryNotes:
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
    
    return 9;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self installDelegates];
	[self installBackButton];
    [self setBackgroundForRootView];
    [self setDetailsTableViewProperties];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DetailsTitle.png"]];
}

@end
