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

@interface NCCanvas : NSObject


- (BOOL)addObjectOfType:(NSString*) type At: (NSPoint) point;
- (BOOL)addConnectionOfType:(NSString*) type From:(NCObject*)fromObject To:(NCObject*) toObject;
- (void)drawRect:(NSRect)dirtyRect onView:(NSView*)view;

@property (nonatomic, retain) NSMutableArray* objects;

@end
