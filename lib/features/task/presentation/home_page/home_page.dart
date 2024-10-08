import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_sync/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_sync/features/task/presentation/cubit/home_cubit.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/addtask_body.dart';
import 'package:task_sync/injection_container.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/utils/utils.dart';
import 'new_task/common _widgets/back_button.dart';
import 'components/progress_task.dart';
import 'components/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().loadDataAndUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.errorMessage.isNotEmpty) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        }
        return Scaffold(
          backgroundColor: black,
          floatingActionButton: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.black,
              isScrollControlled: true,
              builder: (BuildContext modalContext) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: sl<TaskBloc>()),
                    BlocProvider.value(value: sl<AuthBloc>()),
                  ],
                  child: TaskBody(
                      parentContext: context), // Pass the parent context
                );
              },
            ),
            child: Container(
              height: 65,
              width: 65,
              margin: const EdgeInsets.only(right: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  gradient: const LinearGradient(colors: [
                    Colors.pinkAccent,
                    Colors.purpleAccent,
                  ])),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppIcon.menu,
                        // ignore: deprecated_member_use
                        color: Colors.white,
                        height: 30,
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'Hi, ${state.user?.displayName}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          Text(
                            Utils.formatDate(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const CustomBackButton(
                        height: 40,
                        width: 40,
                        radius: 40,
                        widget: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: FlutterLogo(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SearchField(),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Progress  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: '(100%) ',
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ProgressTask(
                  taskList: state.tasks,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Tasks',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 70,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.pinkAccent,
                                      border: Border.all(color: Colors.white)),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Create a new task',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.purpleAccent,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
