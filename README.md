<img align="left" width="80" height="80" src="images/icon.png">


# TechTeam
TechTeam is a simple iOS application for showing employees. The employees are fetched from Teltech API for technical task #2.

# Installation
After cloing the project it is required to run pod install and run .xcworkspace.

# Tech stack
- min iOS 13
- Swift 5.3 
- Xcode 12.3
- MVVM+Rx
- UIKit/SwiftUI
- Pods:
  - RxSwift (v6.0)
  - RxCocoa (v6.0)
  
# Screens
The application screens:
- Splash
- Onboarding
- Employees
- Employee Details

## Splash Screen
When entering application, firstly a small splash screen will show. When the launching icon gets minimized, in the middle will show a bouncing circle. 
Another filling circle is inside the middle circle which is animating filling the stroke as circular shape. 
When the middle circle finished filling the cirlce, the transition animation is triggered. The transition animation expands to the whole screen and after that it starts presenting next screen.

 <img src="images/splash0.png" widht= 150 height = 300  hspace="0"/> <img src="images/splash1.png" widht= 150 height = 300  hspace="0"/> 
 <img src="images/splash2.png" widht= 150 height = 300  hspace="0"/> <img src="images/splash3.png" widht= 150 height = 300  hspace="0"/>
 
## Onboarding Screen
After splash transition finished, this screen will slide from the right to the left on the screen. Onboarding screen represents views as cards with data which is localy stored. The data represents questions/answers which can be read trought circuling the onboarding collection. Beside normal scrolling, user can navigate with bottom controlls to the next/previous card. After getting to the last card a button will show on the screen. The button enables user to enter next screen where he can see the list of employees.

 <img src="images/onboarding0.png" widht= 150 height = 300  hspace="0"/> <img src="images/onboarding1.png" widht= 150 height = 300  hspace="0"/> 

## Employees Screen
After pressing button on onboarding to explore employees list, another screen will slide in. The onboarding screen uses custom transition and it will animate from the left to the right side of screen. When the screen is focused, automatically will a fetch request start. If the data is not available because of poor internet a alert dialog will apear on the screen. Beside alert dialog, the collection will present header cell which informs user to activate pull down on the screen to hit again the fetch request. If everything goes well the screen will populate with employees. To see more details of each employee, it is required to select one cell. After selecting cell, automatically will be trigered another transition to the details screen.

 <img src="images/employee0.png" widht= 150 height = 300  hspace="0"/> <img src="images/employee3.png" widht= 150 height = 300  hspace="0"/> 
 <img src="images/employee1.png" widht= 150 height = 300  hspace="0"/> <img src="images/employee2.png" widht= 150 height = 300  hspace="0"/>
 <img src="images/employee4.png" widht= 150 height = 300  hspace="0"/>

## Employee Details Screen
This screen will show after selecting one of the employees. The transition is starting from top to bottom with spring effect. After is settles down the user can read more about of the employee with data presented on a card. To se more description about the user, a click is required on the card. When tapping, a rotating animation will be trigered and the back side of the card will be shown. To remove the card from screen it is requreid to tap outside of the card. The transition to employees screen will reverse the entering nimation of the card.

 <img src="images/details00.png" widht= 150 height = 300  hspace="0"/> <img src="images/details1.png" widht= 150 height = 300  hspace="0"/> 
 <img src="images/details2.png" widht= 150 height = 300  hspace="0"/> <img src="images/details3.png" widht= 150 height = 300  hspace="0"/> 
 <img src="images/details0.png" widht= 150 height = 300  hspace="0"/>

# Extra
## Multilanguage support 
This application supports english for its base language and croatian. The files for localization can be found inside supporting files, under localization folder. 
Aftter selecting localizable.string, it will show the two supported files (en/hr). The files havekey/values. which keys are used throught the application inside NSLocalizedString. On the next images, some key/values are shown for localization. 

 <img src="images/multilanguage0.png" widht= 150 height = 300  hspace="0"/> <img src="images/multilanguage1.png" widht= 175 height = 125  hspace="0"/> 
 <img src="images/multilanguage2.png" widht= 175 height = 125  hspace="0"/> 
 
### Testing multilanguage support
For easy testing on simluator just edit the schema of current project (it can be found on the right side of stop button). Changeing the App language to croatina will automatically set while running next time on simulator to translate application to croatian. On the images it can be seen on the onboarding screens.

<img src="images/multilanguage3.png" widht= 150 height = 300  hspace="0"/> <img src="images/onboarding0.png" widht= 150 height = 300  hspace="0"/> 
<img src="images/multilanguage4.png" widht= 150 height = 300  hspace="0"/> 

## Usage of SwiftUI
While manly of the app was build with UIKit, the employees description screen is construced with usage of SwiftUI. For supporting this view it was required to pack it as rootViewController inside UIHostingController.

<img src="images/details1.png" widht= 150 height = 300  hspace="0"/> 

## Unit tests
While this filed is still a bit new for me I did try it. In this testing i did test some base stuff of OnboardingViewModel and EmployeeViewModel.
On the images it is shown how to fail and how to pass on the OnboardingViewModel testing. For instance, lets take function test_onboardingListViewModelCount, it is teesting if the init of ViewModel did go good. In this testing it should be 2 but for failing I did set 4.
 
<img src="images/testing0.png" widht= 250 height = 200  hspace="0"/> <img src="images/testing1.png" widht= 250 height = 200  hspace="0"/> 

## Service for event tracking
Inside the Service folder is Analytics folder which consist of files to logg events and send to specific Analyitcs SDK's. To create EventName navigate to Events.swift and add event name which you want to monitor. For this testing i decided to put screenVist and clickEvent.

```swift
enum EventName {
    static let screenVisit = "Screen Visit"
    static let clickEvent = "Click Event"
}
```

For tracking specific features it is requred to open EventFeatures.swift. Here i defined one feature, entering onboarding screen and clicking to leave onboarding and start transition to employees screen. 

```swift
// FeatureOne
enum FeatureOneEvents {
    @Event(screenValue: "Onboarding")
    static var screen: Event

    @Event(clickValue: "FinishedWithOnboarindg")
    static var buttonClick: Event
}
```

For adding numerour Analytics SDK's and their setup we need to navigate to AnalyticsManager. For testing purpose i did setup Firebase class which would fire FirebaseAnalytics after fireing trackEvent()


```swift
// Firebase
class FirebaseEventLogger: AnalyticsEventsLoggerProtocol {
    var user: UserProfileModel?
        
    // set user properties
    func setUserProperties(user: UserProfileModel) {
        self.user = user
        
        if loggerDebugEnabled {
            print("Setup: \(self)")
        }
    }
    
    // add implementation of tracking events
    func trackEvent(event: EventProtocol) {
        guard let user = user else { return }
        
        if loggerDebugEnabled {
            print("\(self) with userID \(user.userID)")
            print("Logg event \(event.name)")
            print("Logg event parramts \(event.params)")
            print("-----")
        }
    }
}
```

For managing all SDK's setups and fireing events.

```swift
class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private var loggers: [AnalyticsEventsLoggerProtocol] = []

    // Setup all the Analytics SDK's
    func setUp() {
        let user = UserProfileModel(userID: UUID().uuidString)
        print("Analytic setup with userID \(user.userID)")

        let firebaseEventLogger = FirebaseEventLogger()
        firebaseEventLogger.setUserProperties(user: user)
        
        loggers.append(firebaseEventLogger)
    }
    
    func trackEvent(_ event: EventProtocol, params: [String: Any] = [:]) {
        loggers.forEach({ logger in
            logger.trackEvent(event: event)
        })
    }
}
```

For testing purpose, it is required to firstly init AnalyticsManager, the best situation would be at start of application. After that i did add event trigger on entering onboarding and leaveing onboarding screen. The event triggers can take extra parametars and can be empty.
       

```swift

// AppDelegate 
AnalyticsManager.shared.setUp()

// Onboarding Screen viewDidLoad
AnalyticsManager.shared.trackEvent(FeatureOneEvents.screen)

// Onboarding Screen handle click on button and leaving screen
AnalyticsManager.shared.trackEvent(FeatureOneEvents.buttonClick,
                                  params:["extraKey": "extraValue"])
```

# Logged events
On the next image the logged events are shown. From init to trigger events.
<img src="images/event_logger0.png" widht= 150 height = 300  hspace="0"/> 
<img src="images/multilanguage3.png" widht= 150 height = 300  hspace="0"/> <img src="images/onboarding0.png" widht= 150 height = 300  hspace="0"/> 
<img src="images/event_logger0.png" widht= 150 height = 300  hspace="0"/> 

