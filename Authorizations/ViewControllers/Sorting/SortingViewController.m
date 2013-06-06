//
//  SortingViewController.m
//  Authorizations
//
//  Created by Casey Egan on 5/4/13.
//  Copyright (c) 2013 Egan Development. All rights reserved.
//

#import "SortingViewController.h"


@interface SortingViewController ()

- (void) setRootViewProperties;
- (void) setSortTableViewProperties;
- (void) setDelegates;


@end



@implementation SortingViewController

@synthesize selectedSortingIndex   = _selectedSortingIndex;
@synthesize sortingBackgroundImage = _sortingBackgroundImage;
@synthesize tableView              = _tableView;



- (void) setDelegates{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void) setSortTableViewProperties{
    
    self.tableView.separatorColor        = BROWN_SEPERATOR_COLOR_HALF_ALPHA;
    self.tableView.layer.borderColor     = BROWN_SEPERATOR_COLOR_HALF_ALPHA.CGColor;
    self.tableView.layer.cornerRadius    = 5.0;
    self.tableView.layer.borderWidth     = 0.5;
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self setDelegates];
    [self setSortTableViewProperties];
    [self setRootViewProperties];
}

- (void) setRootViewProperties{
    
    self.view.layer.shadowOffset    = CGSizeMake(-15, 20);
    self.view.layer.shadowRadius    = 4;
    self.view.layer.shadowOpacity   = 0.3;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [ArchiveUtilities archiveDefaultSortingIndex:[NSNumber numberWithInt:indexPath.row]];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didReceiveSorting" object:nil
                                                      userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"SlectedSortIndex"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortCellIdentifier"];
    
    NSNumber *sortingIndex = [ArchiveUtilities unArchiveDefaultSortingIndex];
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SortCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    switch (indexPath.row) {
        case 0:
            
            if([sortingIndex intValue] == 0){
                
                cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"sortItemCheck.png"]];
            }
            
            cell.textLabel.text = @"Customer Name";
            break;
            
        case 1:
            
            if([sortingIndex intValue] == 1){
                
                cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"sortItemCheck.png"]];
            }
            cell.textLabel.text = @"Approval Type";
            break;
            
        case 2:
            
            if([sortingIndex intValue] == 2){
                
                cell.accessoryView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"sortItemCheck.png"]];
            }
            cell.textLabel.text = @"Approval Date";
            break;
            
        default:
            break;
    }
    
    cell.textLabel.textColor = BROWN_TEXT_COLOR;
    cell.textLabel.font = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init];
    
    return cell;

}


@end
