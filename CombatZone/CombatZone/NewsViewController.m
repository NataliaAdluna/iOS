//
//  NewsViewController.m
//  CombatZone
//
//  Created by Adluna on 14.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@property NSMutableArray* dates;
@property NSMutableArray* news;
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation NewsViewController
@synthesize responseData = _responseData;

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
 
    self.dates = [[NSMutableArray alloc] init];
    self.news = [[NSMutableArray alloc] init];
    
    
    [self loadData];

}


- (void)loadData
{
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selectaktualnosci.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];



   /* dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
    dispatch_async(queue, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selectaktualnosci.php"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        [connection start];

        if(connection) {
            NSLog(@"Connection successful");
            
        } else {
            NSLog(@"Connection failed");
        }
        
       // NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"news"]];
        
       /* NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             email, @"Email",
                             fname, @"FirstName",
                             nil];
        NSError *error;
        NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        [request setHTTPBody:postData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed on the main thread when background task is finished
        });
    });
    
    
    [self.dates addObject:@"21.12"];
    [self.news addObject:@"wiadm 1"];
    
    [self.dates addObject:@"02.07"];
    [self.news addObject:@"wiadm 2 ktora jest bardzo dluga dlatego musia zostac zawinieta w wielu wierszach......"];*/
    
    
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
    NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"news"]];
    for(int i=0; i<[argsArray count]; i++)
    {
        NSDictionary *argsDict = [[NSDictionary alloc] initWithDictionary:[argsArray objectAtIndex:i]];
        [self.dates addObject: argsDict[@"data"]];
        [self.news addObject: argsDict[@"text"]];
        NSLog(self.dates[i]);
    }
    [self showData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)showData
{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i<[self.dates count]; i++) {
        [str appendString: self.dates[i]];
        [str appendString: @"   "];
        [str appendString: self.news[i]];
        
    }
    self.newsLabel.text = str;
    self.newsLabel.numberOfLines = 0;
    [self.newsLabel sizeToFit];
   
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
