# AppPricingSDK - iOS

AppPricing SDK is an intelligent pricing optimization tool for mobile applications. It analyzes user behavior and characteristics to determine the most appropriate pricing strategy for each individual user.

By integrating this SDK, your app will receive smart recommendations for which paywall to display based on sophisticated backend analysis that categorizes users into different purchasing tiers (e.g., premium, standard, or basic pricing segments).

## Example App
There's an example app that you can explore for further integration details:

[AppPricing-iOS](https://github.com/apppricingsdk/AppPricing-iOS)

## Getting Started

### 1. Installation

AppPricingSDK-iOS only supports Swift Package Manager.

1. **Add a Swift Package File**
    - In your Xcode project, go to **File** > **Swift Packages** > **Add Package Dependency**.
1. **Enter Package Repository URL**
    - https://github.com/apppricingsdk/ApppricingSDK-iOS
1. **Select fetched package**
1. **Click on the **Next** button to proceed and choose the target, which should be using the dependency**
1. **Integrate package**


### 2. Initialize the SDK


```swift
class AppDelegate: NSObject, UIApplicationDelegate {
    private let apiKey = "YOUR_API_KEY"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppPricingInstance.initialize(
            apiKey: apiKey, // Required: Your API key from AppPricing Dashboard
            isDebug: true, // Optional: Enable debug mode for development
            errorCallback: { error in // Optional: Handle SDK Errors
                print(error.localizedDescription)
            }, logCallback: { logMessage in // Optional: Handle SDK logs
                print(logMessage)
            }
        )
        
        return true
    }```

## Support

For technical support and inquiries:

- Email: support@apppricing.com