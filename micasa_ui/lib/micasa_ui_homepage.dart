/*
  Copyright 2020 MiCasa Development Team

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import 'package:flutter/material.dart';

class MiCasaUIHomePage extends DefaultTabController {
  MiCasaUIHomePage({
    Key key,
    String title,
  }) : super(
          key: key,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.devices), text: 'Accessories'),
                  Tab(icon: Icon(Icons.settings), text: 'Configuration'),
                  Tab(icon: Icon(Icons.ad_units), text: 'Plugin Management'),
                ],
              ),
              title: Text(title),
            ),
            body: TabBarView(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegate(),
                  itemBuilder: (context, index) {
                    Text('Item')
                  },
                ),
                Icon(Icons.settings),
                Icon(Icons.ad_units),
              ],
            ),
          ),
        );
}
