import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/empty_view.dart';
import '../../../../../core/widgets/error_view.dart';
import '../../../../../core/widgets/loading_view.dart';
import '../../../domain/entities/quiz_category.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import 'quiz_setup_dropdown_decoration.dart';
import '../../theme/quiz_setup_palette.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return switch (state.status) {
          QuizSetupStatus.initial || QuizSetupStatus.loading => const SizedBox(
            height: 96,
            child: LoadingView(),
          ),
          QuizSetupStatus.failure => ErrorView(
            message: state.errorMessage ?? AppStrings.categoriesLoadError,
            onRetry: context.read<QuizSetupCubit>().loadCategories,
          ),
          QuizSetupStatus.ready =>
            state.categories.isEmpty
                ? const EmptyView(
                    title: AppStrings.noCategoriesFound,
                    message: AppStrings.noCategoriesMessage,
                  )
                : DropdownButtonFormField<QuizCategory>(
                    menuMaxHeight: 280,
                    dropdownColor: QuizSetupPalette.dropdownColor(context),
                    iconEnabledColor: QuizSetupPalette.secondaryText(context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: QuizSetupPalette.primaryText(context),
                      fontWeight: FontWeight.w600,
                    ),
                    initialValue: state.selectedCategory,
                    decoration: dropDownDecoration(
                      context,
                      AppStrings.chooseCategory,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    isExpanded: true,
                    itemHeight: 56,
                    items: state.categories
                        .map(
                          (category) => DropdownMenuItem<QuizCategory>(
                            value: category,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: context.read<QuizSetupCubit>().selectCategory,
                  ),
        };
      },
    );
  }
}
