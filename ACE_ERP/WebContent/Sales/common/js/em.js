var gs_daecod = "";	//�������� 
var gs_gubun = "";
var gs_itnbr = "";
var gusrid = "";
var gusrpw = "";
var gusrnm = "";
var gediusr = "";
var gsecurity = "";
var gcurdate = "";
var gautlevel = "";

var gaccess_no =""; //���԰�ȹ No

var gdeptcd = "";  //�μ�
var gdeptnm = "";  //�μ���
var gfdcode = "";  //����
var	gfdname = "";  //������
var	gcocode = "";  //�����
var	gconame = "";  //������

var gs_appdt  = "" ; 

var rDOMAIN = "http://203.242.32.198"; 

 //�����Լ�����
 function fn_Init(){
 //ȭ�� �ʱ�ȭ 
	var vndcd = GetCookie("vusrid");
	
	if (vndcd == null || vndcd == ""){
		SetCookie("vusrid","");
		SetCookie("vusrpw","");
		SetCookie("vusrnm","");
		SetCookie("vediusr","");
		SetCookie("vsecurity","");
		SetCookie("vcurdate","");
		SetCookie("vautlevel","");

		SetCookie("vdeptcd","");
		SetCookie("vdeptnm","");
		SetCookie("vfdcode","");
		SetCookie("vfdname","");
		SetCookie("vcocode","");
		SetCookie("vconame","");
		window.top.location = "Login.html";
	}else{
		fn_Default();
	}
 }
//=================================================================================================
//=================================================================================================
//===== ��¥���� ��� �˾� ���� =====
var __calendarRtn; // return�� ����, ���ڿ��迭(4) { ����, ��, ��, ������ }
function CallCalendar(){ // ����˾� ȣ�� �Լ�
	__calendarRtn = window.showModalDialog("../../common/html/com_calender.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

function CallCalendarII(){ // ����˾� ȣ�� �Լ�2
	__calendarRtn = window.showModalDialog("../html/com_calender.htm","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//===== ��ü�� ��¥���� ����˾����� ���� �� �ֱ� =====
//----- �� ��ü�� �ֱ�
function __GetCallCalendar(objNameHead, objValueProp){
	CallCalendar();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}
}
function CallCalendar1(){ // ����˾� ȣ�� �Լ�
	__calendarRtn = window.showModalDialog("../../Transfer/html/Calendar.html","","dialogWidth:410px;dialogHeight:365px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
}

//===== ��ü�� ��¥���� ����˾����� ���� �� �ֱ� =====
//----- �� ��ü�� �ֱ�
function __GetCallCalendar1(objNameHead, objValueProp){
	CallCalendar1();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		eval( gs_appdt +" = __calendarRtn[4];" );
		 
		__calendarRtn=null;
	}
}

function __GetCallCalendar2(objNameHead, objValueProp,objNameHead1, objValueProp1){
	CallCalendar1();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		eval( objNameHead1+"."+objValueProp1+" = __calendarRtn[4];" );
		 
		 
		__calendarRtn=null;
	}
}

function __GetCallCalendar3(objNameHead, objValueProp){
	CallCalendar();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}

	ln_DataChange(objNameHead.toUpperCase().substring(5,12));
}
function __GetCallCalendar4(objNameHead, objValueProp){
	CallCalendarII();

	if (__calendarRtn!=null && __calendarRtn.length>=4 ){
		eval( objNameHead+"."+objValueProp+" = __calendarRtn[3];" );
		__calendarRtn=null;
	}

	ln_DataChange(objNameHead.toUpperCase().substring(5,12));
}
//=================================================================================================

function get_cookdata()
{
	  gusrid    =  GetCookie("vusrid");
  	gusrpw    =  GetCookie("vusrpw");
	  gusrnm    =  GetCookie("vusrnm");
  	gediusr   =  GetCookie("vediusr");  
  	gsecurity =  GetCookie("vsecurity");  
   	gcurdate  =  GetCookie("vcurdate"); 
   	gautlevel =  GetCookie("vautlevel"); 

		gdeptcd   =  GetCookie("vdeptcd");
		gdeptnm   =  GetCookie("vdeptnm");
		gfdcode   =  GetCookie("vfdcode");
		gfdname   =  GetCookie("vfdname");
		gcocode   =  GetCookie("vcocode");
		gconame   =  GetCookie("vconame");

//alert(gusrid); 
	gJobflag = GetCookie("Jobflag");
}
 function getCookieVal (offset) 
  {
   var endstr = document.cookie.indexOf(";", offset)
   if (endstr == -1)
      endstr = document.cookie.length
   return unescape(document.cookie.substring(offset, endstr))
  }

  function GetCookie (name) 
  {
   var arg = name + "="
   var alen = arg.length
   var clen = document.cookie.length
   var i = 0
  
   while (i < clen) 
    {
     var j = i + alen
     if (document.cookie.substring(i, j) == arg)
        return getCookieVal (j)
     i = document.cookie.indexOf(" ", i) + 1
     if (i == 0) break
    }
    return null
   }

   	function SetCookie (name, value) 
	{
	// ��Ű ������ ���ڿ��� ����� �ݴϴ�.
		var argv = SetCookie.arguments
		var argc = SetCookie.arguments.length
		
		var expires = (2 < argc) ? argv[2] : null
		var path =    (3 < argc) ? argv[3] : null
		var domain = (4 < argc) ? argv[4] : null
		var secure = (5 < argc) ? argv[5] : false
         
		document.cookie = name + "=" + escape (value) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? ";secure" : "")
    }
function gn_connect_info(tbds) {

	  var vusrid =  tbds.NameValue(tbds.RowPosition,'USERID');
  	var vusrpw  = tbds.nameValue(tbds.RowPosition,'PASSWORD');
	  var vusrnm  = tbds.nameValue(tbds.RowPosition,'USERNAME');
	  var vediusr = ""; //tbds.nameValue(tbds.RowPosition,'EDIUSR');
  	var vsecurity = tbds.nameValue(tbds.RowPosition,'SECURITY');
	  var vcurdate  = tbds.nameValue(tbds.RowPosition,'CURDATE');
  	var vautlevel = tbds.nameValue(tbds.RowPosition,'AUTLEVEL');

		var vdeptcd  = tbds.nameValue(tbds.RowPosition,'DEPTCD');
		var vdeptnm  = tbds.nameValue(tbds.RowPosition,'DEPTNM');
		var vfdcode  = tbds.nameValue(tbds.RowPosition,'FDCODE');
		var vfdname  = tbds.nameValue(tbds.RowPosition,'FDNAME');
		var vcocode  = tbds.nameValue(tbds.RowPosition,'COCODE');
		var vconame  = tbds.nameValue(tbds.RowPosition,'CONAME');

 	  SetCookie('vusrid',vusrid);			
  	SetCookie('vusrpw' ,vusrpw);          
	  SetCookie("vusrnm",vusrnm);
  	SetCookie('vediusr' ,vediusr);          
  	SetCookie('vsecurity' ,vsecurity);          
  	SetCookie('vcurdate' ,vcurdate);
  	SetCookie('vautlevel' ,vautlevel);

		SetCookie('vdeptcd',vdeptcd);
		SetCookie('vdeptnm',vdeptnm);
		SetCookie('vfdcode',vfdcode);
		SetCookie('vfdname',vfdname);
		SetCookie('vcocode',vcocode);
		SetCookie('vconame',vconame);

  	tbds.deleterow(tbds.RowPosition);
  	return;
}


// �������� Trim
	function fn_trim(str){
		var index,len;

		while(true){

			index = str.indexOf(" ");
	
			if(index == -1) break
			len = str.length;
			str = str.substring(0, index) + str.substring((index + 1),len)
		}

		return str;
	}
	
/******************************************************************************************
 	Descrition : IE ��ġ�� �߻��ϴ� ���۳�Ʈ ������ ���Ѱ�
******************************************************************************************/
function __ws__(id){
	document.write(id.innerHTML);
	id.id = "";
}

/*########################################################################################
 	2007.11.09 ������ �߰�
########################################################################################*/

/******************************************************************************
	Description : �޺��� ����Ÿ �߰�
	Parameter   : gbn 1-�����߰�,  2- ��ü�߰�
	              gcds - dataSet
								gclx - �޺�
******************************************************************************/
function ln_Insert_Row(gbn,gcds,gclx){
	
	if(gbn==1){
		eval(gcds).insertrow(1);
		eval(gcds).namevalue(1,"COM_CODE") = "";
		eval(gcds).namevalue(1,"COM_SNAME") = "";
		eval(gclx).index = 0;
	}else{
		eval(gcds).insertrow(1);
		eval(gcds).namevalue(1,"COM_CODE") = "";
		eval(gcds).namevalue(1,"COM_SNAME") = "[��ü]";
		eval(gclx).index = 0;
	}
	
}

//########################################################################################
// 	2008.01.28 kbj �߰�	-	������ �ε�� ������ ��ȸ �� ALERT���� ��ȸ�ϱ�
	function gn_LoadComp_NonAlert(e,cnt){
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		document.all.LowerFrame.style.visibility="hidden";
		eval("ft_cnt"+e).innerText = "��ȸ�Ǽ� : " + cnt + " ��";
//		if (cnt <1) alert(gn_Msg(6));
	}	

/*########################################################################################
 	2008.01.10 kbj �߰�	-	fn_replace(asdf, "-", "") => '-'�� ''�� ��ȯ���ִ� �Լ�

function fn_replace(String str, String pattern, String replace) 
        { 
                int s = 0;  
                int e = 0; 
                StringBuffer result = new StringBuffer(); 

                while ((e = str.indexOf(pattern, s)) >= 0)
                { 
                        result.append(str.substring(s, e)); 
                        result.append(replace); 
                        s = e+pattern.length(); 
                } 
                
                result.append(str.substring(s)); 
                return result.toString(); 
        } 
########################################################################################*/