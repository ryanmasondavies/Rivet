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
#import "RVTEngine.h"
#import "RVTFirefighter.h"
#import "RVTPerson.h"

@interface RVTConstructorInjectionTests : SenTestCase
@end

@implementation RVTConstructorInjectionTests

- (void)test
{
    // how to make use of Provider objects to resolve dependencies, in only some cases?
    
    RVTDependencyMap *dependencies = [[RVTDependencyMap alloc] initWithDependencies:[[NSMutableDictionary alloc] init]];
    RVTInjector *injector = [[RVTInjector alloc] initWithDependencies:dependencies];
    
    RVTInitializer *defaultInitializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    
    dependencies[[RVTEngine class]] = [[RVTDependency alloc] initWithClass:[RVTEngine class] initializer:defaultInitializer properties:nil];
    dependencies[[NSString class]] = [[RVTDependency alloc] initWithClass:[NSString class] initializer:defaultInitializer properties:nil];
    dependencies[[RVTFirefighter class]] = [[RVTDependency alloc] initWithClass:[RVTFirefighter class] initializer:defaultInitializer properties:nil];
    
    RVTInitializer *driverInitializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithName:occupation:) dependencies:@[dependencies[[NSString class]], dependencies[[RVTFirefighter class]]]];
    dependencies[[RVTPerson class]] = [[RVTDependency alloc] initWithClass:[RVTPerson class] initializer:driverInitializer properties:nil];
    
    RVTInitializer *carInitializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithEngine:driver:) dependencies:@[dependencies[[RVTEngine class]], dependencies[[RVTPerson class]]]];
    dependencies[[RVTCar class]] = [[RVTDependency alloc] initWithClass:[RVTCar class] initializer:carInitializer properties:nil];
    
    [injector injectInstanceOf:[RVTCar class]];
}

@end
