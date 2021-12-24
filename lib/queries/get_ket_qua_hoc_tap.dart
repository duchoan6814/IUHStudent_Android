String getKetQuaHocTap = """
query (\$hocKyId: ID!) {
  getKetQuaHocTap(hocKyId: \$hocKyId) {
    status
    errors {
      message
      error_fields
    }
    message
    data {
      monHoc {
        monHocId
        tenMonHoc
        soTinChi
      }
      diem
      diemTrungBinh
    }
  }
}
""";