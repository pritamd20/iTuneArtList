//
//  DetailViewController.m
//  iTuneArtList
//
//  Created by Preetham D'souza on 25/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newArtworkObject
{
    if (_artworkObject != newArtworkObject) {
        _artworkObject = newArtworkObject;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    self.title = self.artworkObject.trackName;
    
    if (self.artworkObject.albumName == nil){
        self.albumNameLabel.text = @"(album name not avilable)";
    }
    else{
        self.albumNameLabel.text = self.artworkObject.albumName;
    }

    if (self.artworkObject.artistName == nil) {
        self.artistNameLabel.text = @"(artist name not avilable)";
    }
    else{
        self.artistNameLabel.text = self.artworkObject.artistName;
    }
    
    if (self.artworkObject.price == nil) {
        self.priceLabel.text = @"(price not avilable)";
    }
    else{
        self.priceLabel.text = [NSString stringWithFormat:@"%@ (%@)",self.artworkObject.price,self.artworkObject.currency];
    }
    
    if (self.artworkObject.releaseDate == nil) {
        self.releaseDateLabel.text = @"(release date not avilable)";
    }
    else{
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ssZZZZZ"];
        
        NSDate* date = [dateFormat dateFromString:self.artworkObject.releaseDate];
        
        
        [dateFormat setDateFormat:@"dd-MMM-yyyy"];
        NSString *stringFromDate = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
        
        
        NSLog(@"DATE %@",stringFromDate);
        
        self.releaseDateLabel.text = stringFromDate;

    }
    
    

    
    //////
    self.artworkImageView.image = [UIImage imageNamed:@"paceholder.png"];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0,0,100,100);
    [self.artworkImageView addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0);
    dispatch_async(queue, ^{
    
        NSURL *imageURL=[NSURL URLWithString:self.artworkObject.artworkUrl];
        NSData *image=[NSData dataWithContentsOfURL:imageURL];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            self.artworkImageView.image=[UIImage imageWithData:image];
            [self.artworkImageView.layer setCornerRadius:49];
            [self.artworkImageView.layer setBorderWidth:0];
            [self.artworkImageView.layer setMasksToBounds:YES];
            [indicator stopAnimating];
            
        });
    });
    
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
