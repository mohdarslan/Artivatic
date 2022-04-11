// ignore_for_file: file_names

import 'package:artivatic/enums.dart';
import 'package:artivatic/view_models/about_canada_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutCanadaScreen extends StatefulWidget {
  const AboutCanadaScreen({Key? key}) : super(key: key);

  @override
  State<AboutCanadaScreen> createState() => _AboutCanadaScreenState();
}

class _AboutCanadaScreenState extends State<AboutCanadaScreen> {
  late AboutCanadaViewModel AboutCanadaVM;

  @override
  void initState() {
    super.initState();
    AboutCanadaVM = Provider.of<AboutCanadaViewModel>(context, listen: false)
      ..getCanadaDetails();
  }

  @override
  Widget build(BuildContext context) {
    final AboutCanadaVM =
        Provider.of<AboutCanadaViewModel>(context, listen: true);

    if (AboutCanadaVM.loadingStatus == LoadingStatus.WAITING) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please Wait ...'),
          16.verticalSpace,
          CircularProgressIndicator()
        ],
      );
    } else if (AboutCanadaVM.loadingStatus == LoadingStatus.ERROR) {
      return Center(
        child: Text('Some Error Occured'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AboutCanadaVM.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await AboutCanadaVM.getCanadaDetails();
          return;
        },
        child: ListView(
          cacheExtent: 9999,
          children: [
            for (int i = 0; i < AboutCanadaVM.length; i++) _buildCard(i)
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    //we will return an empty container if Title Description and Image URL are all null
    if (AboutCanadaVM.rowTitle(index) == null &&
        AboutCanadaVM.rowDescription(index) == null &&
        AboutCanadaVM.rowImage(index) == null) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: const Color(0xFFfbf6e8),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: const Color(0xFFd0bc79))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              (AboutCanadaVM.rowImage(index) == null ||
                      !AboutCanadaVM.isImageValid(index))
                  ? Container()
                  : Container(
                      height: 64.h,
                      width: 64.h,
                      child: CachedNetworkImage(
                        imageUrl: AboutCanadaVM.rowImage(index)!,
                        progressIndicatorBuilder: (_, __, ___) =>
                            LinearProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
              (AboutCanadaVM.rowImage(index) == null ||
                      !AboutCanadaVM.isImageValid(index))
                  ? Container()
                  : 8.horizontalSpace,
              Text(
                AboutCanadaVM.rowTitle(index) ?? '',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
          if (AboutCanadaVM.rowDescription(index) != null) ...[
            16.verticalSpace,
            Text(AboutCanadaVM.rowDescription(index) ?? '')
          ]
        ],
      ),
    );
  }
}
