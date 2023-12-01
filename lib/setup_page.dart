import 'package:flutter/material.dart';
import 'gameplay_page.dart';
import 'difficulty_level.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  SetupPageState createState() => SetupPageState();
}


class SetupPageState extends State<SetupPage> {
  DifficultyLevel _selectedDifficulty = DifficultyLevel.easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Setup'), backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              '    Select Difficulty Level:', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30,color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            DropdownButton<DifficultyLevel>(
              alignment: Alignment.center,
              value: _selectedDifficulty,
              onChanged: (DifficultyLevel? value) {
                setState(() {
                  _selectedDifficulty = value!;
                });
              },

              items: const [
                DropdownMenuItem(
                  alignment: Alignment.center,
                  value: DifficultyLevel.easy,
                  child: Text('Easy'),
                ),
                DropdownMenuItem(
                  value: DifficultyLevel.medium,
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: DifficultyLevel.hard,
                  child: Text('Hard'),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameplayPage(
                    difficultyLevel: _selectedDifficulty ,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom( alignment: Alignment.center,
                backgroundColor: Colors.amberAccent,
              ),
              child: const Text(
                'Start Game',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
