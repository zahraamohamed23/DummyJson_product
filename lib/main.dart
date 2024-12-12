import 'package:device_preview/device_preview.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_dummyjson/core/config/injection.dart';
import 'package:products_dummyjson/core/routes/app_routes.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/pro_add_del_up_bloc/product_add_dele_up_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:products_dummyjson/features/products/presentation/bloc/products/products_event.dart';
import 'package:products_dummyjson/features/products/presentation/pages/products_pages.dart';


final di = GetIt.instance;
final sl = GetIt.instance;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(DevicePreview(builder: (context) => MyApp(
    appRouter: AppRouter(),
  )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.appRouter,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<ProductsBloc>().add(GetAllProductsEvent()),
        ),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdateProductBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        onGenerateRoute: appRouter.generateRoute,
        home: const ProductsPage(), 
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _incrementCounter,
            ),
          ],
        ),
      ),
    );
  }
}
