import 'package:appcv/user_grid.dart';
import 'package:appcv/user_view_model.dart';
import 'package:appcv/userlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _client = http.Client();
  final _viewModel = UserViewModel(http.Client());
  bool _isGrid = true;

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Viewer'),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_on),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
        ],
      ),
      body: _isGrid ? UserGrid(viewModel: _viewModel) : UserList(viewModel: _viewModel),
      bottomNavigationBar: BottomAppBar(
        child: _viewModel.isLoading
            ? const LinearProgressIndicator()
            : IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: _viewModel.loadMore,
              ),
      ),
    );
  } 
}