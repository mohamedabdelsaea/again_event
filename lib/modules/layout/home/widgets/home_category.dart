import 'package:again_evently/modules/widget/even_date_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/fire_base/create_event_fire_store.dart';

class HomeCategory extends StatefulWidget {
  final String? selectedCategory;
  final List<EvenDateModel>? events;

  const HomeCategory({super.key, this.selectedCategory, this.events});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  final Set<String> favoriteEvents = {};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (widget.events != null) {
      final events = widget.events!;
      if (events.isEmpty) {
        return const Center(child: Text("No events found"));
      }
      return _buildEventsList(events, size);
    }

    return StreamBuilder<List<EvenDateModel>>(
      stream: CreateEventFireStore.getEventsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No events yet"));
        }

        final events = (widget.selectedCategory == null ||
                widget.selectedCategory!.isEmpty)
            ? snapshot.data!
            : snapshot.data!
                .where((event) => event.category == widget.selectedCategory)
                .toList();

        if (events.isEmpty) {
          return Center(child: Text("No events in ${widget.selectedCategory}"));
        }

        return _buildEventsList(events, size);
      },
    );
  }

  Widget _buildEventsList(List<EvenDateModel> events, Size size) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final currentEvent = events[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: size.height * 0.25,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(currentEvent.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.white,
                        ),
                        child: Text(
                          DateFormat('MMM, dd yyyy')
                              .format(currentEvent.dateTime),
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        CreateEventFireStore.deleteEvent(currentEvent.Id);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                    ),
                    child: Text(
                      MaterialLocalizations.of(context).formatTimeOfDay(
                        currentEvent.timeOfDay,
                        alwaysUse24HourFormat: false,
                      ),
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      width: size.width * 0.85,
                      height: 50,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentEvent.title,
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                currentEvent.isFavourite =
                                    !currentEvent.isFavourite;
                              });

                              await CreateEventFireStore.updateFavouriteStatus(
                                currentEvent.Id,
                                currentEvent.isFavourite,
                              );
                            },
                            child: Icon(
                              currentEvent.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColor.primary,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
