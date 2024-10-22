



class OnbrdingModel {
  final String img;
  final String text;
  final String? buttonText;


  OnbrdingModel({required this.img, required this.text,this.buttonText,});
}

List<OnbrdingModel> onbrdingModelList = [
  OnbrdingModel(img: 'Assets/image 7.png', text: '"Satisfy your hunger without\n leaving home  order your\n favorites now!"'),
  OnbrdingModel(img: 'Assets/image 4.png', text: 'Your next career adventure\n starts here \nJoin us in shaping the future'),
  OnbrdingModel(img: 'Assets/image 6.png', text: '"Stay on top of your health—book and manage appointments effortlessly."'),
  OnbrdingModel(img: 'Assets/image 5.png', text: '"Buy, sell, and thrive  find\n your next deal today!"',buttonText: "Let's Start"),
];
