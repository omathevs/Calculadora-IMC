import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;

@override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = 'Informe seus dados:';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), 
            child: buildForm(),
        )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora IMC'),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.account_circle_outlined,
            size: 150,
            color: Colors.green,
          ),
          buildTextFormField(
              label: 'Peso (kg)',
              error: 'Insira seu peso!',
              controller: _weightController),
          buildTextFormField(
              label: 'Altura (cm)',
              error: 'Insira sua altura!',
              controller: _heightController),
          buildCalculateButton(),
          buildTextResult(),
        ],
      ),
    );
  }

  Padding buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: RaisedButton(
        child: Text('Calcular', 
        style: TextStyle(color: Colors.white)
        ),
        color: Colors.green,
        onPressed: () {
          setState(() {
            if (_formKey.currentState.validate()) {
            calculateImc();
            }
          });
        },
      ),
    );
  }

  Padding buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
  
  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (imc < 18.6)
        _result += "Imc menor que 18.6 – Abaixo do Peso";
      else if (imc < 25.0)
        _result += "Imc entre 18.6 e 24.9 – Peso ideal";
      else if (imc < 30.0)
        _result += "Imc entre 25 e 29.9 – Levemente acima do Peso";
      else if (imc < 35.0)
        _result += "Imc entre 30 e 34.9 – Obesidade grau I";
      else if (imc < 40.0)
        _result += "Imc entre 35 e 39.9 – Obesidade grau II";
      else
        _result += "Imc igual ou maior que 40 – Obesidade grau III";
    });
  }
}
