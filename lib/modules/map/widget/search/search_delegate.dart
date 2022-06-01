import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/model/map/list_room.dart';
import 'package:student_app/model/map/log_search.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:student_app/modules/map/widget/map/draw_map.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/action/map/search_log_action.dart';

import 'package:student_app/service/action/map/search_recent.dart';
import 'dart:developer' as devtools show log;

class BuildingSearchDelegate extends SearchDelegate<String> {
  List<String> searchResultsBuildings =
      ListBuildings.listBuildings.map((e) => e.name).toList();
  List<String> searchResultRooms = Rooms.rooms.map((e) => e.nameRoom).toList();
  List<String> suggestionsRecent = [];
  List<String> suggestionsNow = [];
  List<SearchLog> searchLog = SearchLogAction.actions;
  String idBuildingSelected = '';
  @override
  TextInputType? get keyboardType => super.keyboardType;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              closeSearch(context);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => closeSearch(context),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      FocusScope.of(context).unfocus();
      if (suggestionsNow.isNotEmpty) {
        String itemFirst = suggestionsNow[0];
        setState(
          () {
            idBuildingSelected = searchLog
                    .where((element) => element.name == suggestionsNow[0])
                    .first
                    .idBuilding ??
                '';
            BuildingAction.buildingSelected = ListBuildings.listBuildings
                .where((element) => element.id == idBuildingSelected)
                .first;
          },
        );
        handleWhenSearchRight(context, itemFirst);
      }
      return const Center(
        child: Text(
          'Không tìm kiếm thấy!',
          style: AppTextStyles.h2,
        ),
      );
    });
  }

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: AppTextStyles.h1.copyWith(color: Colors.black),
        ),
      );

  Future<void> closeSearch(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void handleWhenSearchRight(BuildContext context, String suggestion) async {
    FocusScope.of(context).unfocus();
    SearchRecent.searchRecent.add(suggestion);
    query = suggestion;
    showResults(context);
    closeSearch(context);
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        GoogleMapScreen
            .markers[MarkerId(BuildingAction.buildingSelected.id.toString())]
            ?.onTap
            ?.call();
      },
    );
  }

  Widget buildSuggestionsUI(
      BuildContext context, List<String> suggestions, Icon icon) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return suggestions.isEmpty
            ? buildNoSuggestions()
            : ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.greyBlur,
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: IconText(
                        icon: icon,
                        text: suggestion,
                        isBorder: false,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.subdirectory_arrow_left_sharp),
                        onPressed: () {
                          query = suggestion;
                        },
                      ),
                      onTap: () {
                        devtools.log("name building action truoc" +
                            BuildingAction.buildingSelected.name);
                        devtools.log("length buildings" +
                            ListBuildings.listBuildings.length.toString());
                        ListBuildings.mapBuildings.forEach(
                            ((key, value) => devtools.log("key map" + key)));
                        setState(() {
                          idBuildingSelected = searchLog
                                  .where(
                                      (element) => element.name == suggestion)
                                  .first
                                  .idBuilding ??
                              '';
                          devtools.log("id selected" + idBuildingSelected);
                          BuildingAction.buildingSelected =
                              ListBuildings.mapBuildings[idBuildingSelected] ??
                                  ListBuildings.listBuildings[0];

                          devtools.log(ListBuildings
                              .mapBuildings[idBuildingSelected]
                              .toString());

                          devtools.log("name building action" +
                              BuildingAction.buildingSelected.name);
                        });
                        handleWhenSearchRight(context, suggestion);
                      },
                    ),
                  );
                },
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionsRecent = SearchRecent.searchRecent.toList();
    List<String> searchResult =
        searchLog.map((element) => element.name ?? '').toList();
    suggestionsNow = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return query.isEmpty
        ? buildSuggestionsUI(
            context,
            suggestionsRecent.isEmpty ? suggestionsNow : suggestionsRecent,
            const Icon(
              Icons.query_builder_rounded,
              color: AppColors.mainColor,
            ),
          )
        : buildSuggestionsUI(
            context,
            suggestionsNow,
            const Icon(
              Icons.business_outlined,
              color: AppColors.mainColor,
            ),
          );
  }
}
