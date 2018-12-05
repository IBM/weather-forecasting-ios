[![](https://img.shields.io/badge/IBM%20Cloud-powered-blue.svg)](https://bluemix.net)
[![Platform](https://img.shields.io/badge/platform-ios_swift-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)

# Create an iOS weather application in Swift

> We have a similar pattern available for [Android](https://github.com/IBM/weather-forecasting-android), as well!

In this code pattern, you will create an iOS weather forecasting app using Apple Maps and the Weather Company Data service. Use this service to consume current conditions or hourly, daily, and intraday forecasts based on Apple Maps geolocation coordinations of your user's device. Use this pattern to solve real business problems where weather has a significant impact on the outcome.

When you have completed this code pattern, you will understand how to:

* Provision and integrate the Weather Company Data service
* Use Geolocation information integrated with Apple Maps
* Connect to additional IBM Cloud services

![](README_Images/architecture.png)

## Steps

> As an alternative to steps 1 & 2 below, you can [create this project as a starter kit on IBM Cloud](https://console.bluemix.net/developer/appledevelopment/create-app?defaultDeploymentToolchain=&defaultLanguage=IOS_SWIFT&env_id=ibm%3Ayp%3Aus-south&navMode=starterkits&starterKit=90b94b71-caf1-3e2b-a48e-bad99759b189), which automatically provisions required services, and injects service credentials into a custom fork of this pattern. Then, you can skip directly to step 4 below.

1. [Install developer tools](#1-install-developer-tools)
1. [Install dependencies](#2-install-dependencies)
1. [Create a Weather service instance](#3-create-a-weather-service-instance)
1. [Run](#4-run)

### 1. Install developer tools

Ensure you have the [required developer tools installed from Apple](https://developer.apple.com/download/):

* iOS 8.0+
* Xcode 8.0
* Swift 3.0

### 2. Install dependencies

This starter uses the IBM Cloud Mobile services SDKs to use the functionality of the Mobile Analytics, Push Notifications, and Weather services.

The IBM Cloud Mobile services SDK uses [CocoaPods](https://cocoapods.org/) to manage and configure dependencies. To use our latest SDKs, you need version 1.1.0.rc.2.

Install CocoaPods using the following command:

```bash
$ sudo gem install cocoapods --pre
```

If the CocoaPods repository is not configured, run the following command:

```bash
$ pod setup
```

For this starter, a pre-configured `Podfile` is included in this repository. To download and install the required dependencies, run the following command in this repository:

```bash
$ pod install
```
Open the Xcode workspace: `{APP_Name}.xcworkspace`. Continue to open the `.xcworkspace` file as it contains all the dependencies and configurations.

If you run into any issues during the pod install, it is recommended to run a pod update by using the following commands:

```bash
$ pod update
$ pod install
```

### 3. Create a Weather service instance

Use the [IBM Cloud Catalog](https://console.ng.bluemix.net/catalog/) and create a [Weather Company Data](https://console.ng.bluemix.net/catalog/services/weather-company-data/) service instance.

A `WeatherCredentials.plist` configuration file is included in the Xcode project that includes credential configurations for Weather service. Find the credentials for your `WeatherCredentials.plist` file by clicking the **Service Credentials** button:

![Service credentials](README_Images/service-credentials.png)

### 4. Run

Click **Product > Run** to start the app in Xcode.

![Weather App Screenshot](README_Images/weather.png)

The application allows you determine the forecast of any location using your Weather instance on IBM Cloud. Long click to view the forecast.

## License

[Apache 2.0](LICENSE)
