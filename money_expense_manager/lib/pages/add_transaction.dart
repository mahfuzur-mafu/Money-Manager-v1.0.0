import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense/controllers/db_helper.dart';
import 'package:expense/static.dart' as Static;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  //

  int? amonunt;
  String note="Milk";
  String types="income";
  DateTime sdate = DateTime.now();
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sdate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sdate) {
      setState(() {
        sdate = picked;
      });
    }
  }


  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
        persistentFooterButtons: [

          Container(

            width: 900,
            child: Text(
              '© mahfuzurmafu',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],

      //backgroundColor: Color(0xffe2e7ef),

      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text("Add Transaction",
          textAlign: TextAlign.center,

          style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w700,
          color: Colors.green),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
          decoration: BoxDecoration(
              color: Static.PrimaryMaterialColor,
            borderRadius: BorderRadius.circular(16.0)
          ),

                padding: EdgeInsets.all(12.0),
                child:
                  Icon(Icons.attach_money,size: 24.0,color: Colors.white,),

    ),
                 SizedBox(
                   width: 12.0,
                 ),
                  Expanded(

                    child:
                      TextField(
                        decoration: InputDecoration(
                          hintText: "৳",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24.0,),
                        onChanged: (val) {
                          try{
                            amonunt = int.parse(val);

                          }
                          catch(e) {}

                        },

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly

                        ],
                        keyboardType: TextInputType.number,

                      ),

                  ),


            ],
          ),
          SizedBox(
            height: 20.0,
          ),

////////------------------------2nd
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Static.PrimaryMaterialColor,
                    borderRadius: BorderRadius.circular(16.0)
                ),

                padding: EdgeInsets.all(12.0),
                child:
                Icon(Icons.description,size: 24.0,color: Colors.white,),

              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(

                child:
                TextField(
                  decoration: InputDecoration(
                    hintText: "Note of Transaction",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24.0,
                  ),
                  onChanged: (val){
                    note=val;
                  },


                ),

              ),


            ],
          ),

          SizedBox(
            height: 20.0,
          ),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Static.PrimaryMaterialColor,
                    borderRadius: BorderRadius.circular(16.0)
                ),

                padding: EdgeInsets.all(12.0),
                child:
                Icon(Icons.moving_sharp,size: 24.0,color: Colors.white,
                ),

              ),

              SizedBox(
                width: 12.0,
              ),

              ChoiceChip(label: Text("Income",   style: TextStyle(
                  fontSize: 16.0, color:  types == "Income" ? Colors.white:Colors.black,
              ),),

                  selectedColor: Static.PrimaryMaterialColor,
                  selected: types == "Income" ? true:false ,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Income";
                      if (note.isEmpty || note == "Expense") {
                        note = 'Income';
                      }
                    });
                  }
                },),


              SizedBox(
                width: 12.0,
              ),

              ChoiceChip(label: Text("Expense",   style: TextStyle(
                fontSize: 16.0, color:  types == "Income" ? Colors.white:Colors.black,
              ),),

                selectedColor: Static.PrimaryMaterialColor,
                selected: types == "Expense" ? true:false ,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Expense";
                      if (note.isEmpty || note == "Expense") {
                        note = 'Expense';
                      }
                    });
                  }
                },),




            ],
          ),

          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child:
          TextButton(
              onPressed: () {
                _selectDate(context);
              },
            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryMaterialColor,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.date_range,
                      size: 24.0,
                      // color: Colors.grey[700],
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),

                  Text(
                    "${sdate.day} ${months[sdate.month - 1]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],

              ),
          ),
          ),

          SizedBox(
            height: 20.0,
          ),

          SizedBox(
            height:50.0,
          child:
          ElevatedButton(onPressed: () {
            if (amonunt != null) {
              DbHelper dbHelper = DbHelper();
               dbHelper.addData(amonunt!, sdate, types, note);

              Navigator.of(context).pop();
            }
            else {
              print("Not ");
            }
            // print(amonunt);
            // print(note);
            // print(types);
            // print(sdate);
          }, child: Text("Add",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),

          ),
          ),
          )
        ],
      )
    );
  }
}
