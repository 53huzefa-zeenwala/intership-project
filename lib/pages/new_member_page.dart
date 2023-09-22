import 'package:flutter/material.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/widgets/fields/csv_file_input.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';

import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/member/form.dart';

class NewMemberPage extends StatelessWidget {
  const NewMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final String memberId = DateTime.now().millisecondsSinceEpoch.toString();
    final Member member = Member(
      id: memberId,
      firstName: '',
      lastName: '',
      department: Department.functional,
      email: '',
      team: Team.support,
    );
    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            PageHeading(
              title: 'Add Member',
              button: CsvFileInput(upload: (val) {}),
            ),
            Form(
                key: formKey,
                child: MemberForm(
                    member: member, formType: 'New', formKey: formKey))
          ],
        ),
      ),
    );
  }
}
