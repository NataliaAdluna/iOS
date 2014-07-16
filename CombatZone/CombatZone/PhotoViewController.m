//
//  PhotoViewController.m
//  CombatZone
//
//  Created by Adluna on 16.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "PhotoViewController.h"
#import "FullScreenViewController.h"
@interface PhotoViewController ()
@property (nonatomic, strong) NSMutableData *responseData;

@property NSMutableArray *imgArr;
@property NSIndexPath *itemSelected;
@end

@implementation PhotoViewController
@synthesize responseData = _responseData;




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"fullScreenImageSegue"])
    {
        
        // Get reference to the destination view controller
        FullScreenViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
        ImageCell *cell = (ImageCell*)[self.CV cellForItemAtIndexPath:self.itemSelected];
        vc.imgArr = self.imgArr;
        vc.i = self.itemSelected.row;
        //vc.base64 = self.imgArr[self.itemSelected.row];
        //vc.image.image = cell.image.image;
        

        
    }
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.itemSelected = indexPath;
    [self performSegueWithIdentifier:@"fullScreenImageSegue" sender:self];
}

- (void)back:(UIGestureRecognizer *)recognizer
{
    //[self performSegueWithIdentifier:@"backFromGallerySegue" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
    //UILabel *label = (UILabel*)[footerView viewWithTag:5];
    //label.text = //set text;
    UIImageView *back = (UIImageView*)[headerView viewWithTag:5];
    
    UITapGestureRecognizer *singleTapBack= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [singleTapBack setNumberOfTapsRequired:1];
    [back setUserInteractionEnabled:YES];
    [back addGestureRecognizer:singleTapBack];

    
    
    return headerView;
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
    self.imgArr = [[NSMutableArray alloc] init];
    
    //UITapGestureRecognizer *singleTapBack= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    //[singleTapBack setNumberOfTapsRequired:1];
    //[self.back setUserInteractionEnabled:YES];
    //[self.back addGestureRecognizer:singleTapBack];

    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return [self.imgArr count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    //UIImage *img = [UIImage imageNamed:@"logo"];
    
    NSString *base64str = self.imgArr[indexPath.row];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64str options:0];
    UIImage *img = [UIImage imageWithData:decodedData];
    
    [cell.image setImage:img];
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + 100, cell.frame.size.width, cell.frame.size.height);
    return cell;
}


- (void)loadData
{
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selectgaleria.php"]];
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
    NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"galeria"]];
    for(int i=0; i<[argsArray count]; i++)
    {
        NSDictionary *argsDict = [[NSDictionary alloc] initWithDictionary:[argsArray objectAtIndex:i]];
        [self.imgArr addObject:argsDict[@"foto"]];
    }
    
    [self.collectionView reloadData];
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
