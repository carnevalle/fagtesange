//
//  FagteSangeSelectViewController.m
//  FagteSange
//
//  Created by Troels.Johnsen on 06/01/13.
//  Copyright (c) 2013 Noget Med Kode. All rights reserved.
//

#import "FagteSangeSelectViewController.h"

@interface FagteSangeSelectViewController ()

@property (nonatomic, retain) NSMutableArray *items;

@end

@implementation FagteSangeSelectViewController

@synthesize carousel;
@synthesize items;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 1000; i++)
    {
        [items addObject:[NSNumber numberWithInt:i]];
    }
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //configure carousel
    carousel.type = iCarouselTypeRotary;
    carousel.scrollSpeed = 0.4f;
    
    /*
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRecognized:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    */
    NSLog(@"Entered Menu");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.5f;
        }
        case iCarouselOptionArc:
            
            return M_PI * 0.8f;
        case iCarouselOptionOffsetMultiplier:
            
            return 0.85f;
        default:
        {
            return value;
        }
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        NSLog(@"View is nil");
        view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)] autorelease];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        NSLog(@"View is not nil");
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [[items objectAtIndex:index] stringValue];
    
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)swipeRecognized:(UISwipeGestureRecognizer *)swipe
{
    
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"Swiped left!!");
    }else if(swipe.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"Swiped right!!");
    }
}
*/
@end
