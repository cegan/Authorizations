//
//  AuthorizationUIUtilities.m
//  Authorizations
//
//  Created by Casey Egan on 5/25/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AuthorizationUIUtilities.h"
#import "CalendarUtilities.h"
#import "ApprovalDetailBase.h"
#import "Constants.h"

@implementation AuthorizationUIUtilities



+ (UIButton *) getAuthorizationsDoneButton{
    
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame      = CGRectMake(0, 0, 55, 30);
    [button setBackgroundImage: [UIImage imageNamed:@"DoneBrown.png"] forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *) getAuthorizationDetailsBackButton{
    
    UIButton *button        = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame            = CGRectMake(0, 0, 66, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"Details.png"] forState:UIControlStateNormal];
    
    return button;
}

+ (UIImageView *) getBadge:(NSInteger *) withBadgeNumber{
    
    int myInt = withBadgeNumber;
    NSUInteger *charCount = [[NSString stringWithFormat:@"%i", myInt] length];
    
    UIImageView *timeStamp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testBadge.png"]];
   // timeStamp.frame = CGRectMake(200, 7, 42, 25);
    
    timeStamp.frame = CGRectMake(200, 7, 45, 27);
    
    UILabel *dateTimeLabel = [[UILabel alloc] init];
    

    if(charCount == 1){
        
        dateTimeLabel.frame = CGRectMake(18, 8, 25, 12);
        
    }
    else if(charCount == 2){
        
        dateTimeLabel.frame             = CGRectMake(14, 8, 25, 12);
        
    }
    else if(charCount == 3){
        
        dateTimeLabel.frame             = CGRectMake(10, 8, 25, 12);
    }
    
    dateTimeLabel.backgroundColor   = [UIColor clearColor];
  //  dateTimeLabel.textColor         = RED_TEXT_COLOR;
    
    dateTimeLabel.textColor         = [UIColor whiteColor];
    dateTimeLabel.text              = [NSString stringWithFormat:@"%i", myInt];
    
    [dateTimeLabel setFont:[[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init]];
    
    [timeStamp addSubview:dateTimeLabel];
    
    return timeStamp;
    
}

+ (UIImageView *) getApprovalDateTimeStampForDate:(NSString *) approvalDate{
    
       
    UIImageView *timeStamp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"historyTimestamp.png"]];
    UILabel *dateTimeLabel = [[UILabel alloc] init];
    
    timeStamp.frame                 = CGRectMake(17, 5, 82, 17);
    timeStamp.layer.borderColor     = BROWN_BORDER_COLOR;
    timeStamp.layer.borderWidth     = kBorderWidth;
    timeStamp.layer.cornerRadius    = kTimeStampCornerRadius;
    
    dateTimeLabel.backgroundColor   = [UIColor clearColor];
    dateTimeLabel.frame             = CGRectMake(15, 4, 82, 10);
    dateTimeLabel.textColor         = GREEN_TEXT_COLOR;
    dateTimeLabel.text              = approvalDate;
    
    [dateTimeLabel setFont:[[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] init]];

    [timeStamp addSubview:dateTimeLabel];
    
    return timeStamp;
    
}

+ (UIImageView *) getArrivalStampForDate:(NSDate *) date{
    
    
    int days = [CalendarUtilities daysBetweenDate:date andDate:[[NSDate alloc] init]];
    
   
    UIImageView *timeStamp          = [[UIImageView alloc] init];
    
        
    UILabel *label                  = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, 65, 10)];
    label.backgroundColor           = [UIColor clearColor];
    label.textColor                 = RED_TEXT_COLOR;
    label.font                      = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] init];
    
    timeStamp.tag                   = 100;
    timeStamp.image                 = [UIImage imageNamed:@"arrivalTimeStamp3.png"];
    timeStamp.layer.borderColor     = BROWN_BORDER_COLOR;
    timeStamp.layer.borderWidth     = kBorderWidth;
    timeStamp.layer.cornerRadius    = kTimeStampCornerRadius;
    
    if(days == 0){
        
        timeStamp.frame             = CGRectMake(33, 6, 50, 17.5);
        label.text                  = [CalendarUtilities getTimeFromDate:date];
    }
    else if (days == 1){
        
        timeStamp.frame             = CGRectMake(33, 5, 57, 17.5);
        label.text                  = [[[NSNumber numberWithInt:days] stringValue] stringByAppendingString:@" Day Ago"];
    }
    
    else{
        
        timeStamp.frame             = CGRectMake(33, 5, 63, 17.5);
        label.text                  = [[[NSNumber numberWithInt:days] stringValue] stringByAppendingString:@" Days Ago"];
    }
    
    [timeStamp addSubview:label];
    
    return timeStamp;
}


+ (void) updateApproveButton:(UIButton *) button withTotalNumberOfSelectedItems:(int) totalItems{
    
    
    for(UIView *subview in [button subviews]) {
        
        if([subview isKindOfClass:[UILabel class]]) {
            
            UILabel *label = (UILabel*)subview;
            
            int totalSelectedAchs = totalItems;
            
            if(totalSelectedAchs <= 0){
                
                button.enabled  = NO;
                label.alpha     = 0.5;
                label.frame     = CGRectMake(14, 9, 75, 15);
                label.text      = @"Approve";
            }
            else{
                
                NSString *value = [@"Approve(" stringByAppendingString:[[NSNumber numberWithInt:totalSelectedAchs] stringValue]];
                label.alpha     = 1.0;
                label.frame     = CGRectMake(6, 9, 75, 15);
                label.text      = [value stringByAppendingString:@")"];
            }
        }
    }
}

+ (void) showModalNetworkError:(NSInteger *) errorType InView:(UIView *) view{
    
    
    [self setRecursiveUserInteraction:view userInteractionEnabled:NO];
    
    UIImageView *networkError;
    
    if(errorType == 0){
        
        networkError = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"networkError.png"]];
    }
    else{
        
        networkError = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"authorizationServiceError.png"]];
    }
    
    
    networkError.contentMode  = UIViewContentModeScaleAspectFill;
    networkError.frame        = CGRectMake(0,0,320,0);
    
    [UIView animateWithDuration:0.5f delay:0.0f options:nil
     
					 animations:^{
                         
                         [view addSubview:networkError];
                         networkError.frame = CGRectMake(0,0,320,60);
                     }
     
					 completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.5f delay:1.5f options:nil
                                          animations:^{
                                              
                                              networkError.alpha = 0;
                                          }
                                          completion:^(BOOL finished){
                                          
                                              [self setRecursiveUserInteraction:view userInteractionEnabled:YES];
                                          
                                          }
                          ];
                         
                     }
     ];
    
}

+ (void) showModalApprovalSuccessInView:(UIView *) view{
    
    [self setRecursiveUserInteraction:view userInteractionEnabled:NO];

    UIImageView *approvalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"approvedNotification.png"]];
    
    approvalView.frame        = CGRectMake(0,0,320,60);
    approvalView.alpha        = 0.0f;
    [view addSubview:approvalView];
    
    [UIView animateWithDuration:0.5f delay:0.0f options:nil
     
					 animations:^{
                         
                         approvalView.alpha = 1.0f;
                     }
     
					 completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.5f delay:1.0f options:nil
                                          animations:^{
                                              
                                              approvalView.alpha = 0.0f;
                                          }
                                          completion:^(BOOL finished){
                                              
                                              [self setRecursiveUserInteraction:view userInteractionEnabled:YES];
                                              
                                          }
                          ];
                         
                     }
     ];
    
}

+ (void) showModalApprovalErrorInView:(UIView *) view{
    
    [self setRecursiveUserInteraction:view userInteractionEnabled:NO];
    
    
    UIImageView *networkError = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"errorAuthorization.png"]];
    
    
    networkError.contentMode  = UIViewContentModeScaleAspectFill;
    networkError.frame        = CGRectMake(0,0,320,0);
    
    [UIView animateWithDuration:0.5f delay:0.0f options:nil
     
					 animations:^{
                         
                         [view addSubview:networkError];
                         networkError.frame = CGRectMake(0,0,320,60);
                     }
     
					 completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.5f delay:1.5f options:nil
                                          animations:^{
                                              
                                              networkError.alpha = 0;
                                          }
                                          completion:^(BOOL finished){
                                              
                                              [self setRecursiveUserInteraction:view userInteractionEnabled:YES];
                                              
                                          }
                          ];
                         
                     }
     ];
    
}

+ (void) showLocalNotification:(NSString *) messageBody messageAction:(NSString *) messageAction{
    
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    
    notif.fireDate              = [[NSDate alloc] init];
    notif.timeZone              = [NSTimeZone defaultTimeZone];
    
    notif.alertBody             = messageBody;
    notif.alertAction           = messageAction;
    notif.soundName             = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
}




+ (void) setRecursiveUserInteraction:(UIView *) view userInteractionEnabled:(BOOL) enabled{
    
    view.userInteractionEnabled = enabled;
    
    for (UIView *v in [view subviews]) {
        
        v.userInteractionEnabled = enabled;
    }
}


@end
