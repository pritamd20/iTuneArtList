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
    
    [self searchWithKeyWord:searchString];
    
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
    return [self.parsedResultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    ArtworkModel * artworkObject = [self.parsedResultArray objectAtIndex:indexPath.row];
    cell.imageView.frame = CGRectMake(0,0,32,32);
    cell.imageView.image = [UIImage imageNamed:@"paceholder.png"];

    
    //////
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0,0,50,50);
    [cell addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        //This is what you will load lazily
        // NSString *u=[NSString stringWithContentsOfFile:artworkObject.artworkUrl encoding:NSUTF8StringEncoding error:nil];
        NSURL *imageURL=[NSURL URLWithString:artworkObject.artworkUrl];
        NSData *image=[NSData dataWithContentsOfURL:imageURL];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image=[UIImage imageWithData:image];
            [cell setNeedsLayout];
            [indicator stopAnimating];
            
        });
    });
    
    /////
    
    cell.textLabel.text = artworkObject.trackName;
    cell.detailTextLabel.text = artworkObject.artistName;
    return cell;

    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    [self.searchBar resignFirstResponder];
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setArtworkObject:[self.parsedResultArray objectAtIndex:indexPath.row]];
    }
}




#pragma mark - Server Call

- (void)searchWithKeyWord:(NSString *)keyword{
    
    NSLog(@"key :%@",keyword);
    
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@",keyword];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:urlString]
                        ];
        NSDictionary* json = nil;
        if (data) {
            json = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:kNilOptions
                    error:nil];
            NSLog(@"json : %@",json);
            NSLog(@"%@", [NSThread currentThread]);
            NSArray *result = [json objectForKey:@"results"];
            self.parsedResultArray = [[NSMutableArray alloc]init];
            
            for (NSDictionary *artworkDic in result) {
                [artworkDic objectForKey:@""];
                
                ArtworkModel *artworkObj = [[ArtworkModel alloc]initWithTrackName:[artworkDic objectForKey:@"trackName"] albumName:[artworkDic objectForKey:@"collectionCensoredName"] artworkUrl:[artworkDic objectForKey:@"artworkUrl100"] artistName:[artworkDic objectForKey:@"artistName"] price:[[artworkDic objectForKey:@"trackPrice"] stringValue] releaseDate:[artworkDic objectForKey:@"releaseDate"] currency:[artworkDic objectForKey:@"currency"]];
                
                NSLog(@"Name :%@", artworkObj.trackName);
                [self.parsedResultArray addObject:artworkObj];
            }
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"main");
            NSLog(@"%@", [NSThread currentThread]);
            [self.tableView reloadData];
            
        });
        
    });
    
}




@end
