import 'package:flutter/material.dart';
import '../widgets/ui_elements/fab_create.dart';

import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';

class ComplaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DefaultSideDrawer(),
      appBar: AppBar(
        title: Text('Complaints'),
      ),
      body: Container(),
      floatingActionButton: FabCreate(),
    );
  }
}
