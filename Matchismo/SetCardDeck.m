//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (int color = FirstColor; color <= LastColor; color++) {
            for (int symbol = FirstSymbol; symbol <= LastSymbol; symbol++) {
                for (int shading = FirstShading; shading <= LastShading; shading++) {
                    for (int number = FirstNumber; number <= LastNumber; number++) {
                        [self addCard:[[SetCard alloc] initWithNumber:number symbol:symbol shading:shading color:color]];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
