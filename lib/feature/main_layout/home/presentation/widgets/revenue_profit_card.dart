import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class RevenueProfitCard extends StatelessWidget {
  const RevenueProfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${appLocalizations.revenue} &\n${appLocalizations.profit}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
              ),

              Container(
                padding: REdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${appLocalizations.last} 30 ${appLocalizations.days}"),
                    SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 40.h),

          SizedBox(
            height: 220.h,
            child: const Center(
              child: Text("Chart Here"),
            ),
          )
        ],
      ),
    );
  }
}