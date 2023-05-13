import 'package:flutter/material.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class FCTItemList extends StatelessWidget {
  const FCTItemList({
    Key? key,
    required this.fctItems,
    required this.onTap,
  }) : super(key: key);

  final Map<FCTFoodGroup, List<FCTFoodItem>> fctItems;
  final void Function(FCTFoodItem) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: fctItems.length,
          itemBuilder: (context, index) {
            final group = fctItems.keys.elementAt(index);
            final items = fctItems[group]!;
            return ExpansionTile(
              title: Text('${group.id}: ${group.name} (${items.length})'),
              children: items
                  .map((item) => FCTItemCard(item: item, onTap: onTap))
                  .toList(),
            );
          }),
    );
  }
}

class FCTItemCard extends StatelessWidget {
  const FCTItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final FCTFoodItem item;
  final void Function(FCTFoodItem item) onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text('${item.id}: ${item.name}'),
        subtitle: Text(
            '${item.scientificName}\nAlternate names: ${item.alternateNames.length}'),
        trailing: item.photoUrl != null
            ? Image(image: AssetImage(item.photoUrl!))
            : null,
        onTap: () => onTap(item),
      ),
    );
  }
}
