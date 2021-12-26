import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:newsapp/modules/webview.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, BuildContext context, {bool isSearch = false}) {
  return Conditional.single(
    context: context,
    conditionBuilder: (context) => list.length > 0,
    fallbackBuilder: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()),
    widgetBuilder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          width: 1,
          color: Colors.grey,
        ),
      ),
      itemCount: list.length,
    ),
  );
}

Widget defaultFormField({
  required String label,
  required TextInputType type,
  required TextEditingController controller,
  required IconData prefix,
  required validate,
  onChange,
  onTap,
  bool isPass = false,
  IconData? suffix,
  suffixPressed,
  bool isEnable = true,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: TextFormField(
      onChanged: onChange,
      controller: controller,
      validator: validate,
      keyboardType: type,
      obscureText: isPass,
      onTap: onTap,
      enabled: isEnable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
