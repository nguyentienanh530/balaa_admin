import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balaa_admin/common/bloc/generic_bloc_state.dart';
import 'package:balaa_admin/common/widget/empty_widget.dart';
import 'package:balaa_admin/common/widget/error_widget.dart';
import 'package:balaa_admin/common/widget/loading_screen.dart';
import 'package:balaa_admin/core/utils/extensions.dart';
import 'package:balaa_admin/features/food/bloc/food_bloc.dart';

import '../../../food/data/model/food_model.dart';

class FoodBestSeller extends StatelessWidget {
  const FoodBestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            FoodBloc()..add(const FoodsPopulerFetched(isShowFood: true)),
        child: Builder(builder: (context) {
          var state = context.watch<FoodBloc>().state;
          return switch (state.status) {
            Status.loading => const LoadingScreen(),
            Status.empty => const EmptyWidget(),
            Status.failure =>
              ErrorWidgetCustom(errorMessage: state.error ?? ''),
            Status.success =>
              _buildSuccessWidget(context, state.datas ?? <Food>[])
          };
        }));
  }

  Widget _buildFoods(BuildContext context, Food food) {
    return SizedBox(
        height: context.sizeDevice.height * 0.1,
        child: Column(children: [
          Expanded(
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: context.sizeDevice.height * 0.1,
                      width: context.sizeDevice.height * 0.1,
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(food.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress != null
                                  ? const LoadingScreen()
                                  : child))),
              const SizedBox(height: 18),
              Expanded(
                  flex: 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(food.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Colors.white.withOpacity(0.3))))),
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Lần đặt: ${food.count.toString()}',
                                    textAlign: TextAlign.center)))
                      ])),
              const SizedBox(height: 8)
            ]),
          ),
          Divider(color: context.colorScheme.primary.withOpacity(0.3))
        ]));
  }

  _buildSuccessWidget(BuildContext context, List<Food> foods) {
    return Card(
        elevation: 10,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foods.length >= 20 ? 20 : foods.length,
                itemBuilder: (context, index) =>
                    _buildFoods(context, foods[index]))));
  }
}
