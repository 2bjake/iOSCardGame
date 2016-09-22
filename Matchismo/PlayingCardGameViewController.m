//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/21/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardMatchingGame.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)createGame {
    return [[PlayingCardMatchingGame alloc] initWithCardCount:self.cardCount];
}

- (void)drawCard:(Card *)card onButton:(UIButton *)button {

    [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

    button.enabled = !card.isMatched;
}

- (NSString *)titleForCard:(Card *)card {
    return (card.isChosen) ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)attributedStringForCard:(Card *)card {
    return [[NSAttributedString alloc] initWithString:card.contents];
}

@end
