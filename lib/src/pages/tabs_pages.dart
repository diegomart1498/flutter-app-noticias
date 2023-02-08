import 'package:flutter/material.dart';
import 'package:noticias_provider/src/pages/pages.dart';
import 'package:noticias_provider/src/widgets/show_exit_pop.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _NavegacionModel(),
      child: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: const Scaffold(
          body: _Paginas(),
          bottomNavigationBar: _Navegacion(),
        ),
      ),
    );
  }
  // Future<bool> exitFromApp() async {
  //   return false;
  // }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) => navegacionModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    //Cuando cambio el valor de la página, notifico a quienes les interesa esa propiedad
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
