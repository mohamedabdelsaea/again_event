import 'package:again_evently/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/services/snack_bar_service.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/core/utils/fire_base/create_event_fire_store.dart';
import 'package:again_evently/modules/layout/widgets/custom_create_tap.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:again_evently/modules/widget/even_date_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<SettingProvider>(context);
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Event',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: AppColor.primary,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColor.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.3,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: DecorationImage(
                      image: AssetImage(
                        provider.eventCategoryList[selectedIndex].img,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DefaultTabController(
                  length: provider.eventCategoryList.length,
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: AppColor.white,
                    indicatorColor: AppColor.white,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tabs: provider.eventCategoryList.map((category) {
                      return CustomCreateTap(
                        text: category.name,
                        isColor: provider.eventCategoryList.indexOf(category) ==
                            selectedIndex,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Title',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Event Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Icon(Icons.add_comment_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _categoryController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter Description';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Event Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 10),
                    Text(
                      'Event Date',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        provider.selectedEvenDate(context);
                      },
                      child: Text(
                        provider.selectedDate != null
                            ? DateFormat('dd MMM yyy')
                                .format(provider.selectedDate!)
                            : 'Choose Date',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 10),
                    Text(
                      'Event Time',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        provider.selectedDateTime(context);
                      },
                      child: Text(
                        provider.timeOfDay != null
                            ? provider.timeOfDay!.format(context)
                            : 'Choose Time',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        provider.selectedDate != null &&
                        provider.timeOfDay != null) {
                      final user = FirebaseAuth.instance.currentUser ;
                      EvenDateModel data = EvenDateModel(
                        Id: provider.eventCategoryList[selectedIndex].name,
                        title: _titleController.text,
                        image: provider.eventCategoryList[selectedIndex].img,
                        category: _categoryController.text,
                        dateTime: provider.selectedDate!,
                        timeOfDay: provider.timeOfDay!,
                        userId: user?.uid ,
                      );
                      CreateEventFireStore.createNewEvent(data).then(
                        (value) {
                          if (value == true) {
                            navigatorKey.currentState!.pushNamed(PageRouteName.layout);
                            SnackBarService.showSuccessMessage(
                                'successfully created');
                          } else {
                            SnackBarService.showErrorMessage('field');
                          }
                        },
                      );
                    }
                  },
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      local.addEvent,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
