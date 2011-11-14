//
//  LIF.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-06.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#ifndef Neural_Canvas_LIF_h
#define Neural_Canvas_LIF_h

#include "NCNeuronModel.h"
#include <stdio.h>

class NCLIF : public NCNeuronModel {

private:
    double V;
    double tau;
    double R;
    double tref;
    double thresh;
    double spike_height;
    
    double ref;
    
public:
    void update(double dt);
    void update(double dt, double I);
    void initialize();
    void printStatus();
    
    int getNumParams();
    const char* getParamName(int index);
    double getParamValue(int index);    
    
};


#endif
