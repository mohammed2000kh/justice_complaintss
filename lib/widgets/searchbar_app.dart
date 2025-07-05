import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarApp extends StatelessWidget {
  final String label;
  final RxList list;
  final int? initialId;
  final Function({required Object object})? onChanged;

  SearchBarApp({
    super.key,
    required this.label,
    required this.list,
    this.onChanged,
    required this.initialId,
  });

  final RxString selectedItem = ''.obs; // تخزين العنصر المختار

  String getInitialItem() {
    if (initialId != null && initialId != -1) {
      try {
        return list.firstWhere((element) => element.id == initialId).name ?? '';
      } catch (e) {
        return '';
      }
    }
    return '';
  }

  void _showSearchDialog(
      BuildContext context, RxList list, RxList filteredList) {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Scaffold(
              appBar: AppBar(
                title: Text(label),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'ابحث',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          filteredList.value = list;
                        } else {
                          filteredList.value = list
                              .where((item) =>
                                  item.name.toString().contains(value))
                              .toList();
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Obx(() => ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final item = filteredList[index];
                            return ListTile(
                              title: Text(item.name),
                              onTap: () {
                                selectedItem.value =
                                    item.name; // تحديث العنصر المختار
                                Navigator.of(context).pop();
                                if (onChanged != null) {
                                  onChanged!(object: item);
                                  filteredList.value = list;
                                }
                              },
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final RxList filteredList = RxList.of(list);
    selectedItem.value = getInitialItem(); // ضبط القيمة الأولية

    return GestureDetector(
      onTap: () => _showSearchDialog(context, list, filteredList),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        selectedItem.isNotEmpty
                            ? selectedItem.value
                            : 'اختر $label',
                      )),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
