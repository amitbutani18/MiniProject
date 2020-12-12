import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:miniProject/Helpers/upload_sedual.dart';
import 'package:miniProject/Screens/razorpay_screen.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:provider/provider.dart';

class ScheduleingScreen extends StatefulWidget {
  static const routeName = '/Scheduleing';

  final DoctorListObj personalDetails;

  ScheduleingScreen({@required this.personalDetails});

  @override
  _ScheduleingScreenState createState() => _ScheduleingScreenState();
}

class _ScheduleingScreenState extends State<ScheduleingScreen> {
  DateTime fromDate, toDate;
  int _selectedIndex = 0;
  bool isSelected = false;
  TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  List listcall = [
    {
      "time": "4:00 PM",
    },
    {
      "time": "4:30 PM",
    },
    {
      "time": "5:00 PM",
    },
    {
      "time": "5:30 PM",
    },
    {
      "time": "6:00 PM",
    },
    {
      "time": "6:30 PM",
    },
    {
      "time": "7:00 PM",
    },
    {
      "time": "7:30 PM",
    },
    {
      "time": "8:00 PM",
    },
    {
      "time": "8:30 PM",
    },
    {
      "time": "9:00 PM",
    },
    {
      "time": "9:30 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Your Appoientment"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(top: 15, left: 13, right: 13, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Date",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$selectedDate",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            Icon(
                              Icons.date_range,
                              color: Colors.grey[700],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        // child: RawChip(
                        //   label: ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: listcall.length,
                        //     itemBuilder: (context, index) => Text(
                        //       listcall[index]["time"],
                        //     ),
                        //   ),
                        //   showCheckmark: false,
                        //   backgroundColor: Colors.grey[300],
                        // ),
                        // child: ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: listcall.length,
                        //   itemBuilder: (context, index) => RawChip(
                        //     label: Text(listcall[index]["time"]),
                        //     showCheckmark: false,
                        //     backgroundColor: Colors.grey[300],
                        //   ),
                        // ),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            for (int i = 0; i < listcall.length; i++) ...[
                              RawChip(
                                label: Text(
                                  listcall[i]["time"],
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                showCheckmark: false,
                                // backgroundColor: Colors.grey[300],
                                backgroundColor:
                                    isSelected ? Colors.red : Colors.grey[300],
                                // checkmarkColor: Colors.blue,
                                selectedColor: Colors.red,
                                selected: i == _selectedIndex,
                                // onPressed: () {
                                //   setState(() {
                                //     isSelected = !isSelected;
                                //   });
                                // },
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedIndex = i;
                                      switch (_selectedIndex) {
                                        case 0:
                                          // {
                                          print("4.00");
                                          // }
                                          break;
                                      }
                                      print(_selectedIndex);
                                    });
                                  }
                                  // setState(() {
                                  //   isSelected = !isSelected;
                                  // });
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.only(bottom: 15),
                height: 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: RaisedButton(
                    onPressed: _submit,
                    color: Colors.blue,
                    disabledColor: d_colorPrimary,
                    child: Text(
                      "Schedule",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit() async {
    await Provider.of<UploadSedual>(context, listen: false)
        .uploadSedual(widget.personalDetails);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => RazorPayScreen(
              personalDetails: widget.personalDetails,
            )));
  }
}
