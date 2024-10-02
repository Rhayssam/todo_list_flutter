import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart'
    as auth_provider;
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Selector<auth_provider.AuthProvider, String>(
            selector: (context, auth_provider) =>
                auth_provider.user?.displayName ?? 'Não informado',
            builder: (_, value, __) {
              return Text(
                'E aí, $value!',
                style: context.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ],
    );
  }
}
