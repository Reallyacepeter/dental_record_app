import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];

  final String kakaoApiKey = "d8fa415ec8a21a135802513ce9b5a4c3"; // 🔹 카카오 API 키 입력

  Future<void> _searchAddress(String query) async {
    if (query.isEmpty) return;

    final url = Uri.parse("https://dapi.kakao.com/v2/local/search/address.json?query=$query");
    final response = await http.get(url, headers: {
      "Authorization": "KakaoAK d8fa415ec8a21a135802513ce9b5a4c3", // ✅ API 키 확인
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> results = [];

      for (var item in data['documents']) {
        // ✅ "서울특별시 강남구"처럼 시/군/구까지 포함하도록 조합
        String formattedAddress = "${item['address']['region_1depth_name']} ${item['address']['region_2depth_name']}";
        if (item['address']['region_3depth_name'] != "") {
          formattedAddress += " ${item['address']['region_3depth_name']}";
        }

        if (!results.contains(formattedAddress)) {
          results.add(formattedAddress);
        }
      }

      setState(() {
        _suggestions = results;
      });
    } else {
      print("주소 검색 실패: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("주소 검색")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (text) => _searchAddress(text),  // 🔹 사용자가 입력하면 자동완성 실행
              decoration: InputDecoration(
                labelText: "주소 입력",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index]),
                    onTap: () {
                      Navigator.pop(context, _suggestions[index]); // 🔹 선택한 주소를 반환
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
