enum BacDaoTao { DAI_HOC, CAO_DANG, THAC_SI }

extension BacDaoTaoExtension on BacDaoTao {

  static const names = {
    BacDaoTao.THAC_SI: 'Thạc sĩ',
    BacDaoTao.CAO_DANG: 'Cao đẳng',
    BacDaoTao.DAI_HOC: 'Đại học',
  };

  String? get name => names[this];

}
