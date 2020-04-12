import 'package:flutter/material.dart';
import 'package:clinic_app/modules/graphql/gql_client.dart';

class WithGraphQl extends StatelessWidget {
  final Widget child;
  final String token;

  const WithGraphQl({Key key, this.child, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
        uri: "http://206.189.238.178/v1/graphql",
        subscriptionUri: "ws://206.189.238.178/v1/graphql",
        token: token,
        child: child);
  }
}
