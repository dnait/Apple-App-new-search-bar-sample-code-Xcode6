//
//  immuViewController.m
//  2WomenHealth
//
//  Created by Rao Xu on 1/5/15.
//  Copyright (c) 2015. All rights reserved.
// This contains the new search sample code under Xcode 6.4(Version 6.4 (6E35b)). The search sample code is very old on most websites. This file is part of my med app project. It won't work if run in Xcode individually. But I will rewrite another simple sample to explain.  Please feel free to contact me if you have any questions. 

#import "immuViewController.h"
#import "immuDetailViewController.h"
#import "Immu.h"


@interface immuViewController () {
    NSArray *immus;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation immuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize the searchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.immutableView.tableHeaderView = self.searchController.searchBar;
    
    // Initialize the immus array
    Immu *immu1 = [Immu new];
    immu1.name = @"HPV Vaccine";
    immu1.who = @"11 to 26";
    immu1.frequency=@"One series of 3 vaccines";

    Immu *immu2 = [Immu new];
    immu2.name = @"Influenza Vaccine";
    immu2.who =@"6 months and over";
    immu2.frequency = @"Every year";

    Immu *immu3 = [Immu new];
    immu3.name = @"Pneumococcal Vaccine";
    immu3.who = @"65 and over\n\n\nAny age if smoker, diabetes, cancer, or heart, lung, immune disease";
    immu3.frequency = @"Single vaccination\n\n\nSingle vaccination followed by single revaccination in 5 years";

    Immu *immu4 = [Immu new];
    immu4.name = @"Diphtheria/Tetanus/Pertussis Vaccine";
    immu4.who = @"19 to 64";
    immu4.frequency = @"Single vaccination in lieu of Diphtheria/Tetanus booster";
    
    Immu *immu5 = [Immu new];
    immu5.name = @"Diphtheria/Tetanus Vaccine";
    immu5.who = @"Up to 65\n\n\n65 and over";
    immu5.frequency = @"Every 10 years\n\n\nSingle vaccination";
    
    Immu *immu6 = [Immu new];
    immu6.name = @"Shingles Vaccine";
    immu6.who =@"60 and over";
    immu6.frequency = @"Single vaccination";

    immus = [NSArray arrayWithObjects:immu1, immu2, immu3, immu4, immu5,immu6, nil];
    self.searchResults=[[NSMutableArray alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [self.searchResults count];
    } else {
        return [immus count];
    }
}
 //Initializing tableView and display immu detail
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID=@"immuCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    //display immu detail
    Immu *immu = nil;
    if (self.searchController.active) {
        immu=[self.searchResults objectAtIndex:indexPath.row];
    } else {
        immu = [immus objectAtIndex:indexPath.row];
    }
    cell.textLabel.text=immu.name;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//updating searchResult
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchString];
    
    if (self.searchResults!= nil) {
        [self.searchResults removeAllObjects];
    }
    self.searchResults= [NSMutableArray arrayWithArray:[immus filteredArrayUsingPredicate:preicate]];
    [self.immutableView reloadData];
}

//Segue from the UITableViewCell of the tableViewController to a detailViewController.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"immusegue"]) {
        NSIndexPath *indexPath=nil;
        immuDetailViewController *destViewController = segue.destinationViewController;
        Immu *immucell=nil;
        indexPath = [self.immutableView indexPathForSelectedRow];
        immucell = [immus objectAtIndex:indexPath.row];

        destViewController.immucell= immucell;
        [self.searchController setActive:FALSE];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
