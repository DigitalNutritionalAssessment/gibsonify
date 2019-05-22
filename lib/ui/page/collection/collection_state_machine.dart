import 'package:flutter/material.dart';

import 'package:flutter_uikit/model/consumption_data.dart';
import 'package:flutter_uikit/model/food_item.dart';

import 'package:flutter_uikit/database/icrisat_database.dart';

import 'package:flutter_uikit/ui/page/collection/collection_page_common_widgets.dart';

import 'package:flutter_uikit/ui/page/collection/collection_info_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_first_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_second_page.dart';
import 'package:flutter_uikit/ui/page/collection/collection_final_report.dart';

import 'package:flutter_uikit/ui/page/collection/recipes_viewer.dart';





enum PageState {
  INTERVIEW,
  FIRST_PASS,
  SECOND_PASS,
  THIRD_PASS,
  FOURTH_PASS,
}

class CollectionStateMachine extends StatefulWidget {

  final PageState initialPageState;
  final ConsumptionData consumptionData;

  const CollectionStateMachine({
    this.initialPageState,
    this.consumptionData,
});

  @override
  _CollectionStateMachineState createState() => _CollectionStateMachineState();
}

class _CollectionStateMachineState extends State<CollectionStateMachine> {

  ConsumptionData consumptionData;

  PageState _currentPageState;

  Map<String,FoodItem> recipeMap;

  Map<String,int> _fctMap;

  static const Map<PageState, String> PageStateBottomBarMap = {
    PageState.INTERVIEW: "Interview Information",
    PageState.FIRST_PASS: "First Pass",
    PageState.SECOND_PASS: "Second Pass",
    PageState.THIRD_PASS: "Third Pass",
    PageState.FOURTH_PASS: "Fourth Pass",
  };

  VoidCallback switchToNewPageState(PageState newPageState){
    setState(() { _currentPageState = newPageState; });
    return null;
  }

  @override
  void initState() {
    consumptionData = ConsumptionData();
    _currentPageState = PageState.INTERVIEW;
    getRecipeDataAndFctMap();
    super.initState();
  }

  // Allow us to correctly parse arguments that were passed from NamedRoutes
  @override void didChangeDependencies() {
    final Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args?.containsKey('consumptionData')?? false) if (args["consumptionData"] != null) consumptionData = args["consumptionData"];
    if (args?.containsKey('initialPageState')?? false) if (args["initialPageState"] != null) _currentPageState = args["initialPageState"];
    super.didChangeDependencies();
  }

  Future getRecipeDataAndFctMap() async{
    var tmpRecipeDataMap = await IcrisatDB().getRecipeInformation();
    var tmpFctMap = await IcrisatDB().mapDescriptionToFCTCode();
    setState(() {
      recipeMap = tmpRecipeDataMap;
      _fctMap = tmpFctMap;
    });
  }


  @override
  Widget build(BuildContext context) {

    Map<PageState, dynamic> PageStateWidgetMap = {
      PageState.INTERVIEW: InfoDataCard(
          navigatePageState: (){switchToNewPageState(PageState.FIRST_PASS);},
          updatePageState:(interviewData)=> {consumptionData.interviewData = interviewData},
          initialInterviewData: consumptionData.interviewData,
        ),
      PageState.FIRST_PASS: FoodItemList(
        navigatePageState: (){ switchToNewPageState(PageState.SECOND_PASS);},
        updatePageState: (foodItemsList){ consumptionData.listOfFoods = foodItemsList;},
        initialFoodList: consumptionData.listOfFoods,
        recipeMap: recipeMap,
      ),
      PageState.SECOND_PASS: FoodItemList2(
        navigatePageState: (){ switchToNewPageState(PageState.THIRD_PASS);},
        updatePageState: (foodItemsList){ consumptionData.listOfFoods = foodItemsList;},
        initialFoodList: consumptionData.listOfFoods,
      ),
      PageState.THIRD_PASS: RecipeItemList(
        navigatePageStateBack: (){ switchToNewPageState(PageState.SECOND_PASS);},
        navigatePageStateForward: (){ switchToNewPageState(PageState.FOURTH_PASS);},
        updatePageState: (foodItemsList){ consumptionData.listOfFoods = foodItemsList;},
        initialFoodList: consumptionData.listOfFoods,
        fctMap: _fctMap,
      ),
      PageState.FOURTH_PASS: FinalReportCard(
        navigatePageStateBackToInfo: (){ switchToNewPageState(PageState.INTERVIEW);},
        navigatePageStateSubmit: (){Navigator.pop(context);},
        updatePageState: (consumptionData){consumptionData = consumptionData;},
        consumptionData: consumptionData,
      ),
    };


    return new Scaffold(
      appBar: appBar(title: "Collecting New Data",
          bottomBarTitle: PageStateBottomBarMap[_currentPageState]),
      body: new ConsumptionDataInheritedWidget(
        consumptionData: consumptionData,
        child: PageStateWidgetMap[_currentPageState],
      ),
      drawer: CollectionCommonDrawer(
        goToPageStateInfo: ()=> switchToNewPageState(PageState.INTERVIEW),
        goToPageStateFirstPage: ()=>switchToNewPageState(PageState.FIRST_PASS),
        goToPageStateSecondPage: ()=>switchToNewPageState(PageState.SECOND_PASS),
        goToPageStateThirdPage: ()=>switchToNewPageState(PageState.THIRD_PASS),
        goToPageStateFourthPage: ()=>switchToNewPageState(PageState.FOURTH_PASS),
      ),
    );
  }
}
