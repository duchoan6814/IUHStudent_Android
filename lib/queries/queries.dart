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
      }
    }
  }
""";