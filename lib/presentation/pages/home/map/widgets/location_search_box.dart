import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/presentation/blocs/autocomplete/bloc/autocomplete_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:food_delivery_app/theme/app_colors.dart';

class LocationSearchBox extends StatefulWidget {
  const LocationSearchBox({Key? key}) : super(key: key);

  @override
  State<LocationSearchBox> createState() => _LocationSearchBoxState();
}

class _LocationSearchBoxState extends State<LocationSearchBox> {
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
            return BlocBuilder<AutocompleteBloc, AutocompleteState>(
              builder: (context, state) {
                if (state is AutocompleteLoading) {
                  return const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is AutocompleteLoaded) {
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
                          width: MediaQuery.of(context).size.width, //375,
                          height: 48,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    context.read<AutocompleteBloc>().add(
                                          LoadAutocomplete(searchInput: value),
                                        );
                                  },
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
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
                            itemCount: state.autocomplete.length,
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 2,
                              color: AppColors.lightGrey,
                            ),
                            itemBuilder: (context, index) {
                              final searchItem = state.autocomplete[index];

                              return ListTile(
                                onTap: () {
                                  context.read<LocationBloc>().add(
                                        SearchLocation(
                                          placeId:
                                              state.autocomplete[index].placeId,
                                        ),
                                      );
                                  context.router.pop();
                                },
                                minLeadingWidth: 15,
                                leading: const Icon(Icons.watch_later_outlined),
                                title: Text(
                                  // 'Cafe Sante (Bar - Restaurant)',
                                  searchItem.description,
                                  style: const TextStyle(
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
                }

                // return const SizedBox.shrink();
                return const Center(
                  child: SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
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
    );
  }
}
