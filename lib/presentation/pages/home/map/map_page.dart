import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/data/models/restaurant_category.dart';
import 'package:food_delivery_app/presentation/blocs/bottombar/bloc/bottombar_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:food_delivery_app/presentation/pages/home/map/widgets/location_search_box.dart';
import 'package:food_delivery_app/presentation/pages/home/map/widgets/name_search_box.dart';
import 'package:food_delivery_app/presentation/pages/home/map/widgets/share_location_dialog.dart';
import 'package:food_delivery_app/routes/app_router.gr.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double _fabHeight = 10;
  double _panelHeightClosed = 0;

  PanelController panelController = PanelController();

  BitmapDescriptor? customMarker;
  BitmapDescriptor? unselectdMarker;
  BitmapDescriptor? currentLocationMarker;

  FirebaseRemoteDataSourceImpl fire = FirebaseRemoteDataSourceImpl();
  Restaurant? choosedRestaurant;

  @override
  void initState() {
    getBytesFromAsset('assets/cafe.png', 50).then((onValue) {
      customMarker = BitmapDescriptor.fromBytes(onValue);
    });
    getBytesFromAsset('assets/current_loaction.png', 100).then((onValue) {
      currentLocationMarker = BitmapDescriptor.fromBytes(onValue);
    });
    getBytesFromAsset('assets/cafe_off.png', 50).then((onValue) {
      unselectdMarker = BitmapDescriptor.fromBytes(onValue);
    });

    super.initState();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final double _panelHeightOpen = MediaQuery.of(context).size.height * 0.58;

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LocationPermissionDenied) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog<Dialog>(
                context: context,
                builder: (context) => const ShareLocationDialog(),
              );
            });
          }
          if (state is LocationLoaded) {
            final Marker currentMarker = Marker(
              markerId: const MarkerId('user_location'),
              rotation: state.locationData?.heading ?? 0,
              icon: currentLocationMarker!,
              position: LatLng(
                state.locationData?.latitude ?? state.place.lat,
                state.locationData?.longitude ?? state.place.lon,
              ),
              anchor: const Offset(0.5, 0.5),
            );

            final Set<Marker> markers = state.restaurants.map((restaurant) {
              return Marker(
                markerId: MarkerId(restaurant.id),
                icon: state.selectedRestaurant?.id == restaurant.id
                    ? customMarker!
                    : state.selectedRestaurant?.id == null
                        ? customMarker!
                        : unselectdMarker!,
                position: LatLng(
                  restaurant.location.latitude,
                  restaurant.location.longitude,
                ),
                onTap: () {
                  context
                      .read<BottombarBloc>()
                      .add(const HideBottomBar(hide: true));

                  context
                      .read<LocationBloc>()
                      .add(SelectMarkerRestaurant(restaurant));

                  choosedRestaurant = state.restaurants
                      .firstWhere((element) => element.id == restaurant.id);

                  panelController.open();
                },
              );
            }).toSet()
              ..add(currentMarker);

            return Stack(
              children: [
                GoogleMap(
                  markers: markers,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.place.lat,
                      state.place.lon,
                    ),
                  ),
                  onMapCreated: (controller) {
                    context
                        .read<LocationBloc>()
                        .add(LoadMap(controller: controller));
                  },
                ),
                Column(
                  children: [
                    NameSearchBox(restaurantsList: state.restaurants),
                    const LocationSearchBox(),
                  ],
                ),
                SlidingUpPanel(
                  onPanelClosed: () {
                    context.read<BottombarBloc>().add(const HideBottomBar());
                    context
                        .read<LocationBloc>()
                        .add(const SelectMarkerRestaurant(null));
                  },
                  controller: panelController,
                  maxHeight: _panelHeightOpen,
                  minHeight: _panelHeightClosed,
                  parallaxEnabled: true,
                  parallaxOffset: 0.5,
                  panelBuilder: (sc) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 80,
                          child: Divider(
                            thickness: 4,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: choosedRestaurant?.image != null
                              ? Image.network(
                                  choosedRestaurant?.image ?? '',
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox.shrink(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                choosedRestaurant?.name ?? 'Loading...',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  choosedRestaurant?.rating.toString() ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          choosedRestaurant?.options ?? 'Loading...',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location_marker.svg',
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              choosedRestaurant?.address ?? 'Loading...',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/clock.svg',
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              choosedRestaurant?.workingTime ?? 'Loading...',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.router
                                .push(CafeRoute(restaurant: choosedRestaurant));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.orange,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('View'),
                        ),
                      ],
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  onPanelSlide: (pos) => setState(() {
                    _fabHeight =
                        pos * (_panelHeightOpen - _panelHeightClosed) + 10;
                  }),
                ),
                Positioned(
                  bottom: _fabHeight,
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: state.restaurantCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return GestureDetector(
                          onTap: () {
                            if (state.selectedCategory ==
                                state.restaurantCategories[index]) {
                              context.read<LocationBloc>().add(
                                    const SelectRestaurantsCategory(
                                      RestaurantCategory(
                                        categoryName: '',
                                        categoryNameIcon: '',
                                      ),
                                    ),
                                  );
                            } else {
                              context.read<LocationBloc>().add(
                                    SelectRestaurantsCategory(
                                      state.restaurantCategories[index],
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 8,
                              left: 8,
                              bottom: 16,
                            ),
                            height: 26,
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 4,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              color: state.selectedCategory ==
                                      state.restaurantCategories[index]
                                  ? AppColors.orange
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.restaurantCategories[index]
                                    .categoryNameIcon,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
