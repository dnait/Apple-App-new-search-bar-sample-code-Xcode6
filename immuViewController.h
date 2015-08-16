//
//  immuViewController.h
//  2WomenHealth
//
//  Created by Rao Xu on 1/5/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface immuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *immutableView;


@end
