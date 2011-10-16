//
//  NeuralCanvasDocument.m
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-08-13.
//  Copyright 2011 McMaster University. All rights reserved.
//

#import "NeuralCanvasDocument.h"

@implementation NeuralCanvasDocument

@synthesize canvas;

- (id)init
{
    self = [super init];
    if (self) {
        
        // Setup our canvas for this document.
        // Initially it is blank but we could load in a canvas from a file.
        [self setCanvas:[[NCCanvas alloc] init]]; 
    }
    return self;
}

- (void)makeWindowControllers
{
    NCWindowController *windowController = [[NCWindowController
                            allocWithZone:[self zone]] initWithWindowNibName:@"NeuralCanvasDocument"];

    [self addWindowController:windowController];
    [windowController setCanvas:[self canvas]];
    // Pass the canvas into our Canvas View
    [windowController release];
}


- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    /*
     Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    */
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    /*
    Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    */
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
