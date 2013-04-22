/***************************************************************
 //  ALToolbar.h
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

#import <Foundation/Foundation.h>
#import "ALToolbarEnums.h"
#import "ALToolbarDefaults.h"
#import "ALToolbarItem.h"

/**
 * @mainpage
 *
 * ALToolbar is a completely customizable Toolbar.
 * 
 * You can set the Toolbar height to any value you need, and define a background color or image.
 * 
 * ALToolbarItemr are buttons, so you can set normal, highlighted and selected image\n
 * and you can choose between autopositioning (horizontal and/or vertical) or manual frame positioning.
 *
 * You can hide the TabBar with fade, or slide animation (left, right or bottom).
 *
 * Also, the duration of transition can be selected.
 */


@protocol ALToolbarDelegate;

@interface ALToolbar : UIView {
    UIImageView                     *_backgroundImageView;
    NSArray                         *_items;
    id<ALToolbarDelegate>            _delegate;
    NSInteger                        _buttonsSpacing;
    NSInteger                        _buttonsPadding;
    enum ALToolbarButtonsLayoutMode   _layoutMode;
    enum ALToolbarAnimationDirection _animationDirection;
    enum ALToolbarAnimationType      _animationType;
    NSTimeInterval                   _showAnimationDuration;
    NSTimeInterval                   _hideAnimationDuration;
    
    @private
    BOOL                             _animatingToolbar;
}

#pragma mark -
#pragma mark Properties
/**
 *  If present, this imageView stands as the toolbar background
 */
@property (nonatomic,retain)    UIImageView*                        backgroundImageView;
/**
 *  This is the ALToolbarItem array for displaying toolbar buttons
 */
@property (nonatomic,retain)    NSArray*                            items;
/**
 *  Delegate to call
 */
@property (nonatomic,retain)    id<ALToolbarDelegate>               delegate;
/**
 *  The spacing (in pixel) between buttons in toolbar.
 *  This property is valid only if layoutmode is not manual.
 */
@property (nonatomic,assign)    NSInteger                           buttonsSpacing;
/**
 *  The left and right padding (in pixel) between buttons and toolbar bounds.
 *  This property is valid only if layoutmode is not manual.
 */
@property (nonatomic,assign)    NSInteger                           buttonsPadding;
/**
 *  It's possibile to set a custom layout mode for the toolbar view :
 *  ALToolbarButtonLayoutModeAutoCenter -> this value sets autocentering mode 
 *  for both horizontal and vertical buttons positions
 *  ALToolbarButtonLayoutModeAutoCenterHorizontal -> this value sets autocentering mode for horizontal position. 
 *                                                  Vertical position depends on UIToolbarItem frame.
 *  ALToolbarButtonLayoutModeAutoCenterVertical -> this value sets autocentering mode for vertical position. 
 *                                                Horizontal position depends on UIToolbarItem frame.
 *  ALToolbarButtonLayoutModeManual -> this value set autocentering mode off. 
 *                                    Every UIToolbarItem is displayed within its original frame.
 *
 *  Default value is ALToolbarButtonLayoutModeAutoCenter
 */
@property (nonatomic,assign)    enum ALToolbarButtonsLayoutMode     layoutMode;
/**
 *  It's possibile to set a custom direction for the show and hide toolbar animation :
 *  ALToolBarAnimationDirectionFromLeft
 *  ALToolBarAnimationDirectionFromRight
 *  ALToolBarAnimationDirectionFromBottom
 */
@property (assign)              enum ALToolbarAnimationDirection    animatingDirection;
/**
 *  It's possibile to set a custom type for the show and hide toolbar animation :
 *  ALToolbarAnimationTypeSlide
 *  ALToolbarAnimationTypeFade
 */
@property (assign)              enum ALToolbarAnimationType          animationType;
/**
 *  It's possibile to set a custom duration for the  the show toolbar animation 
 */
@property (assign)              NSTimeInterval                      showAnimatingDuration;
/**
 *  It's possibile to set a custom duration for the  the hide toolbar animation 
 */
@property (assign)              NSTimeInterval                      hideAnimatingDuration;

#pragma mark -
#pragma mark Public Methods

/**
 * This methods sets the toolbar background image
 * @param[in]   backgroundImageName     image filename 
 */
- (void) setBackgroundImage:(NSString *)backgroundImageName;
/**
 * This methods sets the toolbar background imageview content mode.
 * This way you can specify to scale to fill, center, etc.
 * @param[in]   contentMode             *************** 
 */
- (void) setBackgroundContentMode:(UIViewContentMode)contentMode;
/**
 * This methods sets the ALToolbarItem array, for displaying toolbar buttons
 * @param[in]   newItems             *************** 
 */
- (void) setItems:(NSArray *)newItems;
/**
 * This methods rebuilds background layout. It is called after changing toolbar frame.
 */
- (void) buildBackgroundLayout;
/**
 * This methods rebuilds buttons layout. It is called after changing toolbar frame.
 */
- (void) buildButtonsLayout;
/**
 *  This methods shows the TabBar (if not visible).
 *  param[in]   animated        NO  shows immediately - YES shows with animation
 */
- (void) showToolbarAnimated:(BOOL) animated;
/**
 *  This methods hides the Toolbar (if visible).
 *  param[in]   animated        NO  hides immediately - YES hides with animation
 */
- (void) hideToolbarAnimated:(BOOL) animated;
/**
 *  This methods hides or shows the Toolbar (depending on the current toolbar visibility).
 *  param[in]   animated        NO  hides or shows immediately - YES hides or shows with animation
 */
- (void) toggleToolbarVisibleAnimated:(BOOL) animated;

@end

#pragma mark -
#pragma mark Protocol
@protocol ALToolbarDelegate <NSObject>

@optional
/**
 *  This methods is called when the user taps on a toolbar button connected.
 *  param[in]   toolbar         *****************
 *  param[in]   index           *****************
 */
- (void) toolbar:(ALToolbar*) toolbar didSelectButtonAtIndex:(NSInteger) index;
/**
 *  This methods is called when the toolbar show animation ends.
 *  If the showing was not animated, this method is called immediately.
 *  param[in]   toolbar         *****************
 */
- (void) toolbarDidAppear:(ALToolbar*) toolbar;
/**
 *  This methods is called when the toolbar hide animation ends.
 *  If the hiding was not animated, this method is called immediately.
 *  param[in]   toolbar         *****************
 */
- (void) toolbarDidDisappear:(ALToolbar*) toolbar;


@end