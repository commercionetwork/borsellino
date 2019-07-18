import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/bloc/verify_mnemonic/verify_mnemonic_event.dart';
import 'package:borsellino/bloc/verify_mnemonic/verify_mnemonic_state.dart';
import 'package:borsellino/pages/verify_mnemonic/components/retrieving_words_body.dart';
import 'package:borsellino/pages/verify_mnemonic/components/verification_words_generated_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'arguments.dart';

class VerifyMnemonicPage extends StatelessWidget {
  static const routeName = "/verifyMnemonic";

  @override
  Widget build(BuildContext context) {
    final VerifyMnemonicBloc bloc = BlocProvider.of(context);

    // Get the arguments
    final VerifyMnemonicArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify mnemonic"),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, VerifyMnemonicState state) {
              if (state is InitialVerifyMnemonicState) {
                bloc.dispatch(GetRandomVerificationWordsEvent(args.mnemonic));
              }

              if (state is GeneratingVerificationWordsState) {
                return RetrievingVerificationWordsBody();
              }

              if (state is VerificationWordsGeneratedState) {
                if (state is VerificationWordsValidState) {
                  print("Valid words!");
                }

                return VerificationWordsGeneratedBody(
                    mnemonic: args.mnemonic,
                    verificationWords: state.words,
                    areWordsInvalid: state is VerificationWordsInvalidState,
                    callBack: (oldWords, insertedWords) {
                      // Dispatch the event to verify the words
                      bloc.dispatch(VerifyInsertedWordsEvent(
                        originalWords: oldWords,
                        insertedWords: insertedWords,
                      ));
                    });
              }

              return Container();
            },
          )),
    );
  }
}
