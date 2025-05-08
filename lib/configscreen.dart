import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  double _distanceRadius = 500;
  String _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Seção de notificações
          _buildSectionHeader('Notificações', Icons.notifications_outlined),
          SwitchListTile(
            title: Text('Alertas de chegada'),
            subtitle: Text(
              'Receba notificações quando seu ônibus estiver próximo',
            ),
            value: _notificationsEnabled,
            activeColor: Color(0xFF0D47A1),
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),

          Divider(),

          // Seção de localização
          _buildSectionHeader('Localização', Icons.location_on_outlined),
          SwitchListTile(
            title: Text('Permissão de localização'),
            subtitle: Text(
              'Permitir acesso à sua localização em segundo plano',
            ),
            value: _locationEnabled,
            activeColor: Color(0xFF0D47A1),
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Raio de busca',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Distância para buscar pontos de ônibus próximos (${_distanceRadius.toInt()}m)',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                Slider(
                  value: _distanceRadius,
                  min: 100,
                  max: 1000,
                  divisions: 9,
                  activeColor: Color(0xFF2196F3),
                  inactiveColor: Colors.grey.shade300,
                  label: '${_distanceRadius.toInt()}m',
                  onChanged: (value) {
                    setState(() {
                      _distanceRadius = value;
                    });
                  },
                ),
              ],
            ),
          ),

          Divider(),

          // Seção de aparência
          _buildSectionHeader('Aparência', Icons.palette_outlined),
          SwitchListTile(
            title: Text('Modo escuro'),
            subtitle: Text('Mudar para tema escuro'),
            value: _darkModeEnabled,
            activeColor: Color(0xFF0D47A1),
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),

          ListTile(
            title: Text('Idioma'),
            subtitle: Text(_selectedLanguage),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showLanguageDialog,
          ),

          Divider(),

          // Seção de conta
          _buildSectionHeader('Conta', Icons.person_outline),
          ListTile(
            title: Text('Meus dados'),
            leading: Icon(Icons.account_circle, color: Color(0xFF2196F3)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          ListTile(
            title: Text('Histórico de viagens'),
            leading: Icon(Icons.history, color: Color(0xFF2196F3)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          Divider(),

          // Seção de sobre
          _buildSectionHeader('Sobre', Icons.info_outline),
          ListTile(
            title: Text('Versão do aplicativo'),
            subtitle: Text('1.0.0'),
            onTap: () {},
          ),

          ListTile(
            title: Text('Termos de uso'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          ListTile(
            title: Text('Política de privacidade'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                // Lógica para sair
              },
              child: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              '© 2025 Manaus Bus - Todos os direitos reservados',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF0D47A1)),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0D47A1),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selecione o idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('Português'),
              _buildLanguageOption('English'),
              _buildLanguageOption('Español'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      leading: Radio<String>(
        value: language,
        groupValue: _selectedLanguage,
        activeColor: Color(0xFF0D47A1),
        onChanged: (value) {
          setState(() {
            _selectedLanguage = value!;
            Navigator.pop(context);
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedLanguage = language;
          Navigator.pop(context);
        });
      },
    );
  }
}
