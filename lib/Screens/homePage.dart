import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tanglis_bible_mobileapp/Screens/viewPlan.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body:
      Column(
        children: [


          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                      items: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:
                          Image.asset('assets/Images/banner1.png',
                            width: MediaQuery.of(context).size.width-40,
                            height: 110,
                            fit: BoxFit.cover,

                          ),

                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:
                          Image.asset('assets/Images/banner2.png',
                            width: MediaQuery.of(context).size.width-40,
                            height: 110,
                            fit: BoxFit.cover,

                          ),

                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:
                          Image.asset('assets/Images/banner3.png',  width: MediaQuery.of(context).size.width-40,
                            height: 110,
                            fit: BoxFit.cover,

                          ),

                        ),
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 110,
                        aspectRatio: 16/9,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),

                      )),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfView()));
                    },
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width-40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/Images/reading.png', height: 100,),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                              child:
                              Text('GET YOUR DAILY PLAN', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,5.0,0.0,0.0),
                              child: Text('FOR BIBLE READING', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                              child: Text('Tap Now', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                            )
                          ],)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                        height: 120.0,
                          width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white
                        ),
                        child:
                        Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(70.0,20,0.0,0.0),
                              child: Text('WEB APPLICATION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            SizedBox(height: 25,),
                            Row(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(130.0,0.0,0.0,0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          _launchURL('http://tanglishbible.com/');
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                            width: 105,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              color: Colors.grey
                                            ),
                                            child: Text('Check Now', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),)
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 15.0,0.0,0.0),
                                  child: Image.asset('assets/Images/web-link.png', height: 30,width: 30,),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/Images/laptop.png', width: 120.0,height: 80,fit: BoxFit.cover,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                        height: 120.0,
                          width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white
                        ),
                        child:
                        Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(70.0,20,0.0,0.0),
                              child: Text('DESKTOP APP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            SizedBox(height: 25,),
                            Row(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(130.0,0.0,0.0,0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                          width: 105,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            color: Colors.grey
                                          ),
                                          child: Text('Check Now', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),)
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 15.0,0.0,0.0),
                                  child: Image.asset('assets/Images/microsoft.png', height: 30,width: 30,),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/Images/desktop.png', width: 120.0,height: 80,fit: BoxFit.cover,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                        height: 120.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white
                        ),
                        child:
                        Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(70.0,20,0.0,0.0),
                              child: Text('KINDLE E-BOOK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            SizedBox(height: 25,),
                            Row(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(130.0,0.0,0.0,0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 105,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              color: Colors.grey
                                          ),
                                          child: Text('Check Now', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),)
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 15.0,0.0,0.0),
                                  child: Image.asset('assets/Images/ebook.png', height: 30,width: 30,),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/Images/desktop.png', width: 120.0,height: 80,fit: BoxFit.cover,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _launchURL(String _url) async {
    try {
      launch(_url);
    } catch (e) {
      print(e.toString());
    }
  }
}
