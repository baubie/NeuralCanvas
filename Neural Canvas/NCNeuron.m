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
    neuronRect.size.width = 50;
    neuronRect.size.height = 30;
    NSColor* fillColor = [NSColor blueColor];
    [fillColor set];
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:neuronRect];
    [path fill];
    [path setLineWidth:5];
    [view unlockFocus];
}


+ (NSCursor *)creationCursor {
    
    // By default we use the crosshairs cursor.
    static NSCursor *crosshairsCursor = nil;
    if (!crosshairsCursor) {
        NSImage *crosshairsImage = [NSImage imageNamed:@"iconNeuron.png"];
        NSSize crosshairsImageSize = [crosshairsImage size];
        crosshairsCursor = [[NSCursor alloc] initWithImage:crosshairsImage hotSpot:NSMakePoint((crosshairsImageSize.width / 2.0), (crosshairsImageSize.height / 2.0))];
    }
    return crosshairsCursor;
}

@end
