//
//  ProductDetailVC.h
//  DbzlMVVM
//
//  Created by Atif on 13/11/2021.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailVC : UIViewController {
}

@property (copy, nonatomic) NSString *productTitle;
@property (copy, nonatomic) NSString *productPrice;
@property (copy, nonatomic) NSString *productDate;
@property (copy, nonatomic) NSString *productImageUrl;

@property (retain, nonatomic) IBOutlet UILabel *lblProductTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblCreatedDate;
@property (retain, nonatomic) IBOutlet UIImageView *ivProductImage;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loader;

@end
NS_ASSUME_NONNULL_END
