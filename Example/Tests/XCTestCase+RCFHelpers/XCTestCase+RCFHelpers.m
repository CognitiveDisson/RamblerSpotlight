// Copyright (c) 2015 RAMBLER&Co
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
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "XCTestCase+RCFHelpers.h"
#import "SpotlightCoreDataStackCoordinatorImplementation.h"
#import "ContextStorageImplementation.h"

@implementation XCTestCase (RCFHelpers)

- (XCTestExpectation *)expectationForCurrentTest {
    SEL testSelector = self.invocation.selector;
    NSString *selectorString = NSStringFromSelector(testSelector);
    NSString *expectationDescription = [NSString stringWithFormat:@"Expectation for %@ test", selectorString];
    return [self expectationWithDescription:expectationDescription];
}

- (void)fulfillExpectationInMainThread:(XCTestExpectation *)expectation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
}

- (SpotlightCoreDataStackCoordinatorImplementation *)setupCoreDataStackForTests {
    ContextStorageImplementation *storage = [[ContextStorageImplementation alloc] init];
    SpotlightCoreDataStackCoordinatorImplementation *coordinator = [SpotlightCoreDataStackCoordinatorImplementation coordinatorWithContextStorage:storage];
    [coordinator setupCoreDataStack];
    return coordinator;
    
}

- (void)tearDownCoreDataStackWithCoordinator:(SpotlightCoreDataStackCoordinatorImplementation *)coordinator {
    [coordinator clearDatabaseFilesSpotlight];
}

@end
