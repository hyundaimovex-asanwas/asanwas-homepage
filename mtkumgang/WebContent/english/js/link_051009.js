	
var root	= "";


var page_0_0_0=root+"/";//index

var page_0_1_0=root+"#";//�α���
var page_0_1_1=root+"#";//�α׾ƿ�
var page_0_2_0=root+"#";//ȸ������
var page_0_3_0=root+"#";//����Ʈ��
var page_0_4_0=root+"#";//English

var page_0_5_0=root+"javascript:winopen();";//�����ϱ�


var page_1_0_0=root+"/company/sub_company.jsp";//ȸ��Ұ�
var page_1_1_0=root+"/company/overview.jsp";//ȸ��Ұ�>����
var page_1_2_0=root+"/company/history.jsp";//ȸ��Ұ�>����
var page_1_3_0=root+"/company/ceo01.jsp";//ȸ��Ұ�>CEO
var page_1_3_1=root+"/company/ceo01.jsp";//ȸ��Ұ�>CEO01
var page_1_3_2=root+"/company/ceo02.jsp";//ȸ��Ұ�>CEO02
var page_1_3_3=root+"/company/ceo03.jsp";//ȸ��Ұ�>CEO03
var page_1_3_4=root+"javascript:openCEO();";//ȸ��Ұ�>CEO04
var page_1_3_5=root+"#";//ȸ��Ұ�>CEO05
var page_1_4_0=root+"/company/business01.jsp";//ȸ��Ұ�>�濵��Ȳ
var page_1_4_1=root+"/company/business0201.jsp";//ȸ��Ұ�>�濵��Ȳ01
var page_1_4_2=root+"/company/business0202.jsp";//ȸ��Ұ�>�濵��Ȳ02
var page_1_5_0=root+"/company/good.jsp";//ȸ��Ұ�>�����
var page_1_6_0=root+"#";//ȸ��Ұ�>ä��
var page_1_6_1=root+"#";//ȸ��Ұ�>ä��>ä������ �ȳ�
var page_1_6_2=root+"#";//ȸ��Ұ�>ä��>�λ�����
var page_1_6_3=root+"#";//ȸ��Ұ�>ä��>��������
var page_1_6_4=root+"#";//ȸ��Ұ�>ä��>�����Ļ�����
var page_1_6_5=root+"#";//ȸ��Ұ�>ä��>ä��Q&A
var page_1_7_0=root+"/company/org.jsp";//ȸ��Ұ�>������
var page_1_8_0=root+"/company/ci01.jsp";//ȸ��Ұ�>CI
var page_1_8_1=root+"/company/ci01.jsp";//ȸ��Ұ�>CI01
var page_1_8_2=root+"/company/bi01.jsp";//ȸ��Ұ�>CI02
var page_1_9_0=root+"/company/map01.jsp";//ȸ��Ұ�>�������ġ


var page_2_0_0=root+"#";//�������
var page_2_1_0=root+"#";//�������
var page_2_2_0=root+"#";//�������
var page_2_3_0=root+"#";//�������
var page_2_4_0=root+"#";//�������
var page_2_5_0=root+"#";//�������
var page_2_6_0=root+"#";//�������
var page_2_7_0=root+"#";//�������
var page_2_8_0=root+"#";//�������


var page_3_0_0=root+"#";//��������
var page_3_1_0=root+"#";//��������
var page_3_2_0=root+"#";//��������
var page_3_3_0=root+"#";//��������
var page_3_4_0=root+"#";//��������
var page_3_5_0=root+"#";//��������
var page_3_6_0=root+"#";//��������
var page_3_7_0=root+"#";//��������
var page_3_8_0=root+"#";//��������


var page_4_0_0=root+"#";//�Ǽ����
var page_4_1_0=root+"#";//�Ǽ����
var page_4_2_0=root+"#";//�Ǽ����
var page_4_3_0=root+"#";//�Ǽ����
var page_4_4_0=root+"#";//�Ǽ����
var page_4_5_0=root+"#";//�Ǽ����


var page_5_0_0=root+"#";//��Ÿ���
var page_5_1_0=root+"#";//��Ÿ���
var page_5_2_0=root+"#";//��Ÿ���
var page_5_3_0=root+"#";//��Ÿ���
var page_5_4_0=root+"#";//��Ÿ���
var page_5_5_0=root+"#";//��Ÿ���
var page_5_6_0=root+"#";//��Ÿ���
var page_5_7_0=root+"#";//��Ÿ���
var page_5_8_0=root+"#";//��Ÿ���


var page_6_0_0=root+"#";//���̹�ȫ����
var page_6_1_0=root+"#";//���̹�ȫ����
var page_6_2_0=root+"#";//���̹�ȫ����
var page_6_3_0=root+"#";//���̹�ȫ����
var page_6_4_0=root+"#";//���̹�ȫ����
var page_6_5_0=root+"#";//���̹�ȫ����
var page_6_6_0=root+"#";//���̹�ȫ����
var page_6_7_0=root+"#";//���̹�ȫ����
var page_6_8_0=root+"#";//���̹�ȫ����


var page_7_0_0=root+"#";//������
var page_7_1_0=root+"#";//������
var page_7_2_0=root+"#";//������
var page_7_3_0=root+"#";//������
var page_7_4_0=root+"#";//������



function pageURL(a, b, c)
{
	var page = "page_" + a +"_"+ b +"_"+ c ;
	/*
	if( ( a == 0 && ( b == 1 || b == 2 || b == 3 || b == 4 || b == 5 ) ) || ( a == 2 ) || ( a == 3 ) || ( a == 4 ) || ( a == 5 ) || ( a == 6 ) ) {
		alert("���� �غ� ���Դϴ�.");
	}*/

	if(eval(page) == "#") {
		alert("���� �غ� ���Դϴ�.");
	}
	else{
		location.href=eval(page);
	}
}


// ��ġ
function search(str)
{
	alert("���� �غ� ���Դϴ�.");
	//var page = ""+str ;
	//location.href=eval(page);
}


function winopen()
{
	window.open("http://www.mtkumgang.com/");
}


function openCEO() { //--CEO���� ����--
  sw = screen.width;  // to center: use desired width
  sh = screen.height;  // to center: use desired height
  cx = (sw-700) * 0.5  // to center: (.5*sw) - (w*.5)
  cy = (sh-450) * 0.5  // to center: (.5*sh) - (h*.5)
  window.open('http://old.hdasan.com/brdFrame_CEO.htm','winCEO','left='+cx+',top='+cy+',width=700,height=450,fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0');
 }

