
import 'package:flutter/material.dart';

class UpdateRecipeScreen extends StatefulWidget {
   final String name;
   final int servings;
   final List<String> instructions;

  const UpdateRecipeScreen({
    super.key,
     required this.name,
     required this.servings,
     required this.instructions,
  });

  @override
  State<UpdateRecipeScreen> createState() => _UpdateRecipeScreenState();
}

class _UpdateRecipeScreenState extends State<UpdateRecipeScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController servingsCtrl;
  late List<TextEditingController> instructionCtrls;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: widget.name);
    servingsCtrl = TextEditingController(text: widget.servings.toString());

    instructionCtrls = widget.instructions
        .map((step) => TextEditingController(text: step))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        title: const Text("Update Recipe",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label("Recipe Name"),
            textField(nameCtrl, "Enter recipe name"),

            const SizedBox(height: 20),
            label("Servings"),
            textField(servingsCtrl, "Eg: 4", isNumber: true),

            const SizedBox(height: 20),
            label("Instructions"),
            const SizedBox(height: 10,),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: instructionCtrls.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: TextField(
                          controller: instructionCtrls[index],
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: "Step ${index + 1}",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // DELETE BUTTON
                    IconButton(
                      onPressed: () {
                        setState(() {
                          instructionCtrls.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                );
              },
            ),

            // ADD STEP BUTTON
            TextButton.icon(
              onPressed: () {
                setState(() {
                  instructionCtrls.add(TextEditingController());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Step"),
            ),

            const SizedBox(height: 25),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameCtrl.text.isEmpty || servingsCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All fields required!")),
                    );
                    return;
                  }

                  List<String> updatedSteps = instructionCtrls
                      .map((c) => c.text.trim())
                      .where((text) => text.isNotEmpty)
                      .toList();

                  Navigator.pop(context, {
                    "name": nameCtrl.text,
                    "servings": int.parse(servingsCtrl.text),
                    "instructions": updatedSteps,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Save Changes",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget label(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );

  Widget textField(TextEditingController controller, String hint,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
