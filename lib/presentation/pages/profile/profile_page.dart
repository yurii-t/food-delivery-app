import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/presentation/blocs/auth_status/bloc/auth_status_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              context.read<AuthStatusBloc>().add(AuthStatusLogedOut());
            },
            child: Text('Log uot')),
      ),
    );
  }
}
