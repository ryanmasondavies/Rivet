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

#import "RVTModule.h"
#import "RVTDependencyMap.h"
#import "RVTFactory.h"
#import "RVTDependency.h"

@interface RVTModule ()
@property (strong, nonatomic, readwrite) RVTDependencyMap *definitions;
@end

@implementation RVTModule

- (id)initWithDefinitions:(RVTDependencyMap *)definitions
{
    if (self = [self initWithDefinitions:definitions]) {
        self.definitions = definitions;
    }
    return self;
}

- (void)configure
{
}

- (id)supplyProduct:(RVTDependency *)dependency
{
    RVTFactory *factory = [[self definitions] factoryForDependency:dependency];
    if (!factory) {
        NSString *reason = [NSString stringWithFormat:@"No factory for %@", dependency];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
    }
    return [factory supplyDependency:dependency inModule:self];
}

@end
