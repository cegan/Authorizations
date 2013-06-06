//
//  Enums.h
//  Authorizations
//
//  Created by Casey Egan on 6/6/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enums : NSObject




typedef enum  {
    
    kName               = 0,
    kAmount             = 1,
    kAccount            = 2,
    kIssuedOn           = 3,
    kSubmittedBy        = 4,
    kOriginatingSystem  = 5,
    kContactInformation = 6,
    kNotes              = 7,
    kError              = 8,
    
} DetailType;


typedef enum  {
    
    kAddress          = 0,
    kCity             = 1,
    kState            = 2,
    kZipCode          = 3,
    kHomePhone        = 4,
    kMobilePhone      = 5,
    kEmailAddress     = 6
    
} ContactInfo;


typedef enum  {
    
    kHistoryName                 = 0,
    kHistoryAmount               = 1,
    kHistoryAccount              = 2,
    kHistoryIssuedOn             = 3,
    kHistoryApprovedOnDate       = 4,
    kHistoryApprovedOnTime       = 5,
    kHistoryOriginatingSystem    = 6,
    kHistoryContactInformation   = 7,
    kHistoryNotes                = 8,
   
} HistoryDetailType;



typedef enum  {
    
    kAchMenuItem      = 0,
    kCheckMenuItem    = 1,
    kWireMenuItem     = 2,
    kHistoryMenuItem  = 3,
    kSettingsMenuItem = 4,
    kLogoutMenuItem   = 5,
    
} AuthorizationMenuItem;


typedef enum  {
    
    kSortByCustomerName       = 0,
    kSortByApprovalType       = 1,
    kSortByApprovedOnDate     = 2,
       
} SortedBy;


typedef enum  {
    
    kNoInternetConnection                  = 0,
    kAuthorizationServiceNotReachable      = 1,
    
} NetworkError;







@end
