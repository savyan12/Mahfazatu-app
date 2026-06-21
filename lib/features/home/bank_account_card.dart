import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';

class BankAccountCard extends StatelessWidget {
  const BankAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1683 / 935,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.sky.withValues(alpha: 0.34)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppAssets.darkCard, fit: BoxFit.cover),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;

                  return Stack(
                    children: [
                      Positioned(
                        right: width * 0.07,
                        top: height * 0.48,
                        child: const Text(
                          r'$10,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.59,
                        bottom: height * 0.33,
                        child: const Text(
                          '4821',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.075,
                        bottom: height * 0.16,
                        child: const Text(
                          'سفيان',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.41,
                        bottom: height * 0.15,
                        child: const Row(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'VALID\nTHRU',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 5.5,
                                fontWeight: FontWeight.w800,
                                height: 0.92,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text(
                              '12/28',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: width * 0.055,
                        bottom: height * 0.095,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            AppAssets.nuranBankLogo,
                            width: width * 0.145,
                            height: height * 0.21,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
