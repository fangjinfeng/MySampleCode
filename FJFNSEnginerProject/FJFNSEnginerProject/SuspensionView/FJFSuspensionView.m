//
//  FJFSuspensionView.m
//  FJFNSEnginerProject
//
//  Created by macmini on 2020/11/3.
//

#import "FJFSuspensionView.h"

@implementation FJFSuspensionView

#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initilize];
    }
    return self;
}


- (void)initilize {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doMoveAction:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    self.backgroundColor = [UIColor redColor];
}


#pragma mark - Action

- (void)doMoveAction:(UIPanGestureRecognizer *)p {
    /// The position where the gesture is moving in the self.view.

    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [p locationInView:appWindow];
    
   // Limited screen range:
    // Top margin limit.
    
    panPoint.y = MAX(self.frame.size.height/2, panPoint.y);
    
    // Bottom margin limit.
    panPoint.y = MIN([UIScreen mainScreen].bounds.size.height  - self.frame.size.height/2, panPoint.y);
    
    // Left margin limit.
    panPoint.x = MAX(self.frame.size.width/2, panPoint.x);
    
    // Right margin limit.
    panPoint.x = MIN([UIScreen mainScreen].bounds.size.width - self.frame.size.width/2, panPoint.x);

    self.containerWindow.center = panPoint;
}

#pragma mark - Setter Methods
- (void)setParentView:(UIView *)parentView {
    _parentView = parentView;
    [parentView addSubview:self];
}

@end
