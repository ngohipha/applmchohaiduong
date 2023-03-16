import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:appcv/user_model.dart';

class UserViewModel {
  static const _perPage = 6;
  final _users = <User>[];
  int _page = 0;
  bool _isLoading = false;
  late Completer<void> _refreshCompleter;
  final http.Client _client;

  UserViewModel(this._client) {
    _refreshCompleter = Completer<void>();
    _loadMore();
  }

  List<User> get users => _users;

  bool get isLoading => _isLoading;

  Future<void> refresh() async {
    if (_isLoading) {
      return;
    }
    _page = 0;
    _users.clear();
    _refreshCompleter = Completer<void>();
    await _loadMore();
    return _refreshCompleter.future;
  }

  Future<void> loadMore() async {
    if (_isLoading) {
      return;
    }
    await _loadMore();
  }

  Future<void> _loadMore() async {
    try {
      _isLoading = true;
      final response = await _client.get(Uri.parse(
          'https://reqres.in/api/users?page=${_page + 1}&per_page=$_perPage'));
      if (response.statusCode == 200) {
        final data = response.body;
        final json = (jsonDecode(data)['data'] as List<dynamic>)
            .cast<Map<String, dynamic>>();
        final newUsers = json.map((j) => User.fromJson(j)).toList();
        _users.addAll(newUsers);
        _page++;
      }
    } finally {
      _isLoading = false;
      if (!_refreshCompleter.isCompleted) {
        _refreshCompleter.complete();
      }
    }
  }

  Widget buildAvatar(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircleAvatar(),
      errorWidget: (context, url, error) => const CircleAvatar(),
    );
  }
}
