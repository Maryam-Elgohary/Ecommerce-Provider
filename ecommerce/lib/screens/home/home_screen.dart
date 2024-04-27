import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/home/widget/home_app_bar.dart';
import 'package:ecommerce/screens/home/widget/image_slider.dart';
import 'package:ecommerce/screens/home/widget/product_cart.dart';
import 'package:ecommerce/screens/home/widget/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectedCategories = [
      all,
      shoes,
      beauty,
      womenFashion,
      jewelry,
      menFashion
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                //for custom appbar
                const CustomAppBar(),
                const SizedBox(
                  height: 20,
                ),
                //for search bar
                const MySearchBAR(),
                const SizedBox(
                  height: 20,
                ),
                ImageSlider(
                    onChange: (value) {
                      setState(() {
                        currentSlider = value;
                      });
                    },
                    currentSlide: currentSlider),
                const SizedBox(
                  height: 20,
                ),
                //for category selection
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selectedIndex == index
                                  ? Colors.blue[200]
                                  : Colors.transparent),
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            AssetImage(categories[index].image),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                categories[index].title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Special For You",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
                //for shopping items
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.78,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: selectedCategories[selectedIndex].length,
                    itemBuilder: (context, index) {
                      return ProductCart(
                          product: selectedCategories[selectedIndex][index]);
                    })
              ],
            ),
          ),
        ));
  }
}
