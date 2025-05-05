# flutter_course

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


lib/
├── core/
│   ├── provider/
│   │   └── providers.dart
│   ├── routing/
│   │   ├── generate_route.dart
│   │   └── app_routes.dart (optional kalau mau constants routes)
│   ├── utils/
│   │   ├── responsive.dart
│   │   ├── size_config.dart
│   │   └── constants.dart (optional untuk warna, fonts, dsb)
│
├── features/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── home_page.dart
│   │   │   ├── provider/
│   │   │   │   └── home_provider.dart
│   │   │   ├── widgets/
│   │   │   │   └── home_banner.dart
│   ├── product/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── product_page.dart
│   │   │   ├── provider/
│   │   │   │   └── product_provider.dart
│   │   │   ├── widgets/
│   │   │   │   └── product_card.dart
│   ├── cart/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   └── cart_page.dart
│   │   │   ├── provider/
│   │   │   │   └── cart_provider.dart
│   │   │   ├── widgets/
│   │   │   │   └── cart_item_card.dart
│
├──common/
    └── widgets/
        ├── app_bar_primary.dart      <-- appbar utama modern
        ├── button_primary.dart       <-- tombol utama (warna solid)
        ├── button_outline.dart       <-- tombol border saja
        ├── button_text.dart          <-- tombol hanya teks
        ├── loading_spinner.dart      <-- loading indicator (circular / linear)
        ├── empty_state_widget.dart   <-- tampilan "data kosong"
        ├── input_text_field.dart     <-- field input standar
        ├── section_title.dart        <-- judul section halaman
        ├── card_product_item.dart    <-- kartu produk (untuk list product)
        ├── card_cart_item.dart       <-- kartu item di cart
        ├── banner_promo.dart         <-- widget banner promo
│
├── main.dart
