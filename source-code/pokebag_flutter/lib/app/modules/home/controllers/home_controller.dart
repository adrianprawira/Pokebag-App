import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';
import 'package:pokebag_flutter/app/services/remote_services.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isFailed = false.obs;
  var isSuccess = false.obs;
  var fetchMoreLoading = false.obs;
  var fetchMoreSuccess = false.obs;
  var fetchMoreFailed = false.obs;
  var hasReachMax = false.obs;

  var pokemonList = <PokemonDetailResponse>[].obs;

  var listPoke = <PokemonDetailResponse>[].obs;

  final nextPage = "".obs;
  var query = "".obs;

  final errorMessage = "There must be a mistake. Please Try Again Later".obs;

  late TextEditingController searchController;

  void fetchData() async {
    isLoading.value = true;
    try {
      RemoteServices.fetchListPokemon().then((value) async {
        nextPage.value = value.nextPage;
        for (var i = 0; i < value.listPokemon.length; i++) {
          final details =
              await RemoteServices.fetchDetailPokemon(value.listPokemon[i].url);
          pokemonList.add(details);
        }
        listPoke.value = pokemonList;
        isLoading.value = false;
        isSuccess.value = true;
        debugPrint(pokemonList.toString());

        return pokemonList;
      });
    } on DioError catch (e) {
      errorMessage.value = e.message;
      isFailed.value = true;
    }
  }

  void fetchMore() async {
    fetchMoreLoading.value = true;
    try {
      RemoteServices.fetchListPokemon(listUrl: nextPage.value)
          .then((value) async {
        value.nextPage != null
            ? nextPage.value = value.nextPage
            : nextPage.value;

        for (var i = 0; i < value.listPokemon.length; i++) {
          if (value.listPokemon.length < 10) {
            final details = await RemoteServices.fetchDetailPokemon(
                value.listPokemon[i].url);
            pokemonList.add(details);
            hasReachMax.value = true;
          } else {
            final details = await RemoteServices.fetchDetailPokemon(
                value.listPokemon[i].url);
            pokemonList.add(details);
          }
        }
        listPoke.value = pokemonList;
        fetchMoreLoading.value = false;
        fetchMoreSuccess.value = true;
        debugPrint(pokemonList.toString());

        return pokemonList;
      });
    } on DioError catch (e) {
      errorMessage.value = e.message;
      fetchMoreFailed.value = true;
    }
  }

  @override
  Future<void> refresh() =>
      Future.delayed(const Duration(milliseconds: 800)).then((value) {
        if (pokemonList.isNotEmpty) {
          pokemonList.clear();
          fetchData();
          return value;
        } else {
          fetchData();
          return value;
        }
      });

  void searchPokemon(String query) {
    final _pokemonList = pokemonList.where((pokemon) {
      final pokemonNameLower = pokemon.name!.toLowerCase();
      final searchLower = query.toLowerCase();

      return pokemonNameLower.contains(searchLower);
    }).toList();

    listPoke.value = _pokemonList;
    this.query.value = query;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();
  }
}
