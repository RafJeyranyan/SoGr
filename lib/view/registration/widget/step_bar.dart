import 'package:flutter/material.dart';
import 'package:so_group/core/style.dart';

class StepBar extends StatelessWidget {
    final int currentIndex;
    final int pageCount;

   StepBar({super.key, this.currentIndex = 0, required this.pageCount}){
     assert(currentIndex >= 0 && currentIndex < pageCount);

   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        List.generate(pageCount, (itemIndex) {

          return Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///
                /// Circles
                ///
                Container(
                  // width: size.width / 10.4,
                  width: size.width / 11,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == itemIndex ? AppColors.primaryYellow : AppColors.backGroundContrast,
                      border:  Border.all(
                        color: currentIndex == itemIndex ? AppColors.primaryYellow :
                        itemIndex < currentIndex ? AppColors.green :
                        AppColors.backGroundContrast
                      )
                  ),
                  child: itemIndex >= currentIndex ? Center(
                    child: Text("${itemIndex + 1}",
                    style: AppTextStyle.header8,),
                  ) : null,
                ),

                ///
                /// Divider
                ///
                if(itemIndex != pageCount - 1)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if( itemIndex < currentIndex )
                      const Spacer(),
                      Container(
                        height: 1,
                        decoration: const BoxDecoration(
                            color: AppColors.backGroundContrast
                        ),
                      ),
                      if( itemIndex < currentIndex )
                      Image.asset("assets/icons/done.png")
                    ],
                  ),
                ),
              ],
            ),
          );
        })
      ,
    );
  }
}
