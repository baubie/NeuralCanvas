//
//  NCObject.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-04.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCObject : NSObject

- (void)drawAtPoint:(NSPoint) point withScale: (float)scale;
- (BOOL)containsDocumentPoint:(NSPoint) point;
- (NSSize)size;

- (void)updateWithTimestep:(double) dt;
- (void)initialize;


@property (nonatomic) NSPoint location;
@property (nonatomic) BOOL selected;

@end

