import 'package:flutter/material.dart';
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
  final List<Map<String, dynamic>> jogos = [
    {
      'id': 'termo', 
      'nome': 'Termo', 
      'url': 'https://term.ooo/',
      'fuso_utc': -3 
    },
    {
      'id': 'contexto', 
      'nome': 'Contexto', 
      'url': 'https://contexto.me/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11impostor', 
      'nome': 'Futbol 11 Impostor', 
      'url': 'https://futbol-11.com/futbol11-impostor/',
      'fuso_utc': -3 
    },
    {
      'id': 'futbol11retro', 
      'nome': 'Futbol 11 Retro', 
      'url': 'https://futbol-11.com/futbol11-retro/',
      'fuso_utc': -3 
    },
    {
      'id': 'letreco', 
      'nome': 'Letreco', 
      'url': 'https://www.gabtoschi.com/letreco/',
      'fuso_utc': -3
    },
    {
      'id': 'worldle', 
      'nome': 'Worldle', 
      'url': 'https://worldle.teuteuf.fr/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11goltexto', 
      'nome': 'Futbol 11 Goltexto', 
      'url': 'https://futbol-11.com/futbol11-goltexto/',
      'fuso_utc': -3
    },
    {
      'id': 'football_bingo_daily',
      'nome': 'PF Football Bingo (Daily)',
      'url': 'https://playfootball.games/football-bingo/daily/',
      'fuso_utc': -3
    },
    {
      'id': 'missing_11_global',
      'nome': 'PF Missing 11 (Global)',
      'url': 'https://playfootball.games/missing-11/global/',
      'fuso_utc': -3
    },
    {
      'id': 'goalless',
      'nome': 'PF Goalless',
      'url': 'https://playfootball.games/goalless/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol_list_a',
      'nome': 'PF Futbol List A',
      'url': 'https://playfootball.games/futbol-list-a/',
      'fuso_utc': -3
    },
    {
      'id': 'who_are_ya_big4',
      'nome': 'PF Who Are Ya (Big 4)',
      'url': 'https://playfootball.games/who-are-ya/big-4/',
      'fuso_utc': -3
    },
    {
      'id': 'box2box_european_league',
      'nome': 'PF Box2Box - European League',
      'url': 'https://playfootball.games/box2box/european-league/',
      'fuso_utc': -3
    },
    {
      'id': 'career_path_challenge',
      'nome': 'PF Career Path Challenge',
      'url': 'https://playfootball.games/career-path-challenge/',
      'fuso_utc': -3
    },
    {
      'id': 'contextinho',
      'nome': 'PF Contextinho',
      'url': 'https://playfootball.games/contextinho/',
      'fuso_utc': -3
    },
    {
      'id': 'football_connections',
      'nome': 'PF Football Connections',
      'url': 'https://playfootball.games/football-connections/',
      'fuso_utc': -3
    },
    {
      'id': 'guess_the_football_club',
      'nome': 'PF Guess the Football Club',
      'url': 'https://playfootball.games/guess-the-football-club/',
      'fuso_utc': -3
    },
    {
      'id': 'football_wordle',
      'nome': 'PF Football Wordle',
      'url': 'https://playfootball.games/football-wordle/',
      'fuso_utc': -3
    },
    {
      'id': 'superdraft_soccer_remix',
      'nome': 'PF Superdraft Soccer (Remix)',
      'url': 'https://playfootball.games/superdraft-soccer/remix/',
      'fuso_utc': -3
    },
    {
      'id': 'pack11_top_stars',
      'nome': 'PF Pack 11 - Top Stars',
      'url': 'https://playfootball.games/pack-11/top-stars',
      'fuso_utc': -3
    },
    {
      'id': 'fan_favourites',
      'nome': 'PF Fan Favourites',
      'url': 'https://playfootball.games/fan-favourites/',
      'fuso_utc': -3
    },
    {
      'id': 'football_tenable',
      'nome': 'PF Football Tenable',
      'url': 'https://playfootball.games/football-tenable/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11goltexto', 
      'nome': 'Futbol 11 Goltexto', 
      'url': 'https://futbol-11.com/futbol11-goltexto/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11legacy', 
      'nome': 'Futbol 11 Legacy', 
      'url': 'https://futbol-11.com/futbol11-legacy/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11grid', 
      'nome': 'Futbol 11 Grid', 
      'url': 'https://futbol-11.com/futbol-grid/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11pyramid', 
      'nome': 'Futbol 11 Pyramid', 
      'url': 'https://futbol-11.com/futbol11-pyramid/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11connections', 
      'nome': 'Futbol 11 Connections', 
      'url': 'https://futbol-11.com/futbol11-connections/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11clubs', 
      'nome': 'Futbol 11 Clubs', 
      'url': 'https://futbol-11.com/futbol11-clubs/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11link', 
      'nome': 'Futbol 11 Link', 
      'url': 'https://futbol-11.com/futbol11-link/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11bingo', 
      'nome': 'Futbol 11 Bingo', 
      'url': 'https://futbol-11.com/futbol11-bingo/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11top10', 
      'nome': 'Futbol 11 Top 10', 
      'url': 'https://futbol-11.com/futbol-top10/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11wordle', 
      'nome': 'Futbol 11 Wordle', 
      'url': 'https://futbol-11.com/futbol11-wordle/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11bingolegends', 
      'nome': 'Futbol 11 Bingo Legends', 
      'url': 'https://futbol-11.com/futbol11-bingo-legends/',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11', 
      'nome': 'Futbol 11', 
      'url': 'https://futbol-11.com/futbol11/',
      'fuso_utc': -3
    },
    {
      'id': 'guess-the-footballer',
      'nome': 'Futbol 11 Guess the Footballer',
      'url': 'https://futbol-11.com/guess-the-footballer',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11legends',
      'nome': 'Futbol 11 Legends',
      'url': 'https://futbol-11.com/futbol11-legends',
      'fuso_utc': -3
    },
    {
      'id': 'futbol11america',
      'nome': 'Futbol 11 América',
      'url': 'https://futbol-11.com/futbol11-america',
      'fuso_utc': -3
    },
    {
      'id': 'where_taken',
      'nome': 'Where Taken',
      'url': 'https://wheretaken.com/',
      'fuso_utc': -3
    },
    {
      'id': 'geo_grid_game',
      'nome': 'Geo Grid',
      'url': 'https://www.geogridgame.com/',
      'fuso_utc': -3
    },
    {
      'id': 'travle',
      'nome': 'Travle',
      'url': 'https://travle.earth/',
      'fuso_utc': -3
    },
    {
      'id': 'flagle',
      'nome': 'Flagle',
      'url': 'https://www.flagle.io/',
      'fuso_utc': -3
    },
    {
      'id': 'mapster',
      'nome': 'Mapster',
      'url': 'https://mapster.teuteuf.fr/',
      'fuso_utc': -3
    },
    {
      'id': 'geo_connections',
      'nome': 'Geo Connections',
      'url': 'https://geoconnections.net/',
      'fuso_utc': -3
    },
    {
      'id': 'where_taken_teuteuf',
      'nome': 'Where Taken (TF)',
      'url': 'https://wheretaken.teuteuf.fr/',
      'fuso_utc': -3
    },
    {
      'id': 'when_taken',
      'nome': 'When Taken',
      'url': 'https://whentaken.com/',
      'fuso_utc': -3
    },
    {
      'id': 'globle',
      'nome': 'Globle',
      'url': 'https://globle-game.com/game',
      'fuso_utc': -3
    },
    {
      'id': 'globle_capitals',
      'nome': 'Globle Capitals',
      'url': 'https://globle-capitals.com/game',
      'fuso_utc': -3
    },
    {
      'id': 'time_guessr',
      'nome': 'Time Guessr',
      'url': 'https://timeguessr.com/',
      'fuso_utc': -3
    },
    {
      'id': 'gamedle',
      'nome': 'Gamedle',
      'url': 'https://www.gamedle.wtf/',
      'fuso_utc': -3
    },
    {
      'id': 'album_blur',
      'nome': 'Album Blur',
      'url': 'https://rockheardle.com/games/album-blur',
      'fuso_utc': -3
    },
    {
      'id': 'harmonies',
      'nome': 'Harmonies',
      'url': 'https://harmonies.io/',
      'fuso_utc': -3
    },
    {
      'id': 'dialed',
      'nome': 'Dialed',
      'url': 'https://dialed.gg/',
      'fuso_utc': -3
    },
    {
      'id': 'pokedle',
      'nome': 'Pokedle',
      'url': 'https://pokedle.net/',
      'fuso_utc': -6
    },
    {
      'id': 'faces',
      'nome': 'Faces',
      'url': 'https://faces.wtf/',
      'fuso_utc': -3
    },
    {
      'id': 'metazooa',
      'nome': 'Metazooa',
      'url': 'https://metazooa.com/',
      'fuso_utc': -3
    },
    {
      'id': 'songless',
      'nome': 'Songless',
      'url': 'https://lessgames.com/songless',
      'fuso_utc': -3
    },
    {
      'id': 'food_guessr',
      'nome': 'Food Guessr',
      'url': 'https://www.foodguessr.com/',
      'fuso_utc': -3
    },
    {
      'id': 'bandle',
      'nome': 'Bandle',
      'url': 'https://bandle.app/menu',
      'fuso_utc': -3
    },
    {
      'id': 'musicle',
      'nome': 'Musicle',
      'url': 'https://musicle.app/',
      'fuso_utc': -3
    },
    {
      'id': 'brandle',
      'nome': 'Brandle',
      'url': 'https://capitalle.app/brandle',
      'fuso_utc': -3
    },
    {
      'id': 'spotle',
      'nome': 'Spotle',
      'url': 'https://spotle.io/',
      'fuso_utc': -3
    },
    {
      'id': 'framed',
      'nome': 'Framed',
      'url': 'https://framed.wtf/',
      'fuso_utc': -3
    },
    {
      'id': 'conexo',
      'nome': 'Conexo',
      'url': 'https://conexo.ws/pt/',
      'fuso_utc': -3
    },
    {
      'id': 'angle',
      'nome': 'Angle',
      'url': 'https://angle.wtf/',
      'fuso_utc': -3
    },
    {
      'id': 'cutle',
      'nome': 'Cutle',
      'url': 'https://pfiffel.com/cutle/',
      'fuso_utc': -3
    },
    {
      'id': 'nerdle',
      'nome': 'Nerdle',
      'url': 'https://nerdlegame.com/',
      'fuso_utc': -3
    },
    {
      'id': 'dodeku',
      'nome': 'Dodeku',
      'url': 'https://dodeku.com/',
      'fuso_utc': -3
    },
    {
      'id': 'thursday30', 
      'nome': 'Thursday 30', 
      'url': 'https://t30.teuteuf.fr/', // Coloque o link correto aqui
      'fuso_utc': -3, 
      'dia_reset': DateTime.thursday // Define que o ciclo dura de quinta a quarta!
    }
  ];

  Map<String, bool> statusJogos = {};

  @override
  void initState() {
    super.initState();
    _carregarStatus();
  }

  Future<void> _carregarStatus() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, bool> statusAtualizado = {};
    for (var jogo in jogos) {
      String dataDoJogo = _obterDataDoJogo(jogo['fuso_utc'], diaResetSemanal: jogo['dia_reset']);
      String chave = 'status_${jogo['id']}_$dataDoJogo';
      statusAtualizado[jogo['id']!] = prefs.getBool(chave) ?? false;
    }

    setState(() {
      statusJogos = statusAtualizado;
      jogos.sort((jogoA, jogoB) {
        bool jogadoA = statusAtualizado[jogoA['id']] ?? false;
        bool jogadoB = statusAtualizado[jogoB['id']] ?? false;

        if (jogadoA && !jogadoB) {
          return 1;  // jogoA está concluído, empurra para o fim
        } else if (!jogadoA && jogadoB) {
          return -1; // jogoA não está concluído, puxa para o início
        }
        
        // Se ambos estiverem com o mesmo status, mantém a ordem atual
        String nomeA = jogoA['nome']?.toString().toLowerCase() ?? '';
        String nomeB = jogoB['nome']?.toString().toLowerCase() ?? '';
        
        return nomeA.compareTo(nomeB);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Jogos Diários'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: jogos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final jogo = jogos[index];
          final bool jaJogou = statusJogos[jogo['id']] ?? false;
          final String faviconUrl = 'https://www.google.com/s2/favicons?sz=64&domain=${Uri.parse(jogo['url']!).origin}';

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(6),
              border: jaJogou ? Border.all(color: Colors.green, width: 2) : null,
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              leading: SizedBox(
                width: 36,
                height: 36,
                child: ClipOval(
                  child: Image.network(
                    faviconUrl,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Icon(
                        jaJogou ? Icons.check_circle : Icons.gamepad,
                        color: jaJogou ? Colors.green : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                jogo['nome']!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white70, size: 20),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaJogo(
                      idJogo: jogo['id']!,
                      nome: jogo['nome']!,
                      url: jogo['url']!,
                      fusoUtc: jogo['fuso_utc']!,
                      diaReset: jogo['dia_reset'],
                    ),
                  ),
                );
                _carregarStatus();
              },
            ),
          );
        },
      ),
    );
  }
}

class TelaJogo extends StatefulWidget {
  final String idJogo;
  final String nome;
  final String url;
  final int fusoUtc;
  final int? diaReset;

  const TelaJogo({
    super.key,
    required this.idJogo,
    required this.nome,
    required this.url,
    required this.fusoUtc,
    this.diaReset,
  });

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  bool _foiJogado = false;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _verificarStatusInicial();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF121212))
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _verificarStatusInicial() async {
    final prefs = await SharedPreferences.getInstance();
    String dataDoJogo = _obterDataDoJogo(widget.fusoUtc);
    String chave = 'status_${widget.idJogo}_$dataDoJogo';
    
    setState(() {
      _foiJogado = prefs.getBool(chave) ?? false;
    });
  }

  Future<void> _alternarStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String dataDoJogo = _obterDataDoJogo(widget.fusoUtc);
    String chave = 'status_${widget.idJogo}_$dataDoJogo';

    setState(() {
      // O símbolo "!" inverte o valor (se era true vira false, e vice-versa)
      _foiJogado = !_foiJogado; 
    });

    await prefs.setBool(chave, _foiJogado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nome),
        actions: [
          IconButton(
            icon: Icon(
              _foiJogado ? Icons.check_circle : Icons.videogame_asset,
              color: _foiJogado ? Colors.green : Colors.white,),
            onPressed: _alternarStatus,
          ),
        ],
      ),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

String _obterDataDoJogo(int fusoUtcDoJogo, {int? diaResetSemanal}) {
  DateTime agoraUtc = DateTime.now().toUtc();
  DateTime horaNoServidor = agoraUtc.add(Duration(hours: fusoUtcDoJogo));

  // Se o jogo tiver um dia de reset semanal configurado
  if (diaResetSemanal != null) {
    // Calcula quantos dias se passaram desde o último dia de reset
    int diasParaSubtrair = (horaNoServidor.weekday - diaResetSemanal + 7) % 7;
    
    // Puxa a data retroativa exata daquele dia
    DateTime ultimaDataReset = horaNoServidor.subtract(Duration(days: diasParaSubtrair));
    return ultimaDataReset.toIso8601String().split('T')[0];
  }
  
  // Retorna apenas a data (ex: 2026-05-30) do ponto de vista do jogo
  return horaNoServidor.toIso8601String().split('T')[0];
}