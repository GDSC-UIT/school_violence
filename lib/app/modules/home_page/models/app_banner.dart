class AppBanner {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String author;

  AppBanner(this.id, this.title, this.thumbnailUrl, this.author);
}

List<AppBanner> appBannerList = [
  AppBanner(
      1,
      'School violence: A preventable public health problem',
      'https://i0.wp.com/vitalrecord.tamhsc.edu/wp-content/uploads/2020/11/school-violence-feature.jpg?fit=1100%2C625&ssl=1',
      'Vital Record'),
  AppBanner(
      2,
      'School violence on the rise, Ministry seeks solutions',
      'https://vnn-imgs-f.vgcloud.vn/2019/05/08/18/school-violence-on-the-rise-ministry-seeks-solutions.jpg',
      'Vietnamnet'),
  AppBanner(
      3,
      'SOCIETY School violence: International experience and Vietnam\’s new solutions',
      'https://cdnimgen.vietnamplus.vn/uploaded/kg1/2019_11_07/3_2.jpg',
      'Baolaodong'),
  AppBanner(
      4,
      'What Is School Violence?',
      'https://www.verywellmind.com/thmb/XQOYIdEquZKEBJMPB_A9qrDpG-0=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1290797065-78b3e5ba569e404da2e0e2ba386864cd.jpg',
      'verywell mind'),
  AppBanner(
      5,
      'Extreme violence in schools on the increase',
      'https://image.vietnamnews.vn/uploadvnnews/Article/2016/10/19/baoluchocduong63961349PM.jpg',
      'Viet Nam News'),
];
