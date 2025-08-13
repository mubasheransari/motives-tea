import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Product {
  final String imageUrl;
  final String price;
  final String title;
  final String subtitle;

  Product(this.imageUrl, this.price, this.title, this.subtitle);
}

class ProductHomeScreen extends StatelessWidget {
  final List<Product> horizontalProducts = [
    Product('https://i.imgur.com/Upk0DjN.png', '\$34.00', 'Stripe Details Jersey Track Top', 'Men\'s shoes'),
    Product('https://i.imgur.com/Dx3X7F3.png', '\$27.00', 'Nike Air Force 1 Low Look Retro', 'Men\'s shoes'),
    Product('https://i.imgur.com/Upk0DjN.png', '\$34.00', 'Stripe Details Jersey Track Top', 'Men\'s shoes'),
    Product('https://i.imgur.com/Dx3X7F3.png', '\$27.00', 'Nike Air Force 1 Low Look Retro', 'Men\'s shoes'),
  ];

  final List<Product> verticalProducts = [
    Product('https://i.imgur.com/Upk0DjN.png', '\$34.00', 'Stripe Details Jersey Track Top', 'Men\'s shoes'),
    Product('https://i.imgur.com/Dx3X7F3.png', '\$27.00', 'Nike Air Force 1 Low Look Retro', 'Men\'s shoes'),
    Product('https://i.imgur.com/Upk0DjN.png', '\$34.00', 'Stripe Details Jersey Track Top', 'Men\'s shoes'),
    Product('https://i.imgur.com/Dx3X7F3.png', '\$27.00', 'Nike Air Force 1 Low Look Retro', 'Men\'s shoes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEEF0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with profile & cart
         /*   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile pic + name
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 18,
                  //       backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                  //     ),
                  //     SizedBox(width: 8),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text('Paul Martine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  //         Text('Premium', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  //       ],
                  //     )
                  //   ],
                  // ),

                  // Cart icon with number
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 18),
                        SizedBox(width: 6),
                        Text('02', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/

            // Background image with overlay text
            Stack(
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwvQl21q35fM_HZVInW83s778j4oUGDitKTg&s'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                  ),
                ),
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Ultimate\nCollection',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Step into style',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Horizontal scrollable product cards
            SizedBox(
              height: 230,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: horizontalProducts.length,
                separatorBuilder: (_, __) => SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final p = horizontalProducts[index];
                  return Container(
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0,5))],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.favorite_border, color: Colors.grey),
                          ),
                          Image.network(p.imageUrl, height: 110, fit: BoxFit.contain),
                          SizedBox(height: 8),
                          Text(p.price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 6),
                          Text(p.title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                          SizedBox(height: 4),
                          Text(p.subtitle, style: TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

            // Expanded vertical list of products
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: verticalProducts.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final p = verticalProducts[index];
                  return Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,3))],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(18)),
                          child: Image.network(p.imageUrl, width: 110, height: 110, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                SizedBox(height: 4),
                                Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 6),
                                Text(p.subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.favorite_border, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}








class CustomCarouselWidget extends StatefulWidget {
  final List<String> imageUrls;
  final double aspectRatio;
  final bool enlargeCenterPage;

  const CustomCarouselWidget({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 16 / 9,
    this.enlargeCenterPage = true,
  });

  @override
  State<CustomCarouselWidget> createState() => _CustomCarouselWidgetState();
}

class _CustomCarouselWidgetState extends State<CustomCarouselWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.9,
            aspectRatio: widget.aspectRatio,
            enlargeCenterPage: widget.enlargeCenterPage,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imageUrls.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                color: isActive ? Colors.blueAccent : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
