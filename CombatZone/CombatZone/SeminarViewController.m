//
//  SeminarViewController.m
//  CombatZone
//
//  Created by Adluna on 15.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "SeminarViewController.h"

@interface SeminarViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end


@implementation SeminarViewController
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
    
    self.text.numberOfLines=0;
    
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
                             [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selectseminarium.php"]];
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
    NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"seminarium"]];

    NSDictionary *argsDict = [[NSDictionary alloc] initWithDictionary:[argsArray objectAtIndex:0]];
    //[self.desc addObject: argsDict[@"opis"]];
    //[self.photo addObject: argsDict[@"foto"]];
    self.text.text = argsDict[@"opis"];
    NSString *base64str = argsDict[@"foto"];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64str options:0];
    UIImage *image = [UIImage imageWithData:decodedData];
    [self.photo setImage:image];
    //Now data is decoded. You can convert them to UIImage

    
    //NSLog(self.dates[i]);

    //[self showData];
}


@end
