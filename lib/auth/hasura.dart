import 'package:hasura_connect/hasura_connect.dart';

class Hasura {
  static final Hasura _this = Hasura._();
  final HasuraConnect hasuraConnect =
      HasuraConnect('https://ibs-finance.hasura.app/v1/graphql');
  late dynamic result = '';
  static Map<String, String>? headers = {};

  static Future<dynamic> query(String doc, {Map<String, dynamic>? v}) async =>
      _this.result = await _this.hasuraConnect.query(doc, variables: v, headers: headers);
  static Future<dynamic> mutate(String doc, {Map<String, dynamic>? v}) async =>
      _this.result =
          await _this.hasuraConnect.mutation(doc, variables: v, headers: headers);

  // static set runMutate(input) => _this.query();

  factory Hasura() => _this;

  Hasura._();
}
