//
//  UIColor+GrayColor.m


#import <SDWebImage/SDWebImage.h>
#import "UIImage+FJFGreyImage.h"
#import "NSObject+FJFSwizzle.h"

@implementation UIImage (FJFGreyImage)

#pragma mark - Public Methods
+ (void)fjf_startGreyStyle {
    //交换方法
    NSError *error = NULL;
    [UIImage fjf_swizzleMethod:@selector(initWithData:)
                   withMethod:@selector(fjf_initWithData:)
                          error:&error];

    [UIImage fjf_swizzleMethod:@selector(initWithData:scale:)
                   withMethod:@selector(fjf_initWithData:scale:)
                          error:&error];
    
    [UIImage fjf_swizzleMethod:@selector(initWithContentsOfFile:)
                   withMethod:@selector(fjf_initWithContentsOfFile:)
                          error:&error];
    
    [UIImage fjf_swizzleClassMethod:@selector(imageNamed:)
                   withClassMethod:@selector(fjf_imageNamed:)
                             error:&error];

    [UIImage fjf_swizzleClassMethod:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)
                   withClassMethod:@selector(fjf_imageNamed:inBundle:compatibleWithTraitCollection:)
                             error:&error];
}

// 转化灰度图片
- (UIImage *)fjf_convertToGrayImage {
    return [self fjf_convertToGrayImageWithRedRate:0.3 blueRate:0.59 greenRate:0.11];
}

// 转化灰度图片
- (UIImage *)fjf_convertToGrayImageWithRedRate:(CGFloat)redRate
                                     blueRate:(CGFloat)blueRate
                                    greenRate:(CGFloat)greenRate {
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, self.size.width* self.scale, self.size.height* self.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [self CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = redRate * rgbaPixel[RED] + greenRate * rgbaPixel[GREEN] + blueRate * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}


#pragma mark - Private Methods
+ (UIImage *)fjf_imageNamed:(NSString *)name {
    UIImage *image = [self fjf_imageNamed:name];
    return [UIImage fjf_converToGrayImageWithImage:image];
}

+ (nullable UIImage *)fjf_imageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle compatibleWithTraitCollection:(nullable UITraitCollection *)traitCollection {
    UIImage *image = [self fjf_imageNamed:name inBundle:bundle compatibleWithTraitCollection:traitCollection];
    return [UIImage fjf_converToGrayImageWithImage:image];
}

- (instancetype)fjf_initWithContentsOfFile:(NSString *)path {
    UIImage *greyImage = [self fjf_initWithContentsOfFile:path];
    if (![path containsString:@"MASCTX.bundle"]) {
        greyImage = [UIImage fjf_converToGrayImageWithImage:greyImage];
    }
    return [self initWithCGImage:greyImage.CGImage];
}

- (UIImage *)fjf_initWithData:(NSData *)data {
    UIImage *greyImage = [[UIImage new] fjf_initWithData:data];
    return [self initWithCGImage:greyImage.CGImage];
}

- (UIImage *)fjf_initWithData:(NSData *)data scale:(CGFloat)scale {
    UIImage *greyImage = [[UIImage new] fjf_initWithData:data scale:scale];
    return [self initWithCGImage:greyImage.CGImage];
}

+ (UIImage *)fjf_converToGrayImageWithImage:(UIImage *)image {
    return [image fjf_convertToGrayImage];
}

+ (UIImage *)fjf_converToGrayImageWithImage:(UIImage *)image
                                   RedRate:(CGFloat)redRate
                                  blueRate:(CGFloat)blueRate
                                 greenRate:(CGFloat)greenRate {
    return [image fjf_convertToGrayImageWithRedRate:redRate blueRate:blueRate greenRate:greenRate];
}


+ (NSData *)fjf_greyImageDataWithImage:(UIImage *)image data:(NSData *)data {
    SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];
    if (imageFormat == SDImageFormatPNG) {
        data = UIImagePNGRepresentation(image);
    } else if(imageFormat == SDImageFormatJPEG) {
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    return data;
}
@end
