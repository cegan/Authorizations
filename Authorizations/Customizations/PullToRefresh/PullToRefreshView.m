

#import "PullToRefreshView.h"
#import "Constants.h"

#define TEXT_COLOR	 [UIColor colorWithRed:(87.0/255.0) green:(108.0/255.0) blue:(137.0/255.0) alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface PullToRefreshView (Private)

@property (nonatomic, assign) PullToRefreshViewState state;

@end

@implementation PullToRefreshView
@synthesize delegate, scrollView;

- (void)showActivity:(BOOL)shouldShow animated:(BOOL)animated {
    if (shouldShow) [activityView startAnimating];
    else [activityView stopAnimating];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:(animated ? 0.1f : 0.0)];
    arrowImage.opacity = (shouldShow ? 0.0 : 1.0);
    [UIView commitAnimations];
}

- (void)setImageFlipped:(BOOL)flipped {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1f];
    arrowImage.transform = (flipped ? CATransform3DMakeRotation(M_PI * 2, 0.0f, 0.0f, 1.0f) : CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f));
    [UIView commitAnimations];
}

- (id)initWithScrollView:(UIScrollView *)scroll {
    CGRect frame = CGRectMake(0.0f, 0.0f - scroll.bounds.size.height, scroll.bounds.size.width, scroll.bounds.size.height);
    
    if ((self = [super initWithFrame:frame])) {
        scrollView = scroll;
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
		lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		lastUpdatedLabel.textColor = TEXT_COLOR;
		//lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		//lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		lastUpdatedLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:lastUpdatedLabel];
        
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		statusLabel.textColor = TEXT_COLOR;
		//statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		//statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:statusLabel];
        
		arrowImage = [[CALayer alloc] init];
		arrowImage.frame = CGRectMake(10.0f, frame.size.height - 60.0f, 24.0f, 52.0f);
		arrowImage.contentsGravity = kCAGravityResizeAspect;
		arrowImage.contents = (id) [UIImage imageNamed:@"arrow"].CGImage;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			arrowImage.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
        
		[self.layer addSublayer:arrowImage];
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		activityView.frame = CGRectMake(10.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:activityView];
        
		[self setState:PullToRefreshViewStateNormal];
    }
    
    return self;
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    NSDate *date = [NSDate date];
    
	if ([delegate respondsToSelector:@selector(pullToRefreshViewLastUpdated:)])
		date = [delegate pullToRefreshViewLastUpdated:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
    lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:date]];
    lastUpdatedLabel.textColor = BROWN_TEXT_COLOR_HALF_ALPHA;
    
}

- (void)setState:(PullToRefreshViewState)state_ {
    state = state_;
    
	switch (state) {
		case PullToRefreshViewStateReady:
			statusLabel.text = @"Release to refresh";
            statusLabel.textColor         = BROWN_TEXT_COLOR;
			[self showActivity:NO animated:NO];
            [self setImageFlipped:YES];
            scrollView.contentInset = UIEdgeInsetsZero;
			break;
            
		case PullToRefreshViewStateNormal:
			statusLabel.text = @"Pull down to refresh";
			[self showActivity:NO animated:NO];
            [self setImageFlipped:NO];
			[self refreshLastUpdatedDate];
            scrollView.contentInset = UIEdgeInsetsZero;
			break;
            
		case PullToRefreshViewStateLoading:
			statusLabel.text = @"Loading";
			[self showActivity:YES animated:YES];
            [self setImageFlipped:NO];
            scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
			break;
            
		default:
			break;
	}
}

#pragma mark -
#pragma mark UIScrollView

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (scrollView.isDragging) {
            if (state == PullToRefreshViewStateReady) {
                if (scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f) 
                    [self setState:PullToRefreshViewStateNormal];
            } else if (state == PullToRefreshViewStateNormal) {
                if (scrollView.contentOffset.y < -65.0f)
                    [self setState:PullToRefreshViewStateReady];
            } else if (state == PullToRefreshViewStateLoading) {
                if (scrollView.contentOffset.y >= 0)
                    scrollView.contentInset = UIEdgeInsetsZero;
                else
                    scrollView.contentInset = UIEdgeInsetsMake(MIN(-scrollView.contentOffset.y, 60.0f), 0, 0, 0);
            }
        } else {
            if (state == PullToRefreshViewStateReady) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.2f];
                [self setState:PullToRefreshViewStateLoading];
                [UIView commitAnimations];
                
                if ([delegate respondsToSelector:@selector(pullToRefreshViewShouldRefresh:)])
                    [delegate pullToRefreshViewShouldRefresh:self];
            }
        }
        self.frame = CGRectMake(scrollView.contentOffset.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
}

- (void)finishedLoading {
    
    if (state == PullToRefreshViewStateLoading) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        [self setState:PullToRefreshViewStateNormal];
        [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	[scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
