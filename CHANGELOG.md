# Changelog
All notable changes to this project will be documented in this file.

## [unreleased]

### Bug Fixes

- *(collection)* Make dropdown items consistently display selected value
- *(collection)* Add missing space to sensitization help page
- *(collection)* Add interview date to get props method of equatable to add it to state
- *(collection_page)* Rename appbar and body text to new collection instead of recipe
- *(home_page)* Change bottom navigation bar type to fixed to allow more than three items
- *(recipe)* Fix renderflex error and bug with dropdown selection not showing
- *(recipe)* Fix bug with probelist keys updating too frequently
- *(recipe)* Fix issue with Bloc not updating for ingredient changes
- *(recipe)* Implement PR comments
- *(recipe)* Fixed bug that blocked new recipe state managementand refactored old code- *(No Category)* Correct app name to start with a capital letter


### Documentation

- *(LICENSE)* Update license name according to convention
- *(README)* Update development instructions
- *(README)* Update development instructions
- *(README)* Update link to Gibson's method
- *(app)* Remove commented out code
- *(changelog)* Update
- *(changelog)* Update
- *(changelog)* Update to fix merge conflict
- *(changelog)* Update
- *(changelog)* Add changes
- *(changelog)* Update readme
- *(changelog)* Update readme
- *(changelog)* Update with further readme changes
- *(changelog)* Update with fvm build and readme changes
- *(collection)* Add todo to change food item card method return values
- *(collection)* Clean up todo comments and add new ones
- *(collection)* Remove null check todo from first pass screen
- *(collection)* Remove extra validation comment todo from respondent name
- *(collection)* Add todo for deleting items confirmation in first pass
- *(collection)* Add a todo to change food item classes to private
- *(collection)* Remove commented out code from second pass screen
- *(collection)* Add todo to add a way of deleting fooditems
- *(collection)* Remove commented out code from first pass
- *(collection)* Remove implemented todo about adding first pass help screen
- *(collection)* Remove completed todos from first pass help page
- *(collection)* Remove completed todos from sensitization help page
- *(collection)* Add first pass with food items
- *(collection)* Update sensitization first pass button todo comment
- *(collection_state)* Add todo about creating more collection states
- *(home_page)* Remove old todo
- *(license)* Add copyright year and owner
- *(readme)* Add unix-like systems note again
- *(readme)* Update contributors and acknowledgments
- *(readme)* Add note about assuming a unix-like system
- *(readme)* Add minor updates
- *(readme)* Add development instructions and update authors
- *(readme)* Add note about fvm doctor and delete unnecessary command
- *(readme)* Update fvm and developement instructions
- *(readme)* Update to fvm version 2.5.1
- *(readme)* Update style in title and oneliner
- *(readme)* Update readme with new name, correct style and typos
- *(recipe)* Add todo to fix ingredients not updating in recipe screen- *(No Category)* Update readme and move dev instructions
- *(No Category)* Move development instructions from readme to a standalone file in docs
- *(No Category)* Use git-cliff for changelog generation and update changelog
- *(No Category)* Add changelog
- *(No Category)* Move user guide to docs directory


### Features

- *(collection)* Add basic functionality of all gibsons method passes
- *(collection)* Make any change to a food item result in unconfirming it
- *(collection)* Add fourth pass ui and underlying bloc
- *(collection)* Add third pass ui and underlying bloc
- *(collection)* Add interview start time field, picker, and logic to sensitization
- *(collection)* Add bloc and ui for deleting food items
- *(collection)* Change second pass wording for increased clarity
- *(collection)* Add second pass ui and bloc
- *(collection)* Add dropdown form field for choosing food time period
- *(collection)* Add sensitization input demo
- *(collection)* Add blocbuilders with demo display of current collection state to third and fourth passes
- *(collection)* Add bloc, model and update collection page and screens with demo
- *(collection)* Add sensitization, first, second, third, and fourth pass screens
- *(recipe)* Implement recipe types and probes
- *(recipe)* Change to slidable delete buttons
- *(recipe)* Implement recipe probes
- *(recipe)* Implement recipe deletion
- *(recipe)* Implement ingredient deletion
- *(recipe)* Implement UUID recipe numbers
- *(recipe)* Implement non-standard recipes
- *(recipe)* Add preliminary recipe implementation
- *(recipe)* Add logic for changing recipe/ingredient status
- *(recipe)* Add navigation logic to enable recipe/ingredient editing
- *(recipe)* Add rudimentary recipe form- *(No Category)* Add generated json methods for recipes list
- *(No Category)* Add manual json serialization to recipe models
- *(No Category)* Add collection third pass help page and underlying navigation
- *(No Category)* Add date picker to sensitization with formatting using intl
- *(No Category)* Add second pass help page to collection and navigation
- *(No Category)* Add ingredient form
- *(No Category)* Add first pass help page to collection and to navigation
- *(No Category)* Add demo display of collection on home page
- *(No Category)* Add sensitization help page to collection with routing in navigation
- *(No Category)* Add system based dark mode
- *(No Category)* Add sync screen
- *(No Category)* Add new pages using feature-driven structure and update navigation
- *(No Category)* Add app screens and navigation


### Refactor

- *(collection)* Move fourth pass food card to its own file
- *(collection)* Move third pass food card dropdown menus to lists
- *(collection)* Move third pass food card to its own file
- *(collection)* Move second pass food card dropdown menus to lists
- *(collection)* Move second pass food card to its own file
- *(collection)* Move first pass time period items to a list
- *(collection)* Make a standalone file and widget for first pass food item cards
- *(collection)* Simplify household id validation check
- *(collection)* Change wording of sensitization date input error text
- *(collection)* Change controller based date text updating to key based
- *(collection)* Remove form field focus ui and logic
- *(collection)* Move first pass blank dropdown item to beginning
- *(collection)* Move sensitization screen help button to app bar
- *(collection)* Remove old logic related to food items
- *(collection)* Remove equatable as a base class for collection and rename to gibsonsform
- *(collection)* Change sensitization screen form to formz inputs, add input models and demos
- *(collection)* Change sensitization, first_pass and second_pass screens to stateless widgets
- *(recipe)* Rename ingredient screen to ingredient form
- *(recipe)* Remove unused focus/unfocus node logic- *(No Category)* Change to feature-driven app architecture using flutter_bloc
- *(No Category)* Move app from main to separate file


### Styling

- *(collection)* Remove trailing commas in first pass food item cards

### Testing

- *(recipe)* Add standard/modified recipe implementation
- *(recipe)* Add recipes state to manage individual recipes- *(No Category)* Remove default test and add todo to add tests


### Build

- *(fvm)* Bump sdk version to 2.5.3
- *(fvm_config)* Bump fvm flutter version to 2.5.1
- *(fvm_config)* Add flutter sdk version 2.2.3
- *(gitignore)* Add note about checking pubspec.lock into version control
- *(gitignore)* Don't check in flutter_export_environment to version control
- *(gitignore)* Ignore intellij related files and folders
- *(gitignore)* Don't exclude fvm config
- *(gitignore)* Ignore fvm files
- *(pubspec)* Add dropdown_plus library to lock file
- *(pubspec)* Add uuid library
- *(pubspec)* Bump flutter_bloc and bloc_test versions
- *(pubspec)* Update dependencies and remove unnecessary ones- *(No Category)* Resolve merge conflict with dev
- *(No Category)* Resolve merge conflict with dev
- *(No Category)* Resolve changelog merge conflict with dev branch
- *(No Category)* Update flutter sdk and fvm version and instructions
- *(No Category)* Remove intellij related files and folders
- *(No Category)* Update gitignore and remove files that should not have been checked into version control


<!-- generated by git-cliff -->
