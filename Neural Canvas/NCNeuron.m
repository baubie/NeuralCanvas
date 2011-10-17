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

- (void)drawAtPoint:(NSPoint) point withScale: (float)scale
{
    NSRect neuronRect;
    neuronRect.origin = point;
    neuronRect.size = [self size];
    neuronRect.size.width *= scale;
    neuronRect.size.height *= scale;
    neuronRect.origin.x -= 15*scale;
    neuronRect.origin.y -= 15*scale;
    NSColor* fillColor = [NSColor blueColor];
    [fillColor set];
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:neuronRect];
    [path fill];
    [path setLineWidth:5];
}

- (BOOL)containsDocumentPoint:(NSPoint) point
{
    NSPoint location = [self location];
    NSSize size = [self size];
      
    return (
            point.x >= location.x-size.width*0.5 &&
            point.x <= location.x+size.width*0.5 &&
            point.y >= location.y-size.height*0.5 &&
            point.y <= location.y+size.height*0.5
            );
            
}

- (NSSize)size
{
    NSSize r = {30,30};
    return r;
}

+ (NSCursor *)creationCursor {
    
    // By default we use the crosshairs cursor.
    return [NSCursor crosshairCursor];
}

@end
