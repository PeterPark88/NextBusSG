import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/components/more/rename_favorites/bottom_sheets.dart';
import 'package:nextbussg/components/more/tile_button.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/extensions.dart';
import 'package:nextbussg/services/provider/favorites.dart';
import 'package:nextbussg/services/renameFavorites.dart';
import 'package:nextbussg/strings.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/bottom_sheet_template.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

class RenameFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FavoritesProvider.getFavorites(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData)
            return PageTemplate(
              showBackButton: true,
              children: [
                TitleText(
                  title: "Rename favorites",
                ).sliverToBoxAdapter(),
                Spacing(height: 10).sliver(),
                MarkdownBody(
                  data: Strings.renameFavoritesPrompt,
                ).sliverToBoxAdapter(),
                Spacing(height: 10).sliver(),

                for (var bs in snapshot.data)
                  // Text('bus stop fav').sliverToBoxAdapter()
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Values.marginBelowTitle),
                      child: Text(
                        "${bs.name} – ${bs.code}",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                    onTap: () => _changeDisplayNameBottomSheet(context, bs.code, bs.name),
                  ).sliverToBoxAdapter(),
                // display all favorites
              ],
            );
          else
            return Text("Loading");
        },
      ),
    );
  }

  _changeDisplayNameBottomSheet(BuildContext context, String code, String name) =>
      // display bottom sheet that takes input using $name as reference
      RenameFavoritesBottomSheets.bs(context, code, name);

  // RenameFavoritesService.rename(code, "3 interchange");

}