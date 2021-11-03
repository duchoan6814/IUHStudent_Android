import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/data.dart';
import 'package:intl/intl.dart';
import 'package:iuh_student/models/enums/bac_dao_tao.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const styleAtributeOfStudent = TextStyle(
    fontSize: 20,
    color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300.0,
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
              color: ColorConfig.primary,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
              boxShadow: [
                BoxShadow(
                    color: ColorConfig.primary, spreadRadius: 3, blurRadius: 7)
              ]),
          child: Row(
            children: [
              CircleAvatar(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      CachedNetworkImageProvider(currentAccount.student.avatar),
                ),
                backgroundColor: Colors.white,
                radius: 55.0,
              ),
              SizedBox(
                width: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentAccount.student.hoTenDem +
                        " " +
                        currentAccount.student.ten,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(height: 10.0,),
                  Text("Ngày sinh: ${DateFormat("dd/MM/yyyy").format(currentAccount.student.ngaySinh)}", style: styleAtributeOfStudent,),
                  SizedBox(height: 10.0,),
                  Text("HSSV: ${currentAccount.student.maSinhVien}", style: styleAtributeOfStudent,),
                  SizedBox(height: 10.0,),
                  Text("Bậc đào tạo: ${currentAccount.student.bacDaoTao.name}", style: styleAtributeOfStudent,),
                  SizedBox(height: 10.0,),
                  Text("Lớp: DHTKPM14BTT}", style: styleAtributeOfStudent,)
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye, color: ColorConfig.orangeCharacter, size: 30.0,),
                  label: Text(
                    "Xem thông tin",
                    style: TextStyle(
                        color:  ColorConfig.orangeCharacter,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.orangeBackground),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.0),
                    )
                  ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.lock, color: ColorConfig.orangeCharacter, size: 30.0,),
                label: Text(
                  "Đổi mật khẩu",
                  style: TextStyle(
                      color:  ColorConfig.orangeCharacter,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold

                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.orangeBackground),
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.0),
                    )
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout, color: ColorConfig.red, size: 30.0,),
                label: Text(
                  "Đăng xuất",
                  style: TextStyle(
                      color:  ColorConfig.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold

                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.redLight),
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.0),
                    )
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
