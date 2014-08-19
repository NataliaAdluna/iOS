//
//  YoutubeViewController.h
//  CombatZone
//
//  Created by Adluna on 17.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeCell.h"
#import "ToastView.h"
@interface YoutubeViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *CV;


@end
