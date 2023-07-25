import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordgenerator/controller/controller.dart';
import 'package:passwordgenerator/presentation/constant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController =
        Provider.of<PasswordController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Password Generator"),
        leading: const Icon(Icons.password),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kheight15,
            TextField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: passwordController.passwordTextController,
              style: const TextStyle(
                fontSize: 20.0,
              ),
              maxLength: 20,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    final passwordGenerated = ClipboardData(
                        text: passwordController.passwordTextController.text);
                    Clipboard.setData(passwordGenerated);
                    showSnackBar(context, "Password Copied", Colors.green);
                  },
                  icon: const Icon(Icons.copy),
                ),
              ),
            ),
            kheight15,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Password Length",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        passwordController.sliderValue.toInt().toString(),
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Slider(
                  value: passwordController.sliderValue,
                  onChanged: (newValue) {
                    passwordController.setSlider(newValue);
                  },
                  min: 1.0,
                  max: 40.0,
                  divisions: 40,
                  label: '${passwordController.sliderValue.toInt()}',
                ),
              ],
            ),
            CheckboxListTile(
                title: const Text("UpperCase Letters (A-Z)"),
                value: passwordController.checkbox[0],
                onChanged: (value) {
                  passwordController.selectedIndex = 0;
                  passwordController.setOption(value!);
                }),
            CheckboxListTile(
                title: const Text("LowerCase Letters (a-z)"),
                value: passwordController.checkbox[1],
                onChanged: (value) {
                  passwordController.selectedIndex = 1;
                  passwordController.setOption(value!);
                }),
            CheckboxListTile(
                title: const Text("Numbers (0-9)"),
                value: passwordController.checkbox[2],
                onChanged: (value) {
                  passwordController.selectedIndex = 2;

                  passwordController.setOption(value!);
                }),
            CheckboxListTile(
                title: const Text("Special Characters"),
                value: passwordController.checkbox[3],
                onChanged: (value) {
                  passwordController.selectedIndex = 3;

                  passwordController.setOption(value!);
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  bool check = passwordController.checkIfGeneratable();
                  if (check == false) {
                    showSnackBar(context,
                        "Cannot generate password with this combination", Colors.red);
                  }
                  else{
                  passwordController.generatePassword();

                  }
                },
                child: const Text("Generate Password",style: TextStyle(fontSize: 16),))
          ],
        ),
      ),
    );
  }

  showSnackBar(BuildContext context, String text, Color color) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        content: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
