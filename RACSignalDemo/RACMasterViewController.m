//
//  RACMasterViewController.m
//  RACSignalDemo
//
//  Created by Xiao ChenYu on 12/27/14.
//  Copyright (c) 2014 sumi-sumi. All rights reserved.
//

#import "RACMasterViewController.h"
#import "UISearchController+RAC.h"

@interface RACMasterViewController()

@property NSMutableArray *objects;

@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic, copy) NSArray *searchTexts;
@property(nonatomic, copy) NSArray *searchResults;
@property(nonatomic, assign, getter = isSearching) BOOL searching;

@end

@implementation RACMasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.searchTexts = @[
                         @"San Francisco",
                         @"Grand Rapids",
                         @"Chicago",
                         @"San Jose"
                         ];
    self.searchResults = @[];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;

    RAC(self, searchResults) = [self rac_liftSelector:@selector(search:) withSignalsFromArray:@[self.searchController.rac_textSignal]];
    @weakify(self);
    [self.searchController.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    RAC(self, searching) = [self.searchController rac_isActiveSignal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)search:(NSString *)searchText {
    NSMutableArray *results = [NSMutableArray array];
    if (searchText.length > 0) {
        for (NSString *text in self.searchTexts) {
            if([[text lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
                [results addObject:text];
            }
        }
    } else {
        results = [self.searchTexts copy];
    }
    return results;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isSearching) {
        return self.searchResults.count;
    } else {
        return self.searchTexts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.isSearching ? self.searchResults[indexPath.row] : self.searchTexts[indexPath.row];
    return cell;
}

@end
