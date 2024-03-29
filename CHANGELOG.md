## 1.4.0 (2023-02-21)

### Feat

- **households**: handle ID clash on create (#72)
- add basic Survey structure and linking (#62)
- **household**: tabbed UI for household and respondent (#75)
- **collection**: require survey ID
- **collection**: add survey input to sensitisation screen
- **gibsonify_api**: add survey ID to Gibson Form model
- **surveys**: handle clash on create
- **survey**: handle import clash
- **models**: make surveyId unique
- **survey**: add import instructions
- **survey**: import survey from QR
- **survey**: export as QR
- **surveys**: view survey screen
- **surveys**: create functionality
- **app**: add Surveys screen to main tabs
- view and delete survey functionality
- **repository**: surveys CRUD
- **models**: new Survey model

### Fix

- **household**: rebuild view fields on edit (#74)
- **households**: cancel subscription on bloc close (#73)
- **households**: cancel subscription on bloc close

## 1.3.0 (2023-02-07)

### Feat

- **respondent**: anthropometric data collection (#58)
- **anthropometrics**: non zero positive value validation
- **respondent**: view anthropometrics
- **respondent**: delete anthropometrics
- **respondent**: create anthropometrics
- **models**: add Anthropometrics
- new data structure and database storage (#57)
- add recipes help page
- add collections help page
- standardize collection duplication and deletion
- **recipe**: add dynamic measurements to ingredient form
- **recipe**: add dynamic measurements to details screen
- **collection**: clear measurement unit and value after method change
- add preliminary dynamic measurements
- **collection**: combine fourth pass preparation method fields
- standardize ingredient and cooking state icons
- add custom preparation method of food items
- add dynamic dropdown search sizing
- **recipe**: add dynamic dropdown sizing
- **collection**: add dynamic dropdown sizing
- implement recipe and collection feedback
- **recipe**: add custom cooking state field
- **recipe**: add helper text for saved recipes
- **recipe**: restrict saving if measurements are not filled
- **gibsonify_api**: add new measurement checks
- **recipe**: finalise hide ingredients and measurements feature
- **recipe**: add toggle to hide ingredients
- **recipe**: add toggle to hide measurements
- **recipe**: restrict probe editting when accessing via collection
- **recipe**: add recipe duplication feat, use modal sheet instead of slidable for deletion
- **recipe**: add ingredient duplication feature
- **recipe**: restrict ingredient deletion when recipe is saved
- **recipe**: add feature to restrict input if recipe is saved
- **recipe**: add new modified recipe implementation
- **recipe**: add recipe duplication
- **recipe**: add ingredients as identifier for recipes

### Fix

- **anthropometrics**: record date only, no time
- **collection**: change to id based food item indexing
- **recipe**: custom cooking state error text condition
- **recipe**: fix render overflow error for ingredient page
- **recipe**: update modified recipe listtile
- **recipe**: update food description field view
- **recipe**: dropdownsearch api change after version bump
- **collection**: dropdownsearch api change after version bump
- remove error text for comments field
- **recipe**: restrict item deletion for standard recipes
- **recipe**: remove old modified recipe logic and fix saved recipe/ingredient logic

### Refactor

- **recipe**: disuse deprecated shareFiles
- **gibsonify_api**: remove old list of measurement units
- make measurement attributes identifiers shorter
- **collection**: pass only food item ids in events
- **collection**: use build context synchronously
- **settings**: remove deprecated launch in favor of launchurl
- **home**: change homepagestate to public
- **collection**: use const for constant constructor
- **collection**: change print call to exception raise
- add new viewedFromCollection parameter for code readability
- remove unnecessary argument for context popping
- rename edit probe page
- **recipe**: move showIngredients and showMeasurements to recipe bloc state
- **recipe**: rename modified recipe function for clarity
- **recipe**: handle unnamed ingredients
- **recipe**: handle unnamed recipes and probes
- **recipe**: remove dialog ingredient deletion
- **recipe**: remove ability to create standard recipe via collection
- **recipe**: remove slidable usage from recipes screen
- **recipe**: refactor error conditions using utils function
- **recipe**: set probe screen as default page for standard recipes
- change name of food item description field to comments

## 1.2.0 (2022-04-18)

### Feat

- add export of collections and recipes
- add recipe sharing functionality
- add preliminary recipe export
- add collection feature requests
- implement data saving to downloads folder
- add preliminary collection export
- **gibsonify_api**: add csv conversion for gibsons forms
- **gibsonify_api**: add string representations
- add read-only mode to collection
- add second visit reason field
- add second interview visit date field
- add interview finished in one visit field
- improve collection status and outcome view
- **collection**: add finish confirmation dialog
- enable collection duplication
- **collection**: add finished and unfinished text
- implement login screen and info
- **login**: integrate employee number logic to collections
- **login**: add employee number field to gibsons form model
- **login**: add verification of login fields for submission
- **login**: add employee number field logic to import
- **login**: add employee number to recipe model
- **login**: add employee number field to recipe csvs
- add collection completed functionality
- validate sensitization before moving on
- **login**: add login button on settings page
- **login**: add gibsonify logo to login screen
- **login**: format login page
- **login**: add MVP login page
- **login**: add local storage logic for login
- **login**: add login bloc
- **login**: add login model
- **recipe**: implement feedback on features
- **recipe**: add logic for replacing old recipes with new ones
- **recipe**: add logic to modify date upon recipe modification
- **recipe**: add date field for recipe list version control
- **collection**: change interview outcome to dropdownsearch
- **collection**: change picture chart input to dropdownsearch
- **collection**: change to dropdownsearch in preparation method
- **collection**: change to dropdownsearch in food source
- **collection**: change to dropdownsearch in time period
- **collection**: change to dropdownsearch in recall day
- **collection**: change food ingredients wording
- **collection**: change fourth pass snackbar text
- rename food description to food ingredients
- **collection**: set dropdown heights for measurements
- **collection**: reverse measurement unit and value order
- **collection**: add check boxes to fourth pass items
- **collection**: add number keyboard for measurement value
- **recipe**: add prompts to notiy user on recipe import status
- **recipe**: handle duplicate recipe imports
- **recipe**: implement basic recipe import
- add settings help page with app information
- **settings**: add source code link to settings help page
- **settings**: show copyright in settings help page
- add settings help page with app version
- update and simplify settings screen
- update item deletion
- add delete dialog to fourth pass
- simplify slidable background red color
- add long-press-to-delete option to third pass
- add delete dialog to third pass
- add long-press-to-delete option to first pass
- add delete dialog to first pass
- add long-press-to-delete recipe option
- standardize delete dialogs
- add long-press-to-delete collection option
- change collection form fields to tiles
- add deletion dialog to collections screen
- reverse slide to delete direction
- trim ingredient list and add generating script
- add script for generating ingredient list

### Fix

- **recipe**: add EOL detection setting for csv import
- **gibsonify_api**: export recipe type according to template
- measurement export format ordering
- use single snack bar upon saving data
- correct export data tab to include import
- gibsons forms csv header whitespace
- **gibsonify_api**: change completed fields to finished
- **collection**: typo in finish page
- **collection**: keyboard covers bottom text input fields
- **collection**: change to unfinished upon duplication
- **recipe**: fix ingredient measurement field bug in recipe import
- **recipe**: fix date fields in import csv
- **recipe**: fix measurement field bug in recipe import
- **collection**: fourth pass validation and order
- **login**: use pushReplacementNamed instead of pushNamed for login page
- **login**: fix login page navigation
- **gibsonify_api**: update time period validator
- **collection**: measurement unit dropdown height
- **collection**: fourth pass last item confirmation
- saving using native back button or swipe
- **recipe**: override back button/swipe to save
- **collection**: override back button/swipe to save
- **collection**: temporarily remove long-press-to-delete
- fix wrongly named map key for argument passing for page navigation

### Refactor

- **gibsonify_api**: clean up helper functions structure
- **gibsonify_api**: simplify csv string updating
- improve naming of local saving of data
- move csv convertor functions to api
- remove deprecated functionality from blocs
- move data file export to standalone bloc
- **collection**: remove null check from second pass
- simplify recipe field names
- rename sync screen to import export
- rename collection completed to finished
- change comments to nullable string
- make interview outcome not completed reason nullable
- change interview outcome to nullable string
- change interview end time to nullable string
- make picture chart not collected reason nullable
- change picturechartcollected to nullable string
- improve sensitization validators readability
- change geolocation to nullable string
- change interview start time to nullable string
- change recall day to nullable string
- change sensitization and interview dates to nullable strings
- change respondent tel number to nullable string
- change respondent name to nullable string
- change household id to nullable string
- change food item preparationmethod to nullable string
- change food item description to nullable string
- change food item source to nullable string
- change food item timeperiod to nullable string
- **gibsonify_api**: change to collection literals
- **collection**: remove unused variable in third pass
- change food item name to nullable string
- **recipe**: simplify import logic
- **recipe**: reorder recipe import logic for readability
- **recipe**: rename variables for readability
- **recipe**: rearrange measurement fields and clean up error handling
- **gibsonify_api**: rename validators to plural
- **collection**: move and rename pop function
- **collection**: move food item deletion dialog class
- rename delete recipe to delete recipe dialog
- remove second ingredients source
- **recipe**: improve code readability
- **recipe**: rename bloc private functions
- **recipe**: standardise ingredients json fields
- **recipe**: remove unused dependency
- **recipe**: use named strings for page navigation
- **recipe**: refactor ingredient loading into bloc and store in state
- **recipe**: add helper functions to refactor bloc functions
- **recipe**: use maps instead of lists for arg passing

## 1.1.0 (2022-02-21)

### Fix

- email export of data
- remove html from export text
- **collection**: fourth pass card color upon confirmation
- **collection**: location status reset and snackbar usage
- **collection**: correctly display gps loading indicator
- reset selected screen when opening collections
- **recipe**: fix probe logic bug
- fix bug causing recipes to not save in device memory

### Feat

- add collection feature requests
- add data saving to file
- change export button to floating action
- change collections deletion to slidable
- **collection**: feat(collection): switch to slidable deletion in fourth pass
- **collection**: switch to slidable deletion in first pass
- **collection**: add gps status outcomes
- **recipe**: add ingredients from retentionfactors.csv
- add export subject and text
- **recipe**: add ingredients from RetentionFactors.csv
- replace flutter_mailer by share_plus
- **collection**: add fourth pass screen switching
- **collection**: add new food item button to fourth pass
- **collection**: shorten add new food button text
- **collection**: add combined measurement functionality
- **gibsonify_api**: add helper, update measurement class
- **recipe**: implement requested recipe features
- add check if interview date is valid
- **recipe**: change item deletion constraint implementation
- **recipe**: add dummy dropdownfield as placeholder while waiting for asset loading
- **recipe**: add ingredients json as asset, async logic to call ingredients file and unlisted ingredient name logic
- **recipe**: change fluttertoast implementation to native snackbar
- add interview outcome not completed reason
- add picture chart not collected reason
- add check for confirmation of food items
- add intl phone number support
- **recipe**: add food item description to probe list
- **recipe**: constrain probe option and measurement deletion and add warning message
- **collection**: remove measurement unit sizes
- **recipe**: add auto capitalisation for text fields
- **recipe**: set default probe values
- **recipe**: implement multiple ingredient measurements logic
- **recipe**: create measurements class and reimplement ingredient measurements
- **recipe**: redesign following app feedback
- **recipe**: add probe resetting when selecting recipes
- **recipe**: add visibility widgets and probe logic
- add picture chart collected field
- add geolocation using gps
- **recipe**: add probe option validation logic
- **recipe**: refactor probes as class and add dropdown list
- **collection**: add delete button to fourth pass
- **collection**: add standard cup sizes
- **collection**: separate grams and millilitres units
- restrict measurement value to max 4 digits
- remove not applicable food source option
- **collection**: restrict sensitization dates to past
- restrict household id length
- **recipe**: add standard recipe checks and recipe saving
- **recipe**: implement recipe page states
- **recipe**: implement probes status check
- **recipe**: implement probes checkbox backend
- **recipe**: implement new probes page ui

### Refactor

- **collection**: correct const fields
- **collection**: change third pass card to use maps
- change collectionsscreen to stateless
- **collection**: change screen index to enum
- move screen index reset to collection bloc
- **collection**: change state screen index to final
- **collection**: move selected screen index to state
- **collection**: use measurement class
- **recipe**: rename variables to more accurate descriptions of variables
- **collection**: change fourth pass snack bar name
- **recipe**: replace Formz usage with Strings and validation
- **recipe**: remove Formz usage from recipe implementation
- rename recipe_item.dart to recipe.dart
- specify dependency versions
- **recipe**: rename files and text widgets for consistency
- **recipe**: rename recipe probes clearing function

## 1.0.0 (2022-01-30)

### Feat

- **collection**: add text to new food item button
- add app icon
- minor collection features
- add comments to collection
- add interview outcome
- add interview end time, finish collection page
- add recall day to collection and api
- add sensitization date, remove sensitization status
- change buttons and time periods display
- export saved data via email
- implement data download
- integrate data layer, collections, recipes
- integrate recipe to collection
- add local storage of recipes
- add data layer and multiple collections
- **recipe**: implement recipe types and probes
- add generated json methods for recipes list
- **recipe**: change to slidable delete buttons
- add multiple collections functionality
- add home bloc
- **gibsonify_api**: remove loadform method
- **gibsonify_repository**: remove loadform functionality
- **gibsonify_repository**: add loading multiple forms and form deletion functionality
- **gibsonify_api**: add functionality to delete a form
- **gibsonify_api**: add multiple gibsons forms saving functionality
- add manual json serialization to recipe models
- **collection**: add saving gibsons form functionality to passes
- **add-loading-and-creating-functionality-to-collections-screen**: 
- **collection**: add data layer functionality to bloc
- add bloc local storage data layer
- add manual json serialization to collection models
- **recipe**: implement recipe probes
- **recipe**: implement recipe deletion
- **recipe**: implement ingredient deletion
- **recipe**: implement UUID recipe numbers
- **recipe**: implement non-standard recipes
- **gibsonify_api**: add pretty string representation of gibsons form
- **collection**: add basic functionality of all gibsons method passes
- **collection**: make any change to a food item result in unconfirming it
- **recipe**: add preliminary recipe implementation
- **recipe**: add logic for changing recipe/ingredient status
- **recipe**: add navigation logic to enable recipe/ingredient editing
- **collection**: add fourth pass ui and underlying bloc
- **collection**: add third pass ui and underlying bloc
- add collection third pass help page and underlying navigation
- **collection**: add interview start time field, picker, and logic to sensitization
- **collection**: add bloc and ui for deleting food items
- **collection**: change second pass wording for increased clarity
- add date picker to sensitization with formatting using intl
- **collection**: add second pass ui and bloc
- add second pass help page to collection and navigation
- **collection**: add dropdown form field for choosing food time period
- add ingredient form
- add first pass help page to collection and to navigation
- **recipe**: add rudimentary recipe form
- add demo display of collection on home page
- add sensitization help page to collection with routing in navigation
- **collection**: add sensitization input demo
- add system based dark mode
- **collection**: add blocbuilders with demo display of current collection state to third and fourth passes
- **collection**: add bloc, model and update collection page and screens with demo
- **collection**: add sensitization, first, second, third, and fourth pass screens
- add sync screen
- add new pages using feature-driven structure and update navigation
- add app screens and navigation

### Fix

- recipes not saving when created from collection
- **collection**: first pass food item card typo
- **collection**: first pass food item card typo
- recipes json method bug
- pubspec confilct and merge dev branch
- duplicate key error in collections screen
- **collection**: sensitization screen bottom overflowed error
- **recipe**: fix renderflex error and bug with dropdown selection not showing
- **recipe**: fix bug with probelist keys updating too frequently
- **recipe**: fix issue with Bloc not updating for ingredient changes
- **recipe**: implement PR comments
- **recipe**: Fixed bug that blocked new recipe state managementand refactored old code
- **collection**: make dropdown items consistently display selected value
- **collection**: add missing space to sensitization help page
- **collection**: add interview date to get props method of equatable to add it to state
- correct app name to start with a capital letter
- **home_page**: change bottom navigation bar type to fixed to allow more than three items
- **collection_page**: rename appbar and body text to new collection instead of recipe

### Refactor

- **gibsonify_api**: rearrange code order for readability
- move recipe models to gibsonify api
- **gibsonify_api**: remove debugging print statements
- move collection models into repository and api
- make one class encompassing all fields of gibsons form
- **collection**: move fourth pass food card to its own file
- **collection**: move third pass food card dropdown menus to lists
- **collection**: move third pass food card to its own file
- **collection**: move second pass food card dropdown menus to lists
- **collection**: move second pass food card to its own file
- **collection**: move first pass time period items to a list
- **collection**: make a standalone file and widget for first pass food item cards
- **recipe**: rename ingredient screen to ingredient form
- **collection**: simplify household id validation check
- **collection**: change wording of sensitization date input error text
- **collection**: change controller based date text updating to key based
- **recipe**: remove unused focus/unfocus node logic
- **collection**: remove form field focus ui and logic
- **collection**: move first pass blank dropdown item to beginning
- **collection**: move sensitization screen help button to app bar
- **collection**: remove old logic related to food items
- change to feature-driven app architecture using flutter_bloc
- **collection**: remove equatable as a base class for collection and rename to gibsonsform
- **collection**: change sensitization screen form to formz inputs, add input models and demos
- **collection**: change sensitization, first_pass and second_pass screens to stateless widgets
- move app from main to separate file
- start a fresh flutter project
