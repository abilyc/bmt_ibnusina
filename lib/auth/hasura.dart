import 'package:hasura_connect/hasura_connect.dart';

class Hasura {
  static final Hasura _this = Hasura._();
  final HasuraConnect hasuraConnect =
      HasuraConnect('https://bankinx.ibnusina.org/v1/graphql');
  late dynamic _result;
  static Map<String, String>? headers = {};

  static Future<dynamic> query(String doc, {Map<String, dynamic>? v}) async =>
      // _this._result =
          await _this.hasuraConnect.query(doc, variables: v, headers: headers);
  static Future<dynamic> mutate(String doc, {Map<String, dynamic>? v}) async =>
      // _this._result = 
      await _this.hasuraConnect.mutation(doc, variables: v, headers: headers);

  static get result => _this._result;

  // static set runMutate(input) => _this.query();

  factory Hasura() => _this;

  Hasura._();
}
