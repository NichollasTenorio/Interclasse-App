import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 72),
      child: Col(
        children: [
          _header(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Col(
              gap: 14,
              children: [
                AppCard(
                  padding: const EdgeInsets.all(12),
                  child: Col(
                    children: [
                      const _CardTitle('DESEMPENHO'),
                      Col(
                        gap: 10,
                        children: const [
                          ProgBar(label: 'Eficiência de Gol', pct: 80, value: '80%'),
                          ProgBar(label: 'Participação em Gols', pct: 73, value: '73%'),
                          ProgBar(label: 'Aproveitamento', pct: 80, value: '80%'),
                        ],
                      ),
                    ],
                  ),
                ),
                AppCard(
                  padding: const EdgeInsets.all(12),
                  child: Col(
                    children: [
                      const _CardTitle('INFORMAÇÕES'),
                      for (final (k, v) in MockData.profileInfo) KeyValueRow(label: k, value: v, spacing: 9),
                    ],
                  ),
                ),
                _settings(),
                Container(
                  padding: const EdgeInsets.all(14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.red),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Label('Sair da conta', size: 13, color: AppColors.red, weight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    final stats = MockData.profileStats;
    return Container(
      color: AppColors.teal,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Col(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HRow(
              gap: 14,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white15,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white40, width: 2),
                  ),
                  child: Label('JS', size: 22, color: AppColors.white, weight: FontWeight.w700),
                ),
                IntrinsicWidth(
                  child: Col(
                    gap: 4,
                    children: [
                      Heading('João Silva', size: 20, color: AppColors.white),
                      Label('Desenvolvimento de Sistemas · #10 · Atacante', color: AppColors.white70),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.white15,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Label('JOGADOR', size: 10, color: AppColors.white, weight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white10,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                for (var i = 0; i < stats.length; i++)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: i < stats.length - 1
                            ? const Border(right: BorderSide(color: AppColors.white20))
                            : null,
                      ),
                      child: Col(
                        align: CrossAxisAlignment.center,
                        children: [
                          Heading(stats[i].$1, size: 20, color: AppColors.white),
                          Label(stats[i].$2, size: 10, color: AppColors.white70),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Toggles estáticos
  Widget _settings() {
    final items = MockData.profileToggles;
    return AppCard(
      child: Col(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
              child: HRow(
                main: MainAxisAlignment.spaceBetween,
                children: [
                  Label(items[i].$1, size: 13, color: AppColors.text),
                  _Toggle(on: items[i].$2),
                ],
              ),
            ),
            if (i < items.length - 1) const HDivider(),
          ],
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Label(text, size: 11, color: AppColors.teal, weight: FontWeight.w700),
      );
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.on});

  final bool on;

  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 22,
        decoration: BoxDecoration(
          color: on ? AppColors.teal : AppColors.placeholder,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              left: on ? 20 : 2,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      );
}
