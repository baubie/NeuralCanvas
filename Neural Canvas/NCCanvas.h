//
//  NCCanvas.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-11.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCObject.h"
#import "NCNeuron.h"
#include <mach/mach_time.h>

@interface NCCanvas : NSObject {

    NSThread *simThread;
    BOOL simIsRunning;
}

- (BOOL)addObjectOfType:(NSString*) type At: (NSPoint) point;
- (BOOL)addConnectionOfType:(NSString*) type From:(NCObject*)fromObject To:(NCObject*) toObject;
- (void)runSimulationWithTimestep:(double)dt Length:(double)length;
- (void)simWithDt:(NSDictionary*) params;
- (BOOL)simulationIsRunning;
- (void)stopSimulation;

@property (nonatomic, retain) NSMutableArray* objects;

@end
