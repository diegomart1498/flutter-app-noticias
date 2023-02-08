import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:noticias_provider/src/models/news_models.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias({
    Key? key,
    required this.noticias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context, index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;
  const _Noticia({
    required this.noticia,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia, index: index),
        const SizedBox(height: 5),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(noticia),
        const SizedBox(height: 5),
        const Divider(),
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTopBar({
    required this.noticia,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: const TextStyle(color: Colors.blue)),
          Text('${noticia.source.name}. '),
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;
  const _TarjetaTitulo({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                  placeholder: const AssetImage('assets/giphy.gif'),
                  image: NetworkImage(noticia.urlToImage!))
              : const Image(image: AssetImage('assets/no-image.png')),
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        (noticia.description != null) ? noticia.description! : '',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;
  const _TarjetaBotones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor: Colors.yellow[700],
            child: const Icon(Icons.star),
          ),
          const SizedBox(width: 14),
          RawMaterialButton(
            onPressed: () async {
              final Uri url = Uri.parse(noticia.url);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fillColor: Colors.blueAccent,
            child: const Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}
