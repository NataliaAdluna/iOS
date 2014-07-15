//
//  TrainingViewController.m
//  CombatZone
//
//  Created by Adluna on 15.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "TrainingViewController.h"

@interface TrainingViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation TrainingViewController
@synthesize responseData = _responseData;

- (void) back:(UIGestureRecognizer *)recognizer{
    //[self performSegueWithIdentifier:@"backFromNewsSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    UITapGestureRecognizer *singleTapBack= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [singleTapBack setNumberOfTapsRequired:1];
    [self.back setUserInteractionEnabled:YES];
    [self.back addGestureRecognizer:singleTapBack];
    
    [self loadData];
    // Do any additional setup after loading the view.
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

- (void)loadData
{
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selecttreningi.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"treningi"]];
    for(int i=0; i<[argsArray count]; i++)
    {
        NSDictionary *argsDict = [[NSDictionary alloc] initWithDictionary:[argsArray objectAtIndex:i]];
        NSString *grupa = argsDict[@"grupa"];
        NSString *dzien = argsDict[@"dzien"];
        NSString *godzina = argsDict[@"godzina"];
        
        if([grupa isEqualToString:@"Gr. 1"]){
            if([dzien isEqualToString:@"Pon"]){
                self.Gr1Pon.text = godzina;
            } else if ([dzien isEqualToString:@"Wt"]){
                self.Gr1Wt.text = godzina;
            } else if ([dzien isEqualToString:@"Sr"]){
                self.Gr1Sr.text = godzina;
            } else if ([dzien isEqualToString:@"Czw"]){
                self.Gr1Czw.text = godzina;
            } else if ([dzien isEqualToString:@"Pt"]){
                self.Gr1Pt.text = godzina;
            } else if ([dzien isEqualToString:@"Sob"]){
                self.Gr1So.text = godzina;
            } else if ([dzien isEqualToString:@"Nd"]){
                self.Gr1Nd.text = godzina;
            }
        }else if([grupa isEqualToString:@"Gr. 2"]){
            if([dzien isEqualToString:@"Pon"]){
                self.Gr2Pon.text = godzina;
            } else if ([dzien isEqualToString:@"Wt"]){
                self.Gr2Wt.text = godzina;
            } else if ([dzien isEqualToString:@"Sr"]){
                self.Gr2Sr.text = godzina;
            } else if ([dzien isEqualToString:@"Czw"]){
                self.Gr2Czw.text = godzina;
            } else if ([dzien isEqualToString:@"Pt"]){
                self.Gr2Pt.text = godzina;
            } else if ([dzien isEqualToString:@"Sob"]){
                self.Gr2So.text = godzina;
            } else if ([dzien isEqualToString:@"Nd"]){
                self.Gr2Nd.text = godzina;
            }
        }
    }
}

@end
