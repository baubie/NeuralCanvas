//
//  NCNeuron.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-04.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCNeuron.h"

@implementation NCNeuron

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawInView:(NSView*) view
{
    [view lockFocus];
    NSRect neuronRect;
    neuronRect.origin = self.location;
    neuronRect.size.width = 30;
    neuronRect.size.height = 30;
    neuronRect.origin.x -= 20;
    neuronRect.origin.y -= 30;
    NSColor* fillColor = [NSColor blueColor];
    [fillColor set];
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:neuronRect];
    [path fill];
    [path setLineWidth:5];
    [view unlockFocus];
}


+ (NSCursor *)creationCursor {
    
    // By default we use the crosshairs cursor.
    return [NSCursor crosshairCursor];
}

@end
