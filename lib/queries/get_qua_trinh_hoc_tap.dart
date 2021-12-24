String getTienDoHocTap = """
query {
  getTienDoHocTap {
    status
    errors {
      message
      error_fields
    }
    message
    data {
      tongTinChi
      tinChiDatDuoc
    }
  }
}
""";