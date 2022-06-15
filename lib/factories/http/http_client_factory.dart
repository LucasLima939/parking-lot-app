import 'package:parking_lot_app/intra/http/http_adapter.dart';

import '../../../data/http/http.dart';

import 'package:http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());
