import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Média', 
      home: const TelaMedia(),
    );
  }
}

class TelaMedia extends StatefulWidget {
  const TelaMedia({super.key});

  @override
  State<TelaMedia> createState() => _TelaMediaState();
}

class _TelaMediaState extends State<TelaMedia> {
  final nota1 = TextEditingController();
  final nota2 = TextEditingController();
  final nota3 = TextEditingController();
  final nota4 = TextEditingController();

  double media = 0;
  String resultado = '';
  String mensagem = '';

  void calcularMedia() {
    if (nota1.text.isEmpty || nota2.text.isEmpty || nota3.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar( //mensagem de erro aparece na parte inferior do site, sem popup
        const SnackBar(
          content: Text('Preencha todas as notas!'),
        ),
      );

      return;
    }

    double n1 = double.parse(nota1.text.replaceAll(',', '.'));
    double n2 = double.parse(nota2.text.replaceAll(',', '.'));
    double n3 = double.parse(nota3.text.replaceAll(',', '.'));
    double n4 = double.parse(nota4.text.replaceAll(',', '.'));

     if (n1 < 0 || n1 > 10 || n2 < 0 || n2 > 10 || n3 < 0 || n3 > 10 || n4 < 0 || n4 > 10) {
      ScaffoldMessenger.of(context).showSnackBar( //mensagem de erro aparece na parte inferior do site, sem popup
        const SnackBar(
          content: Text('As notas devem estar entre 0 e 10!'),
        ),
      );

      return;
    }

    double valorMedia = (n1 + n2 + n3 + n4) / 4;  //calculo de média

    //lógica de classificação de notas = NA, I, R, B, MB
    if (valorMedia < 5){
      resultado = 'I';
      mensagem = 'Você ficou com I. Resultado insuficiente!';
    }
    else if(valorMedia >= 5 && valorMedia <6){
      resultado = 'R';
      mensagem = 'Você ficou com R. Precisa estudar muito!';
    }
    else if(valorMedia >= 6 && valorMedia <=8){
      resultado = 'B';
      mensagem = 'Você ficou com B. Precisa estudar um pouco mais!';
    }
    else if (valorMedia >= 9 && valorMedia <= 10) {
      resultado = 'MB';
      mensagem = 'Você ficou com MB. Foi aprovado com excelência!';
    } 
    else{
      resultado = 'NA';
      mensagem = 'Sua nota não foi avaliada (NA). Informe corretamente os critérios requisitados';
    }

    setState(() {
      media = valorMedia;
    });
  }
@override
  void dispose() { //executa limpeza dos recursos que não serão mais utilizados quando um componente é encerrado.
    nota1.dispose();
    nota2.dispose();
    nota3.dispose();
    nota4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { //construção do header do projeto
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Média'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true, //centralização do título da calculadora
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const Text(
                'Digite as quatro notas do aluno:', //pequeno texto abaixo do header solicitando digitação das notas
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Primeiro campo (nota 1)
              TextField(
                controller: nota1, //variável que será escrita
                keyboardType: const TextInputType.numberWithOptions(decimal: true), //permite números decimais
                decoration: const InputDecoration( //decoração do campo de texto, com animação dinámica como de formulários do google
                  labelText: 'Primeira nota', //texto que está inserido dentro do campo (para informar o ujsuário oq digitar)
                  border: OutlineInputBorder(), // cria borda em torno do campo
                ),
              ),

              const SizedBox(height: 15),

              // Segundo campo
              TextField(
                controller: nota2,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Segunda nota',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Terceiro campo
              TextField(
                controller: nota3,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Terceira nota',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Quarto campo
              TextField(
                controller: nota4,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Quarta nota',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              // Botão para calcular
              ElevatedButton(
                onPressed: calcularMedia, //chamada de função
                child: const Text('Calcular Média'), //textro informado no botão
              ),

              const SizedBox(height: 30),

              // Exibição do resultado
              Text( //estilização
                'Média: ${media.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Resultado: $resultado',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}