import 'package:parking_lot_app/factories/http/http.dart';

import '../../../data/http/http.dart';
import '../decorators/decorators.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
      decoratee: makeHttpAdapter(),
    );
