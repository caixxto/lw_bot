import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:lw/accounts/acc_manager.dart';
import 'package:lw/main/bloc/main_event.dart';
import 'package:lw/main/bloc/main_state.dart';
import 'package:lw/network.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AccountRepository _repository = AccountRepository.instance;
  final AccountDataRepository _repositoryData = AccountDataRepository.instance;
  final BlackMarketRepository _repositoryBlackMarket = BlackMarketRepository.instance;
  final List<String> ids = [];
  final List<String> skip = [];
  final List<double> accountData = [];
  late int index = 0;
  final href = 'https://www.lowadi.com/media/equideo/image/produits/32/';
  List blackMarket = [
    {'name': 'Кожа', 'html': 'ressource-cuir'},
    {'name': 'Экскременты', 'html': 'crottin'},
    {'name': 'Длани Морфея', 'html': 'bras-morphee'},
    {'name': 'Философский Камень', 'html': 'pierre-philosophale'},
    {'name': 'Хронограф Хроноса', 'html': 'sablier-chronos'},
    {'name': 'Кровь Медузы', 'html': 'sang-meduse'},
    {'name': 'Набор гармонии', 'html': 'pack-harmonie'},
    {'name': 'Золотое яблоко', 'html': 'pomme-or'},
    {'name': 'Ахиллесова пята', 'html': 'talon-achille'},
    {'name': 'Двухсторонний медальон', 'html': 'double-face'},
    {'name': 'Одеяние Ириды', 'html': 'iris-coat'},
    {'name': 'Безграничный Луч Гелиоса', 'html': 'rayon-helios-illimite'},
    {'name': 'Луч Гелиоса Ow', 'html': 'rayon-helios-ow'},
    {'name': 'Набор Посейдона', 'html': 'pack-poseidon'},
    {'name': 'Дар Гестии', 'html': 'don-hestia'},
    {'name': 'Кат Ши - Манул', 'html': 'compagnon-cat-sidhe-2'}, //???
    {'name': 'Состязание титанов', 'html': 'defi-titans'}, //???
    {'name': 'Рог изобилия', 'html': 'corne-abondance'},
    {'name': 'Золотое Руно', 'html': 'toison-or'},
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
    {'name': 'Посох Плодовитости', 'html': 'baton-fertilite'},
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
    {'name': 'Лира Апполона', 'html': 'lyre-apollon'},
    {'name': 'Винтажное яблоко', 'html': 'pomme-vintage'},
    {'name': 'Печать тьмы', 'html': 'sceau-apocalypse'},
    {'name': 'Походный дневник', 'html': 'trail-riding-diary'},
    {'name': 'Парадное яблоко', 'html': 'parade-apple'},
    {'name': 'Оригинальный Дух путешествий', 'html': 'esprit-nomade-originaux'},
    {'name': 'Исторический Дух путешествий', 'html': 'esprit-nomade-histoire'},
    {'name': 'Бонус-набор', 'html': 'pack-bonus'},
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

    on<OpenList>((event, state) async {
      _openFile();
    });

    on<SaveDataExcel>((event, state) async {
      final accounts = _repository.getAccounts;
      final data = _repositoryData.getAccountsData;
      final rows = accounts.length;
      List<String> bmNames = [];
      List<int> bmCount = [];

      data[0].market.forEach((element) {
        bmNames.add(element.name);
      });

      final Workbook workbook = Workbook();
      final Worksheet sheet = workbook.worksheets[0];
      
      sheet.importList(bmNames, 1, 7, false);

      for (var i = 0; i < rows; i++) {
        sheet.getRangeByName('A1').setText('№');
        sheet.getRangeByName('B1').setText('Ник');
        sheet.getRangeByName('C1').setText('Пароль');
        sheet.getRangeByName('D1').setText('Ор');
        sheet.getRangeByName('E1').setText('Экю');
        sheet.getRangeByName('F1').setText('Пропы');
        sheet.getRangeByName('A${i+2}').setNumber(i+1);
        sheet.getRangeByName('B${i+2}').setText(accounts[i].login);
        sheet.getRangeByName('C${i+2}').setText(accounts[i].password);
        sheet.getRangeByName('D${i+2}').setValue(data[i].or);
        sheet.getRangeByName('E${i+2}').setValue(data[i].equus);
        sheet.getRangeByName('F${i+2}').setValue(data[i].passes);
        data[i].market.forEach((element) {
          bmCount.add(element.count);
        });
        sheet.importList(bmCount, 2+i, 7, false);
        bmCount.clear();
      }

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path\\Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);

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
          await _logoutRequest();
        } else {
          await _getDataFromMarket(account[i]);
          skip.add(account[i].login);
        }
      }
      _updateScreen(false, 'Пропущенные ${skip.toString()}');

    });

    on<BuyHorses>((event, state) async {
      var pause = event.pause;

      for (var i = 0; i < _repository.getAccounts.length; i++) {
        final account = _repository.getAccounts;
        var exp = true;
        var numRetries = 0;
        var list = [];

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
          var page = 0;
          do {
            list = await _getDataFromPrive();
            page++;
            print('page $page');
            for (var i = 0; i < list.length; i++) {
              var a = list[i].substring(0, 10);
              var b = list[i].substring(11, 19);
              var c = list[i].substring(20, 30);
              var d = list[i].substring(31, 36);
              var e = list[i].substring(37, 47);
              var f = list[i].substring(48, 80);
              var g = list[i].substring(81, 86);
              var h = list[i].substring(87, 119);
              await _buyHorse(a, b, c, d, e, f, g, h, pause);
              print('buy horse ${i+1}');
            }
          } while (list.isNotEmpty);
          list.clear();
          await _logoutRequest();
        }
      }
      _updateScreen(false, 'выкупаю блять');

    });

    on<ChangeAccount>((event, state) async {
      index = event.id;
      emit(UpdateData(_repositoryData.getAccountsData[event.id], _repository.getAccounts, false));
    });

    on<DeleteAccount>((event, state) async {
      var acc = _repository.getAccounts[index].login;
      _repository.deleteAccount(index);
      emit(UpdateScreen(_repository.getAccounts, true, '$acc удален'));
    });

  }

  Future<List<String>> _getDataFromPrive() async {
    final session = Network.instance;
    var res = await session.getHorses();
     var document = parse(res);
     var lots = document.querySelectorAll(".spacer-large-top");
     final List<String> list = [];
    for (var i = 1; i < lots.length; i++){
      var command = lots[i].getElementsByTagName('script')[0].innerHtml;
      command = command.substring(command.indexOf('AjaxJSON'), command.indexOf('}; return false;'));
      const start = "{'params': '";
      const end = "'}))";
      final startIndex = command.indexOf(start);
      final endIndex = command.indexOf(end, startIndex + start.length);
      final comm = command.substring(startIndex + start.length, endIndex);
      list.add(comm);
    }
    return list;
  }

  Future<void> _buyHorse(a, b, c, d, e, f, g, h, pause) async {
    final session = Network.instance;
    await session.buyHorse(a, b, c, d, e, f, g, h, pause);
  }

  Future<void> _openFile() async {
    var filePath = '';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
    } else {

    }

    final File file = File(filePath);

    var text = File(filePath).readAsLinesSync();
    var textList = text.toList();
    var strings = textList.length;

    for (var i = 0; i < strings; i++) {
      var str = textList[i];
      var login = str.substring(0, str.indexOf(':'));
      var password = str.substring(str.indexOf(':') + 1);

      _repository.addNewAccount(Account(login: login, password: password));
    }

    _updateScreen(false, 'Аккаунтов добавлено: $strings');

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

  Future<void> _getDataFromMeadows(account) async {
    //TODO: get data from meadows
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
