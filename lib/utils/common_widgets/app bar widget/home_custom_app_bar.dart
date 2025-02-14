import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indrayani/module/home/view_model/home_view_model.dart';
import 'package:indrayani/module/home/view_model/toggle_button_view_controller.dart';
import 'package:indrayani/utils/widgetConstant/text_widget/text_constant_widget.dart';
// Import the controller

class HomeCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final String imagePath;
  final String containerText;

  const HomeCustomAppBar({
    Key? key,
    this.title,
    required this.imagePath,
    required this.containerText,
  })  : preferredSize =
            const Size.fromHeight(110.0), // Adjust total height as needed
        super(key: key);

  @override
  State<HomeCustomAppBar> createState() => _HomeCustomAppBarState();
}

class _HomeCustomAppBarState extends State<HomeCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.preferredSize.height,
      child: Column(
        children: [
          AppBar(
            backgroundColor: const Color.fromARGB(255, 254, 199, 73),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstantText(text: widget.title),
              ],
            ),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  widget.imagePath,
                  height: 50.0, // Adjust the height to fit your AppBar
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          ToggleButtonsContainer(),
        ],
      ),
    );
  }
}

class ToggleButtonsContainer extends StatelessWidget {
  final ToggleButtonsController toggleButtonsController =
      Get.put(ToggleButtonsController());
  final HomeDataViewModel homeDataViewModel = Get.put(HomeDataViewModel());

  @override
  Widget build(BuildContext context) {
    // Load trending exams by default
    homeDataViewModel.getTrendingExamList();

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 54.0, // Set a fixed height for the container
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!toggleButtonsController.isTrendingSelected.value) {
                    toggleButtonsController.toggleButton();
                  }
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: toggleButtonsController.isTrendingSelected.value
                            ? Colors.white
                            : Colors.grey,
                        border: Border(
                          bottom: BorderSide(
                            color:
                                toggleButtonsController.isTrendingSelected.value
                                    ? Colors.black
                                    : Colors.transparent,
                            width: 4.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: ConstantText(
                            key: ValueKey<bool>(toggleButtonsController
                                .isTrendingSelected.value),
                            text: "TRENDING EXAMS",
                            fontSize:
                                toggleButtonsController.isTrendingSelected.value
                                    ? 15.0
                                    : 14.0,
                            fontWeight:
                                toggleButtonsController.isTrendingSelected.value
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                toggleButtonsController.isTrendingSelected.value
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (toggleButtonsController.isTrendingSelected.value) {
                    toggleButtonsController.toggleButton();
                  }
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: toggleButtonsController.isTrendingSelected.value
                            ? Colors.grey
                            : Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color:
                                toggleButtonsController.isTrendingSelected.value
                                    ? Colors.transparent
                                    : Colors.black,
                            width: 4.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: ConstantText(
                            key: ValueKey<bool>(!toggleButtonsController
                                .isTrendingSelected.value),
                            text: "UPCOMING EXAMS",
                            fontSize:
                                toggleButtonsController.isTrendingSelected.value
                                    ? 14.0
                                    : 15.0,
                            fontWeight:
                                toggleButtonsController.isTrendingSelected.value
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                            color:
                                toggleButtonsController.isTrendingSelected.value
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
