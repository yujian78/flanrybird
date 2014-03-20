//
//  flanrybirdMyScene.m
//  Flanry Bird
//
//  Created by Pengsheng Guo on 16/03/14.
//  Copyright (c) 2014年 Pengsheng Guo. All rights reserved.
//

#import "flanrybirdMyScene.h"
#import "welcome.h"
#import "fail.h"

@implementation flanrybirdMyScene

-(id)initWithSize:(CGSize)size andPoint:(float)angle{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        no_label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        no_label.text = @"-1";
        no_label.fontSize = 40;
        no_label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
        
        bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg_update"];
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        bg.xScale = 0.5;
        bg.yScale = 0.5;
        
        plane = [SKSpriteNode spriteNodeWithImageNamed:@"Bird"];
        plane.position = CGPointMake(CGRectGetMidX(self.frame) - 60, CGRectGetMidY(self.frame) + 5*sinf(angle));
        plane.xScale = 0.5;
        plane.yScale = 0.5;
        
        ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground"];
        ground.position = CGPointMake(CGRectGetMinX(self.frame), 30);
        
        radNo1 = arc4random()%200;
        //NSLog(@"%d", radNo1);
        pipe1_up = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe1_up.position = CGPointMake(CGRectGetMaxX(self.frame)+125, CGRectGetMaxY(self.frame)+(radNo1));
        
        radNo2 = arc4random()%200;
        //NSLog(@"%d", radNo2);
        pipe2_up = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe2_up.position = CGPointMake(CGRectGetMaxX(self.frame)+325, CGRectGetMaxY(self.frame)+(radNo2));
        
        radNo3 = arc4random()%200;
        //NSLog(@"%d", radNo3);
        pipe3_up = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe3_up.position = CGPointMake(CGRectGetMaxX(self.frame)+525, CGRectGetMaxY(self.frame)+(radNo3));
        
        //NSLog(@"%d", radNo1);
        pipe1_down = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe1_down.position = CGPointMake(CGRectGetMaxX(self.frame)+125, CGRectGetMinY(pipe1_up.frame)-360);
        
        //NSLog(@"%d", radNo2);
        pipe2_down = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe2_down.position = CGPointMake(CGRectGetMaxX(self.frame)+325, CGRectGetMinY(pipe2_up.frame)-360);
        
        //NSLog(@"%d", radNo3);
        pipe3_down = [SKSpriteNode spriteNodeWithImageNamed:@"pipe"];
        pipe3_down.position = CGPointMake(CGRectGetMaxX(self.frame)+525, CGRectGetMinY(pipe3_up.frame)-360);
        
        currentY = plane.position.y;
        changeY = currentY + 45;
        slowdown = 0;
        speedup = 0;
        isGoingUp = YES;
        
        angleup = 0;
        angledown = 0;
        angledownspeedup = 0;

        
        [self addChild:bg];
        [self addChild:pipe1_up];
        [self addChild:pipe2_up];
        [self addChild:pipe3_up];
        [self addChild:pipe1_down];
        [self addChild:pipe2_down];
        [self addChild:pipe3_down];
        [self addChild:ground];
        [self addChild:plane];

        [self addChild:no_label];
        
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    currentY = plane.position.y;
    changeY = currentY + 45;
    slowdown = 0;
    speedup = 0;
    isGoingUp = YES;
    
    angleup = 0;
    angledown = 0;
    angledownspeedup = 0;
    
}

-(BOOL)is_up_collide_left
{
    static SKSpriteNode* pipe;
    int l1 = CGRectGetMaxX(pipe1_up.frame) - CGRectGetMinX(plane.frame);
    int l2 = CGRectGetMaxX(pipe2_up.frame) - CGRectGetMinX(plane.frame);
    int l3 = CGRectGetMaxX(pipe3_up.frame) - CGRectGetMinX(plane.frame);
    if ((l1>0 && l1<l2) || (l1>0 && l3<0)) {
        pipe = pipe1_up;
    }
    else if ((l2>0 && l2<l3) || (l2>0 && l1<0)) {
        pipe = pipe2_up;
    }
    
    else if ((l3>0 && l3<l1) || (l3>0 && l2<0)){
        pipe = pipe3_up;
    }
    
    BOOL result = YES;
    result = result && (CGRectGetMaxX(plane.frame) - CGRectGetMinX(pipe.frame) > -1);
    result = result && (CGRectGetMaxY(plane.frame) - CGRectGetMinY(pipe.frame) > 0);
    result = result && (CGRectGetMinX(plane.frame) < CGRectGetMaxX(pipe.frame));
    return result;
}

-(BOOL)is_up_collide_up
{
    static SKSpriteNode* pipe;
    int l1 = CGRectGetMaxX(pipe1_up.frame) - CGRectGetMaxX(plane.frame);
    int l2 = CGRectGetMaxX(pipe2_up.frame) - CGRectGetMaxX(plane.frame);
    int l3 = CGRectGetMaxX(pipe3_up.frame) - CGRectGetMaxX(plane.frame);
    if ((l1>0 && l1<l2) || (l1>0 && l3<0)) {
        pipe = pipe1_up;
    }
    else if ((l2>0 && l2<l3) || (l2>0 && l1<0)) {
        pipe = pipe2_up;
    }
    
    else if ((l3>0 && l3<l1) || (l3>0 && l2<0)){
        pipe = pipe3_up;
    }
    
    BOOL result = YES;
    result = result && (CGRectGetMaxY(plane.frame) - CGRectGetMinY(pipe.frame) > -1);
    result = result && (CGRectGetMinX(plane.frame) - CGRectGetMinX(pipe.frame) > 0);
    result = result && (CGRectGetMaxX(plane.frame) - CGRectGetMaxX(pipe.frame) < 0);
    
    return result;
}

-(BOOL)is_down_collide_left
{
    static SKSpriteNode* pipe;
    int l1 = CGRectGetMaxX(pipe1_down.frame) - CGRectGetMinX(plane.frame);
    int l2 = CGRectGetMaxX(pipe2_down.frame) - CGRectGetMinX(plane.frame);
    int l3 = CGRectGetMaxX(pipe3_down.frame) - CGRectGetMinX(plane.frame);
    if ((l1>0 && l1<l2) || (l1>0 && l3<0)) {
        pipe = pipe1_down;
    }
    else if ((l2>0 && l2<l3) || (l2>0 && l1<0)) {
        pipe = pipe2_down;
    }
    
    else if ((l3>0 && l3<l1) || (l3>0 && l2<0)){
        pipe = pipe3_down;
    }
    
    BOOL result = YES;
    result = result && (CGRectGetMaxX(plane.frame) - CGRectGetMinX(pipe.frame) > -1);
    result = result && (CGRectGetMinY(plane.frame) - CGRectGetMaxY(pipe.frame) < 0);
    result = result && (CGRectGetMinX(plane.frame) < CGRectGetMaxX(pipe.frame));
    return result;
}

-(BOOL)is_down_collide_down
{
    static SKSpriteNode* pipe;
    int l1 = CGRectGetMaxX(pipe1_down.frame) - CGRectGetMaxX(plane.frame);
    int l2 = CGRectGetMaxX(pipe2_down.frame) - CGRectGetMaxX(plane.frame);
    int l3 = CGRectGetMaxX(pipe3_down.frame) - CGRectGetMaxX(plane.frame);
    if ((l1>0 && l1<l2) || (l1>0 && l3<0)) {
        pipe = pipe1_down;
    }
    else if ((l2>0 && l2<l3) || (l2>0 && l1<0)) {
        pipe = pipe2_down;
    }
    
    else if ((l3>0 && l3<l1) || (l3>0 && l2<0)){
        pipe = pipe3_down;
    }
    
    BOOL result = YES;
    result = result && (CGRectGetMinY(plane.frame) - CGRectGetMaxY(pipe.frame) < 0);
    result = result && (CGRectGetMinX(plane.frame) - CGRectGetMinX(pipe.frame) > 0);
    result = result && (CGRectGetMaxX(plane.frame) - CGRectGetMaxX(pipe.frame) < 0);
    
    return result;
}

-(void)updateNo
{
    static SKSpriteNode *pipe;
    const SKSpriteNode *p_change = pipe;
    NSString *no_Str = no_label.text;
    int no_Int = [no_Str integerValue];
    
    int l1 = CGRectGetMaxX(pipe1_down.frame) - CGRectGetMaxX(plane.frame);
    int l2 = CGRectGetMaxX(pipe2_down.frame) - CGRectGetMaxX(plane.frame);
    int l3 = CGRectGetMaxX(pipe3_down.frame) - CGRectGetMaxX(plane.frame);
    if ((l1>0 && l1<l2) || (l1>0 && l3<0)) {
        pipe = pipe1_down;
    }
    else if ((l2>0 && l2<l3) || (l2>0 && l1<0)) {
        pipe = pipe2_down;
    }
    
    else if ((l3>0 && l3<l1) || (l3>0 && l2<0)) {
        pipe = pipe3_down;
    }
    
    if(p_change != pipe){
        no_Int += 1;
        no_label.text = [NSString stringWithFormat:@"%d", no_Int];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateNo];
    
    ground.position =CGPointMake(ground.position.x-2, ground.position.y);
    
    pipe1_up.position = CGPointMake(pipe1_up.position.x-2, pipe1_up.position.y);
    pipe2_up.position =CGPointMake(pipe2_up.position.x-2, pipe2_up.position.y);
    pipe3_up.position =CGPointMake(pipe3_up.position.x-2, pipe3_up.position.y);
    
    pipe1_down.position = CGPointMake(pipe1_down.position.x-2, pipe1_down.position.y);
    pipe2_down.position =CGPointMake(pipe2_down.position.x-2, pipe2_down.position.y);
    pipe3_down.position =CGPointMake(pipe3_down.position.x-2, pipe3_down.position.y);
    
    
    //NSLog(@"%f", pipe.position.x - plane.position.x);
    
    if(isGoingUp && changeY > plane.position.y && plane.position.y < CGRectGetMaxY(self.frame)){
        plane.zRotation = angleup;
        angleup += 0.015;
        if (angleup - 0.3 > -0.05) {
            angleup = 0.3;
        }
        plane.position = CGPointMake(plane.position.x, plane.position.y + 5 + slowdown);
        slowdown -= 0.28;
        
        return;
    }

    isGoingUp = NO;
    plane.zRotation = angledown;
    angledown -= (0.01 + angledownspeedup);
    angledownspeedup += 0.0015;
    if (angledown + 1.57 < 0.05) {
        angledown = -1.57;
    }
    plane.position = CGPointMake(plane.position.x, plane.position.y - 1.5 - speedup);
    speedup += 0.2;
    
    
    if ([self is_up_collide_left] || [self is_up_collide_up] || [self is_down_collide_down] || [self is_down_collide_left] || CGRectGetMinY(plane.frame) - CGRectGetMaxY(ground.frame) < 0.0005) {
        SKView *skView = (SKView *)self.view;
        SKScene *scence = [[fail alloc] initWithSize:self.frame.size andPoint:(int)[no_label.text integerValue]];
        scence.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scence];
    }
    
    if (CGRectGetMaxX(ground.frame) - CGRectGetMaxX(self.frame) < 10) {
        ground.position = CGPointMake(CGRectGetMidX(self.frame)+12, 30);
    }
    
    
    if (CGRectGetMaxX(pipe1_up.frame) < -100){
        radNo1 = arc4random()%200;
        pipe1_up.position = CGPointMake(CGRectGetMidX(pipe3_up.frame)+200, CGRectGetMaxY(self.frame)+(radNo1));
        pipe1_down.position = CGPointMake(CGRectGetMidX(pipe1_up.frame), CGRectGetMinY(pipe1_up.frame)-360);
    }
    if (CGRectGetMaxX(pipe2_up.frame) < -100){
        radNo2 = arc4random()%200;
        pipe2_up.position = CGPointMake(CGRectGetMidX(pipe1_up.frame)+200, CGRectGetMaxY(self.frame)+(radNo2));
        pipe2_down.position = CGPointMake(CGRectGetMidX(pipe2_up.frame), CGRectGetMinY(pipe2_up.frame)-360);
    }
    if (CGRectGetMaxX(pipe3_up.frame) < -100){
        radNo3 = arc4random()%200;
        pipe3_up.position = CGPointMake(CGRectGetMidX(pipe2_up.frame)+200, CGRectGetMaxY(self.frame)+(radNo3));
        pipe3_down.position = CGPointMake(CGRectGetMidX(pipe3_up.frame), CGRectGetMinY(pipe3_up.frame)-360);
    }
    

}

@end
