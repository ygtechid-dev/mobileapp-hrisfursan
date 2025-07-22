part of '../pages.dart';

class HomePage extends StatefulWidget {
  final String token;

  HomePage(this.token);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    print("=== HomePage initState START ===");
    print("Token: ${widget.token}");
    
    // Debug Working Period
    print("=== Calling getWorkingPeriod ===");
    context.read<WorkingPeriodCubit>().getWorkingPeriod(widget.token);
    
    // Debug User Profile dengan lebih detail
    print("=== BEFORE calling getProfile ===");
    print("Current UserCubit state: ${context.read<UserCubit>().state}");
    
    // Panggil getProfile dan tunggu hasilnya
    _loadUserProfile();
    
    super.initState();
    print("=== HomePage initState END ===");
  }

  Future<void> _loadUserProfile() async {
    try {
      print("=== _loadUserProfile START ===");
      print("Token for getProfile: ${widget.token}");
      
      // Panggil getProfile dan tunggu
      await context.read<UserCubit>().getProfile(widget.token);
      print("=== getProfile method completed ===");
      
      // Check state setelah getProfile
      UserState state = context.read<UserCubit>().state;
      print("=== UserState after getProfile: $state ===");
      
      if (state is UserLoaded) {
        print("=== SUCCESS: UserLoaded ===");
        if (state.user != null) {
          print("User ID: ${state.user!.id}");
          print("User Name: ${state.user!.first_name} ${state.user!.last_name}");
          print("User Email: ${state.user!.email}");
          print("User Plan: ${state.user!.plan}");
          print("User Subscription: ${state.user!.subscription}"); // Tambah debug subscription
          print("User Plan Expire: ${state.user!.plan_expire_date}");
          print("User Avatar: ${state.user!.avatar}");
          if (state.user!.employee != null) {
            print("Employee ID: ${state.user!.employee!.employee_id}");
            print("Employee Name: ${state.user!.employee!.name}");
            if (state.user!.employee!.designation != null) {
              print("Designation: ${state.user!.employee!.designation!.name}");
            }
          } else {
            print("Employee data is null");
          }
        } else {
          print("=== ERROR: User is null in UserLoaded state ===");
        }
      } else if (state is UserLoadingFailed) {
        print("=== ERROR: UserLoadingFailed ===");
        print("Error message: ${state.message}");
      } else {
        print("=== Unknown state: ${state.runtimeType} ===");
      }
      
    } catch (e) {
      print("=== EXCEPTION in _loadUserProfile ===");
      print("Exception: $e");
      print("Exception type: ${e.runtimeType}");
    }
    
    print("=== _loadUserProfile END ===");
  }

  // Method untuk mengecek menu yang diizinkan berdasarkan subscription
  bool isMenuAllowed(String menuType, String? subscription) {
    print("=== Checking menu access ===");
    print("Menu: $menuType, Subscription: $subscription");
    
    // Default subscription jika null
    String userSubscription = subscription?.toLowerCase() ?? 'basic';
    
    switch (menuType) {
      case 'attendance_log':
        // Attendance log tersedia untuk semua subscription
        return true;
        
      case 'leave_request_alt':
        // Leave request tersedia untuk Silver, Premium, Enterprise
        return ['silver', 'premium', 'enterprise'].contains(userSubscription);
        
      case 'overtime_request':
        // Overtime request tersedia untuk Premium, Enterprise
        return ['premium', 'enterprise'].contains(userSubscription);
        
      case 'reimbursement_request':
        // Reimbursement tersedia hanya untuk Enterprise
        return ['enterprise'].contains(userSubscription);
        
      case 'calendar':
        // Calendar tersedia hanya untuk Enterprise
        return ['enterprise'].contains(userSubscription);
        
      case 'payslip':
        // Payslip tersedia untuk Premium, Enterprise
        return ['premium', 'enterprise'].contains(userSubscription);
        
      default:
        return false;
    }
  }

  // Method untuk membuat menu dengan kondisi subscription
  Widget buildMenuCard(double width, String menuType, String labelKey, String iconPath, VoidCallback? onTap, String? subscription) {
    bool isAllowed = isMenuAllowed(menuType, subscription);
    
    if (!isAllowed) {
      // Return menu yang disabled atau tidak tampil sama sekali
      return Container(
        width: width,
        height: 80, // Sesuaikan dengan tinggi MenuCard asli
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, color: Colors.grey[600], size: 24),
            SizedBox(height: 4),
            Text(
              "Upgrade Required",
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
    
    // Return menu normal jika diizinkan
    return MenuCard(width, labelKey.trans(context), iconPath, onTap: onTap);
  }

  Future<List<String?>> getDataShared(String employee_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);

    var dateBefore = await prefs.getString('date');
    String? clockin;
    String? clockout;

    ApiReturnValue<Attendant> result = await AttendanceServices.getEmployeeHistory(widget.token, employee_id, formattedDate, formattedDate);

    if(result != null && result.value != null) {
      if (result.value!.attendance_records != null &&
          result.value!.attendance_records!.isNotEmpty) {
        if (result.value!.attendance_records![0].clock_in != null) {
          clockin =
              result.value!.attendance_records![0].clock_in!;
        }

        if (result.value!.attendance_records![0].clock_out != null) {
          clockout =
              result.value!.attendance_records![0].clock_out!;
        }
      }
    }
    return [clockin, clockout];
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      heightAppBar: 240,
      appBarColor: mainColor,
      backColor: "F1F3F8".toColor(),
      appBarColorGradient: backgroundGradient,
      isAppBarCircular: true,
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    print("=== BlocBuilder UserCubit triggered ===");
                    print("Current state: $state");
                    print("State type: ${state.runtimeType}");
                    
                    if (state is UserLoaded) {
                      print("=== BlocBuilder: UserLoaded ===");
                      if (state.user != null) {
                        print("User name: ${state.user!.first_name} ${state.user!.last_name}");
                        print("User plan: ${state.user!.plan}");
                        print("User subscription: ${state.user!.subscription}"); // Debug subscription di BlocBuilder
                        print("User avatar: ${state.user!.avatar}");
                        
                        return Row(
                          children: [
                            (state.user!.avatar != null && state.user!.avatar != "") ? Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider("${state.user!.avatar}")
                                  )
                              ),
                            ) : Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("${prefixImages}img_avatar_dummy.png")
                                  )
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.user!.first_name} ${state.user!.last_name}",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                BlocBuilder<UserCubit, UserState>(
                                    builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Text(
                                      "${(state.user!.employee != null) ? state.user!.employee!.designation!.name : ""}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                                    ) : SizedBox() : loadingIndicator
                                ),
                                // Tambahkan display subscription di UI
                                BlocBuilder<UserCubit, UserState>(
                                    builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Text(
                                      "Subscription: ${state.user!.subscription ?? 'Basic'}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.w300),
                                    ) : SizedBox() : SizedBox()
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        print("=== BlocBuilder: UserLoaded but user is null ===");
                        return SizedBox();
                      }
                    } else if (state is UserLoadingFailed) {
                      print("=== BlocBuilder: UserLoadingFailed ===");
                      print("Error: ${state.message}");
                      return loadingIndicator;
                    } else {
                      print("=== BlocBuilder: Unknown/Loading state - ${state.runtimeType} ===");
                      return loadingIndicator;
                    }
                  }
                ),
                InkWell(
                  onTap: (){
                    Get.to(NotificationPage(widget.token));
                  },
                  child: SvgPicture.asset("${prefixIcons}ic_notification.svg", height: 36, width: 36),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          BlocBuilder<UserCubit, UserState>(
              builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? FutureBuilder(
                  future: getDataShared("${state.user!.employee!.employee_id}"),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return WorkingCard(widget.token, defaultWidth, clockin: snapshot.data![0], clockout: snapshot.data![1],);
                    } else {
                      return loadingIndicator;
                    }
                  }
              ) : SizedBox() : loadingIndicator
          ),
          SizedBox(height: 16),
          // Menu section dengan pembatasan subscription
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded && state.user != null) {
                String? subscription = state.user!.subscription;
                double menuWidth = (defaultWidth - 2*12)/3;
                
                return Container(
                  width: defaultWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Attendance Log - Tersedia untuk semua subscription
                          buildMenuCard(
                            menuWidth, 
                            'attendance_log', 
                            "attendance_log", 
                            "ic_attendance.svg", 
                            isMenuAllowed('attendance_log', subscription) ? () {
                              Get.to(AttendantHistoryPage(widget.token, "${(state.user!.employee != null) ? state.user!.employee!.employee_id : ""}"));
                            } : null,
                            subscription
                          ),
                          
                          // Leave Request - Silver, Premium, Enterprise
                          buildMenuCard(
                            menuWidth, 
                            'leave_request_alt', 
                            "leave_request_alt", 
                            "ic_leave.svg", 
                            isMenuAllowed('leave_request_alt', subscription) ? () {
                              Get.to(LeavePage(widget.token));
                            } : null,
                            subscription
                          ),
                          
                          // Overtime Request - Premium, Enterprise
                          buildMenuCard(
                            menuWidth, 
                            'overtime_request', 
                            "overtime_request", 
                            "ic_overtime.svg", 
                            isMenuAllowed('overtime_request', subscription) ? () {
                              Get.to(OvertimePage(widget.token));
                            } : null,
                            subscription
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Reimbursement - Enterprise only
                          buildMenuCard(
                            menuWidth, 
                            'reimbursement_request', 
                            "reimbursement_request", 
                            "ic_reimbursement.svg", 
                            isMenuAllowed('reimbursement_request', subscription) ? () {
                              Get.to(ReimbursePage(widget.token));
                            } : null,
                            subscription
                          ),
                          
                          // Calendar - Enterprise only
                          buildMenuCard(
                            menuWidth, 
                            'calendar', 
                            "calendar", 
                            "ic_calendar_home.svg", 
                            isMenuAllowed('calendar', subscription) ? () {
                              Get.to(CalendarPage(widget.token));
                            } : null,
                            subscription
                          ),
                          
                          // Payslip - Premium, Enterprise
                          buildMenuCard(
                            menuWidth, 
                            'payslip', 
                            "payslip", 
                            "ic_payslip.svg", 
                            isMenuAllowed('payslip', subscription) ? () {
                              Get.to(PayslipHistoryPage(widget.token));
                            } : null,
                            subscription
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              
              // Loading state
              return Container(
                width: defaultWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: loadingIndicator,
              );
            }
          ),
          SizedBox(height: 16),
          BlocBuilder<WorkingPeriodCubit, WorkingPeriodState>(
              builder: (context, state) => (state is WorkingPeriodLoaded) ? (state.data != null) ? GraphCard(defaultWidth, state.data!.monthly_data ?? []) : SizedBox() : loadingIndicator
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  void modalBottomSheetTermination(contexts, String token){
    double fullWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalTerminationCard(token, fullWidth, 16);
        });
  }
}