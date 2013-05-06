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

- (id<RVTProvider>)carWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTCar class]];
    [initializer setSelector:@selector(initWithDriver:engine:wheels:)];
    [initializer setProviders:@[RVTInject([RVTDriver class]), RVTInject([RVTEngine class]), [RVTWheelsProvider new]]];
    return initializer;
}

- (id<RVTProvider>)driverWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTDriver class]];
    [initializer setSelector:@selector(initWithName:)];
    [initializer setProviders:@[RVTValue(@"John Smith")]];
    return initializer;
}

- (id<RVTProvider>)engineWithInjector:(RVTInjector *)injector
{
    RVTInitializer *initializer = [[RVTInitializer alloc] init];
    [initializer setKlass:[RVTEngine class]];
    [initializer setSelector:@selector(init)];
    return initializer;
}

- (void)test
{
    NSMutableDictionary *providers = [[NSMutableDictionary alloc] init];
    RVTModule *module = [[RVTModule alloc] initWithProviders:providers];
    RVTInjector *injector = [[RVTInjector alloc] initWithModule:module];
    
    module[[RVTCar    class]] = [self    carWithInjector:injector];
    module[[RVTDriver class]] = [self driverWithInjector:injector];
    module[[RVTEngine class]] = [self engineWithInjector:injector];
    
    NSLog(@"Injected car: %@",    [injector instanceOf:[RVTCar    class]]);
    NSLog(@"Injected driver: %@", [injector instanceOf:[RVTDriver class]]);
    NSLog(@"Injected engine: %@", [injector instanceOf:[RVTEngine class]]);
}

@end
