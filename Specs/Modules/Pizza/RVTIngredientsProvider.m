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

#import "RVTIngredientsProvider.h"
#import "RVTAnchovies.h"
#import "RVTCheese.h"
#import "RVTPepperoni.h"
#import "RVTPineapple.h"

@interface RVTIngredientsProvider ()
@property (strong, nonatomic) RVTAnchovies *anchovies;
@property (strong, nonatomic) RVTCheese *cheese;
@property (strong, nonatomic) RVTPepperoni *pepperoni;
@property (strong, nonatomic) RVTPineapple *pineapple;
@end

@implementation RVTIngredientsProvider

- (id)initWithAnchovies:(RVTAnchovies *)anchovies cheese:(RVTCheese *)cheese pepperoni:(RVTPepperoni *)pepperoni pineapple:(RVTPineapple *)pineapple
{
    if (self = [self init]) {
        self.anchovies = anchovies;
        self.cheese    = cheese;
        self.pepperoni = pepperoni;
        self.pineapple = pineapple;
    }
    return self;
}

- (id)get
{
    return @[[self anchovies], [self cheese], [self pepperoni], [self pineapple]];
}

@end
