//
//  InfoViewController.m
//  RottenTomatoes
//
//  Created by Sneha  Datla on 9/17/14.
//  Copyright (c) 2014 Sneha  Datla. All rights reserved.
//

#import "InfoViewController.h"
#import "MoviesViewController.h"
#import "UIImageView+AFNetworking.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollableView;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRating;


@end

@implementation InfoViewController

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
    
    [self.scrollableView setScrollEnabled:YES];
    self.scrollableView.contentSize = CGSizeMake(0, 400);
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1.0];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0 alpha:1.0]}];
   // self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.7f;
    self.navigationController.navigationBar.translucent = YES;
    //(*UIView)[[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:0.7f];
    self.navigationItem.title = self.movieObj[@"title"];
          self.titleLabel.text = self.movieObj[@"title"];
     self.synopsisLabel.text = self.movieObj[@"synopsis"];
    self.mpaaRating.text = self.movieObj[@"mpaa_rating"];
    //self.runtime.text = self.movieObj[@"runtime"];
    //self.runtime.text = self.movieObj[@"runtime"];
        NSString *posterUrl = [[self.movieObj valueForKeyPath:@"posters.thumbnail"] stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_org.jpg"];
    
    [self.posterImage setImageWithURL:[NSURL URLWithString:posterUrl]];
    
   // self.synopsisLabel.text = movie
    // Do any additional setup after loading the view from its nib.
}


    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
