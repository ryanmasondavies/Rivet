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

#import "RVTCarFactory.h"
#import "RVTProduct.h"
#import "RVTModule.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTWheel.h"

@implementation RVTCarFactory

- (id)supplyProduct:(RVTProduct *)product inModule:(RVTModule *)module
{
    RVTProduct *engineProduct = [[RVTProduct alloc] initWithClass:[RVTEngine class] name:nil];
    RVTProduct *wheelProduct = [[RVTProduct alloc] initWithClass:[RVTWheel class] name:nil];
    
    RVTEngine *engine = [module supplyProduct:engineProduct];
    RVTWheel *frontLeftRVTWheel = [module supplyProduct:wheelProduct];
    RVTWheel *frontRightRVTWheel = [module supplyProduct:wheelProduct];
    RVTWheel *rearLeftRVTWheel = [module supplyProduct:wheelProduct];
    RVTWheel *rearRightRVTWheel = [module supplyProduct:wheelProduct];
    
    return [[RVTCar alloc] initWithRVTEngine:engine wheels:@[frontLeftRVTWheel, frontRightRVTWheel, rearLeftRVTWheel, rearRightRVTWheel]];
}

@end
