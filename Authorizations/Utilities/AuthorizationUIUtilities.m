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
#import "AchDetail.h"
#import "CheckDetail.h"
#import "WireDetail.h"
#import "Constants.h"


#define kTimeStampFramePosX     15.0
#define kTimeStampFramePosY     5.0
#define kTimeStampFrameHeight   17.5

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



+ (UIImageView *) getBadgeImageWithCount:(NSInteger *) count{
    

    NSUInteger *charCount  = [[NSString stringWithFormat:@"%i", (int)count] length];
    UIImageView *timeStamp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"testBadge.png"]];
    UILabel *dateTimeLabel = [[UILabel alloc] init];
   
    timeStamp.frame = CGRectMake(200, 7, 45, 27);
    
    switch ((int)charCount) {
        case 1:
            dateTimeLabel.frame = CGRectMake(18, 8, 25, 12);
            break;
            
        case 2:
            dateTimeLabel.frame = CGRectMake(14, 8, 25, 12);
            break;
            
        case 3:
            dateTimeLabel.frame = CGRectMake(10, 8, 25, 12);
            break;
            
        default:
            break;
    }
    
    dateTimeLabel.backgroundColor   = [UIColor clearColor];
    dateTimeLabel.textColor         = [UIColor whiteColor];
    dateTimeLabel.text              = [NSString stringWithFormat:@"%i", (int)count];
    dateTimeLabel.font              = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] init];
    
    [timeStamp addSubview:dateTimeLabel];
    
    return timeStamp;
    
}

+ (UIImageView *) getApprovalTypeStampWithText:(NSString *) text atPosition:(int) position{
    
    UILabel *label           = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, 65, 10)];
    UIImageView *typeStamp   = [[UIImageView alloc] init];
   
    label.text                      = text;
    label.backgroundColor           = [UIColor clearColor];
    label.textColor                 = RED_TEXT_COLOR;
    label.font                      = [[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] init];
    
    
    if([text isEqualToString:@"Ach"]){
        
        typeStamp.frame = CGRectMake((position + 20), 5, 27, 17.5);
        
    }
    else if([text isEqualToString:@"Check"]){
        
        typeStamp.frame = CGRectMake((position + 20), 5, 39, 17.5);
        
    }
    else if([text isEqualToString:@"Wire"]){
        
        typeStamp.frame = CGRectMake((position + 20), 5, 30, 17.5);
        
    }
    
    typeStamp.tag                   = 200;
    typeStamp.image                 = [UIImage imageNamed:@"arrivalTimeStamp3.png"];
    typeStamp.layer.borderColor     = BROWN_BORDER_COLOR;
    typeStamp.layer.borderWidth     = kBorderWidth;
    typeStamp.layer.cornerRadius    = kTimeStampCornerRadius;
    
    [typeStamp addSubview:label];
    
    return typeStamp;
}

+ (UIImageView *) getApprovalDateTimeStampForDate:(NSDate *) approvalDate{
    
   
    int days    = [CalendarUtilities daysBetweenDate:approvalDate andDate:[[NSDate alloc] init]];
    int hours   = [CalendarUtilities getHourFromDate:approvalDate];
    
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
        
        if(hours < 10){
            
            timeStamp.frame = CGRectMake(kTimeStampFramePosX, kTimeStampFramePosY, 45, kTimeStampFrameHeight);
        }
        else{
            
            timeStamp.frame = CGRectMake(kTimeStampFramePosX, kTimeStampFramePosY, 52, kTimeStampFrameHeight);
        }
        label.text = [CalendarUtilities getTimeFromDate:approvalDate];
    }
    else if(days == 1){
        
        timeStamp.frame = CGRectMake(kTimeStampFramePosX, kTimeStampFramePosY, 57, kTimeStampFrameHeight);
        label.text      = [[[NSNumber numberWithInt:days] stringValue] stringByAppendingString:@" Day Ago"];
    }
    else{
        
        timeStamp.frame  = CGRectMake(kTimeStampFramePosX, kTimeStampFramePosY, 63, kTimeStampFrameHeight);
        label.text       = [[[NSNumber numberWithInt:days] stringValue] stringByAppendingString:@" Days Ago"];
        
    }
    
    [timeStamp addSubview:label];
    
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
    else if(days == 1){
        
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

+ (NSString *) getLabelForAuthorizationType:(ApprovalDetailBase *) type{
    
    NSString *typeLabel;
    
    if([type isKindOfClass:[AchDetail class]]){
        
        typeLabel = @"Ach";
        
    }
    else if([type isKindOfClass:[CheckDetail class]]){
        
        typeLabel = @"Check";
        
    }
    
    else if([type isKindOfClass:[WireDetail class]]){
        
        typeLabel = @"Wire";
        
    }
    
    return typeLabel;
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
