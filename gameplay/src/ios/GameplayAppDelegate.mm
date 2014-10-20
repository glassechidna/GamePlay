#import <CoreMotion/CoreMotion.h>
#import "GameplayViewController.h"
#import "GameplayAppDelegate.h"
#import "PlatformiOS.h"

@interface GameplayAppDelegate ()
{
    UIWindow* window;
    GameplayViewController* viewController;
    CMMotionManager* motionManager;
}

@end

@implementation GameplayAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [UIApplication sharedApplication].statusBarHidden = YES;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    motionManager = [[CMMotionManager alloc] init];

    if ([motionManager isAccelerometerAvailable])
    {
        motionManager.accelerometerUpdateInterval = 1 / 40.0;    // 40Hz
        [motionManager startAccelerometerUpdates];
    }

    if ([motionManager isGyroAvailable])
    {
        motionManager.gyroUpdateInterval = 1 / 40.0;    // 40Hz
        [motionManager startGyroUpdates];
    }

    [[PlatformManager sharedInstance] setMotionManager:motionManager];

    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    viewController = [[GameplayViewController alloc] init];
    [[PlatformManager sharedInstance] setActiveViewController:viewController];
    [window setRootViewController:viewController];
    [window makeKeyAndVisible];
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication*)application
{
    [viewController stopUpdating];
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    [viewController stopUpdating];
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    [viewController startUpdating];
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    [viewController startUpdating];
}

- (void)applicationWillTerminate:(UIApplication*)application
{
    [viewController stopUpdating];
}

- (void)dealloc
{
    [window setRootViewController:nil];
}

@end
