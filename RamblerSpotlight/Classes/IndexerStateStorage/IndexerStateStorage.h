// Copyright (c) 2016 RAMBLER&Co
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

#import <Foundation/Foundation.h>

#import "ChangeProviderChangeType.h"

@class IndexTransaction;
@class IndexTransactionBatch;
@protocol ContextProvider;
@protocol SpotlightCoreDataHandler;

/**
 This object is responsible for saving pending changes to process them later.
 */
@interface IndexerStateStorage : NSObject

+ (nullable instancetype)stateStorageWithContextProvider:(nonnull id<ContextProvider>)contextProvider
                                         coreDataHandler:(nonnull id<SpotlightCoreDataHandler>)coreDataHandler;

/**
 Method saves passed transaction to store
 
 @param transaction Index transaction
 */
- (void)insertTransaction:(nonnull IndexTransaction *)transaction;

/**
 Method saves an array of transaction arrays to store
 
 @param transactionsArray NSArray<NSArray *> of transactions
 @param changeType        ChangeProviderChangeType
 */
- (void)insertTransactionsArray:(nonnull NSArray<NSArray *> *)transactionsArray
                     changeType:(ChangeProviderChangeType)changeType;

/**
 Method returns a transaction batch for indexing
 
 @return IndexTransactionBatch
 */
- (nullable IndexTransactionBatch *)obtainTransactionBatch;

/**
 Method removes transactions from the provided batch from the store
 
 @param batch Transaction batch
 */
- (void)removeProcessedBatch:(nonnull IndexTransactionBatch *)batch;

/**
 Method checks whether indexing process ever started
 
 @return YES/NO
 */
- (BOOL)shouldPerformInitialIndexing;

@end
