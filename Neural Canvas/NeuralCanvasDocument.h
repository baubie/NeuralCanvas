//
//  NeuralCanvasDocument.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-13.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NCWindowController.h"
#import "NCCanvas.h"

@interface NeuralCanvasDocument : NSDocument {
    
    
}

@property (nonatomic,retain) NCCanvas* canvas;

@end
