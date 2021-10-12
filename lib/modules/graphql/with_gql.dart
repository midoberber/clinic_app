import 'package:flutter/material.dart';
import 'package:clinic_app/modules/graphql/gql_client.dart';

class WithGraphQl extends StatelessWidget {
  final Widget child;
  // final String token;

  const WithGraphQl({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClientProvider(
        uri: "http://164.90.214.9//v1/graphql",
        subscriptionUri: "ws://164.90.214.9//v1/graphql",
        child: child);
  }
}
