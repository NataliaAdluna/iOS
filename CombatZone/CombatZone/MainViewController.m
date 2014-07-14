//
//  MainViewController.m
//  CombatZone
//
//  Created by Adluna on 14.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
- (void) navi:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w navi");
    NSString *iTunesLink = @"https://www.google.pl/maps/place/Basen+AGH/@50.06819,19.900559,17z/data=!3m1!4b1!4m2!3m1!1s0x0:0x8238af568ff8e769";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    
}

- (void) play:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w play");
    [self performSegueWithIdentifier:@"playSegue" sender:self];
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}

- (void) foto:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w foto");
    [self performSegueWithIdentifier:@"photoSegue" sender:self];
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}

- (void) news:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w news");
    [self performSegueWithIdentifier:@"newsSegue" sender:self];
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}
- (void) facebook:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w facebook");
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}
- (void) training:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w training");
    [self performSegueWithIdentifier:@"trainingSegue" sender:self];
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}
- (void) seminar:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w seminar");
    [self performSegueWithIdentifier:@"seminarSegue" sender:self];
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}
- (void) page:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w page");
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapNavi= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navi:)];
    [singleTapNavi setNumberOfTapsRequired:1];
    [self.navi setUserInteractionEnabled:YES];
    [self.navi addGestureRecognizer:singleTapNavi];
    
    UITapGestureRecognizer *singleTapPlay= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)];
    [singleTapPlay setNumberOfTapsRequired:1];
    [self.play setUserInteractionEnabled:YES];
    [self.play addGestureRecognizer:singleTapPlay];
    
    UITapGestureRecognizer *singleTapPhoto= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foto:)];
    [singleTapPhoto setNumberOfTapsRequired:1];
    [self.foto setUserInteractionEnabled:YES];
    [self.foto addGestureRecognizer:singleTapPhoto];
    
    UITapGestureRecognizer *singleTapNews= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(news:)];
    [singleTapNews setNumberOfTapsRequired:1];
    [self.news setUserInteractionEnabled:YES];
    [self.news addGestureRecognizer:singleTapNews];
    
    UITapGestureRecognizer *singleTapFacebook= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebook:)];
    [singleTapFacebook setNumberOfTapsRequired:1];
    [self.facebook setUserInteractionEnabled:YES];
    [self.facebook addGestureRecognizer:singleTapFacebook];
    
    UITapGestureRecognizer *singleTapTraining= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(training:)];
    [singleTapTraining setNumberOfTapsRequired:1];
    [self.trainings setUserInteractionEnabled:YES];
    [self.trainings addGestureRecognizer:singleTapTraining];
    
    UITapGestureRecognizer *singleTapSeminar= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seminar:)];
    [singleTapSeminar setNumberOfTapsRequired:1];
    [self.seminar setUserInteractionEnabled:YES];
    [self.seminar addGestureRecognizer:singleTapSeminar];
    
    UITapGestureRecognizer *singleTapPage= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(page:)];
    [singleTapPage setNumberOfTapsRequired:1];
    [self.page setUserInteractionEnabled:YES];
    [self.page addGestureRecognizer:singleTapPage];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
