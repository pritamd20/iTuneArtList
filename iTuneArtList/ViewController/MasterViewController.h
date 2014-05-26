//
//  MasterViewController.h
//  iTuneArtList
//
//  Created by Preetham D'souza on 25/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *parsedResultArray;

@end
