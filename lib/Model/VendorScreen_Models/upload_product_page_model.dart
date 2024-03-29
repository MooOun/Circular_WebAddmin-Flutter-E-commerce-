
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminComponent/AddProductScreen_Page.dart';

class UploadProductPageModel extends FlutterFlowModel<UploadProductPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  List<Map<String, dynamic>> categories = [];
  List<String> selectedSizes = [];
   Map<String, int> sizesWithQuantities = {};
  // State field(s) for ProductName widget.
  FocusNode? productNameFocusNode;
  TextEditingController? productNameController;
  String? Function(BuildContext, String?)? productNameControllerValidator;
  // State field(s) for Category widget.
  String? categoryValue;
  FormFieldController<String>? categoryValueController;
  // State field(s) for Size widget.
  FormFieldController<List<String>>? sizeValueController;
  String? get sizeValue => sizeValueController?.value?.firstOrNull;
  set sizeValue(String? val) =>
      sizeValueController?.value = val != null ? [val] : [];
  // State field(s) for ProductPrice widget.
  FocusNode? productPriceFocusNode;
  TextEditingController? productPriceController;
  String? Function(BuildContext, String?)? productPriceControllerValidator;
  // State field(s) for ProductQty widget.

  // FocusNode? productQtyFocusNode;
  // TextEditingController? productQtyController;
  // String? Function(BuildContext, String?)? productQtyControllerValidator;

  // State field(s) for ProductDescription widget.
  FocusNode? productDescriptionFocusNode;
  TextEditingController? productDescriptionController;
  String? Function(BuildContext, String?)?
      productDescriptionControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    productNameFocusNode?.dispose();
    productNameController?.dispose();

    productPriceFocusNode?.dispose();
    productPriceController?.dispose();

    // productQtyFocusNode?.dispose();
    // productQtyController?.dispose();

    productDescriptionFocusNode?.dispose();
    productDescriptionController?.dispose();
  }

 void updateQuantityForSize(String size, int quantity) {
    sizesWithQuantities[size] = quantity;
   }
  /// Action blocks are added here.

  /// Additional helper methods are added here.
  /// 
  /// 
}
