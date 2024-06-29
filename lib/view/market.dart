import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Set the background color of buttons to black
            foregroundColor: Colors.white, // Set the text color of buttons to white
            elevation: 5, // Add some elevation to buttons
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: MarketPage1(),
    );
  }
}

class MarketPage1 extends StatefulWidget {
  @override
  _MarketPage1State createState() => _MarketPage1State();
}

class _MarketPage1State extends State<MarketPage1> {
  List<Map<String, dynamic>> products = [
    {"name": "whey protein", "image": "assets/img/whey protein.jpg", "price": 500.0},
    {"name": "creatine", "image": "assets/img/creatine.jpg", "price": 300.0},
    {"name": "C4", "image": "assets/img/c4.jpg", "price": 400.0},
    // Add more products here
  ];

  List<Map<String, dynamic>> filteredProducts = [];
  Map<String, int> cart = {};
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(products);
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProducts = products
            .where((product) => product["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProducts = List.from(products);
      }
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.update(product['name'], (value) => value + 1, ifAbsent: () => 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['name']} added to cart')),
    );
  }

  void removeFromCart(Map<String, dynamic> product) {
    setState(() {
      if (cart.containsKey(product['name']) && cart[product['name']]! > 0) {
        cart.update(product['name'], (value) => value - 1);
        if (cart[product['name']] == 0) {
          cart.remove(product['name']);
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['name']} removed from cart')),
    );
  }

  void proceedToCheckout() {
    _pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void navigateBack() {
    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Market', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          buildProductListView(),
          buildCartView(),
          buildCheckoutView(),
        ],
      ),
    );
  }

  Widget buildProductListView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for product',
              prefixIcon: Icon(Icons.search, color: Colors.black),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              filterProducts(value);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: filteredProducts[index],
                onAdd: () => addToCart(filteredProducts[index]),
                onRemove: () => removeFromCart(filteredProducts[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCartView() {
    double total = cart.entries.fold(0, (sum, item) {
      var product = products.firstWhere((prod) => prod['name'] == item.key);
      return sum + (product['price'] * item.value);
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: navigateBack,
              ),
              Text('Your Cart', style: TextStyle(fontSize: 18, color: Colors.black)),
              SizedBox(width: 48), // Placeholder for alignment
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              String productName = cart.keys.elementAt(index);
              int quantity = cart[productName]!;
              var product = products.firstWhere((prod) => prod['name'] == productName);

              return ListTile(
                leading: Image.asset(product['image']),
                title: Text(productName),
                subtitle: Text('\$${product['price']} x $quantity'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.black),
                      onPressed: () => removeFromCart(product),
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.black),
                      onPressed: () => addToCart(product),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Text('Total: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MySample()),
    );
  },
  child: Text('Proceed to Checkout'),
),
SizedBox(height: 40,),

            ],
          ),
        ),
      ],
    );
  }

  Widget buildCheckoutView() {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cardNumberController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: navigateBack,
                ),
                Text('Checkout', style: TextStyle(fontSize: 18, color: Colors.black)),
                SizedBox(width: 48), // Placeholder for alignment
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Credit Card Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your credit card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
Colors.black, // Set the background color of button to black
                      foregroundColor: Colors.white, // Set the text color of button to white
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process the payment
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Payment')),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  ProductCard({
    required this.product,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.asset(
              product['image'],
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.black),
              onPressed: onRemove,
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.black),
              onPressed: onAdd,
            ),
            IconButton(
              icon: Icon(Icons.check_circle, color: Colors.black), // تعيين لون الزرار هنا
              onPressed: () {
                // أداء إجراء عند الضغط على زر التشيك آوت
              },
            ),
          ],
        ),
      ),
    );
  }
}





class MySample extends StatefulWidget {
  const MySample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MySampleState();
}

class MySampleState extends State<MySample> {
  bool isLightTheme = false; // حالة الثيم الحالي (فاتح/داكن)
  String cardNumber = ''; // رقم البطاقة
  String expiryDate = ''; // تاريخ انتهاء الصلاحية
  String cardHolderName = ''; // اسم صاحب البطاقة
  String cvvCode = ''; // رمز CVV
  bool isCvvFocused = false; // هل تم التركيز على رمز CVV
  bool useGlassMorphism = false; // هل يجب استخدام تأثير "Glassmorphism"
  bool useBackgroundImage = false; // هل يجب استخدام صورة خلفية
  bool useFloatingAnimation = true; // هل يجب استخدام الرسوم المتحركة الطافية
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>(); // مفتاح عالمي لنموذج البطاقة

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return MaterialApp(
      title: 'Card View',
      debugShowCheckedModeBanner: false,
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        // ثيم النصوص والحقول النصية في حالة الثيم الفاتح
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black, fontSize: 18),
        ),
        // تكوين الألوان لحالة الثيم الفاتح
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.black,
          background: Colors.white,
          primary: Colors.black,
        ),
        // تصميم الحقول النصية
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      darkTheme: ThemeData(
        // ثيم النصوص والحقول النصية في حالة الثيم الداكن
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.white, fontSize: 18),
        ),
        // تكوين الألوان لحالة الثيم الداكن
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          background: Colors.white,
          primary: Colors.white,
        ),
        // تصميم الحقول النصية
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Card View'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // عنصر عرض بطاقة الائتمان
                    CreditCardWidget(
                      enableFloatingCard: useFloatingAnimation,
                      glassmorphismConfig: _getGlassmorphismConfig(),
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      bankName: 'Axis Bank',
                      backgroundImage:'assets/img/visa background.jpeg' ,
                      frontCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      backCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      // تعيين صورة خلفية مخصصة إذا تم تفعيلها
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'assets/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            // نموذج إدخال بيانات بطاقة الائتمان
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              inputConfiguration: const InputConfiguration(
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                ),
                                expiryDateDecoration: InputDecoration(
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  labelText: 'Card Holder',
                                ),
                              ),
// دالة تنفيذ عند تغيير البيانات في نموذج البطاقة
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                            const SizedBox(height: 20),
// زر "Validate" للتحقق من صحة البيانات
                            GestureDetector(
                              onTap: _onValidate,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFB58D67),
                                      Color(0xFFE5D1B2),
                                      Color(0xFFF9EED2),
                                      Color(0xFFEFEFED),
                                      Color(0xFFF9EED2),
                                      Color(0xFFB58D67),
                                    ],
                                    begin: Alignment(-1, -4),
                                    end: Alignment(1, 4),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding:
                                const EdgeInsets.symmetric(vertical: 15),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Validate',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'halter',
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// دالة التحقق من صحة البيانات
  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('صحيحة!');
    } else {
      print('غير صحيحة!');
    }
  }

// دالة لإرجاع تكوين "Glassmorphism" المطلوب
  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }
    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return isLightTheme
        ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
        : Glassmorphism.defaultConfig();
  }

// دالة تنفيذ عند تغيير البيانات في نموذج بطاقة الائتمان
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}