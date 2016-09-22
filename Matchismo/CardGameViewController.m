//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createGame];
    }
    return _game;
}

- (void)resetGame {
    _game = [self createGame];
}

- (CardMatchingGame *)createGame { //abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)drawCard:(Card *)card onButton:(UIButton *)button {
    //abstract
}

- (void)updateUI {
    for (int i = 0; i < self.cardButtons.count; i++) {
        Card *card = [self.game cardAtIndex:i];
        UIButton *button = self.cardButtons[i];
        [self drawCard:card onButton:button];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.statusLabel.text = self.game.lastStatus;
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self resetGame];
    [self updateUI];
}

- (NSUInteger)cardCount {
    return self.cardButtons.count;
}

@end
