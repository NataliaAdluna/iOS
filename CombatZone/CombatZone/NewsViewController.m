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
    [self.backButton setUserInteractionEnabled:YES];
    [self.backButton addGestureRecognizer:singleTapBack];

    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dates = [[NSMutableArray alloc] init];
    self.news = [[NSMutableArray alloc] init];
    
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.8]
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    [self loadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //NSLog([NSString stringWithFormat:@"%d", [self.dates count]]);

    return [self.dates count]+[self.news count];
   }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell;
    int i= floor(indexPath.row/2.0f);
    
    if(indexPath.row%2 == 0){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        cell.textLabel.text = self.dates[i];
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.text = self.news[i];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    //cell.frame.size.height = cell.textLabel.frame.size.height;
    
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.textLabel.frame.size.height);
    
    //cell.textLabel.text = @"abba";
    //cell.textLabel.text = indexPath.row;
    //cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
     /*UILabel *col1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
     col1.text = self.dates[indexPath.row];
     
     UILabel *col2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
     col2.text = self.news[indexPath.row];
    
     //[cell addSubview:col1];
     //[cell addSubview:col2];
     
     
     
     [cell.contentView addSubview:col1];
     [cell.contentView addSubview:col2];*/
    
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog([NSString stringWithFormat:@"wys: %f", [tableView cellForRowAtIndexPath:indexPath].textLabel.frame.size.height]);
    //return [tableView cellForRowAtIndexPath:indexPath].textLabel.frame.size.height;
    //return 50;
    
    
    
    NSString *cellText;
    int i= floor(indexPath.row/2.0f);
    if(indexPath.row%2 == 0){
        cellText = self.dates[i];
    }else{
      
        cellText = self.news[i];
    }
    
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    BOOL portraitOrientation = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
    CGSize constraintSize;
    
    if(portraitOrientation){
        CGFloat w = [[UIScreen mainScreen] bounds].size.width;
        constraintSize = CGSizeMake(w*0.8f, MAXFLOAT);
    }else{
        CGFloat h = [[UIScreen mainScreen] bounds].size.height;
        constraintSize = CGSizeMake(h*0.8f, MAXFLOAT);
    }
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
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
    [self.tableView reloadData];
    //NSMutableString *str = [NSMutableString string];
    //for (int i = 0; i<[self.dates count]; i++) {
        /*UILabel *col1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        col1.text = self.dates[i];
        
        UILabel *col2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
        col2.text = self.news[i];
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        [cell addSubview:col1];
        [cell addSubview:col2];

        

        //[cell.contentView addSubview:col1];
        //[cell.contentView addSubview:col2];

        [self.tableView addSubview:cell];*/
        
        
        //[str appendString: self.dates[i]];
        //[str appendString: @"   "];
        //[str appendString: self.news[i]];
        
    //}
    /*self.newsLabel.text = str;
    self.newsLabel.numberOfLines = 0;
    [self.newsLabel sizeToFit];*/

    
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
