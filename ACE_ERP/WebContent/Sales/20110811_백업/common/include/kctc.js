//****************************************************************************
// ��ư
//****************************************************************************

/* ������ �κ� */
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
 
//****************************************************************************
// TRIM ����
//****************************************************************************
function trim(strSource) {
	re = /^\s+|\s+$/g;
	return strSource.replace(re, '');
}
//�������� �޴� Ŭ���� ���簪�� Ŭ���� �����ؼ� ����ϱ�*******************************************
//��з��޴� Ŭ���� �����ʵ忡 ������
function big_menu(str){
 
parent.parent.hidden.txt_bigid.value = str;
}

//������ Ŭ���� �����ʵ忡 ������
function mid_menu(str){
parent.parent.hidden.txt_pgmid.value = str;
}
//************************************************************************************************
//--------------------------------------------------------------------------
//�α׾ƿ�
//---------------------------------------------------------------------------
function logout(){
out_del();
}

 //�����ʵ尪 Ŭ�����Ű��
function out_del(){
 //�����
 parent.parent.hidden.txt_userid.value = "";
 parent.parent.hidden.txt_userpw.value = "";
 parent.parent.hidden.txt_usernm.value = "";
 //�ý���
 parent.parent.hidden.txt_sysid.value = "";
 parent.parent.hidden.txt_bigid.value = "";
 parent.parent.hidden.txt_midid.value = ""; 
 parent.parent.hidden.txt_pgmid.value = "";
 //����
 parent.parent.hidden.txt_auth_g.value = "";
 parent.parent.hidden.txt_auth_l.value = "";
 parent.parent.hidden.txt_auth_i.value = "";
 parent.parent.hidden.txt_auth_u.value = "";
 parent.parent.hidden.txt_auth_d.value = "";
 parent.parent.hidden.txt_auth_q.value = "";
 parent.parent.hidden.txt_auth_e.value = "";
}
//�α��� ����üũ
function Check_on(sysid,bigid,root,chk_sts) {
	
	var chk_userid = "";
	var chk_auth_g = "";

	    chk_userid = parent.hidden.txt_userid.value;
	       

	if (chk_userid == ""){

		alert("�α��� �� ����� ���ֽ��ϴ�.");
		txt_id.focus();
	}else{
    
		if (chk_sts != "XXXX"){
		
			auth_1.DataID = "http://was.kctc.co.kr/services/servlet/CLSCOM.auth_1?pstr1=" + sysid + "&pstr2=" + chk_userid;
			auth_1.Reset();
			
			chk_auth_g = parent.hidden.txt_auth_g.value; 

				if (chk_auth_g == "")
					{alert("�ý��� �������� �����ϴ�.!!");
				}else{
					parent.hidden.txt_sysid.value = sysid;
					parent.hidden.txt_bigid.value = bigid;
					location.href= "../" + root ;
				}
		}else{
			parent.hidden.txt_sysid.value = sysid;
			parent.hidden.txt_bigid.value = bigid;
			location.href= "../" + root ;
		}
	}
}
//�������ֱ�
function show(id){
	if(ns4)
		document.layers[id].visibility = "show"
	else if (ie4)
		document.all[id].style.visibility = "visible"
}

function hide(id){
	if(ns4)
		document.layers[id].visibility = "hide"
	else if (ie4)
		document.all[id].style.visibility = "hidden"
}
/****************************************************************** 
	* Ư������ ���ڵ�+�ѱۺ�ȯ�Լ� (���ĺ��� ���ڸ� ������ ��� ��)
******************************************************************/ 
	function fn_UrlEncode(han)	{
	var len = han.length ;
	var ret = "" ;

	if( len == 0 ) return ";" ;

	for( i = 0 ; i < len ; i++ )
	{
		ret += han.charCodeAt( i ) ;
		ret += ";" ;
	}

	return ret ;
	}


//**************************************************************************
//DB2�� �ѱ� �ʵ� move���� oeof Check�Ͽ� �ڸ�����ŭ �߶��ֱ�(
//**************************************************************************
	function lfn_UrlEncode(han,slen){ 

	var len = han.length ; 
	var ret = "" ;
	var tlen = 0;
	var tsts="A";
	var rstr="";

	if( len == 0 ) return " " ; 

	for( i = 0 ; i < len ; i++ ) 
	{ 
		if (tlen == slen-3){
			if (tsts == 'H'){
				if (han.charCodeAt( i ) > 12592){
					rstr = rstr + han.substr(i,1);
					return rstr;
				}
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}
			}
		}
		if (tlen == slen-2){
			if (tsts == 'H'){
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}else{
					rstr = rstr + han.substr(i,1)
					return rstr;
				}
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}
			}
		}
		if (tlen == slen-1){
			if (tsts == 'H'){
				return rstr;
			}else{
				if (han.charCodeAt( i ) > 12592){
					return rstr;
				}else{
					rstr = rstr + han.substr(i,1)
					return rstr;
				}
			}
		}		
		if (han.charCodeAt( i ) > 12592){
			if (tsts == 'A'){
			tlen = tlen + 3;
			rstr = rstr + han.substr(i,1);
			tsts="H";
			}else{
			 rstr = rstr + han.substr(i,1);
			 tlen = tlen + 2;
			}
		}else{
			if (tsts == 'H'){
				tlen = tlen + 2;
				rstr = rstr + han.substr(i,1);
				tsts="A";
			}else{
			tlen = tlen +1;
			rstr = rstr + han.substr(i,1);
			}
		}
		
	//ret += han.charCodeAt( i ) ; 
	//ret += ";" ; 
	} 
	return rstr;//ret ; 
	} 

//**************************************************************************
//���������о����
//**************************************************************************
	function fn_Get_Curdate(dat)	{
		var mdate=new Date(); 			

		var year=mdate.getYear(); 
		var day=mdate.getDay(); 
		var month=mdate.getMonth()+1 ;
		if (month<10) 
		month="0"+month; 
		var daym=mdate.getDate();
		if (daym<10) 
		daym="0"+daym;

		var curdate = year+month+daym;
		
		return curdate;
	}
//**************************************************************************
//�ֹι�ȣcheck
//**************************************************************************
function chkjumin(jumin)
{
 var ret = "" ;
 // �ֹι�ȣ�� ���¿� 7��° �ڸ�(����) ��ȿ�� �˻�
 fmt = /^\d{6}[1234]\d{6}$/; 
 if (!fmt.test(jumin))
   {  alert(fmt.test(jumin)); ret="E"; return ret; } 
 
 // ��¥ ��ȿ�� �˻�
  birthYear  = (jumin.charAt(7) <= "2") ? "19" : "20";
  birthYear += jumin.substr(0, 2); 
  birthMonth = jumin.substr(2, 2) - 1;
  birthDate  = jumin.substr(4, 2); 
  birth = new Date(birthYear, birthMonth, birthDate);
 if ( birth.getYear() % 100 != jumin.substr(0, 2) || birth.getMonth() != birthMonth || birth.getDate() != birthDate)
   { ret="E"; return ret; }

 // Check Sum �ڵ��� ��ȿ�� �˻� 
 buf = new Array(13);
 for (i = 0; i < 6; i++) buf[i] = parseInt(resno.charAt(i));
 for (i = 6; i < 13; i++) buf[i] = parseInt(resno.charAt(i));
 multipliers = [2,3,4,5,6,7,8,9,2,3,4,5]; 
 for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]); 
 if ((11 - (sum % 11)) % 10 != buf[12])
  { ret="E"; return ret; }
} 
//////////////////////////////////////////////////
//����üũ ���
// auth_id = 'S' �ý��� ����üũ
// auth_id = 'L' ��з� ����üũ 
// auth_id = 'M' �߸޴� ����üũ
// auth_id = 'P' ������ ����üũ
//////////////////////////////////////////////////
function auth_chk(auth_id){

 

var code1 = "";
var code2 = "";

var authid = auth_id;

if(auth_id == "S" ){
  
	code2 = parent.parent.hidden.txt_userid.value;
    code1 = parent.parent.hidden.txt_sysid.value;
	
	auth_1.DataID = "http://was.kctc.co.kr/services/servlet/CLSCOM.auth_1?pstr1=" + code1 + "&pstr2=" + code2;
	auth_1.Reset();

	chk_auth_g = parent.parent.hidden.txt_auth_g.value;
 
	if (auth_id == chk_auth_g)
	{
	parent.side.location.href="../sidemenu.html";
	}else{
	alert("�ý��ۻ������� �����ϴ�.");
	}

}else if(auth_id == "L"){
	code2 = parent.parent.hidden.txt_userid.value;
    code1 = parent.parent.hidden.txt_bigid.value;
	
	auth_1.DataID = "http://was.kctc.co.kr/services/servlet/CLSCOM.auth_1?pstr1=" + code1 + "&pstr2=" + code2;
	auth_1.Reset();

	chk_auth_g = parent.parent.hidden.txt_auth_g.value;
 
	if (auth_id == chk_auth_g)
	{
	parent.side.location.href="../sidemenu.html";
	}else{
	alert("��з��������� �����ϴ�.");
	}
}else if(auth_id == "M"){
	code2 = parent.parent.hidden.txt_userid.value;
    code1 = parent.parent.hidden.txt_midid.value;
	
	auth_1.DataID = "http://was.kctc.co.kr/services/servlet/CLSCOM.auth_1?pstr1=" + code1 + "&pstr2=" + code2;
	auth_1.Reset();

	chk_auth_g = parent.parent.hidden.txt_auth_g.value;
 
	if (auth_id == chk_auth_g)
	{
	parent.side.location.href="../sidemenu.html";
	}else{
	alert("�޴��������� �����ϴ�.");
	}
}else if(auth_id == "P"){
	code2 = parent.parent.hidden.txt_userid.value;
    code1 = parent.parent.hidden.txt_pgmid.value;
	
	auth_1.DataID = "http://was.kctc.co.kr/services/servlet/CLSCOM.auth_1?pstr1=" + code1 + "&pstr2=" + code2;
	auth_1.Reset();

	chk_auth_g = parent.parent.hidden.txt_auth_g.value;
 
	if (auth_id == chk_auth_g)
	{
	parent.side.location.href="../sidemenu.html";
	}else{
	alert("�������������� �����ϴ�.");
	}
}else{
 
parent.side.location.href="../sidemenu.html";
}


}