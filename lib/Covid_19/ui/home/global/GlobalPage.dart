import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miniProject/Covid_19/models/RpGlobal.dart';
import 'package:miniProject/Covid_19/models/RpLatest.dart';
import 'package:miniProject/Covid_19/network/Repository.dart';
import 'package:miniProject/Covid_19/ui/countrydetails/CountryDetails.dart';
import 'package:miniProject/Covid_19/ui/home/global/GlobalBloc.dart';
import 'package:miniProject/Covid_19/util/ColorUtil.dart';
import 'package:miniProject/Covid_19/util/ShimmerLoading.dart';
import 'package:miniProject/Covid_19/util/StyleUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  var _repository = Repository();
  var _userCountryData = Country();
  var _worldWideLatest = RpLatest();

  @override
  void initState() {
    super.initState();

    _repository.getGloballyLatestData().then((response) {
      setState(() {
        _worldWideLatest = response;
      });
    });

    getUserCountryFromSharedPreference();

    bloc.getGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: StreamBuilder(
        stream: bloc.globalFetcher,
        builder: (context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return getListOfLoadingShimmer();
        },
      ),
    );
  }

  Widget buildList(List<Country> allCountryData) {
    return AnimationLimiter(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: allCountryData.length + 2, //2 is for above list
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildGlobalView(_worldWideLatest);
            } else if (index == 1) {
              return buildUserCountryView(_userCountryData);
            } else {
              var country = allCountryData[index - 2];
              var indexUpdate = index - 2;
              return AnimationConfiguration.staggeredList(
                  position: index - 2,
                  duration: const Duration(milliseconds: 2000),
                  child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                          child:
                              buildSingleCountryView(country, indexUpdate))));
            }
          }),
    );
  }

  Widget buildGlobalView(RpLatest latest) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              // blurRadius: 15.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 25, top: 16),
              child: Text(
                'WORLDWIDE',
                style: getWorldWideTextStyle(18),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '${latest.cases == null ? '0000000' : latest.cases}',
                      style: getWorldWideCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Confirmed',
                      style: getConfirmedRecoveredTextStyle(),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Text(
                      '${latest.recovered == null ? '0000000' : latest.recovered}',
                      style: getWorldWideCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Recovered',
                      style: getConfirmedRecoveredTextStyle(),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Text(
                      '${latest.deaths == null ? '00000' : latest.deaths}',
                      style: getDeathCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Death',
                      style: getDeathTitleTextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildUserCountryView(Country userCountryData) {
    return InkWell(
      onTap: () {
        navigateToDetailsPage(userCountryData);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
              ),
            ]),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 25, top: 16),
                child: Text(
                  '${userCountryData.country == null ? "..." : userCountryData.country.toUpperCase()}',
                  style: getWorldWideTextStyle(18),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '${userCountryData.cases == null ? "..." : userCountryData.cases}',
                        style: getWorldWideCountdownNumberStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Confirmed',
                        style: getConfirmedRecoveredTextStyle(),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: <Widget>[
                      Text(
                        '${userCountryData.recovered == null ? "..." : userCountryData.recovered}',
                        style: getWorldWideCountdownNumberStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Recovered',
                        style: getConfirmedRecoveredTextStyle(),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: <Widget>[
                      Text(
                        '${userCountryData.deaths == null ? "..." : userCountryData.deaths}',
                        style: getDeathCountdownNumberStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Death',
                        style: getDeathTitleTextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSingleCountryView(Country country, int index) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        navigateToDetailsPage(country);
      },
      //   child: Padding(
      //     padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      //     child: Container(
      //       height: 80,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey.withOpacity(0.1),
      //               blurRadius: 15.0,
      //             ),
      //           ]),
      //       child: Row(
      //         children: <Widget>[
      //           SizedBox(
      //             width: 25,
      //           ),
      //           Container(
      //             height: 35,
      //             width: 55,
      //             child: CachedNetworkImage(
      //                 fit: BoxFit.cover,
      //                 placeholder: (context, url) => Container(
      //                       color: Colors.grey[200],
      //                     ),
      //                 errorWidget: (context, url, error) => Container(
      //                     color: Colors.grey.withOpacity(0.2),
      //                     child: Center(
      //                         child: Icon(
      //                       Icons.broken_image,
      //                       size: 50.0,
      //                       color: Colors.grey.withOpacity(0.5),
      //                     ))),
      //                 imageUrl: "${country.countryInfo.flag}"),
      //           ),
      //           SizedBox(
      //             width: 25,
      //           ),
      //           Text('${getOnlyCountryName(country.country)}',
      //               style: getCountryNameInListStyle()),
      //           Spacer(),
      //           Center(
      //               child: Text(
      //             '${country.cases}',
      //             style: getCountryInListCasesStyle(),
      //           )),
      //           SizedBox(width: 25)
      //         ],
      //       ),
      //     ),
      //   ),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: width,
                    height: 80,
                    padding: EdgeInsets.only(left: 80, right: 26),
                    margin:
                        EdgeInsets.only(right: width / 28, left: width / 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${getOnlyCountryName(country.country)}',
                        ),
                        Text(
                          '${country.cases}',
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(left: 18),
                      padding: EdgeInsets.all(width / 25),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                          ),
                          errorWidget: (context, url, error) => Container(
                              color: Colors.grey.withOpacity(0.2),
                              child: Center(
                                  child: Icon(
                                Icons.broken_image,
                                size: 50.0,
                                color: Colors.grey.withOpacity(0.5),
                              ))),
                          imageUrl: "${country.countryInfo.flag}",
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      child:
                          Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      decoration: BoxDecoration(
                          color: Colors.indigo, shape: BoxShape.circle),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getOnlyCountryName(String country) {
    var splits = country.split(",");
    return splits[0];
  }

  void getUserCountryFromSharedPreference() async {
    var preference = await SharedPreferences.getInstance();
    var userCountry = await preference.getString('userCountry');
    print('user country: $userCountry');
    _repository.getUserCountryData(userCountry).then((response) {
      setState(() {
        _userCountryData = response;
      });
    });
  }

  void navigateToDetailsPage(Country country) {
    var countryDetails = CountryDetails(
      country: country,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => countryDetails),
    );
  }
}
