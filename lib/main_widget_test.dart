import 'package:artivatic/enums.dart';
import 'package:artivatic/main.dart';
import 'package:artivatic/view/aboutCanada.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Success state widget test', (WidgetTester widgetTester) async {
    nock('https://run.mocky.io')
        .get('/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf')
        .reply(200, '''
          {
          "title":"About Canada",
          "rows":[
          	{
          	"title":"Beavers",
          	"description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
          	"imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
          	},
          	{
          	"title":"Flag",
          	"description":null,
          	"imageHref":"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
          	},
          	{
          	"title":"Transportation",
          	"description":"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
          	"imageHref":"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"
          	},
          	{
          	"title":"Hockey Night in Canada",
          	"description":"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.",
          	"imageHref":"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
          	},
          	{
          	"title":"Eh",
          	"description":"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.",
          	"imageHref":null
          	},
          	{
          	"title":"Housing",
          	"description":"Warmer than you might think.",
          	"imageHref":"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
          	},
          	{
          	"title":"Public Shame",
          	"description":" Sadly it's true.",
          	"imageHref":"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg"
          	},
          	{
          	"title":null,
          	"description":null,
          	"imageHref":null
          	},
          	{
          	"title":"Space Program",
          	"description":"Canada hopes to soon launch a man to the moon.",
          	"imageHref":"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg"
          	},
          	{
          	"title":"Meese",
          	"description":"A moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you.",
          	"imageHref":"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg"
          	},
          	{
          	"title":"Geography",
          	"description":"It's really big.",
          	"imageHref":null
          	},
          	{
          	"title":"Kittens...",
          	"description":"Éare illegal. Cats are fine.",
          	"imageHref":"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg"
          	},
          	{
          	"title":"Mounties",
          	"description":"They are the law. They are also Canada's foreign espionage service. Subtle.",
          	"imageHref":"http://3.bp.blogspot.com/__mokxbTmuJM/RnWuJ6cE9cI/AAAAAAAAATw/6z3m3w9JDiU/s400/019843_31.jpg"
          	},
          	{
          	"title":"Language",
          	"description":"Nous parlons tous les langues importants.",
          	"imageHref":null
          	}
          ]
          }
''');

    await widgetTester.pumpWidget(MyApp());
    expect(find.text('Please Wait ...'), findsOneWidget);

    await widgetTester.pump();
    expect(find.text('Beavers'), findsOneWidget);
  });

  testWidgets('Error state widget test', (WidgetTester widgetTester) async {
    nock('https://run.mocky.io')
        .get('/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf')
        .reply(404, '');

    await widgetTester.pumpWidget(MyApp());
    expect(find.text('Please Wait ...'), findsOneWidget);

    await widgetTester.pump();
    expect(find.text('Some Error Occured'), findsOneWidget);
  });
}
