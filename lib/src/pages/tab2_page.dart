import 'package:flutter/material.dart';
import 'package:noticias_provider/src/models/category_model.dart';
import 'package:noticias_provider/src/services/news_service.dart';
import 'package:noticias_provider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _ListaCategorias(),
            Expanded(
              child: (newsService
                      .categoryArticles[newsService.selectedCat]!.isEmpty)
                  ? const Center(child: CircularProgressIndicator())
                  : ListaNoticias(
                      noticias: newsService
                          .categoryArticles[newsService.selectedCat]!),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return SizedBox(
      height: 85,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final String nombre = categories[index].name;
          return SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(category: categories[index]),
                  const SizedBox(height: 5),
                  Text(
                    '${nombre[0].toUpperCase()}${nombre.substring(1)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        newsService.selectedCat = category.name;
        //print(category.name);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: (newsService.selectedCat == category.name)
            ? const BoxDecoration(shape: BoxShape.circle, color: Colors.blue)
            : const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: Colors.black54,
        ),
      ),
    );
  }
}
