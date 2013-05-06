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
#import "RVTDriver.h"
#import "RVTEngine.h"

@interface RVTConstructorInjectionTests : SenTestCase
@end

@implementation RVTConstructorInjectionTests

- (RVTDependency *)car
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTCar class]];
    [initializer setSelector:@selector(initWithDriver:engine:wheels:)];
    [initializer setArgumentClasses:@[[RVTDriver class], [RVTEngine class], [NSArray class]]];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTCar class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (RVTDependency *)driver
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTDriver class]];
    [initializer setSelector:@selector(init)];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTDriver class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (RVTDependency *)engine
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTEngine class]];
    [initializer setSelector:@selector(init)];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTEngine class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (RVTDependency *)wheels
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[NSArray class]];
    [initializer setSelector:@selector(init)];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[NSArray class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (void)test
{
    RVTModule *module = [[RVTModule alloc] initWithDependencies:@[[self car], [self driver], [self engine], [self wheels]]];
    RVTInjector *injector = [[RVTInjector alloc] initWithModule:module];
    
    NSLog(@"Injected car: %@", [injector getInstanceOf:[RVTCar class]]);
}

@end
