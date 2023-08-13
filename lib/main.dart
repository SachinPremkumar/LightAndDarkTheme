import 'package:dark_light/Provider/theme_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeChangeData>(create: (_) => ThemeChangeData()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
  );

  ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeData>(builder: (context, isModel, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: isModel.changeValue ? lightTheme : darkTheme,
        home: const MyHomePage(title: 'Dark Theme'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> value = ['Light', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Consumer<ThemeChangeData>(builder: (context, isModel, child) {
        return Center(
            child: Container(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: MediaQuery.sizeOf(context).height * 0.10,
          margin: const EdgeInsets.all(20),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<ThemeChangeData>(context, listen: false)
                      .getThemeChange();
                },
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.10,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(value.length, (index) {
                        return Text(
                          value[index],
                          style: const TextStyle(fontSize: 18),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                alignment: isModel.changeValue
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.33,
                  height: MediaQuery.sizeOf(context).height * 0.13,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.sizeOf(context).width * 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(isModel.changeValue ? value[0] : value[1],
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).iconTheme.color)),
                  ),
                ),
              ),
            ],
          ),
        ));
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
