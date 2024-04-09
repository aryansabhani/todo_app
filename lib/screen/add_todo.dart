import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_app/heloper/helper.dart';
import 'package:todo_app/heloper/themeHelper.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController header = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController body = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  List arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: InkWell(
        onTap: () async {
          if (globalKey.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (context) {
                return PopScope(
                    canPop: false,
                    child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.2)),
                        height: double.maxFinite,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                    onPopInvoked: (val) async {});
              },
            );
            await ApiHelper.apihelper.addTodo(
                body: body.text,
                head: header.text,
                date: date.text,
                number: arg.length == 0 ? '1' : "${arg.length + 1}");
            Get.offAllNamed('/home');
          }

          // Get.toNamed('/addTodo', arguments: tdata);
        },
        child: Container(
          height: s.height * 0.08,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // color: Color(0xff5949F0),
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
          child: Text(
            "SAVE",
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Add Todo",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFormField(
                // autofocus: true,
                controller: header,
                autofillHints: [AutofillHints.email],
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter head line';
                  }
                },
                // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                decoration: InputDecoration(
                  labelText: 'Head Line',
                  // labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E3E7),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(24),
                ),
                minLines: null,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                cursorColor: Color(0xFF4B39EF),
              ),
              SizedBox(
                height: s.height * 0.02,
              ),
              TextFormField(
                // autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please select date';
                  }
                },

                controller: date,
                autofillHints: [AutofillHints.email],
                obscureText: false,
                readOnly: true,
                onTap: () {
                  !ThemeHelper.isdark
                      ? selectNextfollowupDate(context)
                      : darkselectNextfollowupDate(context);
                },
                // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                decoration: InputDecoration(
                  labelText: 'TODO Date',
                  // labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E3E7),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(24),
                ),
                minLines: null,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                cursorColor: Color(0xFF4B39EF),
              ),
              SizedBox(
                height: s.height * 0.02,
              ),
              TextFormField(
                // autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter summary';
                  }
                },

                controller: body,
                autofillHints: [AutofillHints.email],
                obscureText: false,
                maxLines: 4,
                // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                decoration: InputDecoration(
                  labelText: 'Summary',
                  alignLabelWithHint: true,
                  // labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E3E7),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xFFFF5963),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(24),
                ),
                minLines: null,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                cursorColor: Color(0xFF4B39EF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectNextfollowupDate(BuildContext context) async {
    date.text =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 200,
          width: double.maxFinite,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            // backgroundColor: Colors.white,
            onDateTimeChanged: (val1) {
              var newdate = val1;
              date.text = "${newdate.day}-${newdate.month}-${newdate.year}";
            },
            use24hFormat: false,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(1990),
            maximumDate: DateTime(DateTime.now().year + 100),
          ),
        );
      },
    );
  }

  Future<void> darkselectNextfollowupDate(BuildContext context) async {
    date.text =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.black54,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 200,
          width: double.maxFinite,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            // backgroundColor: Colors.white,
            onDateTimeChanged: (val1) {
              var newdate = val1;
              date.text = "${newdate.day}-${newdate.month}-${newdate.year}";
            },
            use24hFormat: false,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(1990),
            maximumDate: DateTime(DateTime.now().year + 100),
          ),
        );
      },
    );
  }
}
