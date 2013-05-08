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

__block RVTSingletonScope *singleton;
__block RVTDependency *dependency;
__block id object;

before(^{
    singleton = [[RVTSingletonScope alloc] init];
    dependency = [[RVTDependency alloc] initWithProvider:nil scope:nil];
    object = [[NSObject alloc] init];
});

when(@"an object is registered for a dependency", ^{
    before(^{
        [singleton setObject:object forDependency:dependency];
    });
    
    it(@"returns the object when requested with the same dependency", ^{
        expect([singleton objectForDependency:dependency]).to.equal(object);
    });
    
    it(@"returns nil when requested with a different dependency", ^{
        RVTDependency *another = [[RVTDependency alloc] initWithProvider:nil scope:nil];
        expect([singleton objectForDependency:another]).to.beNil();
    });
});

SpecEnd
