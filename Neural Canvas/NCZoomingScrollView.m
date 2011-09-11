//
//  NCZoomingScrollView.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-14.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCZoomingScrollView.h"


// The name of the binding supported by this class
NSString *NCZoomingScrollViewFactor = @"factor";

// Default labels and values for the popup button list
static NSString * const NCZoomingScrollViewLabels[] = {@"10%", @"25%", @"50%", @"75%", @"100%", @"125%", @"150%", @"175%", @"200%"};
static const CGFloat NCZoomingScrollViewFactors[] = {0.1f, 0.25f, 0.5f, 0.75f, 1.0f, 1.25f, 1.5f, 1.75f, 2.0f};
static const NSInteger NCZoomingScrollViewPopUpButtonItemCount = sizeof(NCZoomingScrollViewLabels) / sizeof(NSString *);

@implementation NCZoomingScrollView

- (void)validateFactorPopUpButton {
    
    // Ignore redundant invocations
    if (!_factorPopUpButton) {
        
        // Create the popup button and configure its appearance.
        _factorPopUpButton = [[NSPopUpButton alloc] initWithFrame: NSZeroRect pullsDown:NO];
        NSPopUpButtonCell *factorPopUpButtonCell = [_factorPopUpButton cell];
        [factorPopUpButtonCell setArrowPosition:NSPopUpArrowAtBottom];
        [factorPopUpButtonCell setBezelStyle:NSShadowlessSquareBezelStyle];
        [_factorPopUpButton setFont:[NSFont systemFontOfSize:[NSFont smallSystemFontSize]]];
        
        // Populate it and size it to fit
        for (NSInteger index = 0; index<NCZoomingScrollViewPopUpButtonItemCount; index++) {
            [_factorPopUpButton addItemWithTitle:NCZoomingScrollViewLabels[index]];
            [[_factorPopUpButton itemAtIndex:index] setRepresentedObject:[NSNumber numberWithDouble:NCZoomingScrollViewFactors[index]]];
        }
        [_factorPopUpButton sizeToFit];
        
        // Make it appear and then release it right away which is save because -addSubview: retains it.
        [self addSubview:_factorPopUpButton];
        [_factorPopUpButton release];
    }
}


#pragma mark *** Bindings ***

- (void)setFactor:(CGFloat)factor {

    _factor = factor;
    NSView *clipView = [[self documentView] superview];
    NSSize clipViewFrameSize = [clipView frame].size;
    [clipView setBoundsSize:NSMakeSize((clipViewFrameSize.width / factor), (clipViewFrameSize.height / factor))];
    
}


- (void)bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options {
    
    if ([binding isEqualToString:NCZoomingScrollViewFactor]) {
        [self validateFactorPopUpButton];
        [_factorPopUpButton bind:NSSelectedObjectBinding toObject:observable withKeyPath:keyPath options:options];
    }
    
    [super bind:binding toObject:observable withKeyPath:keyPath options:options];
}


#pragma mark *** View Customization ***

-(void) tile {
    
    // We need a horizonal scroll bar to put our zoom factor popup.
    NSAssert([self hasHorizontalScroller], @"NCZoomingScrollView doesn't support use without a horizontal scroll bar.");
    
    // Do NSScrollView's regular tiling and find out where it left the horizonal scroller.
    [super tile];
    NSScroller *horizonalScroller = [self horizontalScroller];
    NSRect horizontalScrollerFrame = [horizonalScroller frame];
    
    // Please the zoom factor popup button to the left of where the horizontal scroller will go, creating it first if necessary and leaving is width alone.
    [self validateFactorPopUpButton];
    NSRect factorPopUpButtonFrame = [_factorPopUpButton frame];
    factorPopUpButtonFrame.origin.x = horizontalScrollerFrame.origin.x;
    factorPopUpButtonFrame.origin.y = horizontalScrollerFrame.origin.y;
    factorPopUpButtonFrame.size.height = horizontalScrollerFrame.size.height;
    [_factorPopUpButton setFrame:factorPopUpButtonFrame];
    
    // Adjust the scroller's frame to make zoom for the popup button
    horizontalScrollerFrame.origin.x += factorPopUpButtonFrame.size.width;
    horizontalScrollerFrame.size.width -= factorPopUpButtonFrame.size.width;
    [horizonalScroller setFrame:horizontalScrollerFrame];
}

@end
