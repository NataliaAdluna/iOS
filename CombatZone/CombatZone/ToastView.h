//
//  ToastView.h
//  CombatZone
//
//  Created by Adluna on 17.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

@property (strong, nonatomic) UILabel *textLabel;
+ (void)showToastInParentView: (UIView *)parentView withText:(NSString *)text withDuaration:(float)duration;

@end
