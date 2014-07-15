//
//  NewsViewController.h
//  CombatZone
//
//  Created by Adluna on 14.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backButton;


@end
