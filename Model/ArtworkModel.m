//
//  ArtworkModel.m
//  iTuneArtList
//
//  Created by Preetham D'souza on 24/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import "ArtworkModel.h"

@implementation ArtworkModel



- (id)initWithTrackName:(NSString *)trackName albumName:(NSString *)albumName artworkUrl:(NSString *)artworkUrl artistName:(NSString *)artistName price:(NSString *)price releaseDate:(NSString *)releaseDate {
    
    self.trackName = trackName;
    self.albumName = albumName;
    self.artworkUrl = artworkUrl;
    self.artistName = artistName;
    self.price = price;
    self.releaseDate = releaseDate;
   
    return self;
}
@end
