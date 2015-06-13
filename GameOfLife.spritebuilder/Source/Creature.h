//
//  Creature.h
//  GameOfLife
//
//  Created by Clive on 13/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property (nonatomic,assign) BOOL isAlive;
@property (nonatomic,assign) NSInteger livingNeighbours;

-(id)initCreature;

@end
