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

#import "RVTCar.h"
#import "RVTPizza.h"

SpecBegin(RVTInitializer)

when(@"has no dependencies", ^{
    it(@"returns the result of calling the method", ^{
        RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[NSArray class] selector:@selector(init) dependencies:@[]];
        NSArray *array = [initializer perform];
        expect(array).to.haveCountOf(0);
    });
});

when(@"selector has 1 dependency", ^{
    it(@"returns an object initialized by passing the resolved dependency as the first argument", ^{
        id dependency = [OCMockObject niceMockForClass:[RVTDependency class]];
        RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[RVTPizza class] selector:@selector(initWithIngredients:) dependencies:@[dependency]];
        
        id ingredients = [[NSObject alloc] init];
        [(RVTDependency *)[[dependency stub] andReturn:ingredients] resolve];
        RVTPizza *pizza = [initializer perform];
        
        expect([pizza ingredients]).to.equal(ingredients);
    });
});

when(@"selector has 2 dependencies", ^{
    __block NSArray *dependencies;
    __block RVTInitializer *initializer;
    
    before(^{
        dependencies = @[[OCMockObject niceMockForClass:[RVTDependency class]], [OCMockObject niceMockForClass:[RVTDependency class]]];
        initializer = [[RVTInitializer alloc] initWithClass:[RVTCar class] selector:@selector(initWithEngine:driver:) dependencies:dependencies];
    });
    
    it(@"passes in the first resolved dependency as the first argument", ^{
        id engine = [[NSObject alloc] init];
        [(RVTDependency *)[[dependencies[0] stub] andReturn:engine] resolve];
        RVTCar *car = [initializer perform];
        expect([car engine]).to.equal(engine);
    });
    
    it(@"passes in the second resolved dependency as the second argument", ^{
        id driver = [[NSObject alloc] init];
        [(RVTDependency *)[[dependencies[1] stub] andReturn:driver] resolve];
        RVTCar *car = [initializer perform];
        expect([car driver]).to.equal(driver);
    });
});

SpecEnd
