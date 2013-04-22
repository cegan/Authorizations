/***************************************************************
 //  ALToolbar.m
 //  ALToolbar
 //
 //  This software is provided AS IS. 
 //  AnguriaLab grants you the right to use and modify this 
 //  code for commercial use as part of your software.
 //
 //  Any distribution of this source code or of any library 
 //  containing this source code is strictly prohibited.
 //
 //  For any support, contact us at support@mobilebricks.com
 //
 //  Looking for another component or piece of code? We can help! 
 //  Get in touch at http://www.mobilebricks.com 
 //
 //  Copyright 2011 AnguriaLab LLC. All rights reserved.
 ****************************************************************/

#import "ALToolbar.h"

#pragma mark -
#pragma mark Private Interface
@interface ALToolbar (Private) 


@end

#pragma mark -
#pragma mark Synthesize Properties
@implementation ALToolbar

@synthesize backgroundImageView=_backgroundImageView;
@synthesize items = _items;
@synthesize delegate = _delegate;
@synthesize buttonsSpacing = _buttonsSpacing;
@synthesize layoutMode = _layoutMode;
@synthesize buttonsPadding = _buttonsPadding;
@synthesize animatingDirection = _animatingDirection;
@synthesize animationType = _animationType;
@synthesize hideAnimatingDuration = _hideAnimationDuration;
@synthesize showAnimatingDuration = _showAnimationDuration;

#pragma mark -
#pragma mark Private Methods
///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/*
 *  Internal method, connected to every toolbar button touchUpInside event
 */
- (void) toolbarButtonPressed:(id)sender{
    NSInteger index=[_items indexOfObject:sender];
    if (_delegate&&[_delegate respondsToSelector:@selector(toolbar:didSelectButtonAtIndex:)])
        [_delegate toolbar:self didSelectButtonAtIndex:index];
}

/*
 *  Internal method, for toolbar button positioning, depending on set layout
 */
- (void) buildButtonsLayout{
    if(_items){
        // builds vertical layout
        if((_layoutMode==ALToolbarButtonsLayoutModeAutoCenter)||(_layoutMode==ALToolbarButtonsLayoutModeAutoCenterVertical)){
            UIView* button;
            for(button in _items){
                [button setFrame:CGRectMake(button.frame.origin.x, (self.frame.size.height-button.frame.size.height)/2, button.frame.size.width, button.frame.size.height)];
            }
        }
        // builds horizontal layout
        if((_layoutMode==ALToolbarButtonsLayoutModeAutoCenter)||(_layoutMode==ALToolbarButtonsLayoutModeAutoCenterHorizontal)){
            UIView* button;
            int totalWidth=0;
            for (button in _items){
                totalWidth+=button.frame.size.width;
            }
            int spacing=_buttonsSpacing;
            int padding=_buttonsPadding;
            if (padding==kToolbarPaddingDefault){
                if(spacing==kToolbarSpacingDefault){
                    spacing=(self.frame.size.width-totalWidth)/([_items count]+1);
                    padding=spacing;
                }else{
                    padding=((self.frame.size.width-totalWidth)-(spacing*([_items count]-1)))/2;
                }
            }else{
                if(spacing==kToolbarSpacingDefault){
                    spacing=(self.frame.size.width-totalWidth-(padding*2))/([_items count]-1);
                }
            }
                
            int currentDrawingX=padding;
            for(int i=0;i< [_items count];i++){
                button=[_items objectAtIndex:i];
                [button setFrame:CGRectMake(currentDrawingX, button.frame.origin.y, button.frame.size.width, button.frame.size.height)];
                currentDrawingX+=spacing+button.frame.size.width;
            }
        }
    }
}

/*
 *  Internal method, for adapting background frame to toolbar frame.
 */
- (void) buildBackgroundLayout{
    [_backgroundImageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

// Toolbar animation ending callback
- (void) animationDidStop:(NSString *)animationID finished:(BOOL)finished context:(void *)context{
    _animatingToolbar=NO;
    if (animationID && [animationID isEqualToString:@"hideToolbar"]){
        [self setHidden:YES];
    }
    //Calls delegate methods
    if(_delegate){
        if (animationID && [animationID isEqualToString:@"hideToolbar"]){
            if ([_delegate respondsToSelector:@selector(toolbarDidDisappear:)]) {
                [_delegate toolbarDidDisappear:self];
            }
        }else if (animationID && [animationID isEqualToString:@"showToolbar"]){
            if ([_delegate respondsToSelector:@selector(toolbarDidAppear:)]) {
                [_delegate toolbarDidAppear:self];
            }
        }
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark -
#pragma mark Override Methods
- (id) initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])){
        _layoutMode=kToolbarLayoutModeDefault;
        _buttonsSpacing=kToolbarSpacingDefault;
        _animatingDirection=kToolbarAnimationDirectionDefault;
        _showAnimationDuration=kToolbarShowAnimationDurationDefault;
        _hideAnimationDuration=kToolbarHideAnimationDurationDefault;
        _animationType=kToolbarAnimationTypeDefault;
        _buttonsPadding=kToolbarPaddingDefault;

        self.backgroundColor=[UIColor blackColor];
        if (_backgroundImageView){
            [_backgroundImageView removeFromSuperview];
            [_backgroundImageView release];
        }
        self.backgroundImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_backgroundImageView setContentMode:kToolbarBackgroundContentMode];
        [self addSubview:_backgroundImageView];
        [self sendSubviewToBack:_backgroundImageView];
    }
    return self;
}

-(void) dealloc{
    if (_backgroundImageView)
        [_backgroundImageView release];
    if (_items)
        [_items release];
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods
- (void) setBackgroundImage:(NSString *)backgroundImageName{
    if(backgroundImageName){
        [_backgroundImageView setImage:[UIImage imageNamed:backgroundImageName]];
    }
}

- (void) setBackgroundContentMode:(UIViewContentMode)contentMode{
    [_backgroundImageView setContentMode:contentMode];
}

- (void) setItems:(NSArray *)newItems{
    if(_items)
        [_items release];
    _items=newItems;   
    [_items retain];
    //If not manual layout mode, rebuilds buttons layout
    if (_layoutMode!=ALToolbarButtonsLayoutModeManual){
        [self buildButtonsLayout];
        UIView *view;
        for (view in [self subviews]){
            if ([view isKindOfClass:[ALToolbarItem class]]){
                [view removeFromSuperview];
            }
        }
    }
    UIButton *button;
    for (button in newItems){
        [button addTarget:self action:@selector(toolbarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }

}

- (void) setButtonsSpacing:(NSInteger)newButtonsSpacing{
    _buttonsSpacing=newButtonsSpacing;
    [self buildButtonsLayout];
}

- (void) toggleToolbarVisibleAnimated:(BOOL)animated{
    if (animated){
        if ([self isHidden]){
            [self showToolbarAnimated:animated];
        }else{
            [self hideToolbarAnimated:animated];
        }
    }else{
        [self setHidden:![self isHidden]];
    }

}

- (void) showToolbarAnimated:(BOOL)animated{
    //if should animate
    if (animated){
        //if it is not already animating
        if ([self isHidden]&&!_animatingToolbar){
            //NSInteger offset=[[UIApplication sharedApplication] isStatusBarHidden] ? 0 : 20 ;
            [self setHidden:NO];
            [UIView beginAnimations:@"showToolBar" context:nil];
            [UIView setAnimationDuration:_showAnimationDuration];
            if(_animationType==ALToolbarAnimationTypeSlide){
                if (_animatingDirection==ALToolbarAnimationDirectionBottom) {
                    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y - self.frame.size.height,self.frame.size.width,self.frame.size.height)];
                }else if (_animatingDirection==ALToolbarAnimationDirectionTop) {
                    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y + self.frame.size.height,self.frame.size.width,self.frame.size.height)];
                }else if (_animatingDirection==ALToolbarAnimationDirectionLeft) {
                    [self setFrame:CGRectMake(0,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
                }else if (_animatingDirection==ALToolbarAnimationDirectionRight) {
                    [self setFrame:CGRectMake(0,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
                }
            }else if(_animationType==ALToolbarAnimationTypeFade){
                self.alpha=1;
            }
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            [UIView commitAnimations];
            _animatingToolbar=YES;
        }
    }else{
        [self setHidden:NO];
        //Calls delegate immediatly if no animation
        if(_delegate && [_delegate respondsToSelector:@selector(toolbarDidAppear:)])
            [_delegate toolbarDidAppear:self];
    }
}

- (void) hideToolbarAnimated:(BOOL)animated{
    //if should animate
    if (animated){
        //if it is not already animating
        if (![self isHidden]&&!_animatingToolbar){
            [UIView beginAnimations:@"hideToolbar" context:nil];
            [UIView setAnimationDuration:_hideAnimationDuration];
            if(_animationType==ALToolbarAnimationTypeSlide){
                if (_animatingDirection==ALToolbarAnimationDirectionBottom) {
                    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y + self.frame.size.height,self.frame.size.width,self.frame.size.height)]; 
                }else if (_animatingDirection==ALToolbarAnimationDirectionTop) {
                    [self setFrame:CGRectMake(self.frame.origin.x,self.frame.origin.y - self.frame.size.height,self.frame.size.width,self.frame.size.height)]; 
                }else if (_animatingDirection==ALToolbarAnimationDirectionLeft) {
                    [self setFrame:CGRectMake(-self.frame.size.width,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
                }else if (_animatingDirection==ALToolbarAnimationDirectionRight) {
                    [self setFrame:CGRectMake(self.frame.size.width,self.frame.origin.y,self.frame.size.width,self.frame.size.height)];
                }
            }else if(_animationType==ALToolbarAnimationTypeFade){
                self.alpha=0;
            }
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            [UIView commitAnimations];
            _animatingToolbar=YES;
            
        }
    }else{
        [self setHidden:YES]; 
        //Calls delegate immediatly if no animation
        if(_delegate && [_delegate respondsToSelector:@selector(toolbarDidDisappear:)])
            [_delegate toolbarDidDisappear:self];
    }
}

@end
