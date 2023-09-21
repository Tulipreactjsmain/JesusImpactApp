class SliderModel {
  String? title;
  String? description;
  String? imagePath;

  SliderModel({this.title, this.description, this.imagePath});

  void setImageAssetPath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescriotion) {
    description = getDescriotion;
  }

  String getImageAssetPath() {
    return imagePath ?? "";
  }

  String getTitle() {
    return title ?? "";
  }

  String getDescription() {
    return description ?? "";
  }
}

List<SliderModel> getslider() {
  List<SliderModel> slides = [];
  SliderModel sliderModel = SliderModel();

  sliderModel.setImageAssetPath('assets/Vulneribility.png');
  sliderModel.setTitle("Vulnerability");
  sliderModel.setDescription(
      "A safe space to share expiriences, struggles, and be vulnerable in our faith work");

  slides.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.setImageAssetPath('assets/Family.png');
  sliderModel.setTitle("Family");
  sliderModel.setDescription("Lets’s do life together");

  slides.add(sliderModel);
  sliderModel = SliderModel();

   sliderModel.setImageAssetPath('assets/Community.png');
  sliderModel.setTitle("Community");
  sliderModel.setDescription("Let’s grow, connect and spread the revival fire");

  slides.add(sliderModel);
  sliderModel = SliderModel();

  return slides;
}
