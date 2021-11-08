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