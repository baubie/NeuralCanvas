//
//  NCCanvas.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-11.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NCCanvas.h"

@implementation NCCanvas

@synthesize objects;

- (id)init
{
    self = [super init];
    if (self) {
        objects = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BOOL) addObjectOfType:(NSString*)type At: (NSPoint)point
{
    
    if([type isEqualToString:@"Neuron"]) {
        
        NCNeuron* newNeuron = [[NCNeuron alloc] init];
        [newNeuron setLocation:point];
        [objects addObject:newNeuron];
        [newNeuron release];
    }
    
    return true;
}

- (BOOL)addConnectionOfType:(NSString*) type From:(NCObject*)fromObject To:(NCObject*) toObject
{
    return true;
}



@end
