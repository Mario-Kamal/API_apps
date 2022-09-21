import 'package:api/component/component/component.dart';
import 'package:api/modules/shop_app/login/shop_login_screen.dart';
import 'package:api/network/local/cached_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/images/1.jpeg", title: "Title 1", body: "Body 1"),
    BoardingModel(
        image: "assets/images/2.jpg", title: "Title 2", body: "Body 2"),
    BoardingModel(
        image: "assets/images/3.jpg", title: "Title 3", body: "Body 3"),
  ];
  void submit(){
    CashedHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value){
        navegateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: Text("Skip"),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                foregroundColor: MaterialStateProperty.all(Colors.green),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index], context),
                itemCount: boarding.length,
              )),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        dotHeight: 10.0,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        expansionFactor: 3,
                        dotWidth: 15.0),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Icon(Icons.arrow_forward_sharp),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage("${model.image}"))),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "${model.title}",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "${model.body}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      );
}
