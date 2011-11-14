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

- (void)runSimulationWithTimestep:(double)dt Length:(double)length;
{
    // Loop over all objects
    for(int i = 0; i < [[self objects] count]; i++) {
        NCObject* obj = [[self objects] objectAtIndex:i];
        [obj initialize];
    }    

    NSDictionary *params;
    NSArray *objs = [NSArray arrayWithObjects:[NSNumber numberWithDouble:length], [NSNumber numberWithDouble:dt], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"length", @"dt", nil];
    params = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    simThread = [[NSThread alloc] initWithTarget:self selector:@selector(simWithDt:) object:params];
    [simThread start];
    simIsRunning = YES;
    
    
}

- (void)stopSimulation {
    [simThread cancel];
    simIsRunning = NO;
}

- (BOOL)simulationIsRunning {
    return simIsRunning;
}


- (void)simWithDt:(NSDictionary*) params
{
    double length = [[params objectForKey:@"length"] doubleValue];
    double dt = [[params objectForKey:@"dt"] doubleValue];

    // Run indefinite length simulation in real time
    if (length == 0) {       
        
        
        // For timing realtime
        NSDate *startTime = [NSDate date];
        
        double t = 0;
        mach_timebase_info_data_t info;
        mach_timebase_info(&info);
        uint64_t start = mach_absolute_time();        
        double to_ms = (info.numer / info.denom)/1000000.0;
        
        while ([[NSThread currentThread] isCancelled] == NO) {
            

            // Loop over all objects
            for(int i = 0; i < [[self objects] count]; i++) {
                NCObject* obj = [[self objects] objectAtIndex:i];
                [obj updateWithTimestep:dt];
            }    
            t += dt;
            
            // Wait until absolute time hits t
            while ((mach_absolute_time() - start)*to_ms - t < 0) {}

        }
        NSTimeInterval difference = -1000*[startTime  timeIntervalSinceNow];        
        
        NSLog(@"Simulation Time: %f ms", t);
        NSLog(@"Real Time: %f ms", difference);
    }
    
    // Run fixed length simulation in simulation time
    if (length > 0) {        
        for (float t = 0; t < length; t+=dt) 
        {
            // Loop over all objects
            for(int i = 0; i < [[self objects] count]; i++) {
                NCObject* obj = [[self objects] objectAtIndex:i];
                [obj updateWithTimestep:dt];
            }    
        }
    }
}


@end
