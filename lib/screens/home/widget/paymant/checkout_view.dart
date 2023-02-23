import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyperpay/hyperpay.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/authentication/models/models_export.dart';
import 'package:rehab_care/widgets/widgets_export.dart';
import '../../model/model_export.dart';
import './constants.dart';
import './formatters.dart';
import '../../../../config/config_export.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    Key? key,
    required this.childrenParent,
    required this.isEditing,
    required this.myUserInfo,
  }) : super(key: key);
  final ChildrenParent childrenParent;
  final bool isEditing;
  final MyUserInfo myUserInfo;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Map<String, String> cardLogo = {
    "visa": AppAssets.visa,
    "mastercard": AppAssets.master,
    "mada": AppAssets.mada
  };
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  BrandType brandType = BrandType.none;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String sessionCheckoutID = '';
  late HyperpayPlugin hyperPay;

  @override
  void initState() {
    // setup();
    super.initState();
  }

  ///TODO paymentPart 1 of 3
  setup() async {
    hyperPay = await HyperpayPlugin.setup(config: TestConfig());
  }

  Future<void> pay() async {
    HyperpayPlugin hyperpayPlugin =
        await HyperpayPlugin.setup(config: TestConfig());
    hyperpayPlugin.initSession(
        checkoutSetting: CheckoutSettings(
            brand: brandType,
            amount: 92,
            headers: {},
            additionalParams: {
          "amount": "92.0",
          "user_id": "17",
          "card_name": "Salem zakkar"
        }));
    await hyperpayPlugin.getCheckoutID;
    PaymentStatus status = await hyperpayPlugin.pay(CardInfo(
        holder: "Salem Zakkar",
        cardNumber: "4000000000000000",
        cvv: "123",
        expiryMonth: "11",
        expiryYear: "2025"));
    print(status.name);
  }

  ///TODO paymentPart 3 of 3
  /// Initialize HyperPay session
  Future<void> initPaymentSession(
    BrandType brandType,
    double amount,
  ) async {
    CheckoutSettings checkoutSettings = CheckoutSettings(
      brand: brandType,
      amount: amount,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer OGFjN2E0Y2E3ODQzZjE3ZDAxNzg0NGM2ZjI1NzA2NmN8Tlc2Sk5nY1kyZQ=='
      },
      additionalParams: {
        'merchantTransactionId': '#123456',
        // 'entity_id' : '8a8294174b7ecb28014b9699220015ca',
        // 'amount' : "92",
        // 'currency' : "AED",
        // 'paymentType' : "DB"
      },
    );

    hyperPay.initSession(checkoutSetting: checkoutSettings);
    sessionCheckoutID = await hyperPay.getCheckoutID;
  }

  ///TODO paymentPart 2 of 3
  Future<void> onPay(context) async {
    final bool valid = Form.of(context)?.validate() ?? false;

    if (valid) {
      setState(() {
        isLoading = true;
      });

      // Make a CardInfo from the controllers
      CardInfo card = CardInfo(
        holder: holderNameController.text,
        cardNumber: cardNumberController.text.replaceAll(' ', ''),
        cvv: cvvController.text,
        expiryMonth: expiryController.text.split('/')[0],
        expiryYear: '20${expiryController.text.split('/')[1]}',
      );

      String userId = '';
      String childId = '';
      String paymentMethod = brandType.name;
      String status = '';
      String actionDate = '';
      double amount = 11;
      try {
        // Start transaction
        if (sessionCheckoutID.isEmpty) {
          // Only get a new checkoutID if there is no previous session pending now
          await initPaymentSession(brandType, amount);
        }
        await setup();
        await initPaymentSession(brandType, amount);
        final result = await hyperPay.pay(card);
        myCustomShowSnackBarText(context, result.name);
        switch (result) {
          case PaymentStatus.init:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment session is still in progress'),
                backgroundColor: Colors.amber,
              ),
            );
            break;
          // For the sake of the example, the 2 cases are shown explicitly
          // but in real world it's better to merge pending with successful
          // and delegate the job from there to the server, using webhooks
          // to get notified about the final status and do some action.
          case PaymentStatus.pending:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment pending ⏳'),
                backgroundColor: Colors.amber,
              ),
            );
            break;
          case PaymentStatus.successful:
            print(result.name);
            print(
                '------------------------------------------------------------------------>');
            // try {
            //   print('user_id : $userId');
            //   print("child_id : $childId");
            //   print("payment_method : $paymentMethod");
            //   print("status : $status");
            //   print("action_date : $actionDate");
            //   print("amount : $amount");
            //
            //   Response resPayment = await myDio.post(
            //     EndPoints.payment,
            //     queryParameters: {
            //       'user_id': userId,
            //       'child_id': childId,
            //       'payment_method': paymentMethod,
            //       'status': status,
            //       'action_date': actionDate,
            //       'amount': amount.toString(),
            //     },
            //   );
            // } catch (error) {
            //   print(error);
            // }

            sessionCheckoutID = '';
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment approved 🎉'),
                backgroundColor: Colors.green,
              ),
            );
            break;

          default:
        }
      } on HyperpayException catch (exception) {
        sessionCheckoutID = '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(exception.details ?? exception.message),
            backgroundColor: Colors.red,
          ),
        );
      } catch (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$exception'),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            autovalidateMode: autoValidateMode,
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(AppAssets.payNow),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Card Info",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Holder
                    TextFormField(
                      controller: holderNameController,
                      validator: (text) {
                        if (!Validator.checkName(text ?? "")) {
                          return "Name is invalid";
                        }
                        return null;
                      },
                      decoration: _inputDecoration(
                        context: context,
                        label: "Card Holder",
                        //hint: "Jane Jones",
                        icon: Icons.account_circle_rounded,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Number
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        context: context,
                        label: "Card Number",
                        hint: "0000 0000 0000 0000",
                        icon: brandType == BrandType.none
                            ? Icons.credit_card
                            : cardLogo[brandType.name],
                      ),
                      onChanged: (value) {
                        setState(() {
                          brandType = value.detectBrand;
                        });
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(brandType.maxLength),
                        CardNumberInputFormatter()
                      ],
                      validator: (String? number) =>
                          brandType.validateNumber(number ?? ""),
                    ),
                    const SizedBox(height: 10),
                    // Expiry date
                    TextFormField(
                      controller: expiryController,
                      decoration: _inputDecoration(
                        context: context,
                        label: "Expiry Date",
                        hint: "MM/YY",
                        icon: Icons.date_range_rounded,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter(),
                      ],
                      validator: (String? date) =>
                          CardInfo.validateDate(date ?? ""),
                    ),
                    const SizedBox(height: 10),
                    // CVV
                    TextFormField(
                      controller: cvvController,
                      decoration: _inputDecoration(
                        context: context,
                        label: "CVV",
                        hint: "000",
                        icon: Icons.confirmation_number_rounded,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (String? cvv) =>
                          CardInfo.validateCVV(cvv ?? ""),
                    ),
                    const SizedBox(height: 30),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: isLoading ? null : () => onPay(context),
                    //     child: Text(
                    //       isLoading
                    //           ? 'Processing your request, please wait...'
                    //           : 'PAY',
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        await pay();
                      },
                      child: Container(
                        width: size.width * 0.5,
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment.center,
                        child: Text(
                          isLoading
                              ? 'Processing your request, please wait...'
                              : "Pay Now",
                          textScaleFactor: 1,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {String? label,
      String? hint,
      dynamic icon,
      required BuildContext context}) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
      labelStyle:
          TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),

      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      prefixIcon: icon is IconData
          ? Icon(
              icon,
              color: Theme.of(context).primaryColor,
            )
          : Container(
              padding: const EdgeInsets.all(6),
              width: 10,
              child: Image.asset(icon),
            ),
    );
  }
}
