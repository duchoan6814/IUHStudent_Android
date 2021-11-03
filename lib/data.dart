import 'package:iuh_student/models/account.dart';

import 'models/models.dart';
import 'models/enums/enums.dart';

Student currentStudent = Student(bacDaoTao: BacDaoTao.DAI_HOC, maSinhVien: "18054321", maHoSo: "123", hoTenDem: "Trương Đức", ten: "Hoàn", gioiTinh: true, ngaySinh: DateTime.now(), noiSinh: "Hải Dương", avatar: "https://scontent-hkt1-1.xx.fbcdn.net/v/t1.6435-9/159839653_2957424391192444_3747099104325645829_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=OBONLJ4J9agAX9grBwb&_nc_ht=scontent-hkt1-1.xx&oh=16af749b2e0cadfb428f11872238cb59&oe=619DB491");

Account currentAccount = Account("18054321", "saPassword", currentStudent);