String getDiemThi = """
query {
  getDiemThi {
    status
    message
    errors {
      message
      error_fields
    }
    data {
      tenHocKy
      monHocs {
        tenMonHoc
        diemThuongKy
        diemGiuaKy
        diemCuoiKy
        diemThucHanh
        diemTrungBinh
        ghiChu
      }
    }
  }
}
""";