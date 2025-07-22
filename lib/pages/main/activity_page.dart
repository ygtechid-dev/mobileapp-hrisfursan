part of '../pages.dart';

class ActivityPage extends StatefulWidget {
  final String token;

  ActivityPage(this.token);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {

  // Method untuk mengecek menu yang diizinkan berdasarkan subscription di Activity page
  bool isActivityAllowed(String activityType, String? subscription) {
    print("=== Checking activity access ===");
    print("Activity: $activityType, Subscription: $subscription");
    
    // Default subscription jika null
    String userSubscription = subscription?.toLowerCase() ?? 'basic';
    
    switch (activityType) {
      case 'analytics':
        // Analytics tersedia untuk Premium, Enterprise
        return ['premium', 'enterprise'].contains(userSubscription);
        
      case 'leave_request':
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

  // Method untuk membuat list ActivityCard berdasarkan subscription
  List<Widget> buildActivityCards(double defaultWidth, String? subscription) {
    List<Widget> cards = [];
    
    // Default subscription jika null
    String userSubscription = subscription?.toLowerCase() ?? 'basic';
    
    print("=== Building activity cards for subscription: $userSubscription ===");
    
    // Jika Basic, tampilkan pesan upgrade
    if (userSubscription == 'basic') {
      return [
        Container(
          width: defaultWidth,
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.star_border,
                size: 64,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text(
                "Upgrade Your Plan",
                style: blackFontStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "Access more features and boost your productivity with Silver, Premium, or Enterprise plans.",
                style: blackFontStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(vertical: 12),
              //   decoration: BoxDecoration(
              //     gradient: backgroundGradient,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(
              //     "View Plans",
              //     style: blackFontStyle.copyWith(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.white,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ],
          ),
        ),
      ];
    }
    
    // Analytics - Premium, Enterprise
    if (isActivityAllowed('analytics', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "analytics".trans(context), "sub_analytics".trans(context), onTap: (){
          Get.to(AnalyticsPage(widget.token));
        })
      );
    }
    
    // Leave Request - Silver, Premium, Enterprise
    if (isActivityAllowed('leave_request', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "leave_request".trans(context), "sub_leave_request".trans(context), onTap: (){
          Get.to(LeavePage(widget.token));
        })
      );
    }
    
    // Overtime Request - Premium, Enterprise
    if (isActivityAllowed('overtime_request', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "overtime_request".trans(context), "sub_overtime_request".trans(context), onTap: (){
          Get.to(OvertimePage(widget.token));
        })
      );
    }
    
    // Reimbursement Request - Enterprise only
    if (isActivityAllowed('reimbursement_request', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "reimbursement_request".trans(context), "sub_reimbursement_request".trans(context), onTap: (){
          Get.to(ReimbursePage(widget.token));
        })
      );
    }
    
    // Calendar - Enterprise only
    if (isActivityAllowed('calendar', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "calendar".trans(context), "sub_calendar".trans(context), onTap: (){
          Get.to(CalendarPage(widget.token));
        })
      );
    }
    
    // Payslip - Premium, Enterprise
    if (isActivityAllowed('payslip', subscription)) {
      cards.add(
        ActivityCard(defaultWidth, "payslip".trans(context), "sub_payslip".trans(context), onTap: (){
          Get.to(PayslipHistoryPage(widget.token));
        })
      );
    }
    
    print("=== Total activity cards created: ${cards.length} ===");
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      heightAppBar: 210,
      appBarColor: mainColor,
      appBarColorGradient: backgroundGradient,
      backColor: "F1F3F8".toColor(),
      isAppBarCircular: true,
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "activity".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "choose_requestment".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("${prefixImages}img_header_activity.png")
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          
          // Activity Cards dengan pembatasan subscription
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded && state.user != null) {
                String? subscription = state.user!.subscription;
                print("=== ActivityPage: User subscription: $subscription ===");
                
                List<Widget> activityCards = buildActivityCards(defaultWidth, subscription);
                
                return Column(
                  children: activityCards,
                );
              }
              
              // Loading state - tampilkan loading indicator
              return Container(
                height: 200,
                child: Center(
                  child: loadingIndicator,
                ),
              );
            }
          ),
          
          SizedBox(height: 50),
        ],
      ),
    );
  }
}