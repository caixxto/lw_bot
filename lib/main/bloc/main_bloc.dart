import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:lw/accounts/acc_manager.dart';
import 'package:lw/main/bloc/main_event.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/network.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AccountRepository _repository = AccountRepository.instance;
  final AccountDataRepository _repositoryData = AccountDataRepository.instance;
  final BlackMarketRepository _repositoryBlackMarket = BlackMarketRepository.instance;
  final List<String> ids = [];
  final List<String> skip = [];
  final List<double> accountData = [];
  final href = 'https://www.lowadi.com/media/equideo/image/produits/32/';
  List blackMarket = [
    {'name': 'Рог изобилия', 'html': 'corne-abondance'},
    {'name': 'Золотое Руно', 'html': 'toison-or'},
    {'name': 'Длани Морфея', 'html': 'bras-morphee'},
    {'name': 'Живая Вода', 'html': 'eau-jouvence'},
    {'name': 'Кусочек облака', 'html': 'fragment-nuage'},
    {'name': 'Очки роста', 'html': 'vieillissement'},
    {'name': 'Ящик Пандоры', 'html': 'boite-pandore'},
    {'name': 'Ласка Филотес', 'html': 'caresse-philotes'},
    {'name': 'Одеяло Гипноса', 'html': 'couverture-hypnos'},
    {'name': 'Часы Кайроса', 'html': 'kairos-watch'},
    {'name': 'Черная Орхидея', 'html': 'orchidee-noire'},
    {'name': 'Набор Никты', 'html': 'pack-nyx'},
    {'name': 'Папирус Плутос', 'html': 'parchemin-ploutos'},
    {'name': 'Философский Камень', 'html': 'pierre-philosophale'},
    {'name': 'Хронограф Хроноса', 'html': 'sablier-chronos'},
    {'name': 'Ахиллесова пята', 'html': 'talon-achille'},
    {'name': 'Посох Плодовитости', 'html': 'baton-fertilite'},
    {'name': 'Дар Гестии', 'html': 'don-hestia'},
    {'name': 'Молния Зевса', 'html': 'eclair-zeus'},
    {'name': 'Стрела Артемиды', 'html': 'fleche-artemis'},
    {'name': 'Слезы Афродиты', 'html': 'larmes-aphrodite'},
    {'name': 'Набор Геры', 'html': 'pack-hera'},
    {'name': '5-й элемент', 'html': '5th-element'},
    {'name': 'Стихия Воздуха', 'html': '5th-element-air'},
    {'name': 'Стихия Земли', 'html': '5th-element-earth'},
    {'name': 'Стихия Огня', 'html': '5th-element-fire'},
    {'name': 'Стихия Воды', 'html': '5th-element-water'},
    {'name': 'Стихия Металла', 'html': '5th-element-metal'},
    {'name': 'Особый 5-й элемент', 'html': '5th-element-plus'},
    {'name': 'Плетение кос-пуговичек', 'html': 'button-braided-mane'},
    {'name': 'Брошь Катрины', 'html': 'catrina-brooch'},
    {'name': 'Волшебная шляпа', 'html': 'chapeau-magique'},
    {'name': 'Двухсторонний медальон', 'html': 'double-face'},
    {'name': 'Одеяние Ириды', 'html': 'iris-coat'},
    {'name': 'Лира Апполона', 'html': 'lyre-apollon'},
    {'name': 'Набор гармонии', 'html': 'pack-harmonie'},
    {'name': 'Золотое яблоко', 'html': 'pomme-or'},
    {'name': 'Винтажное яблоко', 'html': 'pomme-vintage'},
    {'name': 'Безграничный Луч Гелиоса', 'html': 'rayon-helios-illimite'},
    {'name': 'Луч Гелиоса Ow', 'html': 'rayon-helios-ow'},
    {'name': 'Кровь Медузы', 'html': 'sang-meduse'},
    {'name': 'Печать тьмы', 'html': 'sceau-apocalypse'},
    {'name': 'Походный дневник', 'html': 'trail-riding-diary'},
    {'name': 'Парадное яблоко', 'html': 'parade-apple'},
    {'name': 'Оригинальный Дух путешествий', 'html': 'esprit-nomade-originaux'},
    {'name': 'Исторический Дух путешествий', 'html': 'esprit-nomade-histoire'},
    {'name': 'Бонус-набор', 'html': 'pack-bonus'},
    {'name': 'Набор Посейдона', 'html': 'pack-poseidon'},
    {'name': 'Пакет эльфов', 'html': 'pack-xmas-gear-2'},
    {'name': 'Богатство Креза', 'html': 'pactole-cresus'},
    {'name': 'Вальтрап рыцаря', 'html': 'tapis-knight'},
    {'name': 'Бинты дракона', 'html': 'bande-samurai-dragon'},
    {'name': 'Пламя дракона', 'html': 'compagnon-dragon'},
    {'name': 'Привидение', 'html': 'compagnon-fantome'},
    {'name': 'Акита-ину', 'html': 'compagnon-akita-inu'},
    {'name': 'Ара', 'html': 'compagnon-ara-ailes-vertes'},
    {'name': 'Пчела', 'html': 'compagnon-abeille'},
    {'name': 'Сова', 'html': 'compagnon-hibou'},
    {'name': 'Божья коровка', 'html': 'compagnon-coccinelle'},
    {'name': 'Косатка', 'html': 'compagnon-orque'},
    {'name': 'Снежная обезьяна', 'html': 'compagnon-singe-neige'},
    {'name': 'Яйцо монстра', 'html': 'monster-egg'},
    {'name': 'Ow', 'html': 'compagnon-ow'},
    {'name': 'Шика', 'html': 'compagnon-shika'},
    {'name': 'Намадзу', 'html': 'compagnon-namazu'},
    {'name': 'Jaguar', 'html': 'companion-jaguar'},
    {'name': 'Кат-ши', 'html': 'cat-sidhe'},
    {'name': 'Весы Фемиды', 'html': 'balance-themis'},
  ];

  MainBloc() : super(InitialState()) {
    _initState();

    on<DataChanged>((event, state) async {
      // _sendRequest();
    });

    on<AddNewAccount>(_addNewAccount);

    on<Lug>((event, state) async {
      for (var i = 0; i < _repository.getAccounts.length; i++) {
        final account = _repository.getAccounts;
        var exp = true;
        var numRetries = 0;

        do {
          if (exp) {
            print('Попытка входа ${account[i].login}');
            exp = await _loginRequest(account[i].login, account[i].password);
            numRetries++;
          } else {
            _updateScreen(false, 'Вход выполнен ${account[i].login}');
            print('Вход выполнен ${account[i].login}');
          }
        } while ((exp) && (numRetries < 5));

        if (exp == false) {
          await _collectSkinRequest();
          await _sellSkinRequest();
          await _setSkinRequest();
          await _logoutRequest();
        } else {
          skip.add(account[i].login);
        }
        print('Пропущенные аккаунты: $skip');
      }
    });

    on<ParseData>((event, state) async {
      for (var i = 0; i < _repository.getAccounts.length; i++) {
        final account = _repository.getAccounts;
        var exp = true;
        var numRetries = 0;

        do {
          if (exp) {
            print('Попытка входа ${account[i].login}');
            exp = await _loginRequest(account[i].login, account[i].password);
            numRetries++;
          } else {
            _updateScreen(false, 'Вход выполнен ${account[i].login}');
            print('Вход выполнен ${account[i].login}');
          }
        } while ((exp) && (numRetries < 5));

        if (exp == false) {
          await _getDataFromMarket(account[i]);
          //print('get data from ${account[i].login}');
          await _logoutRequest();
        } else {
          await _getDataFromMarket(account[i]);
          skip.add(account[i].login);
        }
      }
    });

    on<ChangeAccount>((event, state) async {
      emit(UpdateData(_repositoryData.getAccountsData[event.id], _repository.getAccounts, false));
    });

  }

  Future<void> _initState() async {
    _updateScreen(false, '');
  }

  Future<void> _getDataFromMarket(account) async {
    final session = Network.instance;
    var res = await session.getData();
    var document = parse(res);
    final htmlEquus = document.querySelector("#reserve")?.innerHtml ?? '0';
    final equus = int.parse(htmlEquus.replaceAll(' ', ''));
    final htmlPasses = document.querySelector("#pass")?.innerHtml ?? '0';
    final passes = int.parse(htmlPasses.replaceAll(' ', ''));
    final orHtml = document.querySelector(".inventory-item-vieillissement.width-50 > span > span > span.grid-cell.align-top > div > span");
    final or = int.parse(orHtml?.text.replaceAll('x ', '') ?? '0');
    List<BlackMarket> bm = [];

    blackMarket.forEach((item) {
        final itemHtml = document.querySelector(".inventory-item-${item['html']}.width-50 > span > span > span.grid-cell.align-top > div > span");
        final itemNumber = int.parse(itemHtml?.text.replaceAll('x ', '') ?? '0');
        final image = '${href + item['html']}.png';
        _repositoryBlackMarket.addNewItem(BlackMarket(item['name'], image, itemNumber));
        bm.add(BlackMarket(item['name'], image, itemNumber));
    });

    _repositoryData.addNewData(AccountData(account: account, passes: passes, equus: equus, or: or, market: bm));

  }

  void _updateScreen(check, status) {
    emit(UpdateScreen(_repository.getAccounts, check, status));
  }

  void _addNewAccount(AddNewAccount event, Emitter<MainState> state) async {
    try {
      final result = _repository
          .addNewAccount(Account(login: event.login, password: event.password));
      _updateScreen(false, '${event.login} добавлен');
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  Future<void> _logoutRequest() async {
    ids.clear();
    _updateScreen(false, 'Выход');
    print('Выход');
  }

  Future<void> _sellSkinRequest() async {
    final session = Network.instance;
    var res = await session.checkEquus();
    var document = parse(res);
    final htmlEquus = document.querySelector("#reserve")!.innerHtml;
    final equus = int.parse(htmlEquus.replaceAll(' ', ''));

    if ((equus < 37500) && (equus != null)) {
      await session.sellSkin();
      _updateScreen(false, 'Продаю кожу');
      print('Продать кожу');
    }
  }

  Future<bool> _loginRequest(login, password) async {
    Network.dio.interceptors.clear();
    final session = Network.instance;
    var res = await session.login(login, password);
    _updateScreen(false, 'Попытка входа в $login');

    return res;
  }

  //collect all cows from meadows
  Future<void> _collectSkinRequest() async {
    try {
      final session = Network.instance;
      final data = await session.getMeadows();
      _parseData(data);

      for (var i = 0; i < ids.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500), () {
          session.collectSkin(ids[i]);
          _updateScreen(false, 'Собираю ${i + 1}');
        });
      }
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  //set new cows to meadows
  Future<void> _setSkinRequest() async {
    try {
      final session = Network.instance;
      for (var i = 0; i < ids.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500), () {
          session.setSkin(ids[i]);
          _updateScreen(false, 'Коровы ${i + 1}');
        });
      }
    } catch (e) {
      _updateScreen(false, 'error');
    }
  }

  //get meadows id
  Future<void> _parseData(data) async {
    final document = parse(data);
    final lug = document.querySelectorAll("#id\\[\\]").length; //всего лугов

    for (var i = 0; i < lug; i++) {
      var id = document.querySelectorAll("#id\\[\\]")[i].attributes.values.last;
      ids.add(id);
    }
  }
}
