//
//  YoutubeViewController.m
//  CombatZone
//
//  Created by Adluna on 17.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "YoutubeViewController.h"

@interface YoutubeViewController ()
@property (nonatomic, strong) NSMutableData *responseData;

@property NSMutableArray *linkiArr;
@property NSMutableArray *imgArr;
@property NSMutableArray *titleArr;

@end

@implementation YoutubeViewController
@synthesize responseData = _responseData;

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ytLink = self.linkiArr[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ytLink]];
}

- (void)back:(UIGestureRecognizer *)recognizer
{
    //[self performSegueWithIdentifier:@"backFromGallerySegue" sender:self];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.linkiArr = [[NSMutableArray alloc] init];
    self.titleArr = [[NSMutableArray alloc] init];
    self.imgArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    
    self.CV.delegate = self;
    [ToastView showToastInParentView:self.view withText:@"Proszę czekać. Trwa pobieranie danych" withDuaration:2.0];
    [self loadData];
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
    YoutubeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    //UIImage *img = [UIImage imageNamed:@"logo"];
    
    NSString *base64str = self.imgArr[indexPath.row];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64str options:0];
    UIImage *img = [UIImage imageWithData:decodedData];
    
    [cell.image setImage:img];
    [cell.text setText:self.titleArr[indexPath.row]];
    [cell.text setNumberOfLines:0];
    //cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + 100, cell.frame.size.width, cell.frame.size.height);
    return cell;
}


- (void)loadData
{
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://adluna.webd.pl/combatzone_panel/selectlinki.php"]];
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
    NSArray *argsArray = [[NSArray alloc] initWithArray:[JSON objectForKey:@"linki"]];
    for(int i=0; i<[argsArray count]; i++)
    {
        NSDictionary *argsDict = [[NSDictionary alloc] initWithDictionary:[argsArray objectAtIndex:i]];
        [self.titleArr addObject:argsDict[@"tytul"]];
        [self.linkiArr addObject:argsDict[@"link"]];
        [self.imgArr addObject:argsDict[@"img"]];
    }
    
    //[self.collectionView reloadData];
    [self.CV reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0; // This is the minimum inter item spacing, can be more
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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
