/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-02
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/about.dart';
import 'package:oy_go_test/constant.dart';
import 'package:oy_go_test/home_page.dart';
import 'package:oy_go_test/routes/animation//animation_hero_ex.dart';
import 'package:oy_go_test/routes/animation//animation_low_level_ex.dart';
import 'package:oy_go_test/routes/animation/animation_animated_builder_ex.dart';
import 'package:oy_go_test/routes/animation/animation_animated_container_ex.dart';
import 'package:oy_go_test/routes/animation/animation_lottie_ex.dart';
import 'package:oy_go_test/routes/animation/animation_opacity_ex.dart';
import 'package:oy_go_test/routes/appbar/appbar_backdrop_ex.dart';
import 'package:oy_go_test/routes/appbar/appbar_basic_appbar_ex.dart';
import 'package:oy_go_test/routes/appbar/appbar_bottom_appbar_ex.dart';
import 'package:oy_go_test/routes/appbar/appbar_sliver_appbar_ex.dart';
import 'package:oy_go_test/routes/layouts/layouts_container_padding_center_ex.dart';
import 'package:oy_go_test/routes/layouts/layouts_expanded_ex.dart';
import 'package:oy_go_test/routes/layouts/layouts_row_col_ex.dart';
import 'package:oy_go_test/routes/layouts/layouts_stack_ex.dart';
import 'package:oy_go_test/routes/layouts/layouts_wrap_ex.dart';
import 'package:oy_go_test/routes/lists/lists_datatable_ex.dart';
import 'package:oy_go_test/routes/lists/lists_expansion_tile_ex.dart';
import 'package:oy_go_test/routes/lists/lists_grid_list_ex.dart';
import 'package:oy_go_test/routes/lists/lists_list_tile_ex.dart';
import 'package:oy_go_test/routes/lists/lists_listview_builder_ex.dart';
import 'package:oy_go_test/routes/lists/lists_reorderable_ex.dart';
import 'package:oy_go_test/routes/lists/lists_swipe_to_dismiss_ex.dart';
import 'package:oy_go_test/routes/nav/nav_bottom_navbar_ex.dart';
import 'package:oy_go_test/routes/nav/nav_bottom_sheet_ex.dart';
import 'package:oy_go_test/routes/nav/nav_bottom_tabbar_ex.dart';
import 'package:oy_go_test/routes/nav/nav_dialogs_ex.dart';
import 'package:oy_go_test/routes/nav/nav_draggable_scrollable_sheet_ex.dart';
import 'package:oy_go_test/routes/nav/nav_nav_drawer_header_ex.dart';
import 'package:oy_go_test/routes/nav/nav_pageselector_ex.dart';
import 'package:oy_go_test/routes/nav/nav_routes_ex.dart';
import 'package:oy_go_test/routes/nav/nav_tabs_ex.dart';
import 'package:oy_go_test/routes/networking/networking_hacker_news_ex.dart';
import 'package:oy_go_test/routes/networking/networking_rest_api_fetch_ex.dart';
import 'package:oy_go_test/routes/networking/networking_rest_api_send_ex.dart';
import 'package:oy_go_test/routes/oytest/oy_test_download_ex.dart';
import 'package:oy_go_test/routes/persistence/persistence_file_rw_ex.dart';
import 'package:oy_go_test/routes/persistence/persistence_hive_ex.dart';
import 'package:oy_go_test/routes/persistence/persistence_preference_ex.dart';
import 'package:oy_go_test/routes/persistence/persistence_sembast_ex.dart';
import 'package:oy_go_test/routes/persistence/persistence_sqlite_ex.dart';
import 'package:oy_go_test/routes/plugins/plugins_extenden_image_ex.dart';
import 'package:oy_go_test/routes/routeSettings/my_route.dart';
import 'package:oy_go_test/routes/states/state_inherited_widget_ex.dart';
import 'package:oy_go_test/routes/states/state_provider_ex.dart';
import 'package:oy_go_test/routes/states/state_scoped_model_ex.dart';
import 'package:oy_go_test/routes/widgets/widget_image_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_buttons_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_card_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_dropdown_button_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_icon_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_stateful_widgets_ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_textField.ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_textFormField.ex.dart';
import 'package:oy_go_test/routes/widgets/widgets_text_ex.dart';

class MyRouteGroup {
  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;

  const MyRouteGroup(
      {@required this.icon, @required this.groupName, @required this.routes});
}

const homeRoute = MyRoute(
  child: MyHomePage(),
  sourceFilePath: 'lib/routes/home.dart',
  title: APP_NAME,
  routeName: Navigator.defaultRouteName,
);

const aboutRoute = MyRoute(
  child: MyAboutRoute(),
  sourceFilePath: 'lib/routes/about.dart',
  title: 'About',
  links: {
    'Doc': 'https://docs.flutter.io/flutter/material/showAboutDialog.html'
  },
);
const MyAppRoutesBasic = <MyRouteGroup>[
  MyRouteGroup(
    groupName: "Widget",
    icon: Icon(Icons.extension),
    routes: <MyRoute>[
      MyRoute(
        child: IconExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_icon_ex.dart',
        title: "Icon",
      ),
      MyRoute(
        child: TextExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_text_ex.dart',
        title: "Text",
      ),
      MyRoute(
        child: TextFieldExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_textField.ex.dart',
        title: "TextField",
      ),
      MyRoute(
        child: TextFormFieldExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_textFormField.ex.dart',
        title: "TextFormField",
      ),
      MyRoute(
        child: ImageExample(),
        sourceFilePath: 'lib/routes/widgets/widget_image_ex.dart',
        title: "Image",
      ),
      MyRoute(
        child: CardExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_card_ex.dart.dart',
        title: "Card Inkwell",
      ),
      MyRoute(
        child: ButtonsExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_buttons_ex.dart',
        title: "Button",
      ),
      MyRoute(
        child: DropdownButtonExample(),
        sourceFilePath: 'lib/routes/widgets/widgets_dropdown_button_ex.dart',
        title: "DropdownButton",
      ),
      MyRoute(
        child: StatefulWidgetsExample(),
        sourceFilePath: 'lib/routes/widgets_stateful_widgets_ex.dart',
        title: "other-StatefulWidgets",
      ),
    ],
  ),
  MyRouteGroup(groupName: 'Layouts', icon: Icon(Icons.dashboard), routes: <
      MyRoute>[
    MyRoute(
      child: ContainerExample(),
      sourceFilePath:
          'lib/routes/layouts/layouts_container_padding_center_ex.dart',
      title: 'Container',
      description: 'Basic widgets for layout.',
      links: {
        'Doc': 'https://docs.flutter.io/flutter/widgets/Container-class.html',
      },
    ),
    MyRoute(
      child: RowColExample(),
      sourceFilePath: 'lib/routes/layouts/layouts_row_col_ex.dart',
      title: 'Row, Column',
      description: 'Align chidren widgets linearly.',
      links: {
        "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=75s",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Row-class.html',
      },
    ),
    MyRoute(
      child: WrapExample(),
      sourceFilePath: 'lib/routes/layouts/layouts_wrap_ex.dart',
      title: 'Wrap',
      description: 'Align chidren widgets linearly.',
      links: {
        "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=75s",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Row-class.html',
      },
    ),
    MyRoute(
      child: ExpandedExample(),
      sourceFilePath: 'lib/routes/layouts/layouts_expanded_ex.dart',
      title: 'Expanded, SizedBox',
      description: 'Dividing space by "weights" (flex).',
      links: {
        'Doc': 'https://docs.flutter.io/flutter/widgets/Expanded-class.html',
        'Youtube video': 'https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s',
      },
    ),
    MyRoute(
      child: StackExample(),
      sourceFilePath: 'lib/routes/layouts/layouts_stack_ex.dart',
      title: 'Stack',
      description: 'Putting widget on top of another.',
      links: {
        "Youtube video": "https://www.youtube.com/watch?v=RJEnTRBxaSg&t=1072s",
        'Doc': 'https://docs.flutter.io/flutter/widgets/Stack-class.html',
      },
    ),
  ]),
  MyRouteGroup(
      groupName: 'Lists',
      icon: Icon(Icons.format_list_numbered),
      routes: <MyRoute>[
        MyRoute(
          child: ListTileExample(),
          sourceFilePath: 'lib/routes/lists/lists_list_tile_ex.dart',
          title: 'ListTile',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/ListTile-class.html',
          },
        ),
        MyRoute(
          child: ListViewBuilderExample(),
          sourceFilePath: 'lib/routes/lists/lists_listview_builder_ex.dart',
          title: 'ListView.builder',
          description: 'Building list items with a builder.',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/widgets/ListView-class.html',
          },
        ),
        MyRoute(
          child: GridListExample(),
          sourceFilePath: 'lib/routes/lists/lists_grid_list_ex.dart.dart',
          title: 'GridList',
          description: 'Building GridList items with a builder.',
          links: {
            'Cookbook': 'https://flutter.io/cookbook/lists/grid-lists/',
          },
        ),
        MyRoute(
          child: ExpansionTileExample(),
          sourceFilePath: 'lib/routes/lists/lists_expansion_tile_ex.dart',
          title: 'ExpansionTile',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/ExpansionTile-class.html',
          },
        ),
        MyRoute(
          child: ListSwipeToDismissExample(),
          sourceFilePath: 'lib/routes/lists/lists_swipe_to_dismiss_ex.dart',
          title: 'Swipe to dismiss',
          links: {
            'Cookbook': 'https://flutter.io/cookbook/gestures/dismissible',
          },
        ),
        MyRoute(
          child: ReorderableListExample(),
          sourceFilePath: 'lib/routes/lists/lists_reorderable_ex.dart',
          title: 'Reorderable list',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/ReorderableListView-class.html'
          },
        ),
        MyRoute(
          child: DataTableExample(),
          sourceFilePath: 'lib/routes/lists/lists_datatable_ex.dart',
          title: 'DataTable',
          description: 'Showing data in a table.',
          links: {
            'Docs':
                'https://docs.flutter.io/flutter/material/PaginatedDataTable-class.html'
          },
        ),
      ]),
  MyRouteGroup(
      groupName: 'Appbar',
      icon: RotatedBox(
        child: Icon(Icons.video_label),
        quarterTurns: 2,
      ),
      routes: <MyRoute>[
        MyRoute(
          child: BasicAppbarExample(),
          sourceFilePath: 'lib/routes/appbar/appbar_basic_appbar_ex.dart',
          title: 'Basic AppBar',
          links: {
            'Doc': 'https://docs.flutter.io/flutter/material/AppBar-class.html',
          },
        ),
        MyRoute(
          child: BottomAppbarExample(),
          sourceFilePath: 'lib/routes/appbar/appbar_bottom_appbar_ex.dart',
          title: 'Bottom AppBar and Floating App Button (FAB)',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html'
          },
        ),
        MyRoute(
          child: SliverAppBarExample(),
          sourceFilePath: 'lib/routes/appbar/appbar_sliver_appbar_ex.dart',
          title: 'Sliver AppBar',
          description: 'Appbar that auto-hides.',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/SliverAppBar-class.html',
            'Medium article':
                'https://flutterdoc.com/animating-app-bars-in-flutter-cf034cd6c68b',
          },
        ),
        MyRoute(
          child: BackdropExample(),
          sourceFilePath: 'lib/routes/appbar/appbar_backdrop_ex.dart',
          title: 'Backdrop',
          description: 'Switching between front and back layer.',
          links: {
            'Medium article':
                'https://medium.com/flutter/decomposing-widgets-backdrop-b5c664fb9cf4'
          },
        ),
      ]),
  MyRouteGroup(
      groupName: 'Navigation',
      icon: Icon(Icons.view_carousel),
      routes: <MyRoute>[
        MyRoute(
          child: TabsExample(),
          sourceFilePath: 'lib/routes/nav/nav_tabs_ex.dart',
          title: 'Tabs',
          links: {
            'Doc': 'https://docs.flutter.io/flutter/material/TabBar-class.html'
          },
        ),
        MyRoute(
          child: DialogsExample(),
          sourceFilePath: 'lib/routes/nav/nav_dialogs_ex.dart',
          title: 'Dialogs',
        ),
        MyRoute(
          child: RoutesExample(),
          sourceFilePath: 'lib/routes/nav/nav_routes_ex.dart',
          title: 'Routes',
          description: 'Jumping between pages.',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/widgets/Navigator-class.html',
            'Youtube video':
                'https://youtu.be/b2fgMCeSNpY?list=PLJbE2Yu2zumDqr_-hqpAN0nIr6m14TAsd',
          },
        ),
        MyRoute(
          child: NavDrawerExample(),
          sourceFilePath: 'lib/routes/nav/nav_nav_drawer_header_ex.dart',
          title: 'Navigation Drawer',
          links: {
            'Doc': 'https://docs.flutter.io/flutter/material/Drawer-class.html',
          },
        ),
        MyRoute(
          child: BottomSheetExample(),
          sourceFilePath: 'lib/routes/nav/nav_bottom_sheet_ex.dart',
          title: 'Bottom sheet',
          links: {
            'Medium article':
                'https://medium.com/flutter-community/flutter-beginners-guide-to-using-the-bottom-sheet-b8025573c433',
          },
        ),
        MyRoute(
          child: BottomTabbarExample(),
          sourceFilePath: 'lib/routes/nav/nav_bottom_tabbar_ex.dart',
          title: 'Bottom tab bar',
        ),
        MyRoute(
          child: BottomNavigationBarExample(),
          sourceFilePath: 'lib/routes/nav/nav_bottom_navbar_ex.dart',
          title: 'Bottom navigation bar',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html',
          },
        ),
        MyRoute(
          child: PageSelectorExample(),
          sourceFilePath: 'lib/routes/nav/nav_pageselector_ex.dart',
          title: 'Page selector',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/material/TabPageSelector-class.html'
          },
        ),
        MyRoute(
          child: DraggableScrollableSheetExample(),
          sourceFilePath:
              'lib/routes/nav/nav_draggable_scrollable_sheet_ex.dart',
          title: 'DraggableScrollableSheet',
          description: 'Scrollable sheet similar to Google Maps.',
          links: {'Youtube': 'https://www.youtube.com/watch?v=Hgw819mL_78'},
        ),
      ]),
  MyRouteGroup(
      groupName: 'Animation(basic)',
      icon: Icon(Icons.movie_filter),
      routes: <MyRoute>[
        MyRoute(
          child: HeroExample(),
          sourceFilePath: 'lib/routes/animation/animation_hero_ex.dart',
          title: 'Hero',
          description: 'Hero animation between routes.',
          links: {
            'cookbook':
                'https://flutter.io/docs/development/ui/animations/hero-animations',
            'Youtube video': 'https://www.youtube.com/watch?v=Be9UH1kXFDw',
          },
        ),
        MyRoute(
          child: OpacityExample(),
          sourceFilePath: 'lib/routes/animation/animation_opacity_ex.dart',
          title: 'Opacity',
          description: 'Making a widget transparent/visible.',
          links: {
            'Doc': 'https://docs.flutter.io/flutter/widgets/Opacity-class.html',
            'Youtube video':
                'https://www.youtube.com/watch?v=9hltevOHQBw&index=5&list=PLOU2XLYxmsIL0pH0zWe_ZOHgGhZ7UasUE',
          },
        ),
        MyRoute(
          child: AnimatedContainerExample(),
          sourceFilePath:
              'lib/routes/animation/animation_animated_container_ex.dart',
          title: 'AnimatedContainer',
          description:
              'Implicit animation when container property changes, without controllers.',
          links: {
            'Cookbook':
                'https://flutter.dev/docs/cookbook/animation/animated-container',
            'Widget of the Week (YouTube)': 'https://youtu.be/yI-8QHpGIP4',
          },
        ),
      ]),
];

const MyAppRoutesAdvanced = <MyRouteGroup>[
  MyRouteGroup(
      groupName: 'Animation(advanced)',
      icon: Icon(Icons.movie_filter),
      routes: <MyRoute>[
        MyRoute(
          child: LowLevelAnimationExample(),
          sourceFilePath: 'lib/routes/animation/animation_low_level_ex.dart',
          title: 'Low level animation',
          description:
              'Implement animation using low-level Animations, AnimationControllers and Tweens.',
          links: {
            'Tutorial':
                'https://flutter.dev/docs/development/ui/animations/tutorial',
            'Youtube video': 'https://www.youtube.com/watch?v=mdhoIQqS2z0',
          },
        ),
        MyRoute(
          child: AnimatedBuilderExample(),
          sourceFilePath:
              'lib/routes/animation/animation_animated_builder_ex.dart',
          title: 'AnimatedBuilder',
          description: 'Similar to AnimatedWidget.',
          links: {
            'Tutorial':
                'https://flutter.dev/docs/development/ui/animations/tutorial#refactoring-with-animatedbuilder',
            'Widget of the Week (YouTube)': 'https://youtu.be/N-RiyZlv8v8',
          },
        ),
        MyRoute(
          child: LottieExample(),
          sourceFilePath: 'lib/routes/animation/animation_lottie_ex.dart',
          title: 'Lottie',
          description: 'Easily add high-quality animation.',
          links: {
            'Lottie': 'https://airbnb.design/lottie/',
            'Pub package': 'https://pub.dev/packages/lottie',
          },
        ),
      ]),
  MyRouteGroup(groupName: 'Persistence', icon: Icon(Icons.sd_storage), routes: <
      MyRoute>[
    MyRoute(
      child: SharedPreferenceExample(),
      sourceFilePath: 'lib/routes/persistence/persistence_preference_ex.dart',
      title: 'Shared preference',
      description: 'Key-value pairs stored locally using shared_preference.',
      links: {
        'Cookbook': 'https://flutter.io/docs/cookbook/persistence/key-value',
      },
    ),
    MyRoute(
      child: FileReadWriteExample(),
      sourceFilePath: 'lib/routes/persistence/persistence_file_rw_ex.dart',
      title: 'Local file read/write',
      description: 'Read and write local file using path_provider.',
      links: {
        'Cookbook':
            'https://flutter.io/docs/cookbook/persistence/reading-writing-files',
      },
    ),
    MyRoute(
      child: SqliteExample(),
      sourceFilePath: 'lib/routes/persistence/persistence_sqlite_ex.dart',
      title: 'SQLite',
      description:
          'A CRUD (Create-Read-Update-Delete) mini todo app using sqflite.',
      links: {
        'Pub package': 'https://pub.dev/packages/sqflite',
      },
    ),
    MyRoute(
      child: SembastExample(),
      sourceFilePath: 'lib/routes/persistence/persistence_sembast_ex.dart',
      title: 'Sembast',
      description: 'NoSQL db, mini todo CRUD app.',
      links: {
        'Pub package': 'https://pub.dev/packages/sembast',
        'ResoCoder blog':
            'https://resocoder.com/2019/04/06/flutter-nosql-database-sembast-tutorial-w-bloc/'
      },
    ),
    MyRoute(
      child: HiveExample(),
      sourceFilePath: 'lib/routes/persistence/persistence_hive_ex.dart',
      title: 'Hive',
      description:
          'Easier NoSQL db with less bolierplate code. Mini todo CRUD app.',
      links: {
        'Documentation': 'https://docs.hivedb.dev',
        'ResoCoder blog':
            'https://resocoder.com/2019/09/30/hive-flutter-tutorial-lightweight-fast-database'
      },
    ),
  ]),
  MyRouteGroup(groupName: 'Networking', icon: Icon(Icons.http), routes: <
      MyRoute>[
    MyRoute(
      child: RestApiFetchExample(),
      sourceFilePath: 'lib/routes/networking/networking_rest_api_fetch_ex.dart',
      title: 'Fetching data',
      links: {
        'Cookbook': 'https://flutter.dev/docs/cookbook/networking/fetch-data'
      },
    ),
    MyRoute(
      child: RestApiSendExample(),
      sourceFilePath: 'lib/routes/networking/networking_rest_api_send_ex.dart',
      title: 'Sending data',
      links: {
        'Cookbook': 'https://flutter.dev/docs/cookbook/networking/send-data'
      },
    ),
    MyRoute(
      child: RestApiHackerNewsExample(),
      sourceFilePath: 'lib/routes/networking/networking_hacker_news_ex.dart',
      title: 'Hacker News',
      description: 'A full REST API example.',
      links: {'Hacker News API': 'https://github.com/HackerNews/API'},
    ),
  ]),
  MyRouteGroup(
      groupName: 'States',
      icon: Icon(Icons.developer_mode),
      routes: <MyRoute>[
        MyRoute(
          child: ScopedModelExample(),
          sourceFilePath: 'lib/routes/states/state_scoped_model_ex.dart',
          title: 'state_scoped_model',
          links: {
            'juejin':
                'https://blog.csdn.net/weixin_34026484/article/details/91431075?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.nonecase'
          },
        ),
        MyRoute(
          child: InheritedWidgetExample(),
          sourceFilePath: 'lib/routes/states/state_inherited_widget_ex.dart',
          title: 'InheritedWidget',
          description: 'Access state of widgets up the tree.',
          links: {
            'Doc':
                'https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html',
            'Youtube': 'https://www.youtube.com/watch?v=4I68ilX0Y24',
          },
        ),
        MyRoute(
          child: ProviderExample(),
          sourceFilePath: 'lib/routes/states/state_provider_ex.dart',
          title: 'Provider',
          description: 'Officially recommended state management solution.',
          links: {
            "I/O'19 talk": 'https://www.youtube.com/watch?v=d_m5csmrf7I',
            'pub.dev': 'https://pub.dev/packages/provider',
          },
        ),
      ]),
  MyRouteGroup(
      groupName: 'OY_Test',
      icon: Icon(Icons.dialer_sip),
      routes: <MyRoute>[
        MyRoute(
          child: DownLoadExample(),
          sourceFilePath: 'lib/routes/oytest/oy_test_download_ex.dart',
          title: 'oy_test_download',
          links: {'juejin': 'https://juejin.im/post/5eab9b376fb9a0434a2e55a8'},
        ),
      ]),
  MyRouteGroup(groupName: 'Plugins', icon: Icon(Icons.power), routes: <MyRoute>[
    MyRoute(
      child: ExtendedImageExample(),
      sourceFilePath: 'lib/routes/plugins/plugins_extenden_image_ex.dart',
      title: 'Flutter 图片全家桶',
      links: {'juejin': 'https://juejin.im/post/5e930d4df265da47de70f8ac'},
    ),
  ])
];

final AllRoutesGroups = <MyRouteGroup>[
  ...MyAppRoutesBasic,
  ...MyAppRoutesAdvanced,
];

final AllRouts = <MyRoute>[
  ...AllRoutesGroups.expand((group) {
    return group.routes;
  }),
];

final RouteNameToRouteGroup = <String, MyRouteGroup>{
  for (final group in AllRoutesGroups)
    for (final route in group.routes) route.routeName: group
};

final AppRoutingTabel = <String, WidgetBuilder>{
  Navigator.defaultRouteName: (context) => homeRoute,
  aboutRoute.routeName: (context) => aboutRoute,
  for (MyRoute route in AllRouts) route.routeName: (context) => route,
};
