import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/auth.dart';
import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'user_type': "user",
    'email': null,
    'first_name': null,
    'last_name': null,
    'password': null,
    'address': null,
    'contact_num': null,
    'resetPasswordToken': null,
    'resetPasswordExpires': null,
  };

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      // colorFilter:
      //     ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Email',
        labelText: 'Email',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Password',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Please enter a valid password';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildFirstNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'First Name',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'cannot be empty';
        }
      },
      onSaved: (String value) {
        _formData['first_name'] = value;
      },
    );
  }

  Widget _buildLastNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Last Name',
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'cannot be empty';
        }
      },
      onSaved: (String value) {
        _formData['last_name'] = value;
      },
    );
  }

  Widget _buildAddressTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Address',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Your address contains less than 10 characters';
        }
      },
      onSaved: (String value) {
        _formData['address'] = value;
      },
    );
  }

  Widget _buildContactNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        //hintText: 'Password',
        labelText: 'Contact Number ex: 0712345678',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'please input a contact number';
        } else if (value.length != 10 ||
            !RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")
                .hasMatch(value)) {
          return 'please input a valid contact number';
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        _formData['contact_num'] = value;
      },
    );
  }

  Widget _buildRegisterFormField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _buildFirstNameTextField(),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: _buildLastNameTextField(),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        _buildEmailTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildPasswordTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildContactNumberTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildAddressTextField(),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _buildLoginFormField() {
    return Column(
      children: <Widget>[
        _buildEmailTextField(),
        SizedBox(
          height: 10.0,
        ),
        _buildPasswordTextField(),
      ],
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_formData);
    final successInformation = await authenticate(_formData, _authMode);
    if (successInformation['success'])
      Navigator.pushReplacementNamed(context, '/newsFeed');
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' An Error Occured'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
    print(successInformation);
  }

  Widget _buildLoginRegisterButton(MainModel model) {
    return RaisedButton(
      child: Text(
        _authMode == AuthMode.Login ? 'Login' : 'Register',
        style: TextStyle(fontSize: 18.0),
      ),
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      onPressed: () => _submitForm(model.authenticate),
    );
  }

  Widget _showLogo() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/user.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          _showLogo(),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _authMode = AuthMode.Login;
                                    });
                                  },
                                  child: Container(
                                    color: _authMode == AuthMode.Login
                                        ? Colors.amber
                                        : Colors.black12,
                                    child: SizedBox(
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: _authMode == AuthMode.Login
                                              ? TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _authMode = AuthMode.Register;
                                    });
                                  },
                                  child: Container(
                                    color: _authMode == AuthMode.Register
                                        ? Colors.amber
                                        : Colors.black12,
                                    child: SizedBox(
                                      height: 40.0,
                                      child: Center(
                                        child: Text(
                                          'Register',
                                          style: _authMode == AuthMode.Register
                                              ? TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.amber,
                            height: 3.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _authMode == AuthMode.Login
                              ? _buildLoginFormField()
                              : _buildRegisterFormField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          ScopedModelDescendant(
                            builder: (BuildContext context, Widget child,
                                MainModel model) {
                              return model.isLoading
                                  ? CircularProgressIndicator()
                                  : _buildLoginRegisterButton(model);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
