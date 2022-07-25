import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  int _selectedTab = 0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  bool openBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<Widget?>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 80,
                              child: Divider(
                                thickness: 4,
                              ),
                            ),
                            TextField(
                              onChanged: (value) => value,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 19),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                    maxHeight: 30, minWidth: 30),
                                prefixIcon: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                ),
                                hintText: 'Search by name',
                                hintStyle:
                                    const TextStyle(color: AppColors.grey),
                                suffixIcon: const Icon(
                                  Icons.clear,
                                ),
                              ),
                            ),
                            const SizedBox(
                              // width: 80,
                              child: Divider(
                                thickness: 2,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: 7,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  thickness: 2,
                                  color: AppColors.lightGrey,
                                ),
                                itemBuilder: (context, index) {
                                  return const ListTile(
                                    minLeadingWidth: 15,
                                    leading: Icon(Icons.watch_later_outlined),
                                    title: Text(
                                      'Cafe Sante (Bar - Restaurant)',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    subtitle: Text(
                                      '15 Shortmarket St, Cape Tow',
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                  width: MediaQuery.of(context).size.width, //375,
                  height: 48,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/qpay.svg',
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        width: 1,
                        color: AppColors.lightGrey,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/search.svg',
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Search by name',
                              style: TextStyle(color: AppColors.grey),
                            ),
                          ],
                        ),
                        // TextField(
                        //   onChanged: (value) => value,
                        //   textAlignVertical: TextAlignVertical.bottom,
                        //   decoration: InputDecoration(
                        //     contentPadding: const EdgeInsets.only(bottom: 19),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide.none,
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     prefixIconConstraints:
                        //         const BoxConstraints(maxHeight: 30, minWidth: 30),
                        //     prefixIcon: SvgPicture.asset(
                        //       'assets/icons/search.svg',
                        //     ),
                        //     hintText: 'Search by name',
                        //     hintStyle: const TextStyle(color: AppColors.grey),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
              /////
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<Widget?>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 80,
                              child: Divider(
                                thickness: 4,
                              ),
                            ),
                            Container(
                              // padding: const EdgeInsets.only(
                              //   left: 12,
                              // ),
                              // margin: const EdgeInsets.only(
                              //     left: 16, right: 16, top: 30),
                              width: MediaQuery.of(context).size.width, //375,
                              height: 48,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) => value,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                          maxHeight: 30,
                                          minWidth: 30,
                                        ),
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icons/search.svg',
                                        ),
                                        hintText: 'Your location',
                                        hintStyle: const TextStyle(
                                          color: AppColors.grey,
                                        ),
                                        suffixIcon: const Icon(Icons.clear),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 12,
                                      left: 12,
                                      bottom: 2,
                                    ),
                                    width: 1,
                                    color: AppColors.lightGrey,
                                  ),
                                  const Text('Map'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              // width: 80,
                              child: Divider(
                                thickness: 2,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: 7,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  thickness: 2,
                                  color: AppColors.lightGrey,
                                ),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        showModalBottomSheet<Widget?>(
                                            // isScrollControlled: true,
                                            // useRootNavigator: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(24),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 100,
                                                color: Colors.red,
                                              );
                                            });
                                      });
                                    },
                                    minLeadingWidth: 15,
                                    leading:
                                        const Icon(Icons.watch_later_outlined),
                                    title: const Text(
                                      'Cafe Sante (Bar - Restaurant)',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    subtitle: const Text(
                                      '15 Shortmarket St, Cape Tow',
                                      style: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  // width: MediaQuery.of(context).size.width, //375,
                  height: 32,

                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/compass.svg',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Choose your location',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                itemCount: 10,
                // itemExtent: 98,
                scrollDirection: Axis.horizontal,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 8, left: 8, bottom: 16),
                      height: 26,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 4,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedTab == index
                            ? AppColors.orange
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🍕'),
                            const Text(
                              'Pizza',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
