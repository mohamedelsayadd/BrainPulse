import 'package:easy_localization/easy_localization.dart';

import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:brain_pulse/core/Widgets/gap.dart';
import 'package:brain_pulse/core/helpers/extentions.dart';
import 'package:brain_pulse/features/history/logic/cubit/get_all_patients_cubit.dart';
import 'package:brain_pulse/features/history/logic/cubit/get_all_patients_state.dart';
import 'package:brain_pulse/features/history/presentation/screens/patient_details.dart';
import 'package:brain_pulse/features/history/presentation/widgets/history_shimmer.dart';
import 'package:brain_pulse/features/history/presentation/widgets/user_card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredPatients = [];
  List<dynamic> _allPatients = [];

  @override
  void initState() {
    super.initState();
    context.read<GetAllPatientsCubit>().getAllPatients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPatients(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredPatients = _allPatients;
      });
    } else {
      setState(() {
        _filteredPatients = _allPatients.where((patient) {
          final name = patient.name.toLowerCase();
          final phone = patient.phoneNumber.toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || phone.contains(searchQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorsApp.primary,
                  ColorsApp.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      const GapH(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Ionicons.people,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                          const GapW(width: 12),
                          Text(
                            'Patient Records'.tr(),
                            style: TextStyleApp.styleText(
                              24,
                              Colors.white,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const GapH(height: 24),
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            _filterPatients(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Ionicons.search,
                              color: ColorsApp.primary,
                            ),
                            border: InputBorder.none,
                            hintText: 'Search by name or phone...'.tr(),
                            hintStyle: TextStyleApp.styleText(
                              15,
                              Colors.grey,
                              FontWeight.normal,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 15.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const GapH(height: 20),
                Expanded(
                  child: BlocConsumer<GetAllPatientsCubit, GetAllPatientsState>(
                    listenWhen: (previous, current) {
                      return current is ErrorDeletePatient ||
                          current is SuccessDeletePatient ||
                          current is LoadingDeletePatient;
                    },
                    listener: (context, state) {
                      if (state is ErrorDeletePatient) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Ionicons.close_circle,
                                    color: Colors.white),
                                const GapW(width: 8),
                                Expanded(
                                  child: Text(
                                    state.errorMessage,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                      if (state is SuccessDeletePatient) {
                        context.pop();
                        context.read<GetAllPatientsCubit>().getAllPatients();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Ionicons.checkmark_circle,
                                    color: Colors.white),
                                GapW(width: 8),
                                Expanded(
                                  child: Text(
                                    'Patient deleted successfully',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                      if (state is LoadingDeletePatient) {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: ColorsApp.primary,
                            ),
                          ),
                        );
                      }
                    },
                    buildWhen: (previous, current) {
                      return current is LoadingGetAllPatients ||
                          current is ErrorGetAllPatients ||
                          current is SuccessGetAllPatients;
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const SizedBox.shrink(),
                        successGetAllPatients: (patients) {
                          _allPatients = patients.patients;
                          final currentQuery = _searchController.text;
                          if (currentQuery.isEmpty) {
                            _filteredPatients = _allPatients;
                          } else {
                            _filteredPatients = _allPatients.where((patient) {
                              final name = patient.name.toLowerCase();
                              final phone = patient.phoneNumber.toLowerCase();
                              final searchQuery = currentQuery.toLowerCase();
                              return name.contains(searchQuery) ||
                                  phone.contains(searchQuery);
                            }).toList();
                          }
                          if (_filteredPatients.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(24.r),
                                    decoration: BoxDecoration(
                                      color: ColorsApp.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Ionicons.people_outline,
                                      size: 64.sp,
                                      color: ColorsApp.primary,
                                    ),
                                  ),
                                  const GapH(height: 16),
                                  Text(
                                    'No patients found'.tr(),
                                    style: TextStyleApp.styleText(
                                      18,
                                      ColorsApp.grey800,
                                      FontWeight.w500,
                                    ),
                                  ),
                                  const GapH(height: 8),
                                  Text(
                                    'Add new patients to see them here'.tr(),
                                    style: TextStyleApp.styleText(
                                      14,
                                      ColorsApp.grey500,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Container(
                            margin: EdgeInsets.only(top: 16.h),
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              physics: const BouncingScrollPhysics(),
                              itemCount: _filteredPatients.length,
                              itemBuilder: (context, index) {
                                final patient = _filteredPatients[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Slidable(
                                    key: ValueKey(patient.id),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {}),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            context
                                                .read<GetAllPatientsCubit>()
                                                .deletePatient(
                                                    patient.id.toString());
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete'.tr(),
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(16.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return PatientDetails(
                                                patientDetails: patient,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          border: Border.all(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: UserCardInfo(
                                          name: patient.name,
                                          phone: patient.phoneNumber,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        loadingGetAllPatients: () => const HistoryShimmer(),
                        errorGetAllPatients: (errorMessage) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(24.r),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Ionicons.alert_circle_outline,
                                  size: 64.sp,
                                  color: Colors.red,
                                ),
                              ),
                              const GapH(height: 16),
                              Text(
                                'Oops!'.tr(),
                                style: TextStyleApp.styleText(
                                  24,
                                  Colors.red,
                                  FontWeight.bold,
                                ),
                              ),
                              const GapH(height: 8),
                              Text(
                                errorMessage,
                                style: TextStyleApp.styleText(
                                  16,
                                  ColorsApp.grey800,
                                  FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const GapH(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
