//
//  NCglScope.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-14.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NCCanvas.h"

@interface NCOpenGLScope : NSOpenGLView {
    
}


- (void) drawRect: (NSRect) bounds;
- (void) drawTrace;

@property (nonatomic,retain) NCCanvas* canvas;

@end
