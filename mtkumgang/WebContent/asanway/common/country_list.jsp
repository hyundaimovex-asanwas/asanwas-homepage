<%@ page import="java.util.HashMap" %>
<%
	//����
	HashMap countryList = new HashMap();
		countryList.put("1","����");
		countryList.put("2","����");
		countryList.put("3","���̾Ƴ�");
		countryList.put("4","�����");
		countryList.put("5","���׸���");
		countryList.put("6","�׷�����");
		countryList.put("7","�׷�����");
		countryList.put("8","�׸���");
		countryList.put("9","���");
		countryList.put("10","��Ϻ���");

		countryList.put("11","���̺��");
		countryList.put("12","�����");
		countryList.put("13","����������");
		countryList.put("14","��������ī��ȭ��");
		countryList.put("15","�״�����");
		countryList.put("16","����");
		countryList.put("17","�븣����");
		countryList.put("18","��������");
		countryList.put("19","������");
		countryList.put("20","��ī���");

		countryList.put("21","�븸");
		countryList.put("22","����ũ");
		countryList.put("23","���̴�ī ����");
		countryList.put("24","���̴�ī ��ȭ��");
		countryList.put("25","����");
		countryList.put("26","��Ƽ��");
		countryList.put("27","�����");
		countryList.put("28","���̺�����");
		countryList.put("29","��Ʈ���");
		countryList.put("30","���þ�");

		countryList.put("31","���ٳ�");
		countryList.put("32","������");
		countryList.put("33","�縶�Ͼ�");
		countryList.put("34","����θ�ũ");
		countryList.put("35","���ϴ�");
		countryList.put("36","�����");
		countryList.put("37","�����ƴϾ�");
		countryList.put("38","�����ٽ�Ÿ��");
		countryList.put("39","���ٰ���ī��");
		countryList.put("40","����");

		countryList.put("41","���ɵ��Ͼ�");
		countryList.put("42","������");
		countryList.put("43","�����̽þ�");
		countryList.put("44","����");
		countryList.put("45","�߽���");
		countryList.put("46","����");
		countryList.put("47","�����");
		countryList.put("48","�𸮼Ž�");
		countryList.put("49","��Ÿ��");
		countryList.put("50","�����ũ");

		countryList.put("51","������");
		countryList.put("52","�����");
		countryList.put("53","��Ÿ");
		countryList.put("54","����");
		countryList.put("55","�̱�");
		countryList.put("56","�̾Ḷ");
		countryList.put("57","��ũ�γ׽þ�");
		countryList.put("58","�ٴ�����");
		countryList.put("59","�ٷ���");
		countryList.put("60","�ٺ��̵���");

		countryList.put("61","��Ƽĭ");
		countryList.put("62","���ϸ�");
		countryList.put("63","�߱۶󵥽�");
		countryList.put("64","����");
		countryList.put("65","���׼����� ");
		countryList.put("66","��Ʈ��");
		countryList.put("67","���⿡");
		countryList.put("68","���η��");
		countryList.put("69","������");
		countryList.put("70","�����Ͼ� �츣ü�ں�");

		countryList.put("71","�����ͳ�");
		countryList.put("72","�������");
		countryList.put("73","�η��");
		countryList.put("74","�θ�Ű���ļ�");
		countryList.put("75","��ź");
		countryList.put("76","����");
		countryList.put("77","�Ұ�����");
		countryList.put("78","�����");
		countryList.put("79","��糪��");
		countryList.put("80","����");

		countryList.put("81","����ƶ���");
		countryList.put("82","�긶����");
		countryList.put("83","������ ��������");
		countryList.put("84","���װ�");
		countryList.put("85","������� ���׳ױ׷�");
		countryList.put("86","���̼�");
		countryList.put("87","����Ʈ��þ�");
		countryList.put("88","����Ʈ��Ʈ �׷�����");
		countryList.put("89","����ƮŰ�� �׺�");
		countryList.put("90","�Ҹ�����");

		countryList.put("91","�ַθ�");
		countryList.put("92","����");
		countryList.put("93","������");
		countryList.put("94","������ī");
		countryList.put("95","����������");
		countryList.put("96","������");
		countryList.put("97","������");
		countryList.put("98","����Ʋ����");
		countryList.put("99","������");
		countryList.put("100","���ι�Ű��");

		countryList.put("101","���κ��Ͼ�");
		countryList.put("102","�ø���");
		countryList.put("103","�ÿ��󸮿�");
		countryList.put("104","�̰�����");
		countryList.put("105","�ƶ����̸�Ʈ");
		countryList.put("106","�Ƹ��޴Ͼ�");
		countryList.put("107","�Ƹ���Ƽ��");
		countryList.put("108","���̽�����");
		countryList.put("109","����Ƽ");
		countryList.put("110","���Ϸ���");

		countryList.put("111","������������");
		countryList.put("112","�������Ͻ�ź");
		countryList.put("113","�ȵ���");
		countryList.put("114","�˹ٴϾ�");
		countryList.put("115","������");
		countryList.put("116","�Ӱ��");
		countryList.put("117","��Ƽ���ٺδ�");
		countryList.put("118","����Ʈ����");
		countryList.put("119","������Ͼ�");
		countryList.put("120","���⵵��");

		countryList.put("121","��Ƽ���Ǿ�");
		countryList.put("122","����ٵ���");
		countryList.put("123","����");
		countryList.put("124","����");
		countryList.put("125","����");
		countryList.put("126","����Ʈ���ϸ���");
		countryList.put("127","����Ʈ����");
		countryList.put("128","�µζ�");
		countryList.put("129","�丣��");
		countryList.put("130","�찣��");

		countryList.put("131","������");
		countryList.put("132","���Ű��ź");
		countryList.put("133","��ũ���̳�");
		countryList.put("134","������");
		countryList.put("135","�̶�ũ");
		countryList.put("136","�̶�");
		countryList.put("137","�̽���");
		countryList.put("138","����Ʈ");
		countryList.put("139","��Ż����");
		countryList.put("140","�ε�");

		countryList.put("141","�ε��׽þ�");
		countryList.put("142","�Ϻ�");
		countryList.put("143","�ױ۷���");
		countryList.put("144","�ڸ���ī");
		countryList.put("145","����");
		countryList.put("146","�������");
		countryList.put("147","�߱�");
		countryList.put("148","�߾Ӿ�����ī");
		countryList.put("149","����Ƽ");
		countryList.put("150","���ٺ��");

		countryList.put("151","����");
		countryList.put("152","üþ");
		countryList.put("153","ü��");
		countryList.put("154","ĥ��");
		countryList.put("155","ī�޷�");
		countryList.put("156","ī��������");
		countryList.put("157","ī���彺ź");
		countryList.put("158","īŸ��");
		countryList.put("159","į�����");
		countryList.put("160","ĳ����");

		countryList.put("161","�ɳ�");
		countryList.put("162","�ڸ��");
		countryList.put("163","�ڽ�Ÿ��ī");
		countryList.put("164","��Ʈ�ϺξƸ�");
		countryList.put("165","�ݷҺ��");
		countryList.put("166","���");
		countryList.put("167","��� ���� ��ȭ��");
		countryList.put("168","���");
		countryList.put("169","�����Ʈ");
		countryList.put("170","ũ�ξ�Ƽ��");

		countryList.put("171","Ű���⽺��ź");
		countryList.put("172","Ű���ٽ�");
		countryList.put("173","Ű���ν�");
		countryList.put("174","Ÿ��Ű��ź");
		countryList.put("175","ź�ڴϾ�");
		countryList.put("176","�±�");
		countryList.put("177","��Ű");
		countryList.put("178","���");
		countryList.put("179","�밡");
		countryList.put("180","����ũ�޴Ͻ�ź");

		countryList.put("181","���߷�");
		countryList.put("182","Ƣ����");
		countryList.put("183","Ʈ���ϴٵ� ��ٰ�");
		countryList.put("184","�ĳ���");
		countryList.put("185","�Ķ����");
		countryList.put("186","��Ű��ź");
		countryList.put("187","��Ǫ�ƴ����");
		countryList.put("188","�ȶ��");
		countryList.put("189","�ȷ���Ÿ��");
		countryList.put("190","���");

		countryList.put("191","��������");
		countryList.put("192","������");
		countryList.put("193","������");
		countryList.put("194","����");
		countryList.put("195","�ɶ���");
		countryList.put("196","�ʸ���");
		countryList.put("197","�ѱ�");
		countryList.put("198","�밡��");


	//����
	HashMap jobgroup = new HashMap();
		jobgroup.put("1","�����");
		jobgroup.put("2","��ġ��");
		jobgroup.put("3","������");
		jobgroup.put("4","������");
		jobgroup.put("5","�����");
		jobgroup.put("6","��Ÿ");
%>
