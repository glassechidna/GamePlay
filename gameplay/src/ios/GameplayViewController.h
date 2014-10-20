#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>

@class GameplayView;

@interface GameplayViewController : UIViewController

- (void)startUpdating;

- (void)stopUpdating;

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController;

- (GameplayView*)gameplayView;

@end
