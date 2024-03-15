import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {

  final Function onItemSelected;

  const PokemonCard({
    super.key,
    required this.onItemSelected
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemSelected();
      },
      child: Card(
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    Text(
                      'Pikachu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
          
              Container(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/example.png',
                  height: 100,
                  width: 100,
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}