import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showRecordBadge; // ✅ 추가
  final bool automaticallyImplyLeading;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showRecordBadge = false,           // ✅ 기본은 표시 안 함
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: showRecordBadge
          ? [
        Consumer<DentalDataProvider>(
          builder: (context, p, _) {
            final isPm = p.recordType == 'PM';
            final no = isPm ? p.pmNumber : p.amNumber;
            final label = isPm ? 'PM' : 'AM';
            final icon = isPm ? Icons.person_off : Icons.person;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Chip(
                avatar: Icon(icon, size: 18),
                label: Text(
                  '$label No: ${no.isEmpty ? "-" : no}',
                  overflow: TextOverflow.ellipsis,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            );
          },
        ),
      ]
          : null,
    );
  }
}
