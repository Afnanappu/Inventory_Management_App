List<String> brandItemList = [
  'All',
  'iPhone',
  'Redmi',
  'Samsung',
  'OnePlus',
];

List<String> itemNameList = [
  'OnePlus Nord 4 5G',
  'Redmi 13C 5G',
  'Samsung Galaxy S23 Ultra',
  'Apple iPhone 14 Plus'
];

List<String> itemImageList = [
  'assets/mobiles/OnePlus Nord 4 5G.png',
  'assets/mobiles/Redmi 13C 5G.png',
  'assets/mobiles/Samsung Galaxy S23 Ultra.png',
  'assets/mobiles/Apple iPhone 14 Plus.png',
  'assets/mobiles/OnePlus 12.png',
];

List<String> itemPriceList = [
  '₹32,998',
  '₹27,999',
  '₹84,999',
  '₹56,499',
];


List<ItemModel> itemModelList = [
  ItemModel(itemName: itemNameList[0], itemBrandName: brandItemList[4], itemImage: itemImageList[0], itemPrice: itemPriceList[0]),
  ItemModel(itemName: itemNameList[1], itemBrandName: brandItemList[2], itemImage: itemImageList[1], itemPrice: itemPriceList[1]),
  ItemModel(itemName: itemNameList[2], itemBrandName: brandItemList[2], itemImage: itemImageList[2], itemPrice: itemPriceList[2]),
  ItemModel(itemName: itemNameList[3], itemBrandName: brandItemList[1], itemImage: itemImageList[3], itemPrice: itemPriceList[3]),
];

class ItemModel {
  String itemName;
  String itemBrandName;
  String itemImage;
  String itemPrice;

  ItemModel({required this.itemName, required this.itemBrandName, required this.itemImage, required this.itemPrice});
}

