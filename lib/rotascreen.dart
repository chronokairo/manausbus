// RotasScreen.dart
import 'package:flutter/material.dart';

class RotasScreen extends StatelessWidget {
  final List<BusRoute> popularRoutes = [
    BusRoute(number: '120', name: 'T1 → Centro', stops: 18, duration: '45 min'),
    BusRoute(
      number: '320',
      name: 'Vieiralves → Ponta Negra',
      stops: 22,
      duration: '55 min',
    ),
    BusRoute(
      number: '401',
      name: 'Terminal 3 → Shopping Manaus',
      stops: 15,
      duration: '40 min',
    ),
  ];

  RotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rotas de Ônibus'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pesquisa de rota
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar rota',
                prefixIcon: Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Opções de filtro
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text('Todas'),
                    selected: true,
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: Color(0xFF2196F3).withOpacity(0.2),
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('Terminais'),
                    selected: false,
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('Centro'),
                    selected: false,
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 8),
                  FilterChip(
                    label: Text('Zona Norte'),
                    selected: false,
                    onSelected: (bool selected) {},
                    backgroundColor: Colors.grey.shade200,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Rotas Populares',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(height: 10),

            // Lista de rotas
            Expanded(
              child: ListView.builder(
                itemCount: popularRoutes.length,
                itemBuilder: (context, index) {
                  final route = popularRoutes[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D47A1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  route.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  route.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${route.stops} paradas'),
                              Text('Duração: ${route.duration}'),
                              TextButton.icon(
                                icon: Icon(Icons.map, color: Color(0xFF2196F3)),
                                label: Text(
                                  'Ver mapa',
                                  style: TextStyle(color: Color(0xFF2196F3)),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
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
}

class BusRoute {
  final String number;
  final String name;
  final int stops;
  final String duration;

  BusRoute({
    required this.number,
    required this.name,
    required this.stops,
    required this.duration,
  });
}
