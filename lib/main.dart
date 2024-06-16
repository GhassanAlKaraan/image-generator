import 'package:flutter/material.dart';
import '../api_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();

  TextEditingController input = TextEditingController();
  String output = "";

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Image(
                    image: NetworkImage('assets/images/monkey.png'),
                    height: 100,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      hintText: 'Input',
                    ),
                    controller: input,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _loading == true
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : IconButton(
                          onPressed: _loading == true
                              ? null
                              : () async {
                                if(input.text.trim().isEmpty) return;
                                  setState(() {
                                    _loading = true;
                                  });
                                  if (input.text.isNotEmpty) {
                                    output = await apiService
                                        .makeApiCall(input.text.trim());
                                  }
                                  setState(() {
                                    _loading = false;
                                  });
                                },
                          icon: Icon(
                            Icons.search_outlined,
                            color: Colors.brown[300],
                            size: 40,
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.grey[200],
                    size: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  !output.startsWith('http')
                      ? const Icon(Icons.hourglass_empty, size: 30, color: Colors.grey,)
                      : Image(
                          image: NetworkImage(output),
                          height: 600,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
