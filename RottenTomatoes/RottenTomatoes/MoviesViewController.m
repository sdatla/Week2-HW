//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Sneha  Datla on 9/16/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "InfoViewController.h"
#import "MBProgressHUD.h"


@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    
    [self.tableView addSubview:self.hud];
   self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setTintColor:[UIColor colorWithRed:0.00 green:0.60 blue:0.00 alpha:1.00]];
    
    [self.tableView addSubview:self.refreshControl];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
   self.navigationItem.title = @"Movies";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    // Do any additional setup after loading the view from its nib.
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if(!connectionError)
        {
            [self.tableView setHidden:NO];
            [self.hud hide:YES];
            [self.errorLabel setHidden:YES];
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = object[@"movies"];
            
            [self.tableView reloadData];
           // NSLog(@"movies: %@", self.movies);
            
        }
        else{
            NSLog(@"Error connecting");
            [self.tableView setHidden:YES];
             [self.errorLabel setHidden:NO];
            
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];


    InfoViewController *vc = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    
 vc.movieObj = [self.movies objectAtIndex:indexPath.row];
           [[self navigationController] pushViewController:vc animated:YES];
  
    
 
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // NSLog(@"index path: %ld", indexPath.row);
    
    NSDictionary *movie = self.movies[indexPath.row];
    
   MovieCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

    
    cell.titleLabel.text = movie[@"title"];
    
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    
    
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    
    
    return cell;
}

- (void)refreshControlRequest
{
    NSLog(@"refreshing");
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];

}

@end
