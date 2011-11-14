//
//  NCNeuronModel.h
//  Neural Canvas
//
//  Created by Brandon Aubie on 11-11-07.
//  Copyright (c) 2011 McMaster University. All rights reserved.
//

#ifndef Neural_Canvas_NCNeuronModel_h
#define Neural_Canvas_NCNeuronModel_h

class NCNeuronModel {
    
public:
    virtual void initialize() = 0;
    virtual void update(double dt, double I) = 0;
    virtual void printStatus() = 0;

    virtual int getNumParams() = 0;
    virtual const char* getParamName(int index) = 0;
    virtual double getParamValue(int index) = 0;
};

#endif
