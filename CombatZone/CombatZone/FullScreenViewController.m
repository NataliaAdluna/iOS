//
//  FullScreenViewController.m
//  CombatZone
//
//  Created by Adluna on 16.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController ()

@end

@implementation FullScreenViewController


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTapBack= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [singleTapBack setNumberOfTapsRequired:1];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:singleTapBack];

    
    //int i = self.tmp;
    // Do any additional setup after loading the view.
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self.imgArr[self.i] options:0];
    UIImage *img = [UIImage imageWithData:decodedData];
    
    [self.image setImage:img];
    
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(oneFingerSwipeRight:)] ;
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe left
    if(self.i==[self.imgArr count]-1)
        self.i = 0;
    else
        self.i++;
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self.imgArr[self.i] options:0];
    UIImage *img = [UIImage imageWithData:decodedData];
    [self.image setImage:img];

    
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle swipe right
    if(self.i == 0)
        self.i = [self.imgArr count]-1;
    else
        self.i--;
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self.imgArr[self.i] options:0];
    UIImage *img = [UIImage imageWithData:decodedData];
    [self.image setImage:img];

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
