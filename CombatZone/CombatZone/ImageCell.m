//
//  ImageCell.m
//  CombatZone
//
//  Created by Adluna on 16.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "ImageCell.h"
@interface ImageCell ()
@property BOOL isLarge;
@property CGRect original;
@end

@implementation ImageCell

- (UIImageView *)internal {
	return self.image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isLarge = NO;
        [self.image setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.isLarge) [self makeSmall];
	else [self makeFull];
}*/

- (void)makeFull {
	[[self superview] bringSubviewToFront:self];
	self.isLarge = YES;
	CGRect largeFrame = [self superview].bounds;
	self.original = self.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[self setFrame:largeFrame];
	[self.internal setFrame:self.bounds];
	[UIView commitAnimations];
	
}
- (void)makeSmall {
	self.isLarge = NO;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[self setFrame:self.original];
	[self.internal setFrame:self.bounds];
	[UIView commitAnimations];
	
}




@end
