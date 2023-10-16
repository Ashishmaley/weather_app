import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getImage(int code) {
    if (code > 200 && code <= 300) {
      return Image.asset('assets/TSTROM.png');
    } else if (code >= 300 && code < 400) {
      return Image.asset('assets/SHOWER.png');
    } else if (code >= 500 && code < 600) {
      return Image.asset('assets/RAIN.png');
    } else if (code >= 600 && code < 700) {
      return Image.asset('assets/SNOW.png');
    } else if (code > 700 && code < 800) {
      return Image.asset('assets/FOG.png');
    } else if (code == 800) {
      return Image.asset('assets/CLEAR.png');
    } else if (code > 800 && code <= 804) {
      return Image.asset('assets/MCLOUDY.png');
    } else {
      return Image.asset('assets/CLEAR.png');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar (
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2, 40, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack (
            children: [
              Align(alignment: const AlignmentDirectional(3,-0.3),
              child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple
              ),
              ),
              ),
              Align(alignment: const AlignmentDirectional(-3,-1.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Align(alignment: const AlignmentDirectional(0,-1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFAB40)
                  ),
                ),
              ),
              BackdropFilter(filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
              ),


              BlocBuilder<WeatherBloc,WeatherState>(
              builder: (context,state){
                if(state is WeatherSuccess) {
                  return ListView(
                      children: <Widget>[
                     SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Column(

                        children: [
                          Text('☁️ ${state.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          const SizedBox(height: 8,),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('Hello ⚡', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                            ),),
                          ),
                          Center(
                              child: getImage(state.weather.weatherConditionCode!)
                          ),
                           Center(
                            child: Text('🌡️${state.weather.temperature!.celsius!.round()}°C',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Center(
                            child: Text(state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd ').add_jm().format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/CLEAR.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Sunrise',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text(
                                          DateFormat().add_jm().format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/CLEAR0.png',
                                    scale: 8,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Sunset',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text(
                                        DateFormat().add_jm().format(state.weather.sunset!),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(
                              vertical: 2.0),
                            child: Divider(color: Color(0x4040426B),),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/hot.png',
                                    scale: 12,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Max Temp',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text('🌡️ ${state.weather.tempMax!.celsius!.round().toString()}°C',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/temperature.png',
                                    scale: 12,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Min Temp',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      Text('🌡️ ${state.weather.tempMin!.celsius!.round().toString()}°C',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(
                              vertical: 2.0),
                            child: Divider(color: Color(0x4040426B),),
                          ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                ]
                  );
                }else{
                  return Container();
                }
                }
              )
            ],
          ) ,
        ),
      ),
    );
  }
}
