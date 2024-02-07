import 'package:get_storage/get_storage.dart';

import '../model/qoute_databse.dart';

final data = GetStorage();

Future<List<QuotesDatabaseModel>>? getAllQuotes;

List<String> imageList = [
  "assets/continer_images/q1.jpeg",
  "assets/continer_images/q2.jpeg",
  "assets/continer_images/q3.jpeg",
  "assets/continer_images/q4.jpeg",
  "assets/continer_images/q5.jpeg",
  "assets/continer_images/q6.jpg",
  "assets/continer_images/q7.jpeg",
  "assets/continer_images/q8.jpeg",
  "assets/continer_images/q9.jpeg",
  "assets/continer_images/q10.jpeg",
];
bool showImages = false;

int currentImageIndex = 0;
var textSize = 14.0;
var verticalSpacing = 1.0;
var textLineSpace = 1.0;

List<String> imagePaths = [
  "assets/images/birthday.png",
  "assets/images/work.png",
  "assets/images/Good morning.png",
  "assets/images/love.png",
  "assets/images/attitude.png",
  "assets/images/relationship.png",
  "assets/images/life.png",
  "assets/images/happy.png",
  "assets/images/sad.png",
  "assets/images/motivation.png",
  "assets/images/wife.png",
  "assets/images/time.png",
  "assets/images/husband.png",
  "assets/images/inspristonal.png",
  "assets/images/success.png",
  "assets/images/friendship.png",
  "assets/images/art.png",
  "assets/images/annevasary.png",
  "assets/images/critshmas.png",
  "assets/images/dream.png",
  "assets/images/failure.png",
  "assets/images/funny.png",
  "assets/images/god.png",
  "assets/images/jelosuly.png",
  "assets/images/meditation.png",
  "assets/images/Nature.png",
  "assets/images/new year.png",
  "assets/images/philosophy.png",
  "assets/images/thankyou.png",
  "assets/images/valentine day.png",
  "assets/images/Good Night.png",
  "assets/images/social.png",
];
