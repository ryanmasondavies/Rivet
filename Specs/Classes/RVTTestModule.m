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

#import "RVTTestModule.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTFirefighter.h"
#import "RVTPerson.h"

@implementation RVTTestModule

- (RVTDependencyMap *)dependencies
{
    RVTDependencyMap *map = [[RVTDependencyMap alloc] initWithDependencies:[NSMutableDictionary dictionary]];
    map[[RVTCar class]] = [self car];
    map[[RVTEngine class]] = [self engine];
    map[[RVTFirefighter class]] = [self firefighter];
    map[[RVTPerson class]] = [self driver];
    return map;
}

- (RVTDependency *)car
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithEngine:driver:) dependencies:@[[self engine], [self driver]]];
    return [[RVTDependency alloc] initWithClass:[RVTCar class] initializer:initializer properties:nil];
}

- (RVTDependency *)engine
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    return [[RVTDependency alloc] initWithClass:[RVTEngine class] initializer:initializer properties:nil];
}

- (RVTDependency *)string
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    return [[RVTDependency alloc] initWithClass:[NSString class] initializer:initializer properties:nil];
}

- (RVTDependency *)firefighter
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(init) dependencies:nil];
    return [[RVTDependency alloc] initWithClass:[RVTFirefighter class] initializer:initializer properties:nil];
}

- (RVTDependency *)driver
{
    // how to make use of Provider objects to resolve dependencies, in only some cases?
    // e.g having a dependency which resolves to a string value
    // and how to extend the concept of providers to allow them to also have dependencies?
    // almost like a two-part construction process:
    // 1. Initialize provider using subdependencies.
    // 2. Create actual object of interest by calling -[Provider get].
    
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithSelector:@selector(initWithName:occupation:) dependencies:@[[self string], [self firefighter]]];
    return [[RVTDependency alloc] initWithClass:[RVTPerson class] initializer:initializer properties:nil];
}

@end
