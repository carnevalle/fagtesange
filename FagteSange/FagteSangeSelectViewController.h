//
//  FagteSangeSelectViewController.h
//  FagteSange
//
//  Created by Troels.Johnsen on 06/01/13.
//  Copyright (c) 2013 Noget Med Kode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface FagteSangeSelectViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;

@end
