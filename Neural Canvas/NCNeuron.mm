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

        model = new NCLIF;
    }
    
    return self;
}

- (void)dealloc {
    delete model;
}

- (void)drawAtPoint:(NSPoint) point withScale: (float)scale
{
    
    NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
    [shadow setShadowOffset: NSMakeSize(1, -1)];
    [shadow setShadowBlurRadius: 4];
    [shadow setShadowColor: [NSColor blackColor]];
    
    if ([self selected])
    {
        [shadow setShadowOffset: NSMakeSize(3, -3)];
        [shadow setShadowBlurRadius: 10]; 
        scale *= 1.1;
    }
    
    
    NSRect neuronRect;
    neuronRect.origin = point;
    neuronRect.size = [self size];
    neuronRect.size.width *= scale;
    neuronRect.size.height *= scale;
    neuronRect.origin.x -= 15*scale;
    neuronRect.origin.y -= 15*scale;
    NSColor* fillColor;
    fillColor = [NSColor blueColor];
    [fillColor set];
    
    [shadow set];

    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:neuronRect];

    [path setLineWidth:0];

    [path stroke];
    
    [path fill];
    
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

- (void)updateWithTimestep:(double) dt
{
    model->update(dt, 1.0);
}

- (void)initialize 
{
    model->initialize();
}

@end
