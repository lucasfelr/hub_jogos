import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const HubJogosApp());
}

class HubJogosApp extends StatelessWidget {
  const HubJogosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hub de Jogos',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const TelaCatalogo(),
    );
  }
}

class TelaCatalogo extends StatefulWidget {
  const TelaCatalogo({super.key});

  @override
  State<TelaCatalogo> createState() => _TelaCatalogoState();
}

class _TelaCatalogoState extends State<TelaCatalogo> {
  List<Map<String, dynamic>> _jogos = [];
  Map<String, bool> statusJogos = {};
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _inicializarApp();
  }

  Future<void> _inicializarApp() async {
    await _carregarJogos();
    await _carregarStatus();
    setState(() => _carregando = false);
  }

  Future<void> _carregarJogos() async {
    final prefs = await SharedPreferences.getInstance();
    String? jogosSalvos = prefs.getString('lista_jogos');

    if (jogosSalvos != null) {
      List<dynamic> decodificado = jsonDecode(jogosSalvos);
      _jogos = decodificado.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      try {
        String cacheInicial = await rootBundle.loadString('assets/jogos_iniciais.json');
        List<dynamic> decodificado = jsonDecode(cacheInicial);
        _jogos = decodificado.map((e) => Map<String, dynamic>.from(e)).toList();
        await _salvarJogos();
      } catch (e) {
        _jogos = [];
      }
    }
  }

  Future<void> _salvarJogos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lista_jogos', jsonEncode(_jogos));
  }

  Future<void> _carregarStatus() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, bool> statusAtualizado = {};
    for (var jogo in _jogos) {
      String dataDoJogo = _obterDataDoJogo(jogo['fuso_utc']!, diaResetSemanal: jogo['dia_reset']);
      statusAtualizado[jogo['id']!] = prefs.getBool('status_${jogo['id']}_$dataDoJogo') ?? false;
    }
    setState(() {
      statusJogos = statusAtualizado;
      _jogos.sort((a, b) {
        bool jaA = statusAtualizado[a['id']] ?? false;
        bool jaB = statusAtualizado[b['id']] ?? false;
        if (jaA != jaB) return jaA ? 1 : -1;
        return a['nome'].toString().toLowerCase().compareTo(b['nome'].toString().toLowerCase());
      });
    });
  }

  Future<void> _adicionarJogo(String nome, String url, int fuso, int? diaReset) async {
    _jogos.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'nome': nome,
      'url': url,
      'fuso_utc': fuso,
      if (diaReset != null) 'dia_reset': diaReset
    });
    await _salvarJogos();
    await _carregarStatus();
  }

  Future<void> _editarJogo(String id, String nome, String url, int fuso, int? diaReset) async {
    int index = _jogos.indexWhere((j) => j['id'] == id);
    if (index != -1) {
      _jogos[index] = {'id': id, 'nome': nome, 'url': url, 'fuso_utc': fuso, if (diaReset != null) 'dia_reset': diaReset};
      await _salvarJogos();
      await _carregarStatus();
    }
  }

  Future<void> _excluirJogo(String id) async {
    _jogos.removeWhere((j) => j['id'] == id);
    await _salvarJogos();
    await _carregarStatus();
  }

  void _exibirConfirmacaoExclusao(String id, String nome) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir "$nome"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _excluirJogo(id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
          )
        ],
      ),
    );
  }

  bool _validarUrl(String url) {
    try {
      Uri.parse(url);
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  void _exibirDialogoEdicao({Map<String, dynamic>? jogo}) {
    final nomeController = TextEditingController(text: jogo?['nome'] ?? '');
    final urlController = TextEditingController(text: jogo?['url'] ?? '');
    final fusoController = TextEditingController(text: jogo?['fuso_utc']?.toString() ?? '-3');
    String? erroUrl;
    int? diaReset = jogo?['dia_reset'];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(jogo == null ? 'Adicionar Jogo' : 'Editar Jogo'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  errorText: erroUrl,
                ),
              ),
              TextField(controller: fusoController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Fuso UTC')),
              const SizedBox(height: 10),
              DropdownButtonFormField<int?>(
                value: diaReset,
                decoration: const InputDecoration(labelText: 'Frequência de Reset'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Diário (Padrão)')),
                  DropdownMenuItem(value: 1, child: Text('Semanal - Segunda')),
                  DropdownMenuItem(value: 2, child: Text('Semanal - Terça')),
                  DropdownMenuItem(value: 3, child: Text('Semanal - Quarta')),
                  DropdownMenuItem(value: 4, child: Text('Semanal - Quinta')),
                  DropdownMenuItem(value: 5, child: Text('Semanal - Sexta')),
                  DropdownMenuItem(value: 6, child: Text('Semanal - Sábado')),
                  DropdownMenuItem(value: 7, child: Text('Semanal - Domingo')),
                ],
                onChanged: (val) => setDialogState(() => diaReset = val),
              ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isEmpty) {
                  setDialogState(() => erroUrl = 'Nome obrigatório');
                  return;
                }
                if (!_validarUrl(urlController.text)) {
                  setDialogState(() => erroUrl = 'URL inválida (use http:// ou https://)');
                  return;
                }
                if (jogo == null) {
                  _adicionarJogo(nomeController.text, urlController.text, int.tryParse(fusoController.text) ?? -3, diaReset);
                } else {
                  _editarJogo(jogo['id'], nomeController.text, urlController.text, int.tryParse(fusoController.text) ?? -3, diaReset);
                }
                Navigator.pop(ctx);
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Jogos'), actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => _exibirDialogoEdicao())]),
      body: ListView.builder(
        itemCount: _jogos.length,
        itemBuilder: (context, i) {
          final j = _jogos[i];
          final jaJogou = statusJogos[j['id']] ?? false;
          String faviconUrl = '';
          try {
            faviconUrl = 'https://www.google.com/s2/favicons?sz=64&domain=${Uri.parse(j['url']).origin}';
          } catch (_) {
            faviconUrl = '';
          }

                    return ListTile(
            leading: SizedBox(
              width: 36,
              height: 36,
              child: jaJogou
                  ? const Icon(Icons.check_circle, color: Colors.green, size: 36)
                  : ClipOval(
                      child: Image.network(
                        faviconUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Icon(Icons.gamepad, color: Colors.grey),
                      ),
                    ),
            ),
            title: Text(
              j['nome'],
              style: TextStyle(
                decoration: jaJogou ? TextDecoration.lineThrough : null,
                color: jaJogou ? Colors.grey : Colors.white,
              ),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: const Icon(Icons.edit, size: 20), onPressed: () => _exibirDialogoEdicao(jogo: j)),
              IconButton(icon: const Icon(Icons.delete, size: 20, color: Colors.red), onPressed: () => _exibirConfirmacaoExclusao(j['id'], j['nome'])),
            ]),
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => TelaJogo(jogo: j)));
              _carregarStatus();
            },
          );
        },
      ),
    );
  }
}

class TelaJogo extends StatefulWidget {
  final Map<String, dynamic> jogo;
  const TelaJogo({super.key, required this.jogo});
  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  bool _foiJogado = false;
  late final WebViewController _controller;
  String? _erroUrl;

  @override
  void initState() {
    super.initState();
    _check();
    try {
      Uri.parse(widget.jogo['url']);
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.jogo['url']));
    } catch (e) {
      _erroUrl = 'URL inválida: ${widget.jogo['url']}';
      _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    }
  }

  Future<void> _check() async {
    final prefs = await SharedPreferences.getInstance();
    String d = _obterDataDoJogo(widget.jogo['fuso_utc'], diaResetSemanal: widget.jogo['dia_reset']);
    setState(() => _foiJogado = prefs.getBool('status_${widget.jogo['id']}_$d') ?? false);
  }

  Future<void> _toggle() async {
    final prefs = await SharedPreferences.getInstance();
    String d = _obterDataDoJogo(widget.jogo['fuso_utc'], diaResetSemanal: widget.jogo['dia_reset']);
    setState(() => _foiJogado = !_foiJogado);
    await prefs.setBool('status_${widget.jogo['id']}_$d', _foiJogado);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.jogo['nome']), actions: [IconButton(icon: Icon(_foiJogado ? Icons.check_circle : Icons.circle_outlined), onPressed: _toggle)]),
        body: _erroUrl != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 64),
                    const SizedBox(height: 16),
                    Text(_erroUrl!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )
            : WebViewWidget(controller: _controller),
      );
}

String _obterDataDoJogo(int fuso, {int? diaResetSemanal}) {
  DateTime now = DateTime.now().toUtc().add(Duration(hours: fuso));
  if (diaResetSemanal != null) {
    int sub = (now.weekday - diaResetSemanal + 7) % 7;
    now = now.subtract(Duration(days: sub));
  }
  return now.toIso8601String().split('T')[0];
}