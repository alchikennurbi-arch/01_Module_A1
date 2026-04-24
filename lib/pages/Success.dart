import 'package:flutter/material.dart';
import 'package:kz_worldskills_a201/widgets/Home.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

double rating = 0;
final name = TextEditingController();
final key = GlobalKey<FormState>();

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(400, 40, 350, 0),
        child: Column(
          spacing: 20,
          children: [
            Text(
              "Successful checkout",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 40),
            ),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                    icon: Icon(
                      rating > index ? Icons.star : Icons.star_border,
                      size: 50,
                    ),
                  );
                }),
                Text(
                  rating == 0 ? "0.0" : rating.toString(),
                  style: TextStyle(fontSize: 35),
                ),
              ],
            ),
            Form(
              key: key,
              child: TextFormField(
                controller: name,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Fill the form";
                },
                textCapitalization: TextCapitalization.sentences,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: "Please enter your rating statement",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
                onPressed: () {
                  if (rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Select rating stars")),
                    );
                    return;
                  }

                  if (key.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                    setState(() {
                      savedItems.clear();
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
