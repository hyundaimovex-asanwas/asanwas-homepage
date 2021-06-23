<%@ page import="java.util.HashMap" %>
<%
	//국가
	HashMap countryList = new HashMap();
		countryList.put("1","가나");
		countryList.put("2","가봉");
		countryList.put("3","가이아나");
		countryList.put("4","감비아");
		countryList.put("5","과테말라");
		countryList.put("6","그레나다");
		countryList.put("7","그루지야");
		countryList.put("8","그리스");
		countryList.put("9","기니");
		countryList.put("10","기니비사우");

		countryList.put("11","나미비아");
		countryList.put("12","나우루");
		countryList.put("13","나이지리아");
		countryList.put("14","남아프리카공화국");
		countryList.put("15","네덜란드");
		countryList.put("16","네팔");
		countryList.put("17","노르웨이");
		countryList.put("18","뉴질랜드");
		countryList.put("19","니제르");
		countryList.put("20","니카라과");

		countryList.put("21","대만");
		countryList.put("22","덴마크");
		countryList.put("23","도미니카 연방");
		countryList.put("24","도미니카 공화국");
		countryList.put("25","독일");
		countryList.put("26","동티모르");
		countryList.put("27","라오스");
		countryList.put("28","라이베리아");
		countryList.put("29","라트비아");
		countryList.put("30","러시아");

		countryList.put("31","레바논");
		countryList.put("32","레소토");
		countryList.put("33","루마니아");
		countryList.put("34","룩셈부르크");
		countryList.put("35","르완다");
		countryList.put("36","리비아");
		countryList.put("37","리투아니아");
		countryList.put("38","리히텐슈타인");
		countryList.put("39","마다가스카르");
		countryList.put("40","마셜");

		countryList.put("41","마케도니아");
		countryList.put("42","말라위");
		countryList.put("43","말레이시아");
		countryList.put("44","말리");
		countryList.put("45","멕시코");
		countryList.put("46","모나코");
		countryList.put("47","모로코");
		countryList.put("48","모리셔스");
		countryList.put("49","모리타니");
		countryList.put("50","모잠비크");

		countryList.put("51","몰도바");
		countryList.put("52","몰디브");
		countryList.put("53","몰타");
		countryList.put("54","몽골");
		countryList.put("55","미국");
		countryList.put("56","미얀마");
		countryList.put("57","미크로네시아");
		countryList.put("58","바누아투");
		countryList.put("59","바레인");
		countryList.put("60","바베이도스");

		countryList.put("61","바티칸");
		countryList.put("62","바하마");
		countryList.put("63","발글라데시");
		countryList.put("64","베냉");
		countryList.put("65","베네수엘라 ");
		countryList.put("66","베트남");
		countryList.put("67","벨기에");
		countryList.put("68","벨로루시");
		countryList.put("69","벨리즈");
		countryList.put("70","보스니아 헤르체코비나");

		countryList.put("71","보츠와나");
		countryList.put("72","볼리비아");
		countryList.put("73","부룬디");
		countryList.put("74","부르키나파소");
		countryList.put("75","부탄");
		countryList.put("76","북한");
		countryList.put("77","불가리아");
		countryList.put("78","브라질");
		countryList.put("79","브루나이");
		countryList.put("80","사모아");

		countryList.put("81","사우디아라비아");
		countryList.put("82","산마리노");
		countryList.put("83","상투데 프린시페");
		countryList.put("84","세네갈");
		countryList.put("85","세르비아 몬테네그로");
		countryList.put("86","세이셸");
		countryList.put("87","세인트루시아");
		countryList.put("88","세인트빈센트 그레나딘");
		countryList.put("89","세인트키츠 네비스");
		countryList.put("90","소말리아");

		countryList.put("91","솔로몬");
		countryList.put("92","수단");
		countryList.put("93","수리남");
		countryList.put("94","스리랑카");
		countryList.put("95","스와질란드");
		countryList.put("96","스웨덴");
		countryList.put("97","스위스");
		countryList.put("98","스코틀랜드");
		countryList.put("99","스페인");
		countryList.put("100","슬로바키아");

		countryList.put("101","슬로베니아");
		countryList.put("102","시리아");
		countryList.put("103","시에라리온");
		countryList.put("104","싱가포르");
		countryList.put("105","아랍에미리트");
		countryList.put("106","아르메니아");
		countryList.put("107","아르헨티나");
		countryList.put("108","아이슬란드");
		countryList.put("109","아이티");
		countryList.put("110","아일랜드");

		countryList.put("111","아제르바이잔");
		countryList.put("112","아프가니스탄");
		countryList.put("113","안도라");
		countryList.put("114","알바니아");
		countryList.put("115","알제리");
		countryList.put("116","앙골라");
		countryList.put("117","앤티가바부다");
		countryList.put("118","에리트레아");
		countryList.put("119","에스토니아");
		countryList.put("120","에콰도르");

		countryList.put("121","에티오피아");
		countryList.put("122","엘살바도르");
		countryList.put("123","영국");
		countryList.put("124","예멘");
		countryList.put("125","오만");
		countryList.put("126","오스트레일리아");
		countryList.put("127","오스트리아");
		countryList.put("128","온두라스");
		countryList.put("129","요르단");
		countryList.put("130","우간다");

		countryList.put("131","우루과이");
		countryList.put("132","우즈베키스탄");
		countryList.put("133","우크라이나");
		countryList.put("134","웨일즈");
		countryList.put("135","이라크");
		countryList.put("136","이란");
		countryList.put("137","이스라엘");
		countryList.put("138","이집트");
		countryList.put("139","이탈리아");
		countryList.put("140","인도");

		countryList.put("141","인도네시아");
		countryList.put("142","일본");
		countryList.put("143","잉글랜드");
		countryList.put("144","자메이카");
		countryList.put("145","잠비아");
		countryList.put("146","적도기니");
		countryList.put("147","중국");
		countryList.put("148","중앙아프리카");
		countryList.put("149","지부티");
		countryList.put("150","짐바브웨");

		countryList.put("151","차드");
		countryList.put("152","체첸");
		countryList.put("153","체코");
		countryList.put("154","칠레");
		countryList.put("155","카메룬");
		countryList.put("156","카보베르데");
		countryList.put("157","카자흐스탄");
		countryList.put("158","카타르");
		countryList.put("159","캄보디아");
		countryList.put("160","캐나다");

		countryList.put("161","케냐");
		countryList.put("162","코모로");
		countryList.put("163","코스타리카");
		countryList.put("164","코트니부아르");
		countryList.put("165","콜롬비아");
		countryList.put("166","콩고");
		countryList.put("167","콩고 민주 공화국");
		countryList.put("168","쿠바");
		countryList.put("169","쿠웨이트");
		countryList.put("170","크로아티아");

		countryList.put("171","키르기스스탄");
		countryList.put("172","키리바시");
		countryList.put("173","키프로스");
		countryList.put("174","타자키스탄");
		countryList.put("175","탄자니아");
		countryList.put("176","태국");
		countryList.put("177","터키");
		countryList.put("178","토고");
		countryList.put("179","통가");
		countryList.put("180","투르크메니스탄");

		countryList.put("181","투발루");
		countryList.put("182","튀니지");
		countryList.put("183","트리니다드 토바고");
		countryList.put("184","파나마");
		countryList.put("185","파라과이");
		countryList.put("186","파키스탄");
		countryList.put("187","파푸아뉴기니");
		countryList.put("188","팔라우");
		countryList.put("189","팔레스타인");
		countryList.put("190","페루");

		countryList.put("191","포르투갈");
		countryList.put("192","폴란드");
		countryList.put("193","프랑스");
		countryList.put("194","피지");
		countryList.put("195","핀란드");
		countryList.put("196","필리핀");
		countryList.put("197","한국");
		countryList.put("198","헝가리");


	//직군
	HashMap jobgroup = new HashMap();
		jobgroup.put("1","기업인");
		jobgroup.put("2","정치인");
		jobgroup.put("3","공무원");
		jobgroup.put("4","법조인");
		jobgroup.put("5","언론인");
		jobgroup.put("6","기타");
%>
