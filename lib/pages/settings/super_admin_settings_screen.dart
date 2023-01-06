import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_constants.dart';
import 'package:smooth_game_app/core/services/smooth_card_game_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_column.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';

class SmoothAdminSettings extends StatelessWidget {
  const SmoothAdminSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothScaffold(
      body: SmoothContainer(
        child: SmoothListView(
          children: [
            SmoothCustomAppBar(type: SmoothCustomAppBarType.login).build(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SmoothColumn(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SmoothText(
                    text: "Smooth Games Card",
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  CarouselSlider(
                    items: SmoothConstants.gameCards.map((card) {
                      return Card(
                        elevation: 12.0,
                        child: Image.asset(card.path),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                    ),
                  ),
                ],
              ),
            ),
            SmoothTextButton(
              title: "Upload cards",
              hPadding: 20.0,
              action: () {
                for (var card in SmoothConstants.gameCards) {
                  SmoothCardGameService().saveCard(card);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
