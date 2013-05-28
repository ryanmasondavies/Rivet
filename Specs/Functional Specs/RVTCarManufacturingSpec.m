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

// models
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"

// modules
#import "RVTCarModule.h"

SpecBegin(RVTObjectGraphSpec)

__block RVTObjectPool *pool;

before(^{
    RVTAssembly *assembly = [RVTAssembly assembly];
    RVTObjectPool *pool = [RVTObjectPool objectPool];
    RVTEnvironment *environment = [RVTEnvironment environmentWithName:@"Production" variables:@{@"Frequency": @102.8}];
    
    [[RVTCarModule moduleWithAssembly:assembly] configureWithEnvironment:environment];
    
    RVTObjectGraphFactory *factory = [RVTObjectGraphFactory objectGraphFactoryWithEnvironment:environment assembly:assembly];
    [[[RVTCarModule alloc] initWithObjectModel:model configuration:configuration] configure];
});

describe(@"an independent radio", ^{
    it(@"has a frequency of 102.8", ^{
        RVTRadio *radio = [factory objectWithName:@"Radio"];
        expect([radio frequency]).to.equal(@102.8);
    });
});

describe(@"a car", ^{
    __block RVTCar *car;
    
    before(^{
        car = [factory objectWithName:@"Car"];
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

describe(@"building two separate cars", ^{
    it(@"results in two references to the same instance", ^{
        RVTCar *cars[2];
        cars[0] = [factory objectWithName:@"Car"];
        cars[1] = [factory objectWithName:@"Car"];
        expect(cars[0]).to.equal(cars[1]);
    });
});

SpecEnd
