import 'package:flutter/material.dart';
import 'package:iuh_student/models/models.dart';

import 'enums/enums.dart';

class Student {
  final String maSinhVien;
  final String maHoSo;
  final String? avatar;
  final String hoTenDem;
  final String ten;
  final bool gioiTinh;
  final BacDaoTao bacDaoTao;
  final TrangThai? trangThai;
  final LoaiHinhDaoTao? loaiHinhDaoTao;
  final DateTime? ngayVaoTruong;
  final DateTime ngaySinh;
  final DateTime? ngayVaoDoan;
  final String? soDienThoai;
  final String? diaChi;
  final String noiSinh;
  final String? hoKhauThuongTru;
  final String? danToc;
  final DateTime? ngayVaoDang;
  final String? email;
  final TonGiao? tonGiao;
  final CMND? cmnd;

  Student({
    required this.maSinhVien,
    required this.maHoSo,
    required this.hoTenDem,
    required this.ten,
    this.avatar,
    required this.gioiTinh,
    required this.bacDaoTao,
    this.trangThai,
    this.loaiHinhDaoTao,
    this.ngayVaoTruong,
    required this.ngaySinh,
    this.ngayVaoDoan,
    this.soDienThoai,
    this.diaChi,
    required this.noiSinh,
    this.hoKhauThuongTru,
    this.danToc,
    this.ngayVaoDang,
    this.email,
    this.tonGiao,
    this.cmnd
  });
}
