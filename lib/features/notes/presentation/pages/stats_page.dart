import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/core/theme/theme_controller.dart';
import 'package:desafio_target/features/notes/presentation/controllers/stats_controller.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late final StatsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<StatsController>();
    _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textPrimary = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: const AppText.headline('Estatísticas'),
        actions: [
          Observer(builder: (_) {
            final themeController = getIt<ThemeController>();
            return IconButton(
              icon: Icon(themeController.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              tooltip: 'Alternar tema',
              onPressed: themeController.toggleTheme,
            );
          }),
        ],
      ),
      body: Observer(builder: (_) {
        if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
        if (_controller.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_outlined, size: 48, color: textSecondary),
                const SizedBox(height: 12),
                AppText.body(_controller.errorMessage!, color: textSecondary),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _controller.load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _summaryRow(surface, textPrimary, textSecondary, border),
            const SizedBox(height: 24),
            if (_controller.totalLetters > 0 || _controller.totalDigits > 0) ...[
              AppText.label('Letras vs números', color: textSecondary),
              const SizedBox(height: 16),
              _pieChart(textPrimary, textSecondary, surface, border),
              const SizedBox(height: 24),
            ],
            if (_controller.letterFrequency.isNotEmpty || _controller.digitFrequency.isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_controller.letterFrequency.isNotEmpty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.label('Top 5 letras', color: textSecondary),
                          const SizedBox(height: 12),
                          _barChart(_controller.letterFrequency, textSecondary),
                        ],
                      ),
                    ),
                  if (_controller.letterFrequency.isNotEmpty && _controller.digitFrequency.isNotEmpty)
                    const SizedBox(width: 16),
                  if (_controller.digitFrequency.isNotEmpty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.label('Top 5 números', color: textSecondary),
                          const SizedBox(height: 12),
                          _barChart(_controller.digitFrequency, textSecondary),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ],
        );
      }),
    );
  }

  Widget _summaryRow(Color surface, Color textPrimary, Color textSecondary, Color border) {
    return Row(
      children: [
        _statCard('Notas', '${_controller.totalNotes}', Icons.note_outlined, surface, textPrimary, textSecondary, border),
        const SizedBox(width: 10),
        _statCard('Linhas', '${_controller.totalLines}', Icons.format_list_bulleted, surface, textPrimary, textSecondary, border),
        const SizedBox(width: 10),
        _statCard('Caracteres', '${_controller.totalChars}', Icons.text_fields, surface, textPrimary, textSecondary, border),
        const SizedBox(width: 10),
        _statCard('Edições', '${_controller.totalEdits}', Icons.edit_outlined, surface, textPrimary, textSecondary, border),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color surface, Color textPrimary, Color textSecondary, Color border) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(height: 6),
            AppText.headline(value, color: textPrimary),
            const SizedBox(height: 2),
            AppText.bodySmall(label, color: textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _pieChart(Color textPrimary, Color textSecondary, Color surface, Color border) {
    final total = _controller.totalLetters + _controller.totalDigits;
    final letterPct = (_controller.totalLetters / total * 100).round();
    final digitPct = 100 - letterPct;
    final digitColor = AppColors.primary.withValues(alpha: 0.4);

    return Row(
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  value: _controller.totalLetters.toDouble(),
                  color: AppColors.primary,
                  title: '$letterPct%',
                  titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  radius: 40,
                ),
                PieChartSectionData(
                  value: _controller.totalDigits.toDouble(),
                  color: digitColor,
                  title: '$digitPct%',
                  titleStyle: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                  radius: 40,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _legend(AppColors.primary, 'Letras', '${_controller.totalLetters}', textSecondary, textPrimary),
            const SizedBox(height: 12),
            _legend(digitColor, 'Números', '${_controller.totalDigits}', textSecondary, textPrimary),
          ],
        ),
      ],
    );
  }

  Widget _legend(Color color, String label, String value, Color textSecondary, Color textPrimary) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.bodySmall(label, color: textSecondary),
            AppText.body(value, color: textPrimary),
          ],
        ),
      ],
    );
  }

  Widget _barChart(Map<String, int> data, Color textSecondary) {
    final entries = data.entries.toList();
    final maxVal = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble();

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          maxY: maxVal * 1.2,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < 0 || index >= entries.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AppText.bodySmall(entries[index].key, color: textSecondary),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(
                rod.toY.toInt().toString(),
                const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          barGroups: List.generate(entries.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: entries[i].value.toDouble(),
                  color: AppColors.primary,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
