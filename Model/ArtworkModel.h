//
//  ArtworkModel.h
//  iTuneArtList
//
//  Created by Preetham D'souza on 24/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtworkModel : NSObject

@property (strong, nonatomic) NSString * trackName;

@property (strong, nonatomic) NSString * albumName;

@property (strong, nonatomic) NSString * artworkUrl;

@property (strong, nonatomic) NSString * artistName;

@property (strong, nonatomic) UIImage *  artwork;

@property (strong, nonatomic) NSString * price;

@property (strong, nonatomic) NSString * releaseDate;


- (id)initWithTrackName:(NSString *)trackName albumName:(NSString *)albumName artworkUrl:(NSString *)artworkUrl artistName:(NSString *)artistName price:(NSString *)price releaseDate:(NSString *)releaseDate;

@end