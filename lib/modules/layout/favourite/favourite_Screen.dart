import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/modules/layout/home/widgets/home_category.dart';
import 'package:flutter/material.dart';
import '../../../modules/widget/even_date_model.dart';
import '../../../core/utils/fire_base/create_event_fire_store.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search For Event',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10),
                  child: Icon(
                    Icons.search_outlined,
                    color: AppColor.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.primary, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.primary, width: 2),
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<List<EvenDateModel>>(
              stream: CreateEventFireStore.getEventsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No favourite events yet"));
                }

                final favouriteEvents = snapshot.data!
                    .where((event) => event.isFavourite)
                    .toList();

                if (favouriteEvents.isEmpty) {
                  return const Center(
                    child: Text("No favourite events yet"),
                  );
                }

                return ListView.builder(
                  itemCount: favouriteEvents.length,
                  itemBuilder: (context, index) {
                    final currentEvent = favouriteEvents[index];
                    return HomeCategory(
                      events: [currentEvent],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
