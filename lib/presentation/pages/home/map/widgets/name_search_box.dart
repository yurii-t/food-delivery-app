import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/data/models/restaurant.dart';
import 'package:food_delivery_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NameSearchBox extends StatefulWidget {
  final List<Restaurant> restaurantsList;
  const NameSearchBox({required this.restaurantsList, Key? key})
      : super(key: key);

  @override
  State<NameSearchBox> createState() => _NameSearchBoxState();
}

class _NameSearchBoxState extends State<NameSearchBox> {
  ValueNotifier<List<Restaurant>> resList = ValueNotifier([]);

  @override
  void initState() {
    resList.value = widget.restaurantsList;
    super.initState();
  }

  void _searchFiles(String query) {
    List<Restaurant> results = [];
    results = query.isEmpty
        ? widget.restaurantsList
        : widget.restaurantsList
            .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    resList.value = results;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            return ValueListenableBuilder(
              valueListenable: resList,
              builder: (context, item, child) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.95,
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
                      TextField(
                        onChanged: _searchFiles,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 19),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(maxHeight: 30, minWidth: 30),
                          prefixIcon: SvgPicture.asset(
                            'assets/icons/search.svg',
                          ),
                          hintText: 'Search by name',
                          hintStyle: const TextStyle(color: AppColors.grey),
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
                          itemCount: resList.value.length, //searchItems.length,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 2,
                            color: AppColors.lightGrey,
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                context.read<LocationBloc>().add(
                                      SearchLocationFromFirebase(
                                        location: LatLng(
                                          resList
                                              .value[index].location.latitude,
                                          resList
                                              .value[index].location.longitude,
                                        ),
                                      ),
                                    );
                                context.router.pop();
                              },
                              minLeadingWidth: 15,
                              leading: const Icon(Icons.watch_later_outlined),
                              title: Text(
                                // 'Cafe Sante (Bar - Restaurant)',
                                resList.value[index].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                // '15 Shortmarket St, Cape Tow',
                                resList.value[index].address,
                                style: const TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }
}
