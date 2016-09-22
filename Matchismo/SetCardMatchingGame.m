//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"

@implementation SetCardMatchingGame
- (instancetype)init {
    self = [super initWithCardCount:12 withDeck:[[SetCardDeck alloc] init]];
    [self setMatchCount:3];
    return self;
}

@end
