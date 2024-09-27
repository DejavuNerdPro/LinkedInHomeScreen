import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_home/NavigationItems/Network.dart';
import 'package:linkedin_home/NavigationItems/home.dart';
import 'package:linkedin_home/NavigationItems/jobs.dart';
import 'package:linkedin_home/NavigationItems/notifications.dart';
import 'package:linkedin_home/NavigationItems/posts.dart';
import 'package:linkedin_home/ScrollController/scroll_to_show_hide.dart';
import 'package:linkedin_home/search_data/post.dart';
import 'package:linkedin_home/search_data/search_delegate.dart';

// ignore: must_be_immutable
class MainScreen extends ConsumerWidget{
  
  List<Post> posts = <Post>[];

  final indexBottomNavBarProvider=StateProvider<int>((ref){
    return 0;
  });

  MainScreen({super.key,required this.posts});
  final GlobalKey<ScaffoldState> _scafoldGlobalKey=GlobalKey<ScaffoldState>();
  ScrollController controller=ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavBarItem=[
      Home(refcontroller: controller,),const Network(),const Posts(),const Notifications(),const Jobs()
    ];
    
    final indexBottomNavBar=ref.watch(indexBottomNavBarProvider);
    return Scaffold(
      key: _scafoldGlobalKey,
      backgroundColor:const Color.fromARGB(255, 198, 198, 194),
      drawer:  NavDrawer(context),
      body: CustomScrollView(
        slivers: [
        SliverAppBar(
        floating: true,
        elevation: 20,
         pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          background:  Container(
            padding: const EdgeInsets.only(top: 25,left: 15),
            child: Row(
            children: [
              GestureDetector(
                onTap: () {
                if(_scafoldGlobalKey.currentState!.isDrawerOpen){
                  _scafoldGlobalKey.currentState!.openDrawer();
                }else{
                  _scafoldGlobalKey.currentState!.openEndDrawer();
                }
              },
              child:Container(
          padding: const EdgeInsets.all(35),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/space1.jpg'),
                fit: BoxFit.cover,
              )
          ),
         ),
              ),
         const SizedBox(
          width: 15,
         ),
         Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromARGB(255, 233, 242, 249),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: InkWell(
              onTap: () => showSearch(
                context: context,
                delegate: Search_Delegate(posts: posts),
                ),
              child: const Row(
              children: [
              Icon(Icons.search),
              Text('Search',
              style: TextStyle(
                color: Color.fromARGB(66, 58, 53, 53),
                fontSize: 15,
              ),
              ),
              ],
            ),
            ),
          ),
         ),
         ],
            ),
            ),
        ),
        actions: const [
         Padding(padding: EdgeInsets.all(10),
         child: Icon(Icons.message),
         ) 
        ],
          ),
          SliverToBoxAdapter(
            child: bottomNavBarItem[indexBottomNavBar],
          ),
        ],
      ),
      bottomNavigationBar: ScrollToShowHide(
        controller: controller,
        child: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: const Color.fromARGB(255, 54, 55, 55),
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 20, 20, 20),fontSize: 10),
        unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 20, 20, 20),fontSize: 10),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Color.fromARGB(255, 54, 55, 55),),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people,color: Color.fromARGB(255, 54, 55, 55),),label: 'My Network'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add,color: Color.fromARGB(255, 54, 55, 55),),label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications,color: Color.fromARGB(255, 54, 55, 55),),label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.work,color: Color.fromARGB(255, 54, 55, 55),),label: 'Jobs'),
        ],
        currentIndex: indexBottomNavBar,
        onTap: (value) => ref.read(indexBottomNavBarProvider.notifier).update((state) => value),
      ),
      ),
    );
  }
    
}

Widget NavDrawer(BuildContext context){
  print(MediaQuery.of(context).size.width*(1/4));
  return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width*(1/4)),
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/space1.jpg'),
                fit: BoxFit.cover,
              ),
          ),
         ),
         const Text('Eugene Cantillon'),
         const Text('View Profile',style: TextStyle(
          color: Colors.grey,fontSize: 13,
         ),)
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.post_add,
            ),
            title: const Text('Saved Posts'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.group ,
            ),
            title: const Text('Group'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*(2/4),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.3,
          ),
          ListTile(
            leading: const Icon(
              Icons.settings ,
            ),
            title: const Text('Setting'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
}