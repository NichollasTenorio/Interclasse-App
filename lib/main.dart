import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/ui.dart';
import 'screens/games_screen.dart';
import 'screens/home_screen.dart';
import 'screens/match_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/ranking_screen.dart';
import 'screens/stats_screen.dart';

//Inicialização da aplicação
void main() => runApp(const InterclasseApp());

class InterclasseApp extends StatelessWidget {
  const InterclasseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interclasse Etec 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
        scaffoldBackgroundColor: AppColors.pageBg,
      ),
      home: const AppShell(),
    );
  }
}

//array de objetos constantes da classe AppTab
enum AppTab {
  home('Início', AppIcons.home),
  games('Jogos', AppIcons.games),
  ranking('Ranking', AppIcons.rank),
  stats('Stats', AppIcons.stats),
  profile('Perfil', AppIcons.user);

  const AppTab(this.label, this.icon);
  final String label;
  final String icon;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppTab _tab = AppTab.home;
  bool _showDetail = false;

  void _goToDetail() => setState(() {
        _showDetail = true;
        _tab = AppTab.games;
      });

  void _goBack() => setState(() => _showDetail = false);

  Widget _screen() {
    if (_showDetail) return MatchDetailScreen(onBack: _goBack);
    return switch (_tab) {
      AppTab.home => HomeScreen(onMatch: _goToDetail),
      AppTab.games => GamesScreen(onMatch: _goToDetail),
      AppTab.ranking => const RankingScreen(),
      AppTab.stats => const StatsScreen(),
      AppTab.profile => const ProfileScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SizedBox.expand(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.bg,
                  boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.12), blurRadius: 40)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(height: topInset, color: AppColors.teal),
                    Expanded(child: ClipRect(child: _screen())),
                    if (!_showDetail) _bottomNav(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (final item in AppTab.values)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _tab = item),
                  child: _NavItem(item: item, active: _tab == item),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.item, required this.active});

  final AppTab item;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.teal : AppColors.muted;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: active ? AppColors.teal : Colors.transparent, width: 2)),
      ),
      child: Col(
        gap: 2,
        align: CrossAxisAlignment.center,
        children: [
          SvgIcon(item.icon, color: color),
          Label(item.label, size: 9, color: color, weight: active ? FontWeight.w700 : FontWeight.w400),
        ],
      ),
    );
  }
}
