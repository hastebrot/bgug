import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../options.dart';
import 'gui_commons.dart';

class OptionsScreen extends StatefulWidget {
  @override
  State<OptionsScreen> createState() => new _OptionsState();
}

class _OptionsState extends State<OptionsScreen> {
  Options options;

  _OptionsState() {
    start();
  }

  start() async {
    options = await Options.fetch();
  }

  @override
  Widget build(BuildContext context) {
    if (options == null) {
      return new Center(child: new Text('Loading...'));
    }
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: new Row(
        children: [
          new Expanded(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pad(new Text('OpTiOnS', style: title), 20.0),
              btn('Save', () {
                options.save().then((a) {
                  Navigator.of(context).pop();
                });
              }),
              btn('Cancel', () {
                Navigator.of(context).pop();
              }),
            ],
          )),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                child: new ListView(
                  children: [
                    textField(
                      'Bullet Speed',
                      doubleValidator,
                      options.bulletSpeed.toString(),
                      (newValue) => options.bulletSpeed = double.parse(newValue),
                    ),
                    textField(
                      'Block Button Starting Cost',
                      intValidator,
                      options.buttonCost.toString(),
                          (newValue) => options.buttonCost = int.parse(newValue),
                    ),
                    textField(
                      'Block Button Inc Cost',
                      intValidator,
                      options.buttonIncCost.toString(),
                          (newValue) => options.buttonIncCost = int.parse(newValue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
