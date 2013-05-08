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

SpecBegin(RVTSingletonScope)

__block RVTScopeCache *scopeCache;
__block RVTSingletonScope *scope;
__block id object;
__block id<RVTProvider> provider;

before(^{
    scopeCache = [[RVTScopeCache alloc] init];
    scope = [[RVTSingletonScope alloc] initWithCache:scopeCache];
    object = [[NSObject alloc] init];
    provider = [[RVTSequentialProvider alloc] initWithObjects:@[object]];
});

describe(@"when the provider's value is not cached", ^{
    it(@"returns the provider's value", ^{
        expect([scope instanceFromProvider:provider]).to.equal(object);
    });
    
    it(@"stores the value in the cache", ^{
        [scope instanceFromProvider:provider];
        expect([scopeCache objectForProvider:provider]).to.equal(object);
    });
});

describe(@"when the provider's value is cached", ^{
    it(@"returns the value in the cache", ^{
        [scopeCache setObject:object forProvider:provider];
        expect([scope instanceFromProvider:provider]).to.equal(object);
    });
});

SpecEnd
