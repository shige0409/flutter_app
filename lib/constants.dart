import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF5D859F);
const kPrimaryLightColor = Color(0xFFB3FFE9);
const kGrayColor = Color(0xFFE1E3E6);
const kBlackColor = Color(0xFF313E51);
const kBackgroundColor = Color(0xFF091C40);
const kRedColor = Color(0xFFFF1E46);
const kBlueColor = Color(0xFFB0DEEC);
const kPinkColor = Color(0xFFF9BBE7);
final kThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.grey,
      ),
    ),
    color: Colors.white,
    centerTitle: true,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
  ),
  textTheme: TextTheme(),
);

const kFirstImageUrl =
    "https://firebasestorage.googleapis.com/v0/b/calling-376aa.appspot.com/o/users%2Fwhite.png?alt=media&token=1510707e-bcdd-42a6-a29b-93a25985e3c4";
const kAPP_ID = '3d261be6b764431c8903996475e59522';
const kTOKEN = null;

const List<String> kCityList = [
  "秘密",
  "東京都",
  "大阪府",
  "福岡県",
  "愛知県",
  "北海道",
  "青森県",
  "岩手県",
  "宮城県",
  "秋田県",
  "山形県",
  "福島県",
  "茨城県",
  "栃木県",
  "群馬県",
  "埼玉県",
  "千葉県",
  "神奈川県",
  "新潟県",
  "富山県",
  "石川県",
  "福井県",
  "山梨県",
  "長野県",
  "岐阜県",
  "静岡県",
  "三重県",
  "滋賀県",
  "京都府",
  "兵庫県",
  "奈良県",
  "和歌山県",
  "鳥取県",
  "島根県",
  "岡山県",
  "広島県",
  "山口県",
  "徳島県",
  "香川県",
  "愛媛県",
  "高知県",
  "佐賀県",
  "長崎県",
  "熊本県",
  "大分県",
  "宮崎県",
  "鹿児島県",
  "沖縄県"
];
