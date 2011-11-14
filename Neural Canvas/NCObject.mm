//
//  NCObject.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-04.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCObject.h"


@implementation NCObject

@synthesize location;
@synthesize selected;

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
    // To be implemented by objects
    return;
}

- (BOOL)containsDocumentPoint:(NSPoint) point
{
    // To be implemented by objects    
    return NO;
}

- (NSSize)size
{
    // To be implemented by objects        
    NSSize r;
    return r;
}

- (void)updateWithTimestep:(double) dt
{
    // To be implemented by objects
}

- (void)initialize
{
    // To be implemented by objects
}


@end
