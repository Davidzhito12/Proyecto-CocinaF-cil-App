import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class AIChatScreen extends StatefulWidget {
  final Recipe recipe;

  const AIChatScreen({super.key, required this.recipe});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Mensaje inicial de bienvenida
    _messages.add(
      ChatMessage(
        text: '¡Hola! Soy tu asistente culinario. Estoy aquí para ayudarte con la receta de "${_cleanRecipeTitle(widget.recipe.title)}". Puedo ayudarte con:\n\n• Sustituciones de ingredientes\n• Consejos de cocina\n• Ajustes en las porciones\n• Explicaciones de técnicas\n• Y mucho más\n\n¿Cómo te puedo ayudar?',
        isAI: true,
      ),
    );
  }

  String _cleanRecipeTitle(String title) {
    if (title.length > 30) {
      return '${title.substring(0, 30)}...';
    }
    return title;
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: message, isAI: false));
      _messageController.clear();
    });

    // Simular respuesta de IA después de un pequeño delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: _generateAIResponse(message),
            isAI: true,
          ));
        });
      }
    });
  }

  String _generateAIResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('ingrediente') || lowerMessage.contains('sustituir')) {
      return 'Para sustituir un ingrediente, depende del tipo de receta. Por ejemplo:\n\n• Mantequilla → Aceite de oliva (3/4 de la cantidad)\n• Leche → Leche vegetal (proporción 1:1)\n• Huevo → Plátano machacado (1/4 de taza)\n\n¿Hay algún ingrediente específico que quieras sustituir en esta receta?';
    } else if (lowerMessage.contains('porciones') || lowerMessage.contains('cantidad')) {
      return 'Para ajustar las porciones, multiplica o divide todos los ingredientes por la misma proporción.\n\nPor ejemplo, si la receta es para 4 porciones y quieres 2:\n• Divide cada cantidad entre 2\n\nPuedo ayudarte a calcular las cantidades específicas si me indicas cuántas porciones necesitas.';
    } else if (lowerMessage.contains('tiempo') || lowerMessage.contains('cuánto')) {
      return 'El tiempo de cocción depende de varios factores como la temperatura, el tamaño de los ingredientes y tu equipo de cocina.\n\nPara esta receta, los tiempos recomendados son aproximados. Puedes verificar que esté lista checando:\n• La textura\n• El color\n• La ternura al pinchar\n\n¿Tienes alguna duda sobre el tiempo de cocción específico?';
    } else if (lowerMessage.contains('técnica') || lowerMessage.contains('cómo')) {
      return 'Claro, te explicaré gustosamente. Las técnicas culinarias son fundamentales para el éxito de una receta.\n\nAlgunas técnicas comunes:\n• Saltear: Cocinar rápidamente a fuego alto\n• Sofreír: Cocinar lentamente ingredientes aromáticos\n• Cocción a vapor: Preservar nutrientes\n• Gratinar: Dorar en el horno\n\n¿Cuál es la técnica específica que te gustaría que te explique?';
    } else if (lowerMessage.contains('consejo') || lowerMessage.contains('ayuda')) {
      return 'Aquí van algunos consejos generales para esta receta:\n\n✓ Lee la receta completa antes de empezar\n✓ Prepara todos los ingredientes (mise en place)\n✓ Usa ingredientes frescos de buena calidad\n✓ Sigue los tiempos indicados\n✓ No abras el horno innecesariamente\n\n¿Hay algún paso específico de la receta en el que necesites ayuda?';
    } else {
      return 'Entendido. Basándome en la receta de "${_cleanRecipeTitle(widget.recipe.title)}":\n\nPuedo ayudarte con adaptaciones, técnicas culinarias, sustituciones de ingredientes, cálculos de porciones y mucho más.\n\n¿Hay algo específico de la receta que te gustaría saber?';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9900),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back, color: Color(0xFFFF9900)),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chef IA',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              _cleanRecipeTitle(widget.recipe.title),
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu pregunta...',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF9900),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: message.isAI ? Colors.grey.shade200 : const Color(0xFFFF9900),
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isAI ? Colors.black87 : Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isAI;

  ChatMessage({required this.text, required this.isAI});
}
