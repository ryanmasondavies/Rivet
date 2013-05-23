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

#import "RVTObjectProvider.h"
#import "RVTInitializer.h"
#import "RVTProperty.h"

@interface RVTObjectProvider ()
@property (strong, nonatomic) Class klass;
@property (strong, nonatomic) RVTInitializer *initializer;
@property (strong, nonatomic) NSArray *properties;
@end

@implementation RVTObjectProvider

- (id)initWithClass:(Class)klass initializer:(RVTInitializer *)initializer properties:(NSArray *)properties
{
    if (self = [self init]) {
        self.klass = klass;
        self.initializer = initializer;
        self.properties = properties;
    }
    return self;
}

- (id)get
{
    if ([self initializer] == nil) {
        [NSException raise:NSInternalInconsistencyException format:@"%@ is missing an initializer.", self];
        return nil;
    }
    
    id object = [[self initializer] perform];
    [[self properties] makeObjectsPerformSelector:@selector(applyToObject:) withObject:object];
    return object;
}

@end