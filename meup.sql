-- Adminer 4.2.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `iAdminId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vName` varchar(255) NOT NULL,
  `vEmail` varchar(255) NOT NULL,
  `vUserName` varchar(255) NOT NULL,
  `vPassword` varchar(255) NOT NULL,
  `vPhonenumber` varchar(255) NOT NULL,
  `vCompany` varchar(255) NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `password_reset_code` varchar(100) NOT NULL,
  `password_reset_req_date` datetime NOT NULL,
  PRIMARY KEY (`iAdminId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `admin` (`iAdminId`, `vName`, `vEmail`, `vUserName`, `vPassword`, `vPhonenumber`, `vCompany`, `dAddedDate`, `dModifiedDate`, `eStatus`, `password_reset_code`, `password_reset_req_date`) VALUES
(1,	'Ankur',	'ankur.lakhani@indianic.com',	'admin',	'$2y$11$ZT6iNmrSCwo0K3ienrzj../kCaFiR6ck3rfh8ouvGEyLnUaXkgDdG',	'08758653112',	'indianic',	'2018-02-15 19:36:49',	'2018-02-15 19:36:49',	'Active',	'',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 NOT NULL,
  `icon` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `link` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `class` varchar(100) CHARACTER SET utf8 NOT NULL,
  `method` varchar(100) CHARACTER SET utf8 NOT NULL,
  `orders` tinyint(3) unsigned NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

INSERT INTO `admin_menu` (`id`, `parent_id`, `name`, `icon`, `link`, `class`, `method`, `orders`, `status`) VALUES
(3,	0,	'pgTitle_chngPassword',	'fa fa-lock',	'changepassword',	'changepassword',	'index',	1,	'Active'),
(4,	0,	'pgTitle_projects',	'fa fa-th',	'projects',	'projects',	'index',	10,	'Inactive'),
(5,	0,	'pgTitle_cms',	'fa fa-files-o',	'cms',	'cms',	'index',	6,	'Inactive'),
(6,	0,	'settings',	'fa fa-cogs',	NULL,	'settings',	'',	7,	'Inactive'),
(7,	6,	'general_settings',	NULL,	'settings/general_settings',	'settings',	'general_settings',	1,	'Inactive'),
(8,	6,	'api_keys',	NULL,	'settings/api_keys',	'settings',	'api_keys',	2,	'Inactive'),
(9,	0,	'pgTitle_avatar',	'fa fa-user',	'avatar',	'avatar',	'index',	8,	'Inactive'),
(10,	0,	'pgTitle_faq',	'fa fa-question-circle',	'faq',	'faq',	'index',	3,	'Active'),
(14,	0,	'pgTitle_user',	'fa fa-user',	'user',	'users',	'index',	2,	'Active'),
(15,	0,	'pgTitle_emailTemplate',	'fa fa-envelope-o',	'settings/email_template',	'email_template',	'index',	10,	'Inactive'),
(16,	0,	'pgTitle_feedback',	'fa fa-th',	'feedback',	'feedback',	'index',	4,	'Active'),
(17,	0,	'pgTitle_blog',	'fa fa-th',	'blog',	'blog',	'index',	5,	'Active'),
(18,	0,	'pgTitle_advertisement',	'fa fa-envelope-o',	'advertisement',	'advertisement',	'index',	6,	'Active'),
(19,	0,	'pgTitle_gym',	'fa fa-th',	'gym',	'gym',	'index',	7,	'Inactive'),
(20,	0,	'pgTitle_articles',	'fa fa-th',	'articles',	'articles',	'index',	5,	'Inactive'),
(21,	0,	'pgTitle_reportedFeeds',	'fa fa-cogs',	'reported_feeds',	'reported_feeds',	'index',	7,	'Active');

DROP TABLE IF EXISTS `advertisement_detail`;
CREATE TABLE `advertisement_detail` (
  `iAdvertisementDetailId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vTitle` varchar(255) NOT NULL,
  `vDescription` varchar(255) NOT NULL,
  `eSendTo` enum('All') NOT NULL,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `dStartDate` datetime NOT NULL,
  `dEndDate` datetime NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `eUploadType` enum('Image','Video') NOT NULL,
  `vVideo` varchar(255) NOT NULL,
  `vThumbVideo` varchar(255) NOT NULL,
  PRIMARY KEY (`iAdvertisementDetailId`),
  KEY `vTitle` (`vTitle`),
  KEY `vDescription` (`vDescription`),
  KEY `eStatus` (`eStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `advertisement_detail` (`iAdvertisementDetailId`, `vTitle`, `vDescription`, `eSendTo`, `vImage`, `vThumbImage`, `dStartDate`, `dEndDate`, `dAddedDate`, `dModifiedDate`, `eStatus`, `eUploadType`, `vVideo`, `vThumbVideo`) VALUES
(1,	'Advertisement ONE',	'Advertisement ONE',	'All',	'blue15208612111903629450.jpg',	'blue15208612111903629450.jpg',	'2017-07-20 00:00:00',	'2019-03-30 00:00:00',	'2018-02-12 18:16:12',	'2018-03-12 18:56:51',	'Inactive',	'Image',	'',	''),
(3,	'Advertisement THREE',	'Advertisement THREE',	'All',	'red15227354961734043729.jpg',	'red15227354961734043729.jpg',	'2018-02-13 00:00:00',	'2019-02-12 00:00:00',	'2018-02-12 18:16:47',	'2018-04-03 11:34:56',	'Active',	'Image',	'',	''),
(18,	'Advertisement TWO',	'Advertisement TWO',	'All',	'blue1522735485339138520.jpg',	'blue1522735485339138520.jpg',	'0021-03-20 00:00:00',	'0022-03-20 00:00:00',	'2018-03-07 06:45:39',	'2018-04-03 11:34:45',	'Active',	'Image',	'',	'');

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `iArticlesId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vTitle` varchar(255) NOT NULL,
  `tDescription` text NOT NULL,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `iAddedBy` int(10) unsigned NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iArticlesId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `articles` (`iArticlesId`, `vTitle`, `tDescription`, `vImage`, `vThumbImage`, `iAddedBy`, `eStatus`, `dAddedDate`, `dModifiedDate`) VALUES
(10,	'Magic Numbers Every Dieter Needs to Know',	'<p>Does this sound familiar? You&#39;ve been watching yourself all week (avoiding junk, skipping seconds) and still, your weight is exactly the same as it was a week ago-or worse, even inched up a pound or two. It&#39;s hard to remember that weight loss is a long-term process, you&#39;ve got to stay patient. But I&#39;ve learned that focusing on just your weight can sabotage your motivation. So instead here are five other numbers to think about. Keep track of these and your overall health (as well as your weight) ought to improve.</p>\r\n\r\n<p>1. Waist circumference&nbsp;<br />\r\nBy now, you&#39;ve probably heard enough experts blast BMI (body mass index, or a ratio of your weight to your height), saying it&#39;s not a good measure of body fat and health. Instead, you should know how many inches your waist measures. That&#39;s because the fat that accumulates around your middle is linked to a host of health problems, including heart disease, type 2 diabetes, and even death. One 2010 study examined more than 100,000 Americans age 50 and older and found that people with the biggest waist size had about twice the risk of dying as the slimmest.</p>\r\n\r\n<p><strong>Numbers to know:&nbsp;</strong>Aim for less than 35 inches for women and 40 for men.</p>\r\n\r\n<p>2. Daily calorie requirement&nbsp;<br />\r\nOur health books editor loves to point out the one thing most successful weight-loss programs have in common: They cut calories. Why? Chances are you consume way more than you realize or need.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>Most not-too-active middle aged women should consume around 1,600 calories a day to lose weight; men should consume 2,000 to 2,200. Try Mayo Clinic&#39;s calorie calculator tool for a personalized guesstimate that takes age, activity levels, and other factors into account.</p>\r\n\r\n<p>3. Daily fiber intake&nbsp;<br />\r\nYou probably scan food labels for calorie and fat content. But if I asked you how much fiber you&#39;re eating each day, I bet you wouldn&#39;t know (and it&#39;s probably half of what you should get). The big deal about fiber and weight loss is that it takes your body a long time to digest it compared to other nutrients. This tamps down hunger cravings and prevents blood sugar spikes. You know how can feel voracious an hour after eating a jumbo plain bagel? That&#39;s probably because your meal had no fiber.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>Many experts recommend 25 to 35 grams a day (a medium apple and a cup of oatmeal each have four, for example); some would love to see us eating even more. Most adults get about 15 grams a day. If you&#39;re pretty low on the fiber intake, add it slowly to avoid feeling bloated.</p>\r\n\r\n<p>4. How much you sleep&nbsp;<br />\r\nSleep helps the body regulate complex hormonal processes that affect our appetite, cravings, and weight. There&#39;s now ample research that shows people who get less sleep are more likely to be overweight and munch on junk food than those who get more. Skimping on sleep may sabotage your diet as much as the Snickers calling your name from the office candy bowl.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>If you&#39;re consistently getting six hours or less, your sleep habits may be tampering with your weight-loss goals. Most adults need seven to eight hours a night. A good clue you&#39;re getting enough: not needing an alarm clock to wake up.</p>\r\n\r\n<p>5. How many steps you take each day&nbsp;<br />\r\nMore and more research shows it&#39;s not the hour we spend sweating it out in the gym that counts, but all the incremental activity that adds up over the course of the day from things like taking the stairs, walking over to a colleague&#39;s desk instead of emailing, or standing and pacing while you chat on the phone. Sitting down is bad for your body and your metabolism-our hunter-gatherer ancestors were constantly on the move, and so we&#39;ve evolved not to sit still for hours on end.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>The magic step count (which you can learn by wearing a pedometer) is 10,000 a day. Most inactive people get 2,000 or fewer.</p>',	'BodyShapr_Social_Media_5-3615226712631511688514.jpg',	'BodyShapr_Social_Media_5-3615226712631511688514.jpg',	0,	'Active',	'2018-04-02 13:58:24',	'2018-04-02 17:44:23'),
(11,	'How to Dine Out and Stay Healthy',	'<p>What these researchers found out about fast food was pretty impressive, from a (bad) health perspective: Each one of those speedy breakfasts, lunches, or dinners contained an average of more than 1,750 milligrams (mg) of sodium.</p>\r\n\r\n<p>To put these findings in perspective, consider that the new U.S. government dietary guidelines recommend that a person consume no more than 1,500 mg of sodium--over the course of a&nbsp;<em>whole day</em>. Would you be shocked if I also told you that over half of those 6,500 single meals (57 percent of them) contained more sodium than the 1,500 mg daily supply?</p>\r\n\r\n<p><strong>Far too much salt</strong></p>\r\n\r\n<p>And how much sodium does the human body really require in a day? Only about 500 mg. And yet, the experts estimate that the average American swallows between 6,900 mg and 9,000 mg of sodium every day.</p>\r\n\r\n<p>Since 1 teaspoon of salt contains roughly 2,000 mg of sodium, this means that the average American is downing up to 4 1/2 teaspoons of salt each and every day! If a high-sodium diet can leave you feeling bloated, what must these folks be feeling?</p>\r\n\r\n<p><strong>A hazardous substance</strong></p>\r\n\r\n<p>For people sensitive to sodium, such as those with a family history of hypertension, people with diabetes, African Americans, and the elderly, the accumulation of too much salt in the body can be particularly risky--it can, for example, increase one&#39;s chances of getting heart disease, a leading killer. Add to this the fact that about half the people with high blood pressure aren&#39;t even aware that they have hypertension--and, Houston, we&#39;ve got a problem here.</p>\r\n\r\n<p><strong>Consuming less sodium in restaurants</strong></p>\r\n\r\n<p>Now that you know that restaurant food in particular is laden with piles of sodium, maybe it&#39;s time for us all to review the tips given by the American Heart Association (AHA) to reduce sodium intake when dining out:</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Get to know which foods are low in sodium, and look for them on the menu.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ask for your dish to be prepared without salt.</p>\r\n	</li>\r\n	<li>\r\n	<p>When you order, be specific about how you want your food prepared.</p>\r\n	</li>\r\n	<li>\r\n	<p>Don&#39;t add salt to your food. Instead of the salt shaker, reach for the pepper shaker.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ask for fresh lemon and squeeze its juice onto your dish instead of using salt. (Lemon juice goes well with fish and vegetables, for example.)</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>And consume less fat as well</strong></p>\r\n\r\n<p>As always, we&#39;ve got to also continue to keep track of the calories and fat when dining out. What should your daily target be for calories and fat? The AHA now recommends that most adults, besides limiting their sodium intake to 1,500 mg per day, consume no more than about 2,000 calories and 20 grams of saturated fat (the artery-clogging kind) each day.</p>\r\n\r\n<p><strong>Healthy options are possible--even at McDonald&#39;s (sort of)</strong></p>\r\n\r\n<p>So how are you supposed to navigate the unhealthy meals being dished out by so many of today&#39;s eating establishments? If you find yourself at a McDonald&#39;s, for example, what can you do to stay healthy? The medical and health news publisher WebMD recommends steering clear of the fatty offerings and going with the&nbsp;<em>Egg McMuffin</em>, which totals</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>300 calories</p>\r\n	</li>\r\n	<li>\r\n	<p>12 grams of fat (5 grams of it saturated fat)</p>\r\n	</li>\r\n	<li>\r\n	<p>2 grams of fiber</p>\r\n	</li>\r\n	<li>\r\n	<p>protein that should help you feel satisfied for hours</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>But... please know that the McMuffin falters in the sodium department, containing as it does a whopping 820 mg of the stuff, or a little more than half the daily limit of 1,500 mg.</p>\r\n\r\n<p><strong>... And even at Burger King (sort of)</strong></p>\r\n\r\n<p>In Burger King, you could choose the&nbsp;<em>Egg and Cheese Croissan&#39;wich</em>, which provides</p>\r\n\r\n<p>&bull; 320 calories</p>\r\n\r\n<p>&bull; 16 grams fat (7 grams of it saturated)</p>\r\n\r\n<p>&bull; 11 g of protein to keep your hunger at bay</p>\r\n\r\n<p>Like the McMuffin&#39;s, however, the Croissan&#39;wich&#39;s sodium content is still too high: 690 mg.</p>\r\n\r\n<p>If you&#39;re ordering lunch at Burger King, the&nbsp;<em>chicken baguette sandwich&nbsp;</em>will supply you with 350 calories and 5 grams of fat.</p>\r\n\r\n<p><strong>A great source of dietary info from restaurants</strong></p>\r\n\r\n<p>HealthyDining<em>finder</em>&nbsp;is a website that has teamed up with restaurants and with registered dietitians to help diners in the U.S. find--and restaurants to serve--food that passes or surpasses a list of healthy-eating criteria. The website shows diners a selection of restaurants in their area that offer tasty, dietitian-approved, menu choices, while it inspires the restaurants themselves to offer healthier choices.</p>\r\n\r\n<p>The site also provides tips on how to decrease the content and consumption of calories, fat, and sodium. In order to meet HealthyDining<em>finder</em>&#39;s &quot;Sodium Savvy&quot; criteria, for example, an entr&eacute;e can have no more than 750 mg of sodium, whereas appetizers, side dishes, and desserts must contain no more than 250 mg.</p>\r\n\r\n<p><strong>Playing with HealthyDining</strong><em><strong>finder</strong></em></p>\r\n\r\n<p>Here&#39;s how I had fun playing with this website:</p>\r\n\r\n<ol>\r\n	<li>\r\n	<p>Go to the search mechanism on HealthyDiningfinder.com and you&#39;ll find the search parameters listed in a column down the left-hand side of the page.</p>\r\n	</li>\r\n	<li>\r\n	<p>Type in your city, state, and zip code. (It&#39;s not necessary to enter your exact street address.)</p>\r\n	</li>\r\n	<li>\r\n	<p>Narrow your search to within 5, 10, 15, 20, or 50 miles of your house, depending on how far you&#39;re willing to drive for a meal.</p>\r\n	</li>\r\n	<li>\r\n	<p>Don&#39;t bother choosing a &quot;Price Range&quot;--you might as well see all the restaurant options available out there.</p>\r\n	</li>\r\n	<li>\r\n	<p>I clicked on only 1 &quot;Cuisine&quot; choice at a time--&quot;American/Family&quot;; &quot;Asian/Chinese&quot;; &quot;Italian&quot;; Fast/Quick&quot;; &quot;Mexican&quot;; &quot;Seafood&quot;; &quot;Other&quot;; etc.). By choosing just a single category each time, I could keep my search results simple.</p>\r\n	</li>\r\n	<li>\r\n	<p>Click the &quot;Apply&quot; button after each of your &quot;Cuisine&quot; choices, take note of the results, and then go back to the search page and unclick your last choice. Choose another type of cooking that you&#39;re interested in and click &quot;Apply&quot; again. Repeat as long as you want to keep looking.</p>\r\n	</li>\r\n	<li>\r\n	<p>I also didn&#39;t bother to choose any of the 3 Specialties--&quot;Sodium Savvy,&quot; &quot;Kids LiveWell,&quot; and &quot;Coupons&quot;--because whenever a restaurant popped up in the search results, its specialties were automatically listed below its name and logo.</p>\r\n	</li>\r\n</ol>\r\n\r\n<p><strong>A couple of surprises</strong></p>\r\n\r\n<p>HealthyDining<em>finder</em>&#39;s search form worked pretty well for me, although it presented me with a couple of surprises. A Hooters restaurant here in Baltimore, for example, proudly listed 7 &quot;Healthy Dining Options&quot;--who knew? And when I searched &quot;Seafood,&quot; not a single restaurant turned up, even when I extended the search out to 50 miles. I have to assume that the &quot;Seafood&quot; category was not functioning, since I live in Baltimore, a city that sits right on the Chesapeake Bay and is world-renowned for its piscine delights. Oh--that reminds me of 1 further step:</p>\r\n\r\n<p>8. At some point in your search, be sure to click on the last category, &quot;Other.&quot; When I finally got around to searching it, several seafood places did pop up--although none was a Baltimore great.</p>\r\n\r\n<p>The point is, with a little planning and the help of HealthyDining<em>finder</em>, you can indeed find healthy meals when you dine out.</p>',	'BodyShapr_Social_Media_6-4115226712871686315150.jpg',	'BodyShapr_Social_Media_6-4115226712871686315150.jpg',	0,	'Active',	'2018-04-02 13:59:16',	'2018-04-02 17:44:47'),
(12,	'Painless Ways to Cut Carbs',	'<p>The Atkins diet achieved peak fad status in 2004, and although it&#39;s since been replaced by trendy new ways of losing weight, it&#39;s had a lasting impact on how people view weight loss. Atkins recommended that dieters reduce their intake of carbohydrates. But that can be harder than it sounds. Here are some easy ways to cut carbs from your diet without sacrificing all of your favorite foodstuffs.</p>\r\n\r\n<p>1. Lose the Juice- Fruit juice isn&#39;t as healthy as people once thought. It lacks the fiber of whole fruit, and even 100% fruit juice is loaded with sugar and carbs. Cutting out fruit juice from your diet can eliminate a source of carbs you may not have even been watching out for.</p>\r\n\r\n<p>2. Cut the Crust- While pizza is an undeniably delicious indulgence, most pizza crusts are high in refined white flour, which is a major carbohydrate offender. If you can&#39;t resist eating pizza, opt for the thin crust variety rather than deep dish. You can still get your cheese and tomato sauce fix without ingesting as many carbohydrates.</p>\r\n\r\n<p>3. Wrap It Up- Sacrificing sandwiches and burgers is one of the toughest things about going low carb. But if you &quot;think outside the bun,&quot; you can still enjoy many of the flavors you love, just low carb. The solution? Substitute lettuce wraps for the bun on your burger or the bread on your turkey sandwich. You&#39;ll drastically lower the carb content and still have something to grip.</p>\r\n\r\n<p>4. Substitute Your Spaghetti- A spiralizer is the kitchen invention you never knew you needed-and it&#39;s shockingly affordable, with many going for under $30. This nifty gadget can transform squash, zucchini, and other low-carb veggies into spaghetti (or other shapes), making a great substitute for that carb-heavy pasta you miss eating.</p>\r\n\r\n<p>5. Replace Your Rice- Rice, like pasta, is a carb-heavy starch that&#39;s omnipresent in many cuisines. But you don&#39;t have to give up on Chinese or Indian food entirely just because you&#39;re counting carbs. Try subbing in riced cauliflower. It&#39;s got a similar texture and absorbency, and when it&#39;s loaded up with curry or broccoli beef, you&#39;ll barely notice a difference.</p>\r\n\r\n<p>6. Switch Your Chips- Potato chips are one of those snacks that it&#39;s really tough to let go of. If you&#39;re craving that crunch, try kale chips, which offer the same snackability with fewer carbs and a host of other health benefits. You can even make your own by tossing chopped up kale in olive oil, separating the leaves on a cooking sheet, and throwing them in the oven until they crisp up.</p>\r\n\r\n<p>7. Go with Protein for Breakfast- Even healthy breakfast cereals like granola and oatmeal are high in carbohydrates. But if you start your day with a protein, particularly eggs, you won&#39;t get off on the wrong foot. Eating protein early in the day also kick-starts your digestive system and helps you start burning fat when you exercise.</p>\r\n\r\n<p>8. Skip the Starch- While you need veggies to stay healthy on your low-carb diet, you want to avoid the starchier varieties. Potatoes are an obvious no-go, but so are sweet potatoes, despite being healthy otherwise. Other secretly starchy veggies include carrots, peas, and corn. The next time you need a vegetable side or want to add something to a salad, reach for some bell peppers, broccoli, asparagus, or artichokes.</p>\r\n\r\n<p>The paleo and keto diets both take a page out of Atkins&#39; book by suggesting you cut down on carbohydrates. If you&#39;re following either of these diets, or the many others that recommend a reduced carb intake, the tips above can help!</p>',	'BodyShapr_Social_Media_5-351522671252966249987.jpg',	'BodyShapr_Social_Media_5-351522671252966249987.jpg',	0,	'Active',	'2018-04-02 13:59:54',	'2018-04-02 17:44:12'),
(13,	'How You Can Boost Your Willpower',	'<p>If you don&#39;t have enough willpower, it may be difficult for you to achieve your life goals and getting enough of it requires a lot of sacrifice. Your willpower is like your muscle - it can be exhausted and can also be trained to become powerful. The training can be very challenging but if you can be patient enough, you will reap the benefits therein and some of the benefits are; cleaving to your long-term goals without stress, completing tasks without interference, resisting temptation and so on. What are the steps you need to take in order to enhance your willpower? Read on.</p>\r\n\r\n<p>Meditation&nbsp;<br />\r\nDaily meditation can be regarded as a spiritual exercise but it also has a medical perspective. Researchers were able to discover that meditation has the ability of boosting grey matter density in the prefrontal cortex of the brain, which is responsible for self-control or willpower. This means that daily meditation will enhance your willpower and you will also get other benefits like stress reduction as well as curtailment of the aging process.</p>\r\n\r\n<p>Gratitude Journaling&nbsp;<br />\r\nGratitude journaling is the process of writing down three things you are grateful for every morning and evening. Lots of studies have revealed that gratitude journaling can greatly enhance happiness, motivation and overall well-being. It also helps to boost your willpower and reduce the constancy of negative emotions that lead to stress.</p>\r\n\r\n<p>Avoid Willpower Depletion&nbsp;<br />\r\nDepletion of willpower can lead to stress which inactivates the prefrontal cortex and this can result in uncontrollable mood swing as well as indulgences, followed by a feeling of defeat which can make you to fall back on harmful old habits. It is very vital to flex your willpower muscle in order to keep it in shape but you should also give it a break. Hence, there is the need to strike a balance between the two so as to avoid unnecessary depletion. It is also important for you to avoid taking too much at once. For example, do not try to stop drinking coffee, break your nail-biting habit, stop smoking and start a new fitness plan, all at the same time. You should take them one after the other.</p>\r\n\r\n<p>Master The Art of Building Good Habits&nbsp;<br />\r\nHaving good habits is very vital for building your willpower because when you are stressed up, you are more likely to fall back to your old habits. For example, some people fall back to alcohol after a stressful day but if you develop a good habit after a stressful day, like going for a 10-minute walk, your body will no longer crave for alcohol but the walk.</p>',	'BodyShapr_Social_Media_6-291522671275991684248.jpg',	'BodyShapr_Social_Media_6-291522671275991684248.jpg',	0,	'Active',	'2018-04-02 14:00:19',	'2018-04-02 17:44:35');

DROP TABLE IF EXISTS `background_image_master`;
CREATE TABLE `background_image_master` (
  `iBackgroundImageMasterId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  PRIMARY KEY (`iBackgroundImageMasterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `background_image_master` (`iBackgroundImageMasterId`, `vImage`, `vThumbImage`) VALUES
(1,	'01.png',	''),
(2,	'02.png',	''),
(3,	'03.png',	''),
(4,	'04.png',	''),
(5,	'05.png',	''),
(6,	'06.png',	''),
(7,	'07.png',	''),
(8,	'08.png',	''),
(9,	'09.png',	''),
(10,	'10.png',	''),
(11,	'11.png',	''),
(12,	'12.png',	''),
(13,	'13.png',	''),
(14,	'14.png',	''),
(15,	'15.png',	''),
(16,	'16.png',	''),
(17,	'17.png',	''),
(18,	'18.png',	''),
(19,	'19.png',	''),
(20,	'20.png',	''),
(21,	'21.png',	''),
(22,	'22.png',	''),
(23,	'23.png',	''),
(24,	'24.png',	''),
(25,	'25.png',	''),
(26,	'26.png',	''),
(27,	'27.png',	''),
(28,	'28.png',	''),
(29,	'29.png',	''),
(30,	'30.png',	''),
(31,	'31.png',	''),
(32,	'32.png',	''),
(33,	'33.png',	''),
(34,	'34.png',	''),
(35,	'35.png',	'');

DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `iBlogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vBlogTitle` varchar(255) NOT NULL,
  `tBlogDesc` text NOT NULL,
  `vBlogImage` varchar(255) NOT NULL,
  `vThumbBlogImage` varchar(255) NOT NULL,
  `iAddedBy` int(10) unsigned NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iBlogId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `blog` (`iBlogId`, `vBlogTitle`, `tBlogDesc`, `vBlogImage`, `vThumbBlogImage`, `iAddedBy`, `eStatus`, `dAddedDate`, `dModifiedDate`) VALUES
(7,	'Painless Ways to Cut Carbs',	'<p>The Atkins diet achieved peak fad status in 2004, and although it&#39;s since been replaced by trendy new ways of losing weight, it&#39;s had a lasting impact on how people view weight loss. Atkins recommended that dieters reduce their intake of carbohydrates. But that can be harder than it sounds. Here are some easy ways to cut carbs from your diet without sacrificing all of your favorite foodstuffs.</p>\r\n\r\n<p>1. Lose the Juice- Fruit juice isn&#39;t as healthy as people once thought. It lacks the fiber of whole fruit, and even 100% fruit juice is loaded with sugar and carbs. Cutting out fruit juice from your diet can eliminate a source of carbs you may not have even been watching out for.</p>\r\n\r\n<p>2. Cut the Crust- While pizza is an undeniably delicious indulgence, most pizza crusts are high in refined white flour, which is a major carbohydrate offender. If you can&#39;t resist eating pizza, opt for the thin crust variety rather than deep dish. You can still get your cheese and tomato sauce fix without ingesting as many carbohydrates.</p>\r\n\r\n<p>3. Wrap It Up- Sacrificing sandwiches and burgers is one of the toughest things about going low carb. But if you &quot;think outside the bun,&quot; you can still enjoy many of the flavors you love, just low carb. The solution? Substitute lettuce wraps for the bun on your burger or the bread on your turkey sandwich. You&#39;ll drastically lower the carb content and still have something to grip.</p>\r\n\r\n<p>4. Substitute Your Spaghetti- A spiralizer is the kitchen invention you never knew you needed-and it&#39;s shockingly affordable, with many going for under $30. This nifty gadget can transform squash, zucchini, and other low-carb veggies into spaghetti (or other shapes), making a great substitute for that carb-heavy pasta you miss eating.</p>\r\n\r\n<p>5. Replace Your Rice- Rice, like pasta, is a carb-heavy starch that&#39;s omnipresent in many cuisines. But you don&#39;t have to give up on Chinese or Indian food entirely just because you&#39;re counting carbs. Try subbing in riced cauliflower. It&#39;s got a similar texture and absorbency, and when it&#39;s loaded up with curry or broccoli beef, you&#39;ll barely notice a difference.</p>\r\n\r\n<p>6. Switch Your Chips- Potato chips are one of those snacks that it&#39;s really tough to let go of. If you&#39;re craving that crunch, try kale chips, which offer the same snackability with fewer carbs and a host of other health benefits. You can even make your own by tossing chopped up kale in olive oil, separating the leaves on a cooking sheet, and throwing them in the oven until they crisp up.</p>\r\n\r\n<p>7. Go with Protein for Breakfast- Even healthy breakfast cereals like granola and oatmeal are high in carbohydrates. But if you start your day with a protein, particularly eggs, you won&#39;t get off on the wrong foot. Eating protein early in the day also kick-starts your digestive system and helps you start burning fat when you exercise.</p>\r\n\r\n<p>8. Skip the Starch- While you need veggies to stay healthy on your low-carb diet, you want to avoid the starchier varieties. Potatoes are an obvious no-go, but so are sweet potatoes, despite being healthy otherwise. Other secretly starchy veggies include carrots, peas, and corn. The next time you need a vegetable side or want to add something to a salad, reach for some bell peppers, broccoli, asparagus, or artichokes.</p>\r\n\r\n<p>The paleo and keto diets both take a page out of Atkins&#39; book by suggesting you cut down on carbohydrates. If you&#39;re following either of these diets, or the many others that recommend a reduced carb intake, the tips above can help!</p>',	'N',	'N',	0,	'Active',	'2018-04-04 10:55:35',	'2018-06-06 10:29:55'),
(8,	'Magic Numbers Every Dieter Needs to Know',	'<p>Does this sound familiar? You&#39;ve been watching yourself all week (avoiding junk, skipping seconds) and still, your weight is exactly the same as it was a week ago-or worse, even inched up a pound or two. It&#39;s hard to remember that weight loss is a long-term process, you&#39;ve got to stay patient. But I&#39;ve learned that focusing on just your weight can sabotage your motivation. So instead here are five other numbers to think about. Keep track of these and your overall health (as well as your weight) ought to improve.</p>\r\n\r\n<p>1. Waist circumference&nbsp;<br />\r\nBy now, you&#39;ve probably heard enough experts blast BMI (body mass index, or a ratio of your weight to your height), saying it&#39;s not a good measure of body fat and health. Instead, you should know how many inches your waist measures. That&#39;s because the fat that accumulates around your middle is linked to a host of health problems, including heart disease, type 2 diabetes, and even death. One 2010 study examined more than 100,000 Americans age 50 and older and found that people with the biggest waist size had about twice the risk of dying as the slimmest.</p>\r\n\r\n<p><strong>Numbers to know:&nbsp;</strong>Aim for less than 35 inches for women and 40 for men.</p>\r\n\r\n<p>2. Daily calorie requirement&nbsp;<br />\r\nOur health books editor loves to point out the one thing most successful weight-loss programs have in common: They cut calories. Why? Chances are you consume way more than you realize or need.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>Most not-too-active middle aged women should consume around 1,600 calories a day to lose weight; men should consume 2,000 to 2,200. Try Mayo Clinic&#39;s calorie calculator tool for a personalized guesstimate that takes age, activity levels, and other factors into account.</p>\r\n\r\n<p>3. Daily fiber intake&nbsp;<br />\r\nYou probably scan food labels for calorie and fat content. But if I asked you how much fiber you&#39;re eating each day, I bet you wouldn&#39;t know (and it&#39;s probably half of what you should get). The big deal about fiber and weight loss is that it takes your body a long time to digest it compared to other nutrients. This tamps down hunger cravings and prevents blood sugar spikes. You know how can feel voracious an hour after eating a jumbo plain bagel? That&#39;s probably because your meal had no fiber.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>Many experts recommend 25 to 35 grams a day (a medium apple and a cup of oatmeal each have four, for example); some would love to see us eating even more. Most adults get about 15 grams a day. If you&#39;re pretty low on the fiber intake, add it slowly to avoid feeling bloated.</p>\r\n\r\n<p>4. How much you sleep&nbsp;<br />\r\nSleep helps the body regulate complex hormonal processes that affect our appetite, cravings, and weight. There&#39;s now ample research that shows people who get less sleep are more likely to be overweight and munch on junk food than those who get more. Skimping on sleep may sabotage your diet as much as the Snickers calling your name from the office candy bowl.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>If you&#39;re consistently getting six hours or less, your sleep habits may be tampering with your weight-loss goals. Most adults need seven to eight hours a night. A good clue you&#39;re getting enough: not needing an alarm clock to wake up.</p>\r\n\r\n<p>5. How many steps you take each day&nbsp;<br />\r\nMore and more research shows it&#39;s not the hour we spend sweating it out in the gym that counts, but all the incremental activity that adds up over the course of the day from things like taking the stairs, walking over to a colleague&#39;s desk instead of emailing, or standing and pacing while you chat on the phone. Sitting down is bad for your body and your metabolism-our hunter-gatherer ancestors were constantly on the move, and so we&#39;ve evolved not to sit still for hours on end.</p>\r\n\r\n<p><strong>Number to know:&nbsp;</strong>The magic step count (which you can learn by wearing a pedometer) is 10,000 a day. Most inactive people get 2,000 or fewer.</p>',	'BodyShapr_Social_Media_5-361522819562698438557.jpg',	'BodyShapr_Social_Media_5-361522819562698438557.jpg',	0,	'Active',	'2018-04-04 10:56:03',	'0000-00-00 00:00:00'),
(9,	'How You Can Boost Your Willpower',	'<p>If you don&#39;t have enough willpower, it may be difficult for you to achieve your life goals and getting enough of it requires a lot of sacrifice. Your willpower is like your muscle - it can be exhausted and can also be trained to become powerful. The training can be very challenging but if you can be patient enough, you will reap the benefits therein and some of the benefits are; cleaving to your long-term goals without stress, completing tasks without interference, resisting temptation and so on. What are the steps you need to take in order to enhance your willpower? Read on.</p>\r\n\r\n<p>Meditation&nbsp;<br />\r\nDaily meditation can be regarded as a spiritual exercise but it also has a medical perspective. Researchers were able to discover that meditation has the ability of boosting grey matter density in the prefrontal cortex of the brain, which is responsible for self-control or willpower. This means that daily meditation will enhance your willpower and you will also get other benefits like stress reduction as well as curtailment of the aging process.</p>\r\n\r\n<p>Gratitude Journaling&nbsp;<br />\r\nGratitude journaling is the process of writing down three things you are grateful for every morning and evening. Lots of studies have revealed that gratitude journaling can greatly enhance happiness, motivation and overall well-being. It also helps to boost your willpower and reduce the constancy of negative emotions that lead to stress.</p>\r\n\r\n<p>Avoid Willpower Depletion&nbsp;<br />\r\nDepletion of willpower can lead to stress which inactivates the prefrontal cortex and this can result in uncontrollable mood swing as well as indulgences, followed by a feeling of defeat which can make you to fall back on harmful old habits. It is very vital to flex your willpower muscle in order to keep it in shape but you should also give it a break. Hence, there is the need to strike a balance between the two so as to avoid unnecessary depletion. It is also important for you to avoid taking too much at once. For example, do not try to stop drinking coffee, break your nail-biting habit, stop smoking and start a new fitness plan, all at the same time. You should take them one after the other.</p>\r\n\r\n<p>Master The Art of Building Good Habits&nbsp;<br />\r\nHaving good habits is very vital for building your willpower because when you are stressed up, you are more likely to fall back to your old habits. For example, some people fall back to alcohol after a stressful day but if you develop a good habit after a stressful day, like going for a 10-minute walk, your body will no longer crave for alcohol but the walk.</p>',	'BodyShapr_Social_Media_6-291522819600410060378.jpg',	'BodyShapr_Social_Media_6-291522819600410060378.jpg',	0,	'Active',	'2018-04-04 10:56:40',	'0000-00-00 00:00:00'),
(10,	'How to Dine Out and Stay Healthy',	'<p>What these researchers found out about fast food was pretty impressive, from a (bad) health perspective: Each one of those speedy breakfasts, lunches, or dinners contained an average of more than 1,750 milligrams (mg) of sodium.</p>\r\n\r\n<p>To put these findings in perspective, consider that the new U.S. government dietary guidelines recommend that a person consume no more than 1,500 mg of sodium--over the course of a&nbsp;<em>whole day</em>. Would you be shocked if I also told you that over half of those 6,500 single meals (57 percent of them) contained more sodium than the 1,500 mg daily supply?</p>\r\n\r\n<p><strong>Far too much salt</strong></p>\r\n\r\n<p>And how much sodium does the human body really require in a day? Only about 500 mg. And yet, the experts estimate that the average American swallows between 6,900 mg and 9,000 mg of sodium every day.</p>\r\n\r\n<p>Since 1 teaspoon of salt contains roughly 2,000 mg of sodium, this means that the average American is downing up to 4 1/2 teaspoons of salt each and every day! If a high-sodium diet can leave you feeling bloated, what must these folks be feeling?</p>\r\n\r\n<p><strong>A hazardous substance</strong></p>\r\n\r\n<p>For people sensitive to sodium, such as those with a family history of hypertension, people with diabetes, African Americans, and the elderly, the accumulation of too much salt in the body can be particularly risky--it can, for example, increase one&#39;s chances of getting heart disease, a leading killer. Add to this the fact that about half the people with high blood pressure aren&#39;t even aware that they have hypertension--and, Houston, we&#39;ve got a problem here.</p>\r\n\r\n<p><strong>Consuming less sodium in restaurants</strong></p>\r\n\r\n<p>Now that you know that restaurant food in particular is laden with piles of sodium, maybe it&#39;s time for us all to review the tips given by the American Heart Association (AHA) to reduce sodium intake when dining out:</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>Get to know which foods are low in sodium, and look for them on the menu.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ask for your dish to be prepared without salt.</p>\r\n	</li>\r\n	<li>\r\n	<p>When you order, be specific about how you want your food prepared.</p>\r\n	</li>\r\n	<li>\r\n	<p>Don&#39;t add salt to your food. Instead of the salt shaker, reach for the pepper shaker.</p>\r\n	</li>\r\n	<li>\r\n	<p>Ask for fresh lemon and squeeze its juice onto your dish instead of using salt. (Lemon juice goes well with fish and vegetables, for example.)</p>\r\n	</li>\r\n</ul>\r\n\r\n<p><strong>And consume less fat as well</strong></p>\r\n\r\n<p>As always, we&#39;ve got to also continue to keep track of the calories and fat when dining out. What should your daily target be for calories and fat? The AHA now recommends that most adults, besides limiting their sodium intake to 1,500 mg per day, consume no more than about 2,000 calories and 20 grams of saturated fat (the artery-clogging kind) each day.</p>\r\n\r\n<p><strong>Healthy options are possible--even at McDonald&#39;s (sort of)</strong></p>\r\n\r\n<p>So how are you supposed to navigate the unhealthy meals being dished out by so many of today&#39;s eating establishments? If you find yourself at a McDonald&#39;s, for example, what can you do to stay healthy? The medical and health news publisher WebMD recommends steering clear of the fatty offerings and going with the&nbsp;<em>Egg McMuffin</em>, which totals</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>300 calories</p>\r\n	</li>\r\n	<li>\r\n	<p>12 grams of fat (5 grams of it saturated fat)</p>\r\n	</li>\r\n	<li>\r\n	<p>2 grams of fiber</p>\r\n	</li>\r\n	<li>\r\n	<p>protein that should help you feel satisfied for hours</p>\r\n	</li>\r\n</ul>\r\n\r\n<p>But... please know that the McMuffin falters in the sodium department, containing as it does a whopping 820 mg of the stuff, or a little more than half the daily limit of 1,500 mg.</p>\r\n\r\n<p><strong>... And even at Burger King (sort of)</strong></p>\r\n\r\n<p>In Burger King, you could choose the&nbsp;<em>Egg and Cheese Croissan&#39;wich</em>, which provides</p>\r\n\r\n<p>&bull; 320 calories</p>\r\n\r\n<p>&bull; 16 grams fat (7 grams of it saturated)</p>\r\n\r\n<p>&bull; 11 g of protein to keep your hunger at bay</p>\r\n\r\n<p>Like the McMuffin&#39;s, however, the Croissan&#39;wich&#39;s sodium content is still too high: 690 mg.</p>\r\n\r\n<p>If you&#39;re ordering lunch at Burger King, the&nbsp;<em>chicken baguette sandwich&nbsp;</em>will supply you with 350 calories and 5 grams of fat.</p>\r\n\r\n<p><strong>A great source of dietary info from restaurants</strong></p>\r\n\r\n<p>HealthyDining<em>finder</em>&nbsp;is a website that has teamed up with restaurants and with registered dietitians to help diners in the U.S. find--and restaurants to serve--food that passes or surpasses a list of healthy-eating criteria. The website shows diners a selection of restaurants in their area that offer tasty, dietitian-approved, menu choices, while it inspires the restaurants themselves to offer healthier choices.</p>\r\n\r\n<p>The site also provides tips on how to decrease the content and consumption of calories, fat, and sodium. In order to meet HealthyDining<em>finder</em>&#39;s &quot;Sodium Savvy&quot; criteria, for example, an entr&eacute;e can have no more than 750 mg of sodium, whereas appetizers, side dishes, and desserts must contain no more than 250 mg.</p>\r\n\r\n<p><strong>Playing with HealthyDining</strong><em><strong>finder</strong></em></p>\r\n\r\n<p>Here&#39;s how I had fun playing with this website:</p>\r\n\r\n<ol>\r\n	<li>\r\n	<p>Go to the search mechanism on HealthyDiningfinder.com and you&#39;ll find the search parameters listed in a column down the left-hand side of the page.</p>\r\n	</li>\r\n	<li>\r\n	<p>Type in your city, state, and zip code. (It&#39;s not necessary to enter your exact street address.)</p>\r\n	</li>\r\n	<li>\r\n	<p>Narrow your search to within 5, 10, 15, 20, or 50 miles of your house, depending on how far you&#39;re willing to drive for a meal.</p>\r\n	</li>\r\n	<li>\r\n	<p>Don&#39;t bother choosing a &quot;Price Range&quot;--you might as well see all the restaurant options available out there.</p>\r\n	</li>\r\n	<li>\r\n	<p>I clicked on only 1 &quot;Cuisine&quot; choice at a time--&quot;American/Family&quot;; &quot;Asian/Chinese&quot;; &quot;Italian&quot;; Fast/Quick&quot;; &quot;Mexican&quot;; &quot;Seafood&quot;; &quot;Other&quot;; etc.). By choosing just a single category each time, I could keep my search results simple.</p>\r\n	</li>\r\n	<li>\r\n	<p>Click the &quot;Apply&quot; button after each of your &quot;Cuisine&quot; choices, take note of the results, and then go back to the search page and unclick your last choice. Choose another type of cooking that you&#39;re interested in and click &quot;Apply&quot; again. Repeat as long as you want to keep looking.</p>\r\n	</li>\r\n	<li>\r\n	<p>I also didn&#39;t bother to choose any of the 3 Specialties--&quot;Sodium Savvy,&quot; &quot;Kids LiveWell,&quot; and &quot;Coupons&quot;--because whenever a restaurant popped up in the search results, its specialties were automatically listed below its name and logo.</p>\r\n	</li>\r\n</ol>\r\n\r\n<p><strong>A couple of surprises</strong></p>\r\n\r\n<p>HealthyDining<em>finder</em>&#39;s search form worked pretty well for me, although it presented me with a couple of surprises. A Hooters restaurant here in Baltimore, for example, proudly listed 7 &quot;Healthy Dining Options&quot;--who knew? And when I searched &quot;Seafood,&quot; not a single restaurant turned up, even when I extended the search out to 50 miles. I have to assume that the &quot;Seafood&quot; category was not functioning, since I live in Baltimore, a city that sits right on the Chesapeake Bay and is world-renowned for its piscine delights. Oh--that reminds me of 1 further step:</p>\r\n\r\n<p>8. At some point in your search, be sure to click on the last category, &quot;Other.&quot; When I finally got around to searching it, several seafood places did pop up--although none was a Baltimore great.</p>\r\n\r\n<p>The point is, with a little planning and the help of HealthyDining<em>finder</em>, you can indeed find healthy meals when you dine out.</p>',	'BodyShapr_Social_Media_6-4115228196411178157956.jpg',	'BodyShapr_Social_Media_6-4115228196411178157956.jpg',	0,	'Inactive',	'2018-04-04 10:57:21',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `core_value_master`;
CREATE TABLE `core_value_master` (
  `iCoreValueMasterId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUserId` int(10) unsigned NOT NULL,
  `vValue` varchar(255) NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iCoreValueMasterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `email_template`;
CREATE TABLE `email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) unsigned NOT NULL,
  `template_name` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `from_email` varchar(100) COLLATE utf32_unicode_ci DEFAULT NULL,
  `from_name` varchar(100) COLLATE utf32_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf32_unicode_ci NOT NULL,
  `updated_date` datetime NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

INSERT INTO `email_template` (`id`, `admin_id`, `template_name`, `from_email`, `from_name`, `ip`, `updated_date`, `created_date`) VALUES
(1,	2,	'SIGNUP_ACTIVATION_EMAIL',	'',	'',	'10.2.2.6',	'2016-04-23 11:00:31',	'0000-00-00 00:00:00'),
(2,	2,	'FORGOT_PASSWORD',	'',	'',	'10.2.2.8',	'2016-03-30 17:20:21',	'0000-00-00 00:00:00'),
(3,	2,	'ADMIN_FORGOT_PASSWORD',	'ankur.lakhani@indianic.com',	'Ankur Lakhani',	'10.2.2.8',	'2016-04-06 11:24:55',	'0000-00-00 00:00:00'),
(4,	2,	'NEWSLETTER',	'mukund.topiwala@indianic.com',	'Mukund Topiwala',	'127.0.0.1',	'2016-07-13 10:57:29',	'2016-07-13 10:57:29');

DROP TABLE IF EXISTS `email_template_keyword`;
CREATE TABLE `email_template_keyword` (
  `email_template_id` int(11) unsigned NOT NULL,
  `keyword` varchar(128) COLLATE utf32_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`email_template_id`,`keyword`),
  CONSTRAINT `email_templates_keywords_id` FOREIGN KEY (`email_template_id`) REFERENCES `email_template` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

INSERT INTO `email_template_keyword` (`email_template_id`, `keyword`, `description`) VALUES
(1,	'{#USERNAME#}',	'Username'),
(1,	'{#VERIFICATION_LINK#}',	'Verification Link'),
(2,	'{#REQUEST_EXPIRY_TIME#}',	'Time in hour, when link will expire'),
(2,	'{#RESET_PASSWORD_LINK#}',	'Reset Password Link'),
(2,	'{#USERNAME#}',	'User\'s first name'),
(3,	'{#REQUEST_EXPIRY_TIME#}',	'Time in hour, when link will expire'),
(3,	'{#USERNAME#}',	'Username'),
(3,	'{#VERIFICATION_LINK#}',	'Verification Link');

DROP TABLE IF EXISTS `email_template_lang`;
CREATE TABLE `email_template_lang` (
  `email_template_id` int(11) unsigned NOT NULL,
  `lang_id` tinyint(3) unsigned NOT NULL,
  `subject` varchar(256) COLLATE utf32_unicode_ci NOT NULL,
  `message` text COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`email_template_id`,`lang_id`),
  KEY `email_templates_lang_id` (`lang_id`),
  CONSTRAINT `email_template_lang_ibfk_1` FOREIGN KEY (`email_template_id`) REFERENCES `email_template` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `email_templates_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

INSERT INTO `email_template_lang` (`email_template_id`, `lang_id`, `subject`, `message`) VALUES
(1,	1,	'{#SITE_NM#} Account Verification',	'<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\"><html>    <head>        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">        <title>Minty-Multipurpose Responsive Email Template</title>        <style type=\"text/css\">            /* Client-specific Styles */            #outlook a {padding:0;} /* Force Outlook to provide a \"view in browser\" menu link. */            body{width:100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0;}            /* Prevent Webkit and Windows Mobile platforms from changing default font sizes, while not breaking desktop design. */            .ExternalClass {width:100%;} /* Force Hotmail to display emails at full width */            .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div {line-height: 100%;} /* Force Hotmail to display normal line spacing.  More on that: http://www.emailonacid.com/forum/viewthread/43/ */            #backgroundTable {margin:0; padding:0; width:100% !important; line-height: 100% !important;}            img {outline:none; text-decoration:none;border:none; -ms-interpolation-mode: bicubic;}            a img {border:none;}            .image_fix {display:block;}            p {margin: 0px 0px !important;}            table td {border-collapse: collapse;}            table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; }            a {/*color: #e95353;*/ text-underline:none!important; text-decoration: none;text-decoration:none!important;}            /*STYLES*/            table[class=full] { width: 100%; clear: both; }            /*################################################*/            /*IPAD STYLES*/            /*################################################*/            @media only screen and (max-width: 640px) {                a[href^=\"tel\"], a[href^=\"sms\"] {                    text-decoration: none;                    color: #ffffff; /* or whatever your want */                    pointer-events: none;                    cursor: default;                }                .mobile_link a[href^=\"tel\"], .mobile_link a[href^=\"sms\"] {                    text-decoration: default;                    color: #ffffff !important;                    pointer-events: auto;                    cursor: default;                }                table[class=devicewidth] {width: 440px!important;text-align:center!important;}                table[class=devicewidthinner] {width: 420px!important;text-align:center!important;}                table[class=\"sthide\"]{display: none!important;}                img[class=\"bigimage\"]{width: 420px!important;height:219px!important;}                img[class=\"col2img\"]{width: 420px!important;height:258px!important;}                img[class=\"image-banner\"]{width: 440px!important;height:106px!important;}                td[class=\"menu\"]{text-align:center !important; padding: 0 0 10px 0 !important;}                td[class=\"logo\"]{padding:10px 0 5px 0!important;margin: 0 auto !important;}                img[class=\"logo\"]{padding:0!important;margin: 0 auto !important;}            }            /*##############################################*/            /*IPHONE STYLES*/            /*##############################################*/            @media only screen and (max-width: 480px) {                a[href^=\"tel\"], a[href^=\"sms\"] {                    text-decoration: none;                    color: #ffffff; /* or whatever your want */                    pointer-events: none;                    cursor: default;                }                .mobile_link a[href^=\"tel\"], .mobile_link a[href^=\"sms\"] {                    text-decoration: default;                    color: #ffffff !important;                     pointer-events: auto;                    cursor: default;                }                table[class=devicewidth] {width: 280px!important;text-align:center!important;}                table[class=devicewidthinner] {width: 260px!important;text-align:center!important;}                table[class=\"sthide\"]{display: none!important;}                img[class=\"bigimage\"]{width: 260px!important;height:136px!important;}                img[class=\"col2img\"]{width: 260px!important;height:160px!important;}                img[class=\"image-banner\"]{width: 280px!important;height:68px!important;}            }        </style>    </head>    <body>        <table st-sortable=\"preheader\" bgcolor=\"#d2d6de\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">            <tbody>                <tr>                    <td width=\"100%\">                        <table hasbackground=\"true\" class=\"devicewidth\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width=\"580\"><tbody>                                <tr>                                    <td height=\"5\" width=\"100%\">                                    </td>                                </tr>                                <tr>                                    <td style=\"font-family: Helvetica, arial, sans-serif; font-size: 10px;color: #999999\" st-content=\"preheader\" align=\"right\" valign=\"middle\">                                        <p>&nbsp;</p>                                        <p>&nbsp;</p>                                    </td>                                </tr>                                <tr><td height=\"5\" width=\"100%\">&nbsp;</td></tr>                            </tbody>                        </table>                    </td>                </tr>            </tbody>        </table>        <table st-sortable=\"full-text\" bgcolor=\"#d2d6de\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">            <tbody>                <tr>                    <td>                        <table hasbackground=\"true\" class=\"devicewidth\" bgcolor=\"#ffffff\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width=\"580\">                            <tbody>                                <tr>                                    <td height=\"30\" width=\"100%\">                                    </td>                                </tr>                                <tr>                                    <td>                                        <table class=\"devicewidthinner\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width=\"540\"><tbody>                                                <!-- Title --><tr>                                                    <td st-title=\"fulltext-title\" style=\"font-family: Helvetica, arial, sans-serif; font-size: 18px; color: #333333; text-align:center;line-height: 20px;\">                                                        <p align=\"left\">                                                            <span style=\"font-size: 10pt;\">Hi {#USERNAME#}﻿,</span>                                                        </p>                                                    </td>                                                </tr>                                                <tr>                                                    <td height=\"30\" width=\"100%\">                                                    </td>                                                </tr>                                                <tr>                                                    <td st-title=\"fulltext-title\" style=\"font-family: Helvetica, arial, sans-serif; font-size: 24px; color: #333333; text-align:center;line-height: 20px;\" class=\"mce-edit-focus\">                                                        <p>                                                            Just one more step....                                                        </p>                                                        <p>                                                        </p>                                                    </td>                                                </tr>                                                <!-- End of Title --><!-- spacing --><tr>                                                    <td height=\"5\">                                                    </td>                                                </tr>                                                <!-- End of spacing --><!-- content --><tr>                                                    <td st-content=\"fulltext-paragraph\" style=\"font-family: Helvetica, arial, sans-serif; font-size: 14px; color: #95a5a6; text-align:center;line-height: 30px;\">                                                        <p>                                                            Thank you for signup with {#SITE_NM#}! Verify you email address                                                        </p>                                                    </td>                                                </tr>                                                <!-- End of content --><!-- Spacing --><tr>                                                    <td height=\"10\" width=\"100%\">                                                    </td>                                                </tr>                                                <!-- Spacing --><!-- button --><tr>                                                    <td>                                                        <table style=\"background-color: rgb(54, 127, 169); border-radius: 4px; background-clip: padding-box; font-size: 13px; font-family: Helvetica,arial,sans-serif; text-align: center; color: rgb(255, 255, 255); font-weight: 300; padding-left: 25px; padding-right: 25px;\" st-button=\"edit\" class=\"tablet-button\" valign=\"middle\" bgcolor=\"#367fa9\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" height=\"36\"><tbody><tr>                                                                    <td style=\"padding-left:18px; padding-right:18px;font-family:Helvetica, arial, sans-serif; text-align:center;  color:#ffffff; font-weight: 300;\" align=\"center\" height=\"36\" valign=\"middle\" width=\"auto\">                                                                        <span style=\"color: #ffffff; font-weight: 300;\"> <a st-content=\"download\" href=\"{#VERIFICATION_LINK#}\" style=\"color: #ffffff; text-align:center;text-decoration: none;\" tabindex=\"-1\">Confirm Email</a></span>                                                                    </td>                                                                </tr></tbody></table>                                                    </td>                                                </tr>                                                <!-- /button --><!-- Spacing --><tr>                                                    <td height=\"30\" width=\"100%\">                                                    </td>                                                </tr>                                                <!-- Spacing --><tr>                                                    <td class=\"mce-edit-focus\" st-content=\"fulltext-paragraph\" style=\"font-family: Helvetica, arial, sans-serif; font-size: 14px; color: #95a5a6; text-align:center;line-height: 30px;\">                                                        <p>                                                            <span style=\"font-size: 10pt;\">Link is no tworking? Paste this into your browser</span><br><span style=\"font-size: 10pt;\">{#VERIFICATION_LINK#}</span>                                                        </p>                                                    </td>                                                </tr>                                                <!-- End of content --><!-- Spacing --><tr>                                                    <td height=\"10\" width=\"100%\">                                                    </td>                                                </tr>                                            </tbody></table>                                    </td>                                </tr>                            </tbody></table>                    </td>                </tr></tbody></table>        <table st-sortable=\"postfooter\" bgcolor=\"#d2d6de\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tbody><tr>                    <td width=\"100%\">                        <table hasbackground=\"true\" class=\"devicewidth\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\" width=\"580\"><tbody>                                <!-- Spacing --><tr>                                    <td height=\"5\" width=\"100%\">                                    </td>                                </tr>                                <!-- Spacing --><tr>                                    <td style=\"font-family: Helvetica, arial, sans-serif; font-size: 10px;color: #999999\" st-content=\"preheader\" align=\"center\" valign=\"middle\">                                        <p>                                        </p>                                        <p>                                        </p>                                    </td>                                </tr>                                <!-- Spacing --><tr>                                    <td height=\"5\" width=\"100%\">                                    </td>                                </tr>                                <!-- Spacing -->                            </tbody></table>                    </td>                </tr></tbody></table>    </body></html>'),
(1,	2,	'{#SITE_NM#} Account Verification',	'<p>Minty-Multipurpose Responsive Email Template</p>\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n <tbody>\r\n  <tr>\r\n   <td>\r\n   <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n    <tbody>\r\n     <tr>\r\n      <td> </td>\r\n     </tr>\r\n     <tr>\r\n      <td>\r\n      <p> </p>\r\n\r\n      <p> </p>\r\n      </td>\r\n     </tr>\r\n     <tr>\r\n      <td> </td>\r\n     </tr>\r\n    </tbody>\r\n   </table>\r\n   </td>\r\n  </tr>\r\n </tbody>\r\n</table>\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n <tbody>\r\n  <tr>\r\n   <td>\r\n   <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n    <tbody>\r\n     <tr>\r\n      <td> </td>\r\n     </tr>\r\n     <tr>\r\n      <td>\r\n      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n       <tbody>&lt;!-- Title --&gt;\r\n        <tr>\r\n         <td xss=removed>\r\n         <p>Hi {#USERNAME#}﻿,</p>\r\n         </td>\r\n        </tr>\r\n        <tr>\r\n         <td> </td>\r\n        </tr>\r\n        <tr>\r\n         <td xss=removed>\r\n         <p>Just one more step....</p>\r\n\r\n         <p> </p>\r\n         </td>\r\n        </tr>\r\n        &lt;!-- End of Title --&gt;&lt;!-- spacing --&gt;\r\n        <tr>\r\n         <td> </td>\r\n        </tr>\r\n        &lt;!-- End of spacing --&gt;&lt;!-- content --&gt;\r\n        <tr>\r\n         <td xss=removed>\r\n         <p>Thank you for signup with {#SITE_NM#}! Verify you email address</p>\r\n         </td>\r\n        </tr>\r\n        &lt;!-- End of content --&gt;&lt;!-- Spacing --&gt;\r\n        <tr>\r\n         <td> </td>\r\n        </tr>\r\n        &lt;!-- Spacing --&gt;&lt;!-- button --&gt;\r\n        <tr>\r\n         <td>\r\n         <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n          <tbody>\r\n           <tr>\r\n            <td xss=removed><a href=\"{#VERIFICATION_LINK#}\">Confirm Email</a></td>\r\n           </tr>\r\n          </tbody>\r\n         </table>\r\n         </td>\r\n        </tr>\r\n        &lt;!-- /button --&gt;&lt;!-- Spacing --&gt;\r\n        <tr>\r\n         <td> </td>\r\n        </tr>\r\n        &lt;!-- Spacing --&gt;\r\n        <tr>\r\n         <td xss=removed>\r\n         <p>Link is no tworking? Paste this into your browser<br>\r\n         {#VERIFICATION_LINK#}</p>\r\n         </td>\r\n        </tr>\r\n        &lt;!-- End of content --&gt;&lt;!-- Spacing --&gt;\r\n        <tr>\r\n         <td> </td>\r\n        </tr>\r\n       </tbody>\r\n      </table>\r\n      </td>\r\n     </tr>\r\n    </tbody>\r\n   </table>\r\n   </td>\r\n  </tr>\r\n </tbody>\r\n</table>\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n <tbody>\r\n  <tr>\r\n   <td>\r\n   <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" xss=removed>\r\n    <tbody>&lt;!-- Spacing --&gt;\r\n     <tr>\r\n      <td> </td>\r\n     </tr>\r\n     &lt;!-- Spacing --&gt;\r\n     <tr>\r\n      <td>\r\n      <p> </p>\r\n\r\n      <p> </p>\r\n      </td>\r\n     </tr>\r\n     &lt;!-- Spacing --&gt;\r\n     <tr>\r\n      <td> </td>\r\n     </tr>\r\n     &lt;!-- Spacing --&gt;\r\n    </tbody>\r\n   </table>\r\n   </td>\r\n  </tr>\r\n </tbody>\r\n</table>'),
(2,	1,	'{#SITE_NM#} Reset Password',	'Dear {#USERNAME#},\r\n<br/>\r\nCan\'t remember your password? Don\'t worry about it — it happens.\r\n\r\n<br/>Please click the following link to reset your password:\r\n<br/>\r\n<a href=\"{#RESET_PASSWORD_LINK#}\">{#RESET_PASSWORD_LINK#}</a>\r\n<br/><br/>\r\nRegards,\r\n<br/>\r\nThe Superbrains Team'),
(2,	2,	'{#SITE_NM#} Reset Password',	'<p>Dear {#USERNAME#},<br>\r\nCan&#39;t remember your password? Don&#39;t worry about it — it happens.<br>\r\nPlease click the following link to reset your password:<br>\r\n<a href=\"{#RESET_PASSWORD_LINK#}\">{#RESET_PASSWORD_LINK#}</a><br>\r\n<br>\r\nThis link will expire in {#REQUEST_EXPIRY_TIME#} hour.<br>\r\n<br>\r\nRegards,<br>\r\nThe Superbrains Team</p>'),
(3,	1,	'Reset password request received',	'<p>Hello {#USERNAME#},<br />\r\n<br />\r\nWe received a password reset request. If you did not request a password request, ignore this email.<br />\r\nClick on below link to reset your password:<br />\r\n<a href=\"{#RESET_PASSWORD_LINK#}\">{#RESET_PASSWORD_LINK#}</a><br />\r\n<br />\r\nRegards,<br />\r\n{#SITE_NM#}</p>'),
(3,	2,	'Reset password request received',	'<p>Hello {#USERNAME#},<br>\r\n<br>\r\nWe received a password reset request. If you did not request a password request, ignore this email.<br>\r\nClick on below link to reset your password:<br>\r\n<a href=\"{#RESET_PASSWORD_LINK#}\">{#RESET_PASSWORD_LINK#}</a></p>\r\n\r\n<p>This link will expire in {#REQUEST_EXPIRY_TIME#} hour.<br>\r\n<br>\r\nRegards,<br>\r\n{#SITE_NM#}</p>'),
(4,	2,	'Test Newsletter',	'<p>Hi, </p>\r\n\r\n<p>This is sample test newsletter</p>');

DROP TABLE IF EXISTS `faq`;
CREATE TABLE `faq` (
  `iFaqId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vFaqQuestion` varchar(255) NOT NULL,
  `vFaqAnswer` varchar(5000) NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iFaqId`),
  KEY `vFaqQuestion` (`vFaqQuestion`),
  KEY `vFaqAnswer` (`vFaqAnswer`(3072)),
  KEY `eStatus` (`eStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `faq` (`iFaqId`, `vFaqQuestion`, `vFaqAnswer`, `eStatus`, `dAddedDate`, `dModifiedDate`) VALUES
(1,	'About',	'Starting a fitness journey is tough and even tougher to maintain, but it’s one of the best investments you can make. It improves your health, helps you keep up with your kids/grandkids, makes you happier, more productive and self-confident, to name a few of the benefits.  The main goal we set out to accomplish with BodyShapr is to serve as a motivational tool for those on a fitness journey, by providing a powerful array of options for visualizing your body transformation, including weight loss, muscle gain, etc. We believe motivation is being able to truly visualize your results. The results you see are purely for entertainment and reference, it is not intended to provide health or medical information, nor for making any dietary or exercising decisions without consulting with professionals. ',	'Active',	'2018-01-09 10:07:34',	'2018-02-19 11:44:51'),
(2,	'General Guidelines for Social Feed',	'With the app’s Social Feed and Social Media (Instagram & Facebook) we incentivize a community of supportive peers who want to share their progress, offer feedback and promote positives vibes. If you see anything that constitutes as harmful or offensive content, please notify us immediately. (See Harmful Content).',	'Active',	'2018-01-09 10:07:57',	'2018-01-09 10:07:57'),
(3,	'Harmful Content',	'We have zero tolerance disrespectful and offensive behavior toward others. Any comment, photo or other form of content in any of our platforms (app & social media pages) that constitutes as harmful, derogatory and/or nude content should be immediately reported to us by any of the contact options available. Our direct e-mail is: contact@bodyshapr.net. We count on your help to keep our virtual community safe. ',	'Active',	'2018-01-09 10:08:13',	'2018-01-09 10:08:13'),
(4,	'Usage Tips',	'1. Thoroughly review the How to & FAQs sections 2. Define your schedule. At minimum, take a set of pics once a week.  3. It works best if you have somebody take the pictures for you  4. It works best if you always take the pictures in the same place with the same lighting conditions 5. Always use Superimpose mode when taking a picture, it is the best way to guarantee your pictures remain as identical as possible for making accurate comparisons.  6. Be patient! Achieving your fitness goals takes a lot of time and effort. ',	'Active',	'2018-01-09 10:08:34',	'2018-01-09 10:08:34'),
(5,	'How should I start?',	'BodyShapr works around you. You decide how you want to monitor your fitness journey and how frequently you want to take pictures of your body. For that, we developed 4 useful tools that let you compare anywhere from 2-20 pictures. With that in mind, you should know by now that a body transformation takes a lot of time and patience, and it’s very hard to notice any changes in a short time span. So, maybe you want to test drive the app and see how it works? Start by taking pictures of your body (See: How Base Image Works) and play around with the various comparison options (See: Making a Comparison), you can get creative and switch attires or monitor your beard shaving process to see how comparisons work, while you work on your body transformation, but really…  On regular use, you will want do define how frequently you want to take pictures. You could start by taking pictures once or twice per week/per body section. That way, at the end of the month, you would have enough pictures to utilize the GIF & Lapse modes.',	'Active',	'2018-01-09 10:08:52',	'2018-01-09 10:08:52'),
(6,	'Weight Chart',	'Weight information is taken from the first picture you take on any given day. If you take more than one picture in a single day, it will only grab weight input from the first one.',	'Active',	'2018-01-09 10:10:31',	'2018-06-06 11:26:48'),
(7,	'Navigation Bar',	'The Navigation Bar refers to the horizontal bar located at the top of the app that contains three icons (a Star, a Camera and a Picture). The Star icon represents the app’s Social Feed, where you can find featured content, your friend’s published content and the content you choose to publish. The Camera icon is where you take pictures and Base Images. The Picture icon is where you see the complete list of comparisons you’ve made and also where you can make a new comparison. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(8,	'How Base Image Works',	'We want to make sure you stay in the same place each time you take a picture, for that reason we have Base Images. You need to take a Base Image of each Body Section (See Body Sections), which will then be used in the Superimpose mode for positioning reference when taking a picture. (See Superimpose Mode).',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(9,	'Body Sections',	'Body Sections are the views of your body which you can make comparisons of. Face, back, front, legs, side and torso. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(10,	'Comparison Modes',	'You have four comparison modes at your disposal, each varying in the amount of pictures you can choose to compare. For example, the Slider allows two images, which makes it perfect to monitor significant progress. On the other hand, the GIF and Slider options can make comparisons between 10 and 20 images, respectively.',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(11,	'Superimpose Mode',	'Superimpose is only available when taking a picture. It is a great tool for making sure your position within the picture always remains the same. It grabs the very first picture you took and places it in the background for positioning reference. All you have to do is match your current position to the superimposed image. This is essential for making great comparisons. You can toggle Superimpose on/off. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(12,	'Making a Comparison',	'Already took a few pictures of your body? Select the Gallery option from the Navigation Bar (See Navigation Bar) and press “Make New Comparison”. You’ll be prompted to select the comparison mode, then the pictures you’d like to compare, followed by a preview of that comparison. There you go! Now admire your progress, save, share or make a new comparison. If you have additional questions about the process, review the How To section located on the main page. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(13,	'Image & Profile Storage',	'mages are stored in the cloud, securely, for your convenience. That results in minimal local storage consumption and you can safely uninstall/reinstall your app without losing progress. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(14,	'Sharing & Publishing',	'Want to show your progress? You can use your default smartphone sharing options for doing so. You can also publish your progress within the app’s Social Feed. Both options are available by clicking the comparison you want to share and then pressing the + circle located at the bottom right. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(15,	'More questions?',	'We’re happy to assist you with any question you have regarding the app, please write us at contact@bodyshapr.net',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(16,	'Finding Friends',	'Who better than your friends to keep you motivated? Head to your Profile and tap the ‘Find Friends’ at the bottom, you will be able to see your Facebook friends. If you can’t find any, it’s because they still haven’t downloaded the app. In that case, start getting the word around!',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31'),
(17,	'Comments/Complaints',	'Are you enjoying the app but want to tell us about a cool feature we could integrate or you have complaints about the tools we provide? We want to know your experience with BodyShapr, please let us know in the Feedback section, you can find it in the menu. ',	'Active',	'2018-04-24 10:10:31',	'2018-04-24 10:10:31');

DROP TABLE IF EXISTS `feed_images`;
CREATE TABLE `feed_images` (
  `iFeedImagesId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `vUsersMediaId` varchar(255) NOT NULL,
  `vFile` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `eType` enum('slider','gif','collage','lapse') NOT NULL,
  `eSliderType` enum('','before','after') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `ePrivacyType` enum('own','friend') NOT NULL,
  `eBodyType` enum('','face','back','front','legs','side','torso') NOT NULL,
  `eStatus` enum('Report','Notabused','Block') NOT NULL DEFAULT 'Notabused',
  `iSysRecDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iFeedImagesId`),
  KEY `iUsersId` (`iUsersId`),
  KEY `eBodyType` (`eBodyType`),
  CONSTRAINT `feed_images_ibfk_1` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gym_master`;
CREATE TABLE `gym_master` (
  `iGymMasterId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vGymName` varchar(255) NOT NULL,
  `vDescription` varchar(255) NOT NULL,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `vLatitude` varchar(255) NOT NULL,
  `vLongitude` varchar(255) NOT NULL,
  `vAddress` varchar(255) NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iGymMasterId`),
  KEY `vGymName` (`vGymName`),
  KEY `vDescription` (`vDescription`),
  KEY `vAddress` (`vAddress`),
  KEY `eStatus` (`eStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `gym_master` (`iGymMasterId`, `vGymName`, `vDescription`, `vImage`, `vThumbImage`, `vLatitude`, `vLongitude`, `vAddress`, `eStatus`, `dAddedDate`, `dModifiedDate`) VALUES
(1,	'Press GYM',	'Press GYM description',	'gf_148215231811514889366890391594.jpg',	'gf_148215231811514889366890391594.jpg',	'23',	'72',	'ahmedabad',	'Active',	'2018-01-02 15:31:24',	'2018-01-02 15:31:24'),
(2,	'Women gym',	'Fitness Center for women',	'gf_1482152318515148893761127425824.jpg',	'gf_1482152318515148893761127425824.jpg',	'23.0745',	'72.526',	'ahmedabad',	'Inactive',	'2018-01-02 15:58:08',	'2018-01-02 15:58:08'),
(3,	'Hulk gym&protein point',	'Hulk Gym in LIG Colony, Indore listed under Gyms with Address, Contact Number , Reviews & Ratings, Photos, Maps. Visit Justdial for Hulk Gym, LIG Colony',	'gf_1482152318815148893831181961611.jpg',	'gf_1482152318815148893831181961611.jpg',	'45',	'72',	'E sector, near Rohit eye care hospital, LIG Main Rd, Indore, Madhya Pradesh',	'Active',	'2018-01-02 15:59:30',	'2018-01-02 15:59:30'),
(4,	'AR fitness',	'AR fitness',	'gf_148215231861514889419785752872.jpg',	'gf_148215231861514889419785752872.jpg',	'23',	'72',	'A 513 Mondeal Heights Near wide angle Cinema, Ramdev Nagar, Ahmedabad, Gujarat 380015',	'Active',	'2018-01-02 16:03:41',	'2018-01-02 16:03:41'),
(5,	'Vala\'s Gym',	'Plan your visit, People typically spend 1 hour here',	'gf_1482152318415148894011403581666.jpg',	'gf_1482152318415148894011403581666.jpg',	'23',	'72.56',	'Prernatirth Derasar Rd, Ahmedabad',	'Active',	'2018-01-02 16:04:47',	'2018-01-02 16:04:47'),
(10,	'Vala\'s Gym- Mumbai',	'Vala\'s Gym- Mumbai',	'gf_148215231861520861356982240747.jpg',	'gf_148215231861520861356982240747.jpg',	'19.0759837',	'72.8776559',	'Mumbai',	'Active',	'2018-02-27 19:13:51',	'2018-03-12 18:59:16');

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf32_unicode_ci NOT NULL,
  `code` char(2) COLLATE utf32_unicode_ci NOT NULL,
  `image` varchar(50) COLLATE utf32_unicode_ci NOT NULL,
  `date_format` varchar(20) COLLATE utf32_unicode_ci DEFAULT NULL,
  `time_format` varchar(20) COLLATE utf32_unicode_ci DEFAULT NULL,
  `orders` smallint(6) NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci COMMENT='ADMIN Use';

INSERT INTO `languages` (`id`, `name`, `code`, `image`, `date_format`, `time_format`, `orders`, `created_date`) VALUES
(1,	'Dutch',	'nl',	'',	'd-m-Y',	'h:i A',	1,	'0000-00-00 00:00:00'),
(2,	'English',	'en',	'',	'm-d-Y',	'h:i A',	2,	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL,
  `method` varchar(6) NOT NULL,
  `params` text,
  `api_key` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `time` int(11) NOT NULL,
  `rtime` float DEFAULT NULL,
  `authorized` varchar(1) NOT NULL,
  `response_code` smallint(3) DEFAULT '0',
  `response` text,
  `dAddedDate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `reported_feeds`;
CREATE TABLE `reported_feeds` (
  `iReportedFeedsId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iFeedImagesId` int(10) unsigned NOT NULL,
  `iUsersId` int(10) unsigned NOT NULL,
  `tReason` text NOT NULL,
  `dAddedDate` datetime NOT NULL,
  PRIMARY KEY (`iReportedFeedsId`),
  KEY `iFeedImagesId` (`iFeedImagesId`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `reported_feeds_ibfk_1` FOREIGN KEY (`iFeedImagesId`) REFERENCES `feed_images` (`iFeedImagesId`),
  CONSTRAINT `reported_feeds_ibfk_2` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `reported_feeds` (`iReportedFeedsId`, `iFeedImagesId`, `iUsersId`, `tReason`, `dAddedDate`) VALUES
(1,	53,	1,	'test',	'2018-06-24 15:40:27'),
(2,	53,	13,	'not ok ',	'2018-06-24 16:09:37'),
(3,	53,	1,	'Bad images',	'2018-06-25 12:29:16'),
(4,	53,	1,	'Bad images',	'2018-06-25 12:30:06'),
(5,	53,	1,	'Bad images',	'2018-06-25 12:30:21'),
(6,	53,	1,	'Bad images',	'2018-06-25 12:48:39'),
(7,	53,	1,	'Bad images',	'2018-06-25 12:58:27'),
(8,	53,	1,	'Bad images',	'2018-06-25 13:00:01'),
(9,	53,	1,	'Bad images',	'2018-06-25 13:21:27'),
(10,	53,	1,	'Bad images',	'2018-06-25 13:22:54'),
(11,	53,	1,	'Bad images',	'2018-06-25 13:23:22'),
(12,	53,	1,	'Bad images',	'2018-06-25 13:23:50'),
(13,	53,	1,	'Bad images',	'2018-06-25 13:23:57'),
(14,	53,	1,	'Bad images',	'2018-06-25 13:24:16'),
(15,	53,	1,	'Bad images',	'2018-06-25 13:24:39'),
(16,	53,	1,	'Bad images',	'2018-06-25 13:25:05'),
(17,	53,	1,	'Bad images',	'2018-06-25 13:36:48'),
(18,	53,	1,	'Bad images',	'2018-06-25 13:37:03'),
(19,	53,	1,	'Bad images',	'2018-06-25 13:37:36'),
(20,	53,	1,	'Bad images',	'2018-06-25 13:37:59'),
(21,	53,	1,	'Bad images',	'2018-06-25 13:38:58'),
(22,	53,	1,	'Bad images',	'2018-06-25 13:39:14'),
(23,	53,	1,	'Bad images',	'2018-06-25 13:43:17'),
(24,	53,	1,	'Bad images',	'2018-06-25 13:44:16'),
(25,	53,	1,	'Bad images',	'2018-06-25 13:44:39'),
(26,	53,	1,	'Bad images',	'2018-06-25 13:44:56'),
(27,	53,	1,	'Bad images',	'2018-06-25 13:48:20'),
(28,	53,	1,	'Bad images',	'2018-06-25 13:49:06'),
(29,	53,	1,	'Bad images',	'2018-06-25 13:50:07'),
(30,	53,	1,	'Bad images',	'2018-06-25 13:50:31'),
(31,	53,	1,	'Bad images',	'2018-06-25 14:02:22'),
(32,	53,	1,	'Bad images',	'2018-06-25 14:02:41'),
(33,	53,	1,	'Bad images',	'2018-06-25 14:04:40'),
(34,	53,	1,	'Bad images',	'2018-06-25 14:13:29'),
(35,	53,	1,	'Bad images',	'2018-06-25 14:19:19'),
(36,	18,	7,	'testing',	'2018-06-25 19:21:09'),
(37,	46,	13,	'Bad images',	'2018-06-25 16:16:25'),
(38,	46,	13,	'Bad images',	'2018-06-25 16:18:15'),
(39,	46,	13,	'Bad images',	'2018-06-26 07:50:16'),
(40,	46,	13,	'Bad images',	'2018-06-26 11:21:08');

DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE `site_setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(150) CHARACTER SET latin1 NOT NULL,
  `constant` varchar(100) CHARACTER SET latin1 NOT NULL,
  `field_type` enum('input','hidden','upload','password','textarea') CHARACTER SET latin1 NOT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `class` varchar(150) CHARACTER SET latin1 DEFAULT NULL,
  `type` enum('general','key') CHARACTER SET latin1 NOT NULL DEFAULT 'general',
  `value` varchar(500) CHARACTER SET latin1 NOT NULL,
  `attributes` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `orders` smallint(6) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `constant` (`constant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;



DROP TABLE IF EXISTS `sport_value_master`;
CREATE TABLE `sport_value_master` (
  `iSportValueMasterId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vIcon` varchar(255) NOT NULL,
  `vActiveIcon` varchar(255) NOT NULL,
  `vSelectedIcon` varchar(255) NOT NULL,
  `vText` varchar(255) NOT NULL,
  `eStatus` enum('Active','Deactive') NOT NULL,
  PRIMARY KEY (`iSportValueMasterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `sport_value_master` (`iSportValueMasterId`, `vIcon`, `vActiveIcon`, `vSelectedIcon`, `vText`, `eStatus`) VALUES
(1,	'01.png',	'01_active.png',	'01_copy.png',	'',	'Active'),
(2,	'02.png',	'02_active.png',	'02_copy.png',	'',	'Active'),
(3,	'03.png',	'03_active.png',	'03_copy.png',	'',	'Active'),
(4,	'04.png',	'04_active.png',	'04_copy.png',	'',	'Active'),
(5,	'05.png',	'05_active.png',	'05_copy.png',	'',	'Active'),
(6,	'06.png',	'06_active.png',	'06_copy.png',	'',	'Active'),
(7,	'07.png',	'07_active.png',	'07_copy.png',	'',	'Active'),
(8,	'08.png',	'08_active.png',	'08_copy.png',	'',	'Active'),
(9,	'09.png',	'09_active.png',	'09_copy.png',	'',	'Active'),
(10,	'10.png',	'10_active.png',	'10_copy.png',	'',	'Active'),
(11,	'11.png',	'11_active.png',	'11_copy.png',	'',	'Active'),
(12,	'12.png',	'12_active.png',	'12_copy.png',	'',	'Active'),
(13,	'13.png',	'13_active.png',	'13_copy.png',	'',	'Active'),
(14,	'14.png',	'14_active.png',	'14_copy.png',	'',	'Active'),
(15,	'15.png',	'15_active.png',	'15_copy.png',	'',	'Active'),
(16,	'16.png',	'16_active.png',	'16_copy.png',	'',	'Active'),
(17,	'17.png',	'17_active.png',	'17_copy.png',	'',	'Active'),
(18,	'18.png',	'18_active.png',	'18_copy.png',	'',	'Active'),
(19,	'19.png',	'19_active.png',	'19_copy.png',	'',	'Active'),
(20,	'20.png',	'20_active.png',	'20_copy.png',	'',	'Active'),
(21,	'21.png',	'21_active.png',	'21_copy.png',	'',	'Active'),
(22,	'22.png',	'22_active.png',	'22_copy.png',	'',	'Active'),
(23,	'23.png',	'23_active.png',	'23_copy.png',	'',	'Active'),
(24,	'24.png',	'24_active.png',	'24_copy.png',	'',	'Active'),
(25,	'25.png',	'25_active.png',	'25_copy.png',	'',	'Active'),
(26,	'26.png',	'26_active.png',	'26_copy.png',	'',	'Active'),
(27,	'27.png',	'27_active.png',	'27_copy.png',	'',	'Active'),
(28,	'28.png',	'28_active.png',	'28_copy.png',	'',	'Active'),
(29,	'29.png',	'29_active.png',	'29_copy.png',	'',	'Active'),
(30,	'30.png',	'30_active.png',	'30_copy.png',	'',	'Active'),
(31,	'31.png',	'31_active.png',	'31_copy.png',	'',	'Active'),
(32,	'32.png',	'32_active.png',	'32_copy.png',	'',	'Active'),
(33,	'33.png',	'33_active.png',	'33_copy.png',	'',	'Active'),
(34,	'34.png',	'34_active.png',	'34_copy.png',	'',	'Active'),
(35,	'35.png',	'35_active.png',	'35_copy.png',	'',	'Active'),
(36,	'36.png',	'36_active.png',	'36_copy.png',	'',	'Deactive');

DROP TABLE IF EXISTS `static_pages`;
CREATE TABLE `static_pages` (
  `iStaticPagesId` int(11) NOT NULL,
  `vPageTitle` varchar(255) NOT NULL,
  `vSeoKeyword` varchar(255) NOT NULL,
  `vContent` varchar(255) NOT NULL,
  `tMetaTitle` text NOT NULL,
  `tMetaKeyword` text NOT NULL,
  `tMetaDesc` text NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `terms_and_conditions`;
CREATE TABLE `terms_and_conditions` (
  `iTermsAndConditionsId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vTitle` varchar(255) NOT NULL,
  `tDesc` text NOT NULL,
  `iAddedBy` int(10) unsigned NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iTermsAndConditionsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `iUsersId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vUsername` varchar(255) NOT NULL,
  `vEmail` varchar(255) NOT NULL,
  `vPassword` varchar(255) NOT NULL,
  `eStatus` enum('Active','Inactive') NOT NULL,
  `eGender` enum('Male','Female') NOT NULL,
  `eUserType` enum('Normal','Pro') NOT NULL DEFAULT 'Pro',
  `tSocialId` text NOT NULL,
  `eSocialType` enum('','facebook') NOT NULL,
  `vProfilePic` varchar(255) NOT NULL,
  `vFbProfilePic` varchar(255) NOT NULL,
  `vThumbProfilePic` varchar(255) NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `vLatitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `vLongitude` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `fSize` float NOT NULL,
  `eSizeType` enum('Feet','Cms') NOT NULL,
  `iAge` int(10) unsigned NOT NULL,
  `vWeight` varchar(255) NOT NULL,
  `eWeightType` enum('kg','lbs','pound') NOT NULL,
  `vCoreValues` varchar(255) NOT NULL,
  `vSportsMasterId` varchar(255) NOT NULL,
  `vIsProfilePrivate` varchar(255) NOT NULL,
  `iRegisterationStatus` int(11) NOT NULL COMMENT '0 default and 1 after update user data',
  `vBackgroundImageId` varchar(255) NOT NULL,
  `iResetPassword` int(11) NOT NULL COMMENT '1 means request for forgotpassword.2 means already changed and 0 is default',
  `iIsRecDeleted` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1 means deleted',
  PRIMARY KEY (`iUsersId`),
  KEY `vUsername` (`vUsername`),
  KEY `vEmail` (`vEmail`),
  KEY `eStatus` (`eStatus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_awards`;
CREATE TABLE `user_awards` (
  `iUserAwardsId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `iFeedImagesId` int(10) unsigned NOT NULL,
  `iFeedOwnerId` int(10) unsigned NOT NULL,
  `eStatus` enum('true','false') NOT NULL DEFAULT 'false',
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iUserAwardsId`),
  KEY `iFeedImagesId` (`iFeedImagesId`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `user_awards_ibfk_2` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_device`;
CREATE TABLE `user_device` (
  `iUserDeviceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `vDeviceToken` varchar(255) NOT NULL,
  `eDeviceType` enum('Ios','Android') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `vAccessToken` varchar(255) NOT NULL,
  `iIsPushNotification` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`iUserDeviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_faq`;
CREATE TABLE `user_faq` (
  `iUserFaqId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iFaqId` int(10) unsigned NOT NULL,
  `iUsersId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`iUserFaqId`),
  KEY `iFaqId` (`iFaqId`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `user_faq_ibfk_3` FOREIGN KEY (`iFaqId`) REFERENCES `faq` (`iFaqId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_faq_ibfk_4` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_feedback`;
CREATE TABLE `user_feedback` (
  `iUserFeedbackId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `fRating` float NOT NULL,
  `eType` enum('recommendations','complaints','appreciate') NOT NULL,
  `vDescription` varchar(255) NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iUserFeedbackId`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `user_feedback_ibfk_1` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `user_feedback` (`iUserFeedbackId`, `iUsersId`, `fRating`, `eType`, `vDescription`, `dAddedDate`, `dModifiedDate`) VALUES
(1,	8,	2,	'recommendations',	'xyz',	'2018-04-24 15:49:32',	'0000-00-00 00:00:00'),
(2,	2,	3.5,	'recommendations',	'Hggggggggggggggggggggggggggggggggggggggggg',	'2018-05-25 00:33:12',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `user_friend`;
CREATE TABLE `user_friend` (
  `iUserFriendId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iSenderId` int(10) unsigned NOT NULL,
  `iReceiverId` int(10) unsigned NOT NULL,
  `eStatus` enum('Pending','Accepted','Rejected') NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iUserFriendId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_media`;
CREATE TABLE `user_media` (
  `iUserMediaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `vweight` varchar(255) NOT NULL,
  `eWeightType` enum('kg','lbs','pound') NOT NULL,
  `iUsersId` int(10) unsigned NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  `eBodyType` enum('','face','back','front','legs','side','torso') NOT NULL,
  `eStatus` enum('publish','share','save') NOT NULL,
  `eImageType` enum('slider','gif','collage','lapse') NOT NULL,
  `eSliderType` enum('before','after') NOT NULL,
  `iSysRecDeleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iUserMediaId`),
  KEY `iUsersId` (`iUsersId`),
  KEY `eBodyType` (`eBodyType`),
  KEY `eWeightType` (`eWeightType`),
  CONSTRAINT `user_media_ibfk_1` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_setting`;
CREATE TABLE `user_setting` (
  `iUserSettingId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `vSettingName` varchar(255) NOT NULL,
  `vValue` varchar(255) NOT NULL,
  `dAddedDate` datetime NOT NULL,
  `dModifiedDate` datetime NOT NULL,
  PRIMARY KEY (`iUserSettingId`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `user_setting_ibfk_1` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `user_super_impose_image`;
CREATE TABLE `user_super_impose_image` (
  `iUserSuperImposeImageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iUsersId` int(10) unsigned NOT NULL,
  `vImage` varchar(255) NOT NULL,
  `vThumbImage` varchar(255) NOT NULL,
  `eBodyType` enum('face','back','front','legs','side','torso') NOT NULL,
  PRIMARY KEY (`iUserSuperImposeImageId`),
  KEY `eBodyType` (`eBodyType`),
  KEY `iUsersId` (`iUsersId`),
  CONSTRAINT `user_super_impose_image_ibfk_4` FOREIGN KEY (`iUsersId`) REFERENCES `users` (`iUsersId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 2018-11-11 05:15:47
