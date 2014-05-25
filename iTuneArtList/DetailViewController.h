//
//  DetailViewController.h
//  iTuneArtList
//
//  Created by Preetham D'souza on 25/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;


@end
