//
//  NCNeuron.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-09-04.
//  Copyright 2011 McMaster University. All rights reserved.
//

#include "NCObject.h"
#include "NCLIF.h"

@interface NCNeuron : NCObject {
    
    NCNeuronModel *model;
}

    + (NSCursor *)creationCursor;
@end
