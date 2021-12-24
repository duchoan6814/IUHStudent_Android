import 'get_lich_hoc.dart';
import 'get_diem.dart';
import 'get_lich_hoc.dart';
import 'get_qua_trinh_hoc_tap.dart';
import 'get_hoc_ky.dart';

String getProfileQuery = """
  query GET_PROFILE {
    getProfile {
      status
      message
      errors {
        message
        error_fields
      }
      data {
        sinhVienId
        maSinhVien
        maHoSo
        image
        hoTenDem
        ten
        gioiTinh
        ngaySinh
        bacDaoTao
        trangThai
        loaiHinhDaoTao
        ngayVaoTruong
        ngayVaoDoan
        soDienThoai
        diaChi
        noiSinh
        hoKhauThuongTru
        danToc
        ngayVaoDang
        email
        tonGiao
      }
    }
  }
""";