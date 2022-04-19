import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/widgets.dart';

import '../data/models/response/pokemon/list/poke-list_response.dart';
import '../data/models/response/pokemon/detail/poke-detail_response.dart';

const _defTimeout = Duration.millisecondsPerMinute;

void networkDebugPrint(Object? message) => debugPrint(message.toString());

const String baseUrl = "https://pokeapi.co/api/v2/";

const String fetchFirstListUrl = "pokemon?limit=10&offset=0";

const String firebaseDBUrl =
    "https://pokebag-flutterdb-default-rtdb.asia-southeast1.firebasedatabase.app/";

Dio useDio() {
  var dio = Dio();

  dio.options.connectTimeout = _defTimeout;
  dio.options.receiveTimeout = _defTimeout;

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    logPrint: networkDebugPrint,
  ));

  return dio;
}

class RemoteServices {
  static Dio client = useDio();

  static Future<PokemonListResponse> fetchListPokemon(
      {String listUrl = baseUrl + fetchFirstListUrl}) async {
    final res = await client.get(listUrl);

    if (res.statusCode != 200) {
      throw '${res.statusMessage}';
    } else {
      final value = PokemonListResponse.fromJson(res.data);
      return value;
    }
  }

  static Future<PokemonDetailResponse> fetchDetailPokemon(
      String detailUrl) async {
    final res = await client.get(detailUrl);

    if (res.statusCode != 200) {
      throw '${res.statusMessage}';
    } else {
      final value = PokemonDetailResponse.fromJson(res.data);
      return value;
    }
  }

  static Future<dynamic> postPokebag({
    required String nameGiven,
    required PokemonDetailResponse dataPokemon,
  }) async {
    final res = await client.post(firebaseDBUrl + "pokebags.json",
        data: {"pokeName": nameGiven, "dataPokemon": dataPokemon});

    if (res.statusCode != 200) {
      throw '${res.statusMessage}';
    } else {
      return res.data;
    }
  }

  static Future<dynamic> getPokebag() async {
    final res = await client.get(firebaseDBUrl + "pokebags.json");
    if (res.statusCode != 200) {
      debugPrint(res.statusMessage);
      return res.statusMessage;
    } else {
      return res.data;
    }
  }

  static Future<void> deletePokebag(String id) async =>
      await client.delete(firebaseDBUrl + "pokebags/$id.json");
}
