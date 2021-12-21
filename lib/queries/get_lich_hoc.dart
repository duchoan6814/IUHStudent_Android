String getLichHoc = """
  query (\$date: String!) {
  getLichHoc(date: \$date) {
    status
    errors {
      message
      error_fields
    }
    message
    data {
      name
      monHocs {
        tenMonHoc
        tenLopHocPhan
        lopHocPhan
        tiet
        phong
        ghiChu
        giangVien
        nhomThucHanh
      }
    }
  }
}
""";