import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dio/dio.dart';

import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  // final HomeController homeC = get.lazyput(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
              asyncItems: (text) async {
                print("Run");
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {
                    "key": "566430af179baa880bfa80cc68d54c30",
                  },
                );
                // print(response);
                // return [];
                return Province.fromJsonList(
                  response.data["rajaongkir"]["results"],
                );
              },
              popupProps: PopupProps.menu(
                showSearchBox: true,
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(
                      "${item.province}",
                    ),
                  );
                },
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Asal",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(),
                ),
              ),
              onChanged: (value) {
                controller.provAsalID.value = value?.provinceId ?? "0";
              }),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<City>(
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provAsalID.value}",
                queryParameters: {
                  "key": "566430af179baa880bfa80cc68d54c30",
                },
              );
              return City.fromJsonList(
                response.data["rajaongkir"]["results"],
              );
            },
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(
                    "${item.cityName}",
                  ),
                );
              },
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kab Asal",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<Province>(
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                queryParameters: {
                  "key": "566430af179baa880bfa80cc68d54c30",
                },
              );
              return Province.fromJsonList(
                response.data["rajaongkir"]["results"],
              );
            },
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(
                    "${item.province}",
                  ),
                );
              },
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) {
              controller.provTujuanID.value = value?.provinceId ?? "0";
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<City>(
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanID.value}",
                queryParameters: {
                  "key": "566430af179baa880bfa80cc68d54c30",
                },
              );
              return City.fromJsonList(
                response.data["rajaongkir"]["results"],
              );
            },
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(
                    "${item.cityName}",
                  ),
                );
              },
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kab Tujuan",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Cek Ongkir",
            ),
          )
        ],
      ),
    );
  }
}
