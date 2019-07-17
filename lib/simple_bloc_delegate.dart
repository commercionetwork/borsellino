import 'package:bloc/bloc.dart';


/// Extension of BlocDelegate that allows to print transitions
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}