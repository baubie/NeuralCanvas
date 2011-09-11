//
//  NCZoomingScrollView.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-14.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *NCZoomingScrollViewFactor;

@interface NCZoomingScrollView : NSScrollView {

    @private
    
    // Popup button with the zoom factor next to the horizonal scrollbar.
    NSPopUpButton *_factorPopUpButton;
    
    // The current zoom factor. This variable isn't actually used, however, Apple describes it as necessary to overcome an oddity in the default implementation of key-value binding.
    CGFloat _factor;

}
@end
