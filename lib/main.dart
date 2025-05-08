import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Importe as novas telas
import 'rotascreen.dart';
import 'alertascreen.dart';
import 'feedbackscreen.dart';
import 'configscreen.dart';

void main() {
  runApp(ManausBusApp());
}

class ManausBusApp extends StatelessWidget {
  const ManausBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manaus Bus',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0D47A1), // Azul escuro
          onPrimary: Colors.white,
          secondary: Color(0xFF2196F3), // Azul médio
          onSecondary: Colors.white,
          tertiary: Color(0xFF03A9F4), // Azul claro
          onTertiary: Colors.white,
          error: Colors.red.shade700,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF0D47A1),
          unselectedItemColor: Colors.grey.shade600,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF0D47A1)),
          ),
        ),
      ),
      home: MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  MainNavigatorState createState() => MainNavigatorState();
}

class MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    RotasScreen(),
    AlertasScreen(),
    FeedbackScreen(),
    ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Rotas'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Alertas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config.'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  bool _showBusList = true;

  // Posição inicial do mapa (centro de Manaus)
  static const LatLng _manausCenter = LatLng(-3.10719, -60.0261);

  // Lista de marcadores para os ônibus
  final List<Marker> _busMarkers = [
    Marker(
      point: LatLng(-3.1037, -60.0212),
      width: 45,
      height: 45,
      child: _BusMarker(label: '120', onTap: () {}),
    ),
    Marker(
      point: LatLng(-3.0901, -60.0325),
      width: 45,
      height: 45,
      child: _BusMarker(label: '320', onTap: () {}),
    ),
    Marker(
      point: LatLng(-3.1202, -60.0161),
      width: 40,
      height: 40,
      child: _BusMarker(label: '401', onTap: () {}),
    ),
    Marker(
      point: LatLng(-3.0955, -60.0384),
      width: 40,
      height: 40,
      child: _BusMarker(label: '702', onTap: () {}),
    ),
  ];

  // Lista de ônibus para exibição na lista
  final List<BusInfo> busList = [
    BusInfo(
      number: '120',
      route: 'T1 → Centro',
      time: 'Chegada em 5 min',
      position: LatLng(-3.1037, -60.0212),
    ),
    BusInfo(
      number: '320',
      route: 'Vieiralves → Ponta Negra',
      time: 'Chegada em 8 min',
      position: LatLng(-3.0901, -60.0325),
    ),
    BusInfo(
      number: '401',
      route: 'Terminal 3 → Shopping Manaus',
      time: 'Chegada em 3 min',
      position: LatLng(-3.1202, -60.0161),
    ),
    BusInfo(
      number: '702',
      route: 'Djalma Batista → Terminal 1',
      time: 'Chegada em 12 min',
      position: LatLng(-3.0955, -60.0384),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapa como fundo (usando FlutterMap em vez de GoogleMap)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _manausCenter,
              initialZoom: 12.0,
              onTap: (tapPosition, point) {
                // Código para lidar com toques no mapa
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.manausbus.app',
                // Atribuição obrigatória para OpenStreetMap
                tileBuilder: (context, child, tile) {
                  return Opacity(
                    opacity: 0.8, // Mantém o mapa um pouco mais leve
                    child: child,
                  );
                },
              ),
              // Camada de marcadores
              MarkerLayer(markers: _busMarkers),
              // Atribuição (obrigatória para OSM)
            ],
          ),

          // Painel deslizante com lista de ônibus
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Indicador de arrastar
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    // Campo de busca
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Para onde você vai?',
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    // Título da seção
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ônibus Próximos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon: Icon(_showBusList ? Icons.map : Icons.list),
                            onPressed: () {
                              setState(() {
                                _showBusList = !_showBusList;
                              });
                            },
                            tooltip:
                                _showBusList
                                    ? 'Mostrar no mapa'
                                    : 'Mostrar lista',
                          ),
                        ],
                      ),
                    ),

                    // Lista de ônibus
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: busList.length,
                        itemBuilder: (context, index) {
                          final bus = busList[index];
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D47A1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.directions_bus,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    Text(
                                      bus.number,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(bus.route),
                              subtitle: Text(bus.time),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.directions,
                                  color: Color(0xFF2196F3),
                                ),
                                onPressed: () {
                                  // Centralizar o mapa na posição do ônibus
                                  _mapController.move(bus.position, 15);
                                },
                                tooltip: 'Ver no mapa',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Botões de controle do mapa
          Positioned(
            right: 16,
            bottom: 300,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  mini: true,
                  backgroundColor: Colors.white.withOpacity(0.7),
                  foregroundColor: Color(0xFF0D47A1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    double currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom + 1,
                    );
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'btn2',
                  mini: true,
                  backgroundColor: Colors.white.withOpacity(0.7),
                  foregroundColor: Color(0xFF0D47A1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    double currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center,
                      currentZoom - 1,
                    );
                  },
                  child: Icon(Icons.remove),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'btn3',
                  mini: true,
                  backgroundColor: Colors.white.withOpacity(0.7),
                  foregroundColor: Color(0xFF0D47A1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    _mapController.move(_manausCenter, 12);
                  },
                  child: Icon(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget personalizado para marcador de ônibus
class _BusMarker extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _BusMarker({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0D47A1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_bus, color: Colors.white, size: 14),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusInfo {
  final String number;
  final String route;
  final String time;
  final LatLng position; // Adicione a posição

  BusInfo({
    required this.number,
    required this.route,
    required this.time,
    required this.position, // Adicione a posição como parâmetro
  });
}
