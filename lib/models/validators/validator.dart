import 'package:meta/meta.dart';

class Validator {
  String name;
  String address;
  String tokens;
  String commission;
  Validator({
    @required this.name,
    @required this.address,
    @required this.tokens,
    @required this.commission,
  }) : assert(name != null &&
            address != null &&
            tokens != null &&
            commission != null);
}
