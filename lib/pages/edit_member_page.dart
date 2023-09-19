import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';

import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/member/form.dart';

class EditMemberPage extends StatelessWidget {
  final String? memberId;

  const EditMemberPage({super.key, required this.memberId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
      
    if (memberId == null || members.indexWhere((element) => element.id == memberId) == -1) {
      context.pop();
      return Scaffold(
        body: Center(
          child: Text('Page Not found',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      );
    }

    final Member member = members.firstWhere((member) => member.id == memberId);

    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const PageHeading(title: 'Edit Member'),
            Form(
                key: formKey,
                child: MemberForm(
                    member: member, formType: 'Edit', formKey: formKey))
          ],
        ),
      ),
    );
  }
}
