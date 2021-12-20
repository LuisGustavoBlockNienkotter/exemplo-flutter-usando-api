// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:books/book/BookListModel.dart';
import 'package:books/conexao/EndPoints.dart';
import 'BookModel.dart';

class BookUI extends StatefulWidget {
  const BookUI({Key? key}) : super(key: key);

  @override
  _BookUI createState() => _BookUI();
}

class _BookUI extends State {
  late Future<BookListModel> bookListFuture;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<BookListModel>(
          future: bookListFuture,
          builder: (context, snapshot) {
            // Com switch conseguimos identificar em que ponto da conexão estamos
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return loadingView();
                }
              case ConnectionState.active:
                {
                  return loadingView();
                }
              case ConnectionState.done:
                {
                  // Se o estado é de finalizado, será trabalhado os dados do snapshot recebido
                  // snapshot representa um instantâneo (foto) dos dados recebidos
                  // Se o snapshot tem informações, apresenta
                  if (snapshot.hasData) {
                    // ignore: unnecessary_null_comparison
                    if (snapshot.data!.bookList != null) {
                      if (snapshot.data!.bookList.isNotEmpty) {
                        // preenche a lista
                        return ListView.builder(
                            itemCount: snapshot.data!.bookList.length,
                            itemBuilder: (context, index) {
                              return generateColum(
                                  snapshot.data!.bookList[index]);
                            });
                      } else {
                        // Em caso de retorno de lista vazia
                        return noDataView("1 No data found");
                      }
                    } else {
                      // Apresenta erro se a lista ou os dados são nulos
                      return noDataView("2 No data found");
                    }
                  } else if (snapshot.hasError) {
                    // Apresenta mensagem se teve algum erro
                    return noDataView("1 beer Something went wrong: " +
                        snapshot.error.toString());
                  } else {
                    return noDataView("2 Something went wrong");
                  }
                }
              case ConnectionState.none:
                {
                  return noDataView("4 Something went wrong");
                }
              default:
                {
                  return noDataView("3 Something went wrong");
                }
            }
          }),
    );
  }

  @override
  void initState() {
    // Verificamos a conexão com a internet
    isConnected().then((internet) {
      if (internet) {
        // define o estado enquanto carrega as informações da API
        setState(() {
          // chama a API para apresentar os dados
          // Aqui estamos no initState (ao iniciar a aplicação/tela), mas pode ser iniciado com um click de botão.
          bookListFuture = getBookListData(author: "harari");
        });
      }
    });

    super.initState();
  }

  Widget generateColum(BookModel item) => Card(
        child: ListTile(
          title: Text(
            item.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          isThreeLine: true,
          subtitle: Text(
            item.author,
            style: const TextStyle(fontWeight: FontWeight.w600),
            maxLines: 2,
          ),
          trailing: const Icon(Icons.star),
          onLongPress: () => {createBook(item)},
        ),
      );
}
