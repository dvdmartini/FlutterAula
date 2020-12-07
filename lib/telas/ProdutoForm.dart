import '../dados.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ProdutoModel.dart';
import '../Produto.dart';
import '../tipo.dart';

class ProdutoForm extends StatefulWidget {
  @override
  _ProdutoFormState createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final _precoFocusNode = FocusNode();
  final _descricaoFocusNode = FocusNode();

  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final produto = ModalRoute.of(context).settings.arguments as Produto;

      if (produto != null) {
        _formData['id'] = produto.id;
        _formData['titulo'] = produto.titulo;
        _formData['descricao'] = produto.descricao;
        _formData['preco'] = produto.preco;
        _formData['imageUrl'] = produto.imageUrl;
        _formData['tipoids'] = produto.tipoIds[0];

        _imageUrlController.text = _formData['imageUrl'];
      } else {
        _formData['preco'] = '';
      }
    }
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final produto = Produto(
        id: _formData['id'],
        titulo: _formData['titulo'],
        descricao: _formData['descricao'],
        tipoIds: []..add(_formData['tipoids']),
        preco: _formData['preco'],
        imageUrl: _formData['imageUrl']);

    final prodProvider = Provider.of<ProdutoModel>(context, listen: false);
    if (_formData['id'] == null) {
      prodProvider.adicionaItem(produto);
    } else {
      prodProvider.atualiza(produto);
    }
    Navigator.of(context).pop();
  }

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp || startWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (Tipo tipo in TIPOS_PRODUTOS) {
      items.add(
          new DropdownMenuItem(value: tipo.id, child: new Text(tipo.titulo)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['titulo'],
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['titulo'] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 3;

                  if (isEmpty || isInvalid) {
                    return 'Informe um Título válido com no mínimo 3 caracteres!';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['preco'].toString(),
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _precoFocusNode,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_descricaoFocusNode);
                // },
                onSaved: (value) => _formData['preco'] = double.parse(value),
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  var novoPreco = double.tryParse(value);
                  bool isInvalid = novoPreco == null || novoPreco <= 0;

                  if (isEmpty || isInvalid) {
                    return 'Informe um Preço válido!';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['descricao'],
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descricaoFocusNode,
                onSaved: (value) => _formData['descricao'] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 10;

                  if (isEmpty || isInvalid) {
                    return 'Informe uma Descrição válida com no mínimo 10 caracteres!';
                  }

                  return null;
                },
              ),
              // TextFormField(
              //   initialValue: _formData['tipoids'],
              //   decoration: InputDecoration(labelText: 'Categoria/Tipo:'),
              //   textInputAction: TextInputAction.next,
              //   onSaved: (value) => _formData['tipoids'] = value,
              //   validator: (value) {
              //     bool isEmpty = value.trim().isEmpty;
              //     if (isEmpty) {
              //       return 'Informe uma categoria!';
              //     }
              //     return null;
              //   },
              // ),
              DropdownButton(
                value: _formData['tipoids'],
                items: getDropDownMenuItems(),
                onChanged: (value) => setState(() {
                  _formData['tipoids'] = value;
                }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocusNode,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => _formData['imageUrl'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = !isValidImageUrl(value);

                        if (isEmpty || isInvalid) {
                          return 'Informe uma URL válida!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
