import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart'
    as auth_provider;
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<auth_provider.AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://i.pinimg.com/originals/e5/df/45/e5df457e8de5d0aae37691c00e8a672e.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<auth_provider.AuthProvider, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.titleSmall,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Alterar Nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () {
                              final nameValue = nameVN.value;
                              if (nameVN.value.isEmpty) {
                                Messages.of(context)
                                    .showError('Nome obrigatório');
                              } else {
                                Loader.show(context);
                                context
                                    .read<UserService>()
                                    .updateDisplayName(nameValue);
                                Loader.hide();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Alterar')),
                      ],
                    );
                  });
            },
            title: Text('Alterar nome'),
          ),
          ListTile(
            onTap: () => context.read<auth_provider.AuthProvider>().logout(),
            title: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
