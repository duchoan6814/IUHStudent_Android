String getHocKySimple = """
query {
  getHocKySimple {
    status
    message
    errors {
      message
      error_fields
    }
    data {
      hocKyId
      namHoc
    }
  }
}
""";