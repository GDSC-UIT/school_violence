// import 'package:flutter/material.dart';
// import '../screens/map_home_screen.dart';
// import 'bottom_sheet_content.dart';
// import '../../../core/values/app_colors.dart';

// class StartButton extends StatelessWidget {
//   StartButton({Key? key, required typeBully, messageValue})
//       : _typeBully = typeBully,
//         _messageValue = messageValue,
//         super(key: key);

//   String _messageValue;
//   final TypeBullyEnum? _typeBully;
//   String typeBully = '';

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         if (_typeBully == TypeBullyEnum.violence) {
//           typeBully = 'violence';
//         } else if (_typeBully == TypeBullyEnum.shooting) {
//           typeBully = 'shooting';
//         } else {
//           typeBully = 'none';
//         }
//         test(_messageValue, typeBully);
//       },
//       style: ElevatedButton.styleFrom(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(30),
//           ),
//         ),
//         backgroundColor: AppColors.primaryColor,
//         elevation: 0,
//         minimumSize: const Size(380, 50),
//       ),
//       child: const Text(
//         "Start",
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }
