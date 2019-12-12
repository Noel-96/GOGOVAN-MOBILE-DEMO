# GOGOVAN-MOBILE-DEMO

GoGovan mobile demo is an implementaion of the gogovan mobile-code-challenge 

## List of pods used

pod 'GoogleMaps'<br />
pod 'GooglePlaces'<br/>
pod 'RxSwift', '4.2' <br />
pod 'RxCocoa', '4.2'

## swift version used 

swift 4.2

## Xcode version used 

Xcode version 10.1

## How to use

Clone the project  <br />
Go into the app delegate file and input your api key here
```
let googleApiKey = "ENTER_YOUR_API_KEY_HERE_WITH_MAPS SDK FOR IOS_AND_PLACES API_ENABLED"
```
then go ahead to run the project

## Additional information
The Google places api has a limit of 10 requests per second when on the free tier. so i increased the debounce rate on the uitextfields to 2 seconds in order reduce  the amount of times the application exceeds this limit 
