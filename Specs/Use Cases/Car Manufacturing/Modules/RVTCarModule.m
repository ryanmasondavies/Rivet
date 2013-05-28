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

#import "RVTCarModule.h"
#import "RVTObjectGraphFactory.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTRadio.h"
#import "RVTWheel.h"

@implementation RVTCarModule

- (void)configure
{
    RVTEnvironment *env = [self environment];
    
    [self define:@"Car" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTCar alloc] initWithEngine:factory[@"Engine"] radio:factory[@"Radio"] wheels:factory[@"Wheels"]];
    }];
    
    [self define:@"Engine" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTEngine alloc] init];
    }];
    
    [self define:@"Radio" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTRadio alloc] initWithFrequency:env[@"Frequency"]];
    }];
    
    [self define:@"Wheels" as:^id(RVTObjectGraphFactory *factory) {
        return @[factory[@"Wheel"], factory[@"Wheel"], factory[@"Wheel"], factory[@"Wheel"]];
    }];
    
    [self define:@"Wheel" as:^id(RVTObjectGraphFactory *factory) {
        return [[RVTWheel alloc] init];
    }];
}

@end
