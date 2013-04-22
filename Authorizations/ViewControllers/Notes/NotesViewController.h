//
//  NotesViewController.h
//  Authorizations
//
//  Created by Casey Egan on 6/10/12.
//  Copyright (c) 2012 Casey Egan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApprovalDetailBase.h"

@interface NotesViewController : UIViewController <UITextViewDelegate>


@property (strong, nonatomic) ApprovalDetailBase *approvalDetail;
@property (strong, nonatomic) UITextView *userNoteView;


@end
