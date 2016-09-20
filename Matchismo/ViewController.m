//
//  ViewController.m
//  Matchismo
//
//  Created by Foster, Jake on 9/19/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UISwitch *matchCountSwitch;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) [self resetGame];
    return _game;
}

- (void)resetGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count withDeck:[self createDeck]];
    [self setMatchCountToThree:self.matchCountSwitch.isOn];
    
}

- (Deck*)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)updateUI {
    for (int i = 0; i < self.cardButtons.count; i++) {
        Card *card = [self.game cardAtIndex:i];
        UIButton *button = self.cardButtons[i];
        
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        button.enabled = !card.isMatched;
        self.matchCountSwitch.enabled = !self.game.started;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.statusLabel.text = self.game.lastStatus;
}

- (NSString *)titleForCard:(Card *)card {
    return (card.isChosen) ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self resetGame];
    [self updateUI];
}

- (void)setMatchCountToThree:(BOOL)toThree {
    if (toThree) {
        self.game.matchCount = 3;
    } else {
        self.game.matchCount = 2;
    }
}

- (IBAction)toggleMatchSwitch:(UISwitch *)sender {
    [self setMatchCountToThree:sender.isOn];
}
@end
