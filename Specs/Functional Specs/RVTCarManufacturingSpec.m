// The MIT License
//
// Copyright (c) 2013 Ryan Davies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// library
#import "RVTDependency.h"
#import "RVTFactory.h"
#import "RVTModule.h"

// model
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"
#import "RVTWheel.h"

// modules
#import "RVTCarModule.h"
#import "RVTRadioModule.h"

// factories
#import "RVTCarFactory.h"
#import "RVTEngineFactory.h"
#import "RVTRadioFactory.h"
#import "RVTWheelFactory.h"

SpecBegin(RVTCarManufacturingSpec)

__block RVTModule *module;

before(^{
    module = [[RVTCarModule alloc] init];
});

describe(@"an independent radio", ^{
    it(@"has a frequency of 102.8", ^{
        RVTDependency *radioProduct = [[RVTDependency alloc] initWithClass:[RVTRadio class] name:nil];
        RVTRadio *radio = [module supplyProduct:radioProduct];
        expect([radio frequency]).to.equal(@102.8);
    });
});

describe(@"a car", ^{
    __block RVTCar *car;
    
    before(^{
        RVTDependency *dependency = [[RVTDependency alloc] initWithClass:[RVTCar class] name:nil];
        car = [module supplyProduct:dependency];
    });
    
    it(@"has an engine", ^{
        expect([car engine]).to.beKindOf([RVTEngine class]);
    });
    
    it(@"has 4 wheels", ^{
        expect([car wheels]).to.haveCountOf(4);
    });
    
    describe(@"radio", ^{
        it(@"has a frequency of 102.8", ^{
            expect([[car radio] frequency]).to.equal(@102.8);
        });
    });
});

SpecEnd
