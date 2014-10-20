#import <CoreMotion/CoreMotion.h>

@class GameplayViewController;

namespace gameplay
{

extern double getMachTimeInMilliseconds();

}

@interface PlatformManager : NSObject

@property (nonatomic, strong) GameplayViewController* activeViewController;
@property (nonatomic, strong) CMMotionManager* motionManager;

+ (PlatformManager*)sharedInstance;

@end
