import 'dart:io';
import 'dart:async';

import 'package:app_ban_sach/resources/strings.dart';
import 'package:app_ban_sach/resources/widgets/elevated_button_custom.dart';
import 'package:app_ban_sach/resources/widgets/horizontal_bar.dart';
import 'package:app_ban_sach/resources/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FocusNode myFocusNode;
  TextEditingController? controllerClient;
  TextEditingController? controllerNumberBooks;
  double totalMoney = 0.0;
  bool isClientVip = false;
  int totalClients = 0;
  int totalClientsVip = 0;
  double totalRevenue = 0.0;
  late double promotion;

  Future<void> openDialogRevenue() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Center(
            child: Text(nameBtnStatistical),
          ),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  const Expanded(child: Text(nameLabelTotalRevenue+": ", style: TextStyle(fontSize: 20),),),
                  Expanded(child: Text(totalRevenue.round().toString()+"VNĐ", style: const TextStyle(fontSize: 20),),),
                ],
              ),
            )
          ],
        );
      }
    );
  }

  Future<void> openDialogQuit() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(nameLabelNotification),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Bạn có chắc muốn thoát khỏi chương trình?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalClients = (prefs.getInt('totalClients') ?? 0);
      totalClientsVip = (prefs.getInt('totalClientsVip') ?? 0);
      totalRevenue = (prefs.getDouble('totalRevenue') ?? 0.0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    controllerClient = TextEditingController();
    controllerNumberBooks = TextEditingController();
    myFocusNode = FocusNode();
  }

  void incrementClients() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalClients = ((prefs.getInt('totalClients') ?? 0) + 1);
      prefs.setInt('totalClients', totalClients);
    });
  }

  void incrementClientsVip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalClientsVip = ((prefs.getInt('totalClientsVip') ?? 0) + 1);
      prefs.setInt('totalClientsVip', totalClientsVip);
    });
  }

  void sumRevenue({required double totalMoney}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalRevenue = ((prefs.getDouble('totalRevenue') ?? 0.0) + totalMoney);
      prefs.setDouble('totalRevenue', totalRevenue);
    });
  }
  
  void removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('totalClients');
      prefs.remove('totalClientsVip');
      prefs.remove('totalRevenue');
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(nameApp),
        titleTextStyle: const TextStyle(fontSize: fontSizeCustom),
        toolbarHeight: 25,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const HorizontalBar(nameTitle: nameBill),
              Row(
                children: [
                  const Expanded(child: Text("Tên Khách Hàng", style: TextStyle(fontSize: fontSizeCustom),),),
                  Expanded(flex: 2, child: TextInputWidget(focusNode: myFocusNode, hintText: "Nhập tên khách hàng", controller: controllerClient,))
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text("Số lượng sách", style: TextStyle(fontSize: fontSizeCustom),),),
                  Expanded(flex: 2, child: TextInputWidget(focusNode: FocusNode(canRequestFocus: false), hintText: "Nhập số lượng sách", controller: controllerNumberBooks,))
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text(""),),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                            value: isClientVip,
                            onChanged: (bool? value) {
                              setState(() {
                                isClientVip = value!;
                              });
                            },
                          ),
                        ),
                        const Expanded(
                          flex: 8,
                          child: Text("Khách hàng Vip", style: TextStyle(fontSize: fontSizeCustom),),
                        )
                      ],
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text("Thành Tiền", style: TextStyle(fontSize: fontSizeCustom),),),
                  Expanded(
                    flex: 2,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: const EdgeInsets.all(0),
                      borderOnForeground: false,
                      color: Colors.white30,
                      child: SizedBox(
                        height: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalMoney.round().toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: fontSizeCustom,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButtonCustom(
                      nameBtn: nameBtnCalMoney,
                      onPressed: () {
                        setState(() {
                          if(isClientVip == true) {
                            promotion = 0.9;
                          } else {
                            promotion = 1;
                          }
                          totalMoney = double.parse(controllerNumberBooks!.text) * 20000 * promotion;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButtonCustom(
                      nameBtn: nameBtnNext,
                      onPressed: (){
                        setState(() {
                          if((controllerClient!.text != '') && (controllerNumberBooks!.text != '') && (totalMoney != 0.0)) {
                            if(isClientVip) {
                              incrementClients();
                              incrementClientsVip();
                            } else {
                              incrementClients();
                            }
                            sumRevenue(totalMoney: totalMoney);
                            controllerClient!.text = '';
                            controllerNumberBooks!.text = '';
                            totalMoney = 0.0;
                            myFocusNode.requestFocus();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButtonCustom(
                      nameBtn: nameBtnStatistical,
                      onPressed: (){
                        openDialogRevenue();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              const HorizontalBar(nameTitle: nameStatistical),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Expanded(child: Text(nameLabelTotalClients+":", style: TextStyle(fontSize: fontSizeCustom),),),
                    Expanded(
                      flex: 2,
                      child: Text(totalClients.toString(), style: const TextStyle(fontSize: fontSizeCustom),),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Expanded(child: Text(nameLabelTotalClientsVip+":", style: TextStyle(fontSize: fontSizeCustom),),),
                    Expanded(
                      flex: 2,
                      child: Text(totalClientsVip.toString(), style: const TextStyle(fontSize: fontSizeCustom),),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Expanded(child: Text(nameLabelTotalRevenue+":", style: TextStyle(fontSize: fontSizeCustom),),),
                    Expanded(
                      flex: 2,
                      child: Text(totalRevenue.round().toString(), style: const TextStyle(fontSize: fontSizeCustom),),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const HorizontalBar(nameTitle: ''),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: "Thoát khỏi chương trình",
                  onPressed: () {
                    openDialogQuit();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerClient!.dispose();
    controllerNumberBooks!.dispose();
    myFocusNode.dispose();
  }
}
