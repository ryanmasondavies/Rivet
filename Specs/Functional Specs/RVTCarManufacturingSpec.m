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

__block RVTObjectGraphFactory *factory;

before(^{
    RVTAssembly *assembly = [RVTAssembly assembly];
    RVTEnvironment *environment = [RVTEnvironment environmentWithName:@"Production" variables:@{@"Frequency": @102.8}];
    [[RVTCarModule moduleWithAssembly:assembly environment:environment] configure];
    factory = [RVTObjectGraphFactory objectGraphFactoryWithAssembly:assembly];
});

describe(@"an independent radio", ^{
    it(@"has a frequency of 102.8", ^{
        RVTRadio *radio = factory[@"Radio"];
        expect([radio frequency]).to.equal(@102.8);
    });
});

describe(@"a car", ^{
    __block RVTCar *car;
    
    before(^{
        car = factory[@"Car"];
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
    __block NSArray *cars;
    
    before(^{
        cars = @[factory[@"Car"], factory[@"Car"]];
    });
    
    it(@"results in two references to the same instance", ^{
        expect(cars[0]).to.equal(cars[1]);
    });
    
    describe(@"and then using a provider to retrieve a car", ^{
        it(@"results in the same instance", ^{
            RVTObjectProvider provider = factory[@"Car Provider"];
            RVTCar *newCar = provider();
            expect(cars[0]).to.equal(newCar);
            expect(cars[1]).to.equal(newCar);
        });
    });
});

describe(@"building two separate radios", ^{
    __block NSArray *radios;
    
    before(^{
        radios = @[factory[@"Radio"], factory[@"Radio"]];
    });
    
    it(@"results in two instances of the radio", ^{
        expect(radios[0]).toNot.equal(radios[1]);
    });
    
    describe(@"and then using a provider to retrieve a radio", ^{
        it(@"results in a different instance", ^{
            RVTObjectProvider provider = factory[@"Radio Provider"];
            radios = [radios arrayByAddingObject:provider()];
            expect(radios[0]).toNot.equal(radios[2]);
            expect(radios[1]).toNot.equal(radios[2]);
        });
    });
});

SpecEnd
