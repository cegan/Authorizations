//
//  ControlPanel.m
//  Authorizations
//
//  Created by Casey Egan on 1/26/13.
//  Copyright (c) 2013 Casey Egan. All rights reserved.
//

#import "ControlPanel.h"
#import "ArchiveUtilities.h"
#import "SearchUtilities.h"

@interface ControlPanel ()

- (void) installDelegates;
- (void) performSearchWithCriteria:(NSString *)criteria;

@end

@implementation ControlPanel


@synthesize searchResultsList           = _searchResultsList;
@synthesize AuthorizationsSearchBar     = _AuthorizationsSearchBar;


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userBeganSearch" object:nil];
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self performSearchWithCriteria:searchBar.text];
    [searchBar resignFirstResponder];
}

- (void) performSearchWithCriteria:(NSString *)criteria{
    
    _searchResultsList = [SearchUtilities searchAllHistoricalItemsContainingText:self.AuthorizationsSearchBar.text];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self installDelegates];
}




- (void) installDelegates{
    
    self.AuthorizationsSearchBar.delegate = self;
    
}



@end
