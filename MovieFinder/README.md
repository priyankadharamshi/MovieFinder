# MovieFinder App

The main Purpose of this app is to showcase usage of Swift features - JSON parsing, custom object creation, and custom Unit Test cases for objects and UI.
The application follows MVVM architecture for separation of concerns, code readability and testability.

## Compatibility
This project is written in Swift 4.1 and requires Xcode 9.3 to build and run. The application is supported from iOS 9.0 upwards to 11.x

## Getting Started
1. Navigate to the project directory. Open MovieFinder.xcodeproj to run the project.
2. An API key must first be created to support authentication and authorization on Moviedb.org using user account
3. Navigate to MovieFinder->Network->Credential.swift and add APIKey to the corresponding parameter generated for the developer.

## Assumptions
1. Data is fetched from the movieDB endpoint URLs as provided for movie list, movie details and collections.
2. Application supports data transfer only over HTTPS protocol, for data security purposes.
3. No external/3rd party libraries are used in the application.
4. For simplicity only single page now playing list is fetched. 

## Application Design highlights
1. MVVM and separation of concerns : Separate classes for model and view to create and display movie and collections for ease of use and understanding.
2. Open/Close Principle: Extensions used extensively throughout the app for code readability and feature separation. Inheritance used for generating mock models and stubs.
3. JSON decoder - Automatic parsing of data to custom object.
4. Unit testing - TDD and Unit testing implemented extensively throughout the app.

## Testing
1. All tests are written using XCTest framework. There are no pre-requisites for testing.
2. Navigate to MovieFinderTests or MovieFinderUITests in project and run tests. No setup is required.

## Proposed Enhancements
1. Support for display of multiple page now playing list.
2. Search/filter based on various parameters ( popularity, vote count, release date, etc)
3. Unit Testing ViewControllers.
4. Better error handling.
5. More UI elements (textfields) in both Grid and Movie detail screens.
6. Network manager tests.
7. Performance improvisation by caching images for posters in a central location.

## Contact Info
dharamshi.priyanka@gmail.com



