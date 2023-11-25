import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/style/app_font_size.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

import '../../style/app_colors.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            const Text('Create new group'),
            Card(

              child:   ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 0.3.mqWdith(context),
                  maxWidth: 0.4.mqWdith(context),
                  minHeight: 0.3.mqHeight(context),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children:[Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Stack(
                          children: [

                            Icon(
                              Icons.folder_copy_outlined,
                              size: 100,
                              color: Colors.grey,
                            ),
                            Positioned(
                                left: 5,
                                top: 5,
                                child: Icon(Icons.add_circle_outline,size: 50,color: AppColors.primaryColor,)),
                          ],
                        ),
                  ),
                  SizedBox(width: 0.1.mqWdith(context),),
                    Text('Create Group',style: AppTextStyle.headerTextStyle(),),
                  ],
                ),
              ),


            ),
          ],
        ),
      ),
    );
  }
}
