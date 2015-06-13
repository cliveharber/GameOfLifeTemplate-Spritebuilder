//
//  Grid.h
//  GameOfLife
//
//  Created by Clive on 13/06/2015.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic,assign) int totalAlive;
@property (nonatomic,assign) int generation;

-(void)evolveStep;
-(void)countNeighbours;
-(void)updateCreatures;

@end
