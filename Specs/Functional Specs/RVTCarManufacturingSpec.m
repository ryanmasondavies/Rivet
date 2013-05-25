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
#import "RVTConfiguration.h"
#import "RVTModule.h"
#import "RVTObjectDescription.h"
#import "RVTObjectGraphFactory.h"
#import "RVTObjectModel.h"
#import "RVTObjectPool.h"
#import "RVTRelationshipDescription.h"

// models
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"

// modules
#import "RVTCarModule.h"

SpecBegin(RVTObjectGraphSpec)

__block RVTObjectPool *pool;

before(^{
    RVTConfiguration *configuration = [RVTConfiguration configuration];
    RVTObjectModel *model = [RVTObjectModel objectModel];
    RVTObjectGraphFactory *factory = [RVTObjectGraphFactory objectGraphFactoryWithConfiguration:configuration objectModel:model];
    pool = [RVTObjectPool objectPoolWithFactory:factory];
    
    [[RVTCarModule new] addToObjectModel:model];
    [[RVTCarModule new] addToConfiguration:configuration];
});

describe(@"an independent radio", ^{
    it(@"has a frequency of 102.8", ^{
        RVTRadio *radio = [pool objectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTRadio class] identifier:@""]];
        expect([radio frequency]).to.equal(@102.8);
    });
});

describe(@"a car", ^{
    __block RVTCar *car;
    
    before(^{
        car = [pool objectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""]];
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

describe(@"building the radio and then building the car", ^{
    it(@"results in a car with the same instance of RVTRadio", ^{
        RVTRadio *radio = [pool objectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTRadio class] identifier:@""]];
        RVTCar *car = [pool objectWithDescription:[RVTObjectDescription objectDescriptionWithClass:[RVTCar class] identifier:@""]];
        expect([car radio]).to.equal(radio);
    });
});

SpecEnd
