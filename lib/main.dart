import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plants_ui_app_design/models/plant_model.dart';
import 'package:flutter_plants_ui_app_design/screens/plant_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Plants App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController? _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _plantSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController!,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController!.position.haveDimensions) {
          value = _pageController!.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500,
            width: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PlantScreen(plant: plants[index])));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                        tag: plants[index].imageUrl!,
                        child: Image(
                          height: 280,
                          width: 280,
                          image: AssetImage('assets/images/plant$index.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                      top: 30,
                      right: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "From",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "\$${plants[index].price}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  Positioned(
                    left: 30,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plants[index].category!.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          plants[index].name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 4,
                child: RawMaterialButton(
                  onPressed: () {
                    print("Has been added");
                  },
                  padding: const EdgeInsets.all(15),
                  shape: const CircleBorder(),
                  elevation: 2,
                  fillColor: Colors.black,
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 60.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.menu,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      size: 30.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  "Top Picks",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                isScrollable: true,
                tabs: const [
                  Tab(
                    child: Text(
                      "Top",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "OutDoor",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Indoor",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "New Arrivals",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Limited Edition",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      _selectedPage = index;
                    });
                  },
                  itemCount: plants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _plantSelector(index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Desc",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      plants[_selectedPage].description!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
