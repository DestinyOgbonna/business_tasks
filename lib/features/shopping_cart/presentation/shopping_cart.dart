import 'package:busniess_search/features/shopping_cart/wdget/custom_toast.dart';
import 'package:busniess_search/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartScreen extends StatefulWidget {
  final Item? item;
  final int? index;
  const ShoppingCartScreen({super.key, this.item, this.index});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Details',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    // Product Image Container
                    Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              widget.item?.imagePath ??
                                  'assets/placeholder.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Details Container
                    Container(
                      padding: const EdgeInsets.all(25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DetailsWidget(
                              title: 'Product',
                              description: widget.item?.name ?? 'N/A',
                            ),
                          ),
                          const Expanded(
                            child: DetailsWidget(
                              title: 'Material',
                              description: '100% Cotton',
                            ),
                          ),
                          Expanded(
                            child: DetailsWidget(
                              title: 'Price',
                              description: widget.item != null
                                  ? '\$${widget.item!.price.toStringAsFixed(2)}'
                                  : 'N/A',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(26),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.item?.description ?? 'No description available.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Positioned(
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          CustomToast.show(
                              message:
                                  'Mentor You rest kwanu. You say make we add to basket?',
                              isError: false,
                              context: context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Add to Basket',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 255,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: Text(
                          'Favorite',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                  ),
                ),
                Positioned(
                  top: 370,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: Text(
                          'Descriptions',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
