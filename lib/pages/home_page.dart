import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  // var f = DateFormat("dd/MM/yyyy EEEE");
  var formatText = DateFormat("dd/MM/yyyy");

  var modVal = 0;
  var houseName = "";
  var pickedDay = "";

  var isChecked = false;

  var isLateFourth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mahabote"),
      ),
      body: _homeDesign(),
    );
  }

  TextStyle _selectedColor(val) => TextStyle(
      color: houseName == val ? Theme.of(context).primaryColor : Colors.black);

  TextStyle _pickedColor(val) => TextStyle(
      color: pickedDay == val ? Theme.of(context).primaryColor : Colors.black);

  Text _labelResultText(val) => Text(val , style: _pickedColor(val));

  Text _labelText(val) => Text(val, style: _selectedColor(val));

  Widget _mahaboteLayout() => Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(""),
            _labelText("အဓိပတိ"),
            const Text(""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelText("အထွန်း"),
            _labelText("သိုက်"),
            _labelText("ရာဇ"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelText("မရဏ"),
            _labelText("ဘင်္ဂ"),
            _labelText("ပုတိ"),
          ],
        ),
      ],
    ),
  );

  Widget _resultLayout(mod,first,second,third,fourth,fifth,sixth) => Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(""),
            Padding(padding: const EdgeInsets.all(5.0),
            child: _labelResultText(sixth.toString())),
            const Text(""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(second.toString())),
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(third.toString())),
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(fourth.toString())),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(first.toString())),
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(mod.toString())),
            Padding(padding: const EdgeInsets.all(5.0),
                child: _labelResultText(fifth.toString())),
          ],
        ),
      ],
    ),
  );

  String _houseResult(year, day) {
    //print(day);
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်","ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  String _checkPickedDayColor (day){
    if(day == 7){
      var result = 1;
      return result.toString();
    }else if(day == 6){
      var result = 0;
      return result.toString();
    }else{
      var result = day + 1;
      return result.toString();
    }
  }

  Widget switchCase(modVal) {
    switch(modVal){
      case 1 :
        return _resultLayout(modVal, 4, 0, 3, 6, 2 , 5);
      case 2 :
        return _resultLayout(modVal, 5, 1, 4, 0, 3 , 6);
      case 3 :
        return _resultLayout(modVal, 6, 2, 5, 1, 4 , 0);
      case 4 :
        return _resultLayout(modVal, 0, 3, 6, 2, 5 , 1);
      case 5 :
        return _resultLayout(modVal, 1, 4, 0, 3, 6 , 2);
      case 6 :
        return _resultLayout(modVal, 2, 5, 1, 4, 0 , 3);
    }
    return _resultLayout(1, 4, 0, 3, 6, 2 , 5);
  }

  Widget _homeDesign() => SafeArea(
    child: ListView(
      children: <Widget>[
        Container(
          height: 120,
          color: Theme.of(context).primaryColor,
          child: ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2025),
                    helpText: 'Select Your Birthday', // Can be used as title
                    cancelText: 'Not now');
                  if (picked != null) {
                    //Check April First / Later

                    var myanmarYear = picked.year - 638;
                    var pickedMonth = picked.month;

                    if (pickedMonth < 4) {
                      debugPrint("Month $pickedMonth");

                      setState(() {
                        isLateFourth = false;
                        selectedDate = picked;
                        myanmarYear = picked.year - 639;
                        modVal = myanmarYear % 7;
                        houseName = _houseResult(myanmarYear, picked.weekday);
                        pickedDay = _checkPickedDayColor(picked.weekday);
                        selected = true;
                      });
                    }else if(pickedMonth == 4){
                      setState(() {
                        isLateFourth = true;
                        myanmarYear = picked.year - 639;
                        modVal = myanmarYear % 7;
                        houseName = _houseResult(myanmarYear, picked.weekday);
                        pickedDay = _checkPickedDayColor(picked.weekday);
                        selectedDate = picked;
                        selected = true;
                      });
                    }else{
                      setState(() {
                        isLateFourth = false;
                        myanmarYear = picked.year - 638;
                        modVal = myanmarYear % 7;
                        houseName = _houseResult(myanmarYear, picked.weekday);
                        pickedDay = _checkPickedDayColor(picked.weekday);
                        selectedDate = picked;
                        selected = true;
                      });
                    }
                }
              },
              child: selected
                  ? Text(formatText.format(selectedDate),style: TextStyle(
                fontSize: 25,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
              ),)
                  :  Text("Select Your Birthday",style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.fill
                  ..color = Colors.white,
              ),)),
        ),
        isLateFourth == false ? Container() : Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('မြန်မာနှစ်သစ်ကူးပီးမှ မွေးဖွားသည် ',style: TextStyle(fontSize: 15.0,color: Colors.white), ),
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                    debugPrint("Checked $isChecked");
                    if(isChecked == false){
                      var myanmarYear = selectedDate.year - 639;
                      modVal = myanmarYear % 7;
                      houseName = _houseResult(myanmarYear, selectedDate.weekday);
                    }else{
                      var myanmarYear = selectedDate.year - 638;
                      modVal = myanmarYear % 7;
                      houseName = _houseResult(myanmarYear, selectedDate.weekday);
                    }

                  });
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          height: 150,
          child: Card(child: Center(child: _mahaboteLayout())),
        ),
        selected == false
            ? Container()
            : Container(
          margin: const EdgeInsets.all(12),
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text("အကြွင်း $modVal"),
                      Text(
                        houseName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ))),
        ),
        modVal == 0
            ? Container() : Container(
          margin: const EdgeInsets.all(12),
          height: 150,
          child: Card(
              child: Center(
                  child: switchCase(modVal)
              )
          ),
        ),
      ],
    ),
  );
}