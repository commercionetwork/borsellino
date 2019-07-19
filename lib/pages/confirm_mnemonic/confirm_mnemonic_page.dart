import 'package:borsellino/bloc/blocs.dart';
import 'package:borsellino/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'arguments.dart';
import 'components/retrieving_words_body.dart';
import 'components/verification_words_generated_body.dart';

export 'arguments.dart';

class ConfirmMnemonicPage extends StatelessWidget {
  static const routeName = "/verifyMnemonic";

  @override
  Widget build(BuildContext context) {
    final ConfirmMnemonicBloc bloc = BlocProvider.of(context);

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
            builder: (context, ConfirmMnemonicState state) {
              if (state is InitialMnemonicConfirmationState) {
                bloc.dispatch(GetRandomVerificationWordsEvent(args.mnemonic));
              }

              if (state is GeneratingVerificationWordsState) {
                return RetrievingVerificationWordsBody();
              }

              if (state is VerificationWordsGeneratedState) {

                // Get the current verification status
                var verificationStatus = VerificationStatus.UNKNOWN;
                if (state is VerificationWordsValidState) {
                  verificationStatus = VerificationStatus.VALID;
                } else if (state is VerificationWordsInvalidState) {
                  verificationStatus = VerificationStatus.INVALID;
                }

                return VerificationWordsGeneratedBody(
                    mnemonic: args.mnemonic,
                    verificationWords: state.words,
                    verificationStatus: verificationStatus,
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
