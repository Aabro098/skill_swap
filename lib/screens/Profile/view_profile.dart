// // ignore_for_file: use_build_context_synchronously

// import 'dart:math';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:skill_swap/extensions/context_extensions.dart';
// import 'package:skill_swap/model/user_model.dart';
// import 'package:skill_swap/notifiers/friend_req_notifiers.dart';
// import 'package:skill_swap/notifiers/friends_notifier.dart';
// import 'package:skill_swap/services/dio_client.dart';
// import 'package:skill_swap/utils/constants/image_strings.dart';
// import 'package:skill_swap/utils/constants/sizes.dart';
// import 'package:skill_swap/utils/helpers/helper_functions.dart';

// class ViewProfile extends StatefulWidget {
//   final UserModel user;
//   final bool isRequest;
//   const ViewProfile({
//     required this.user,
//     this.isRequest = false,
//     super.key,
//   });

//   @override
//   State<ViewProfile> createState() => _ViewProfileState();
// }

// class _ViewProfileState extends State<ViewProfile> {
//   final List<Color> colors = [
//     Colors.red,
//     Colors.indigo,
//     Colors.green,
//     Colors.orange,
//     Colors.purple,
//     Colors.amber,
//   ];

//   final Random random = Random();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = widget.user;
//     return Scaffold(
//       appBar: AppBar(
//         title: const AutoSizeText('Profile'),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(AppSizes.padding),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 64,
//                     backgroundImage: const AssetImage(AppImages.fallback),
//                     foregroundImage: NetworkImage(user.profileUrl),
//                     onForegroundImageError: (_, __) {},
//                   ),
//                 ),
//                 const SizedBox(height: AppSizes.lg),
//                 Center(
//                   child: AutoSizeText(
//                     user.name,
//                     style: context.textTheme.titleLarge
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: AppSizes.xs),
//                 Center(
//                   child: AutoSizeText(
//                     user.email,
//                     style: context.textTheme.titleSmall,
//                   ),
//                 ),
//                 if (widget.isRequest == true) ...[
//                   const SizedBox(height: AppSizes.md),
//                   _isLoading
//                       ? const Center(
//                           child: SizedBox(
//                               width: AppSizes.md,
//                               height: AppSizes.md,
//                               child: CircularProgressIndicator(
//                                 color: Colors.green,
//                                 strokeWidth: 2,
//                               )))
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 120,
//                               child: OutlinedButton(
//                                 onPressed: () async {
//                                   try {
//                                     if (mounted) {
//                                       setState(() {
//                                         _isLoading = true;
//                                       });
//                                     }
//                                     await ref
//                                         .read(requestsProvider.notifier)
//                                         .respondRequest(
//                                           userId: user.id,
//                                           action: 'accepted',
//                                         );
//                                     if (mounted) {
//                                       setState(() {
//                                         _isLoading = false;
//                                       });
//                                     }
//                                     showSuccessSnackbar(
//                                         "Request accepted successfully",
//                                         context: context);
//                                     ref.read(requestsProvider.notifier).fetch();
//                                     ref.read(friendNotifier.notifier).fetch();
//                                     Navigator.pop(context);
//                                   } on DioException catch (e) {
//                                     final errorMessage =
//                                         DioClient.parseDioError(e);
//                                     showErrorSnackbar(errorMessage,
//                                         context: context);
//                                   } catch (e) {
//                                     showErrorSnackbar('Something went wrong',
//                                         context: context);
//                                   } finally {
//                                     if (mounted) {
//                                       setState(() {
//                                         _isLoading = false;
//                                       });
//                                     }
//                                   }
//                                 },
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.check,
//                                       color: Colors.green,
//                                     ),
//                                     SizedBox(width: AppSizes.xs),
//                                     Text(
//                                       'Accept',
//                                       style: TextStyle(color: Colors.green),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: AppSizes.md),
//                             SizedBox(
//                               width: 120,
//                               child: OutlinedButton(
//                                 onPressed: () {},
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.close,
//                                       color: Colors.red.shade900,
//                                     ),
//                                     const SizedBox(width: AppSizes.xs),
//                                     Text(
//                                       'Decline',
//                                       style:
//                                           TextStyle(color: Colors.red.shade900),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                 ],
//                 const SizedBox(height: AppSizes.sm),
//                 AutoSizeText(
//                   context.tr('about_me'),
//                   style: context.textTheme.titleMedium,
//                 ),
//                 const SizedBox(height: AppSizes.xs),
//                 AutoSizeText(
//                   user.description,
//                   style: context.textTheme.bodyMedium,
//                   textAlign: TextAlign.start,
//                 ),
//                 const SizedBox(height: AppSizes.sm),
//                 AutoSizeText(
//                   context.tr('skills'),
//                   style: context.textTheme.titleMedium,
//                 ),
//                 const SizedBox(height: AppSizes.sm),
//                 Wrap(
//                   spacing: AppSizes.xs,
//                   runSpacing: AppSizes.xs,
//                   children: user.skills
//                       .map((skill) => Chip(
//                             color: WidgetStatePropertyAll(Colors.grey.shade50),
//                             padding: const EdgeInsets.all(AppSizes.xs),
//                             visualDensity: VisualDensity.comfortable,
//                             label: Text(
//                               skill,
//                               style: context.textTheme.titleSmall
//                                   ?.copyWith(color: Colors.black),
//                             ),
//                             side: BorderSide(
//                                 color: colors[random.nextInt(colors.length)],
//                                 width: 2),
//                           ))
//                       .toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
