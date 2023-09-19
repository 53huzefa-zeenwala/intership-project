import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/widgets/base_input_widget/base_view.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
import 'package:main_project/widgets/custom_fields/custom_dropdown.dart';
import 'package:main_project/widgets/custom_fields/textfield/normal_textfield.dart';
import 'package:main_project/widgets/custom_fields/custom_date_picker.dart';
import 'package:main_project/utils/constants.dart';
import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/teams.dart';

class MemberForm extends StatefulWidget {
  final Member member;
  final String formType;
  final GlobalKey<FormState> _formKey;
  const MemberForm(
      {super.key,
      required this.member,
      required this.formType,
      required GlobalKey<FormState> formKey})
      : _formKey = formKey;

  @override
  State<MemberForm> createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  late Member member;

  @override
  void initState() {
    super.initState();
    member = widget.member;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> teams = Team.values.map(
      (element) {
        return getTeamString(element);
      },
    ).toList();
    final List<String> departments = Department.values.map(
      (element) {
        return getDepartmentString(element);
      },
    ).toList();

    return Column(
      children: [
        InputContainer(
            child: Column(
          children: [
            InputFrame(
              title: 'First Name',
              inputField: NormalTextField(
                labelText: '',
                autoFocus: true,
                defaultValue:
                    member.firstName.isNotEmpty ? member.firstName : null,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "First Name can't be empty";
                  }
                  return null;
                },
                onSaved: (value) => member.firstName = value!,
              ),
            ),
            InputFrame(
              title: 'Last Name',
              inputField: NormalTextField(
                labelText: '',
                defaultValue:
                    member.lastName.isNotEmpty ? member.lastName : null,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return "Last Name can't be empty";
                  }
                  return null;
                },
                onSaved: (value) => member.lastName = value!,
              ),
            )
          ],
        )),
        InputContainer(
          child: Column(
            children: [
              InputFrame(
                title: 'Phone Number',
                inputField: NormalTextField(
                  labelText: '',
                  defaultValue:
                      member.phoneNumber == null || member.phoneNumber!.isEmpty
                          ? null
                          : member.phoneNumber!,
                  onSaved: (value) => member.phoneNumber = value!,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (value.length < 10) {
                      return 'Phone number atleast have 10 digit';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              InputFrame(
                title: 'Email',
                inputField: NormalTextField(
                  labelText: '',
                  onSaved: (value) => member.email = value!,
                  defaultValue: member.email.isNotEmpty ? member.email : null,
                  keyboardType: TextInputType.emailAddress,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    if (!EmailValidator.validate(value)) {
                      return 'Email is not valid';
                    }
                    return null;
                  },
                ),
              ),
              InputFrame(
                title: 'Joining Date',
                inputField: CustomDatePicker(
                  onSaved: (val) => member.joinDate = val == null ? null : 
                      DateFormat(Constants.dateFormat).format(val),
                  defaultValue: member.joinDate == null
                      ? null
                      : DateFormat(Constants.dateFormat).parse(
                          member.joinDate!,
                        ),
                  validator: (val) {
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
        InputContainer(
          child: Column(
            children: [
              InputFrame(
                title: 'Department',
                inputField: CustomDropDown(
                  dropItems: departments,
                  defaultValue: getDepartmentString(member.department),
                  labelText: '',
                  onSaved: (value) => member.department = getDepartment(value![0])!,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please Assign Department';
                    }
                    return null;
                  },
                ),
              ),
              InputFrame(
                title: 'Team',
                inputField: CustomDropDown(
                  defaultValue: getTeamString(member.team),
                  dropItems: teams,
                  labelText: '',
                  onSaved: (value) => member.team = getTeam(value![0])!,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please Assign team';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PrimaryButton(
            title: "${widget.formType == 'New' ? 'Add' : 'Update'} Member",
            onTap: () {
              if (widget._formKey.currentState!.validate()) {
                widget._formKey.currentState!.save();
                print(member);
              }
            },
            paddingVertical: 18,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
