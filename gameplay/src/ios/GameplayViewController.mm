//
// Created by Benjamin Dobell on 20/10/14.
//

#import <GameKit/GameKit.h>
#import "GameplayViewController.h"
#import "GameplayView.h"
#import "PlatformiOS.h"

#define UIInterfaceOrientationEnum(x) ([x isEqualToString:@"UIInterfaceOrientationPortrait"]?UIInterfaceOrientationPortrait:                        \
                                      ([x isEqualToString:@"UIInterfaceOrientationPortraitUpsideDown"]?UIInterfaceOrientationPortraitUpsideDown:    \
                                      ([x isEqualToString:@"UIInterfaceOrientationLandscapeLeft"]?UIInterfaceOrientationLandscapeLeft:              \
                                        UIInterfaceOrientationLandscapeRight)))

@implementation GameplayViewController

- (id)init
{
    return [super init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)loadView
{
    [self setView:[[GameplayView alloc] init]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Fetch the supported orientations array
    NSArray *supportedOrientations = NULL;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        supportedOrientations = [[NSBundle mainBundle] infoDictionary][@"UISupportedInterfaceOrientations~ipad"];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        supportedOrientations = [[NSBundle mainBundle] infoDictionary][@"UISupportedInterfaceOrientations~iphone"];
    }

    if (supportedOrientations == NULL)
    {
        supportedOrientations = [[NSBundle mainBundle] infoDictionary][@"UISupportedInterfaceOrientations"];
    }

    // If no supported orientations default to v1.0 handling (landscape only)
    if (supportedOrientations == nil)
    {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    }

    for (NSString *s in supportedOrientations)
    {
        if (interfaceOrientation == UIInterfaceOrientationEnum(s))
        {
            return YES;
        }
    }

    return NO;
}

- (void)startUpdating
{
    [[self gameplayView] startUpdating];
}

- (void)stopUpdating
{
    [[self gameplayView] stopUpdating];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (GameplayView*)gameplayView
{
    return (GameplayView*)[self view];
}

@end
