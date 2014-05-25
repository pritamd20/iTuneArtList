//
//  MasterViewController.m
//  iTuneArtList
//
//  Created by Preetham D'souza on 25/05/14.
//  Copyright (c) 2014 my company. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ArtworkModel.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"searchBarSearchButtonClicked");
    [searchBar resignFirstResponder];
    
    NSString *searchString = [self.searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    //[self searchWithKeyWord:searchString];
    
    self.title = self.searchBar.text;
    
}


#pragma mark - Scroll View

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

       cell.textLabel.text = @"qwe";
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}




@end
