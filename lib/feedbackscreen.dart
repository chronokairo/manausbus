// FeedbackScreen.dart
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _selectedRating = 0;
  final _formKey = GlobalKey<FormState>();

  final List<String> _feedbackTypes = [
    'Problema no aplicativo',
    'Sugestão de melhoria',
    'Problema em linha de ônibus',
    'Elogio',
    'Outro',
  ];

  String _selectedFeedbackType = 'Problema no aplicativo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Envie seu Feedback'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sua opinião é importante',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ajude-nos a melhorar o Manaus Bus com seu feedback',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
              SizedBox(height: 24),

              // Avaliação
              Text(
                'Como você avalia sua experiência?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    iconSize: 36,
                    icon: Icon(
                      _selectedRating > index ? Icons.star : Icons.star_border,
                      color:
                          _selectedRating > index
                              ? Color(0xFF2196F3)
                              : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 24),

              // Tipo de feedback
              Text(
                'Tipo de feedback',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedFeedbackType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedFeedbackType = value!;
                  });
                },
                items:
                    _feedbackTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
              ),
              SizedBox(height: 24),

              // Linha de ônibus (opcional)
              Text(
                'Linha de ônibus (opcional)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ex: 120, 320, etc.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 24),

              // Descrição
              Text(
                'Sua mensagem',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Descreva seu feedback em detalhes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escreva uma mensagem';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Anexar imagem
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.photo_camera),
                label: Text('Anexar imagem'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF2196F3),
                  side: BorderSide(color: Color(0xFF2196F3)),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              SizedBox(height: 32),

              // Botão enviar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Feedback enviado com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Enviar Feedback',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
