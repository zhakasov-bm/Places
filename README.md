# Places
Places is a simple iOS application built in Swift that allows users to save their favorite locations using the Core Data framework. The app uses MapKit and Core Location to allow users to add new locations by long-pressing on the map and entering location details.

## Features
* Changing the map type: The app allows the user to switch between different map types, including standard, satellite, and hybrid. This feature can be accessed through a segment controller, which has a blurred background.
* Navigating through marked places: The user can navigate through all marked places by simply double-clicking next to the segment controller. The title of the navigation controller changes to the name of the navigated place.
* Listing all marked places: The app allows the user to view all marked places in a TableView. After clicking on the bar button on the navigation controller, the TableView appears on a blurred map. Whenever the user clicks on a TableView cell, it hides the TableView and navigates to the selected place.
* Deleting marked places: The user can delete marked places by simply sliding to the left on the TableView and clicking the red delete button.

## Technologies Used
* Swift 5
* UIKit
* TableView
* Core Data
* MapKit
* Core Location

## Preview
https://user-images.githubusercontent.com/126884891/228464092-8235651b-c7fc-412c-8d26-dd680269cbb7.mov
