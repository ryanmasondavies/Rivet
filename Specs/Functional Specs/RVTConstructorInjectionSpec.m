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
#import "RVTWheel.h"

#define RVTInject(klass) [[RVTInjectionProvider alloc] initWithClass:klass injector:injector]
#define RVTValue(val) [[RVTValueProvider alloc] initWithValue:val]

@interface RVTWheelsProvider : NSObject <RVTProvider>

@end

@implementation RVTWheelsProvider

- (id)get
{
    return @[[RVTWheel new], [RVTWheel new], [RVTWheel new], [RVTWheel new]];
}

@end

@interface RVTConstructorInjectionTests : SenTestCase
@end

@implementation RVTConstructorInjectionTests

- (RVTDependency *)carWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTCar class]];
    [initializer setSelector:@selector(initWithDriver:engine:wheels:)];
    [initializer setProviders:@[RVTInject([RVTDriver class]), RVTInject([RVTEngine class]), [RVTWheelsProvider new]]];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTCar class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (RVTDependency *)driverWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTDriver class]];
    [initializer setSelector:@selector(initWithName:)];
    [initializer setProviders:@[RVTValue(@"John Smith")]];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTDriver class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (RVTDependency *)engineWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTEngine class]];
    [initializer setSelector:@selector(init)];
    
    RVTDependency *dependency = [[RVTDependency alloc] init];
    [dependency setKlass:[RVTEngine class]];
    [dependency setInitializer:initializer];
    
    return dependency;
}

- (void)test
{
    NSMutableArray *dependencies = [[NSMutableArray alloc] init];
    RVTModule *module = [[RVTModule alloc] initWithDependencies:dependencies];
    RVTInjector *injector = [[RVTInjector alloc] initWithModule:module];
    
    dependencies[0] = [self carWithInjector:injector];
    dependencies[1] = [self driverWithInjector:injector];
    dependencies[2] = [self engineWithInjector:injector];
    
    NSLog(@"Injected car: %@", [injector instanceOf:[RVTCar class]]);
    NSLog(@"Injected driver: %@", [injector instanceOf:[RVTDriver class]]);
    NSLog(@"Injected engine: %@", [injector instanceOf:[RVTEngine class]]);
}

@end
