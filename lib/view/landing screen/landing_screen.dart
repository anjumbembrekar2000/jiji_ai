import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/app_colors.dart';
import 'chat_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitDialog(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    'Jiji',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: const Text(
                    'Your AI Friend',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                Image.asset(
                  'assets/jiji_ai_img.jpg',
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: AppColors.primaryColor),
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isEmpty) return;

                          context.read<ChatBloc>().add(SendMessageEvent(text));
                          controller.clear();


                          Future.delayed(const Duration(milliseconds: 100), () {
                            if (scrollController.hasClients) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Chat Area (Jiji reply only)
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.botReply == null) return const SizedBox();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text("Jiji Says",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Text(state.botReply!),
                              if (state.showRagActions)...[
                                SizedBox(height: 15,),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/powerpoint.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'Presentation on RAG',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 32,
                                            width: 80,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Opening PowerPoint tool...'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: const Text(
                                                'Open',
                                                style: TextStyle(
                                                  color: AppColors.background,
                                                  fontSize: 14, // smaller text
                                                ),
                                              ),
                                            ),
                                          ),                                    ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey.shade300),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/youthtube.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'What is RAG',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 32,
                                            width: 80,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Redirecting to YouTube...'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.secondaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.zero, // remove extra padding
                                              ),
                                              child: const Text(
                                                'Watch',
                                                style: TextStyle(
                                                  color: AppColors.background,
                                                  fontSize: 14, // smaller text
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]

                            ],
                          ),
                        ),

                        const SizedBox(height: 16),


                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Exit App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to exit?'),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            ),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            ),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }


}
