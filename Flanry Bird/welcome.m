//
//  welcome.m
//  Flanry Bird
//
//  Created by Pengsheng Guo on 16/03/14.
//  Copyright (c) 2014年 Pengsheng Guo. All rights reserved.
//

#import "welcome.h"
#import "flanrybirdMyScene.h"

@implementation welcome
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.125 green:0.711 blue:0.766 alpha:1.0];
        
        title = [SKSpriteNode spriteNodeWithImageNamed:@"title_update"];
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 160);
        title.xScale = 0.5;
        title.yScale = 0.5;
        
        start = [SKSpriteNode spriteNodeWithImageNamed:@"start"];
        start.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 80);
        start.xScale = 0.5;
        start.yScale = 0.5;
        start.name = @"enter";
        
        bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_blur"];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.xScale = 0.5;
        bg.yScale = 0.5;
        
        plane = [SKSpriteNode spriteNodeWithImageNamed:@"Bird"];
        plane.position = CGPointMake(CGRectGetMidX(self.frame) - 60, CGRectGetMidY(self.frame)+10);
        plane.xScale = 0.5;
        plane.yScale = 0.5;
        
        ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground"];
        ground.position = CGPointMake(CGRectGetMinX(self.frame), 30);
        
        angle = 0;
        
        [self addChild:bg];
        [self addChild:ground];
        [self addChild:plane];
        [self addChild:start];
        [self addChild:title];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"enter"]) {
        start.position = CGPointMake(CGRectGetMidX(self.frame) - 5, CGRectGetMidY(self.frame) - 85);
        SKView *skView = (SKView *)self.view;
        SKScene *scence = [[flanrybirdMyScene alloc] initWithSize:self.frame.size andPoint:(float)angle];
        scence.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scence];
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    ground.position =CGPointMake(ground.position.x-2, ground.position.y);
    
    angle += 0.15;
    plane.position = CGPointMake(plane.position.x, CGRectGetMidY(self.frame) + 5*sinf(angle));

    
    if (CGRectGetMaxX(ground.frame) - CGRectGetMaxX(self.frame) < 10) {
        ground.position = CGPointMake(CGRectGetMidX(self.frame)+12, 30);
    }
}

@end
