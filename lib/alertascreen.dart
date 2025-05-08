// AlertasScreen.dart
import 'package:flutter/material.dart';

class AlertasScreen extends StatelessWidget {
  final List<BusAlert> alertsList = [
    BusAlert(
      title: 'Desvio na Av. Constantino Nery',
      description:
          'Devido a obras na via, os ônibus seguirão rota alternativa até o dia 15/05.',
      severity: AlertSeverity.high,
      timeAgo: '10 min atrás',
      affectedRoutes: ['120', '320', '450'],
    ),
    BusAlert(
      title: 'Atraso Terminal 3',
      description:
          'Ônibus com saída do Terminal 3 estão com atraso médio de 15 minutos devido ao tráfego intenso.',
      severity: AlertSeverity.medium,
      timeAgo: '30 min atrás',
      affectedRoutes: ['401', '702'],
    ),
    BusAlert(
      title: 'Novo ponto na Djalma Batista',
      description:
          'Novo ponto de ônibus instalado próximo ao Shopping Manauara.',
      severity: AlertSeverity.low,
      timeAgo: '2 horas atrás',
      affectedRoutes: ['702'],
    ),
    BusAlert(
      title: 'Interrupção temporária',
      description:
          'A linha 210 não funcionará neste final de semana devido à manutenção programada.',
      severity: AlertSeverity.high,
      timeAgo: '5 horas atrás',
      affectedRoutes: ['210'],
    ),
  ];

  AlertasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alertas de Tráfego'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.filter_list), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alertas Recentes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Informações importantes sobre o serviço de ônibus',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: alertsList.length,
                itemBuilder: (context, index) {
                  final alert = alertsList[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _getSeverityColor(
                          alert.severity,
                        ).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getSeverityIcon(alert.severity),
                                color: _getSeverityColor(alert.severity),
                              ),
                              SizedBox(width: 8),
                              Text(
                                _getSeverityText(alert.severity),
                                style: TextStyle(
                                  color: _getSeverityColor(alert.severity),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                alert.timeAgo,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            alert.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            alert.description,
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 12),
                          if (alert.affectedRoutes.isNotEmpty) ...[
                            Text(
                              'Linhas afetadas:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 6),
                            Wrap(
                              spacing: 8,
                              children:
                                  alert.affectedRoutes.map((route) {
                                    return Chip(
                                      label: Text(route),
                                      backgroundColor: Color(
                                        0xFF03A9F4,
                                      ).withOpacity(0.2),
                                      labelStyle: TextStyle(
                                        color: Color(0xFF0D47A1),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    );
                                  }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.low:
        return Colors.green;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.high:
        return Colors.red;
    }
  }

  IconData _getSeverityIcon(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.low:
        return Icons.info_outline;
      case AlertSeverity.medium:
        return Icons.warning_amber_outlined;
      case AlertSeverity.high:
        return Icons.error_outline;
    }
  }

  String _getSeverityText(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.low:
        return 'Informação';
      case AlertSeverity.medium:
        return 'Atenção';
      case AlertSeverity.high:
        return 'Alerta importante';
    }
  }
}

enum AlertSeverity { low, medium, high }

class BusAlert {
  final String title;
  final String description;
  final AlertSeverity severity;
  final String timeAgo;
  final List<String> affectedRoutes;

  BusAlert({
    required this.title,
    required this.description,
    required this.severity,
    required this.timeAgo,
    required this.affectedRoutes,
  });
}
