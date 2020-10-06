import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/local_places/local_places_controller.dart';
import 'package:hnh/app/pages/local_places/local_places_tabs.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_local_places_repository.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LocalPlacesPage extends View {
  LocalPlacesPage({Key key}) : super(key: key);

  @override
  _LocalPlacesPageView createState() => _LocalPlacesPageView();
}

class _LocalPlacesPageView
    extends ViewState<LocalPlacesPage, LocalPlacesController> {
  _LocalPlacesPageView()
      : super(LocalPlacesController(
            DataLocalPlacesRepository(), DeviceLocationRepository()));

  @override
  Widget buildPage() {
    return DefaultTabController(
      key: globalKey,
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          drawer: Drawer(elevation: 8.0, child: HHHConstants.drawer),
          appBar: appBar,
          body: LoadingOverlay(
              child: getBody(),
              isLoading: controller.isLoading,
              color: UIConstants.progressBarColor,
              opacity: UIConstants.progressBarOpacity)),
    );
  }

  Widget getBody() {
    return TabBarView(
      children: [
        RestaurantsTab(controller.restaurants),
        HotelsTab(controller.hotels),
      ],
    );
  }

  AppBar get appBar => AppBar(
        title: Text(
          'Local Places',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.restaurant)),
            Tab(icon: Icon(Icons.local_hotel)),
          ],
        ),
      );
}
