//
//  ProductDetailVC.m
//  DbzlMVVM
//
//  Created by Atif on 13/11/2021.
//

#import "ProductDetailVC.h"

@interface ProductDetailVC ()

@end

@implementation ProductDetailVC
@synthesize lblProductTitle;
@synthesize lblProductPrice;
@synthesize lblCreatedDate;
@synthesize ivProductImage;
@synthesize loader;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Product Detail";
    [self showLoader];
    [self.lblProductTitle setText:_productTitle];
    [self.lblProductPrice setText:_productPrice];
    [self.lblCreatedDate setText:_productDate];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.productImageUrl]];
        if ( data == nil ) {
            [self hideLoader];
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoader];
            self.ivProductImage.image = [UIImage imageWithData: data];
        });
    });
}

- (void) showLoader {
    [self.loader setHidden:false];
    [self.loader startAnimating];
}

- (void) hideLoader {
    [self.loader setHidden:true];
    [self.loader stopAnimating];
}

@end
