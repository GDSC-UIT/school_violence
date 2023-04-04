class SchoolClub {
  final int id;
  final String title;
  final String thumbnailUrl;

  SchoolClub(this.id, this.title, this.thumbnailUrl);
}

List<SchoolClub> schoolClubList = [
  SchoolClub(1, 'Shooting',
      'https://thumbs.dreamstime.com/b/school-shooting-bullet-holes-made-firearm-massacre-educational-institution-vector-illustration-school-shooting-129845367.jpg'),
  SchoolClub(2, 'POP',
      'https://scontent.fsgn16-1.fna.fbcdn.net/v/t39.30808-6/311597017_113760194844270_7077197174785174317_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=BWk24KXmyJUAX_CHuBp&_nc_ht=scontent.fsgn16-1.fna&oh=00_AfCrbJ8qki5hnd-VMwud2ELBzKuqOTmv93i888dJWdL0wg&oe=64305969'),
  SchoolClub(3, 'BAC',
      'https://vnn-imgs-f.vgcloud.vn/2019/05/02/10/comprehensive-measures-needed-to-end-school-violence.jpg'),
  SchoolClub(4, 'NAM',
      'https://www.dianova.org/wp-content/uploads/2017/08/school-violence.jpg'),
  SchoolClub(5, 'Fight',
      'https://live-production.wcms.abc-cdn.net.au/aa93c853bce31a9f8ece2ab025d7cabf?impolicy=wcms_crop_resize&cropH=3079&cropW=4619&xPos=0&yPos=0&width=862&height=575'),
];
