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

//var rDOMAIN = "http://www.singiro.co.kr";   //�׽�Ʈ ������URL
var rDOMAIN = "http://203.242.32.198";   //����ƻ� ������URL
var g_servlet ="/services/servlet";

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
function is_null(item){
	if(item == "" || item ==null || item == 'undefined')
		return true;
	else
		return false;
}
//=================================================================================================
//=================================================================================================
//===== ��¥���� ��� �˾� ���� =====
var __calendarRtn; // return�� ����, ���ڿ��迭(4) { ����, ��, ��, ������ }

function CallCalendar(){ // ����˾� ȣ�� �Լ�
	__calendarRtn = window.showModalDialog("../../Transfer/jsp/com_calender.jsp","","dialogWidth:180px;dialogHeight:230px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
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
	__calendarRtn = window.showModalDialog("../../Transfer/jsp/Calendar.jsp","","dialogWidth:410px;dialogHeight:365px;scroll:no;status:no;titlebar:no;center:yes;help:yes;");
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

function Reset_Cnt() 
    {
		var myday = new Date()
		var sms = 0
		SetCookie("sms", sms, myday , "/", null, false)
		location.reload()
	}

	function fn_ChkButton(cQ,cI,cS,cD,cC,cE,cEx,cPr,cDe){
	//���ϼ����� �����Ѵ�
		if(cQ == "T"){
			btn_Query.disabled = true;
			btn_Query.src = "../imgdat/btn/b_query_x.gif";
			btn_Query.style.cursor = "default";
		}else{
			btn_Query.disabled = false;
			btn_Query.src = "../imgdat/btn/b_query.gif";
			btn_Query.style.cursor = "hand";
		}
		if(cI == "T"){
			btn_Insert.disabled = true;
			btn_Insert.src = "../imgdat/btn/b_insert_x.gif";
			btn_Insert.style.cursor = "default";
		}else{
			btn_Insert.disabled = false;
			btn_Insert.src = "../imgdat/btn/b_insert.gif";
			btn_Insert.style.cursor = "hand";
		}
		if(cS == "T"){
			btn_Save.disabled = true;
			btn_Save.src = "../imgdat/btn/b_save_x.gif";
			btn_Save.style.cursor = "default";	
		}else{
			btn_Save.disabled = false;
			btn_Save.src = "../imgdat/btn/b_save.gif";
			btn_Save.style.cursor = "hand";
		}
		if(cD == "T"){
			btn_Delete.disabled = true;
			btn_Delete.src = "../imgdat/btn/b_delete_x.gif";
			btn_Delete.style.cursor = "default";
		}else{
			btn_Delete.disabled = false;
			btn_Delete.src = "../imgdat/btn/b_delete.gif";
			btn_Delete.style.cursor = "hand";
		}
		if(cC == "T"){
			btn_Cancel.disabled = true;
			btn_Cancel.src = "../imgdat/btn/b_cancel_x.gif";
			btn_Cancel.style.cursor = "default";
		}else{
			btn_Cancel.disabled = false;
			btn_Cancel.src = "../imgdat/btn/b_cancel.gif";
			btn_Cancel.style.cursor = "hand";
		}
		if(cE == "T"){
			btn_Exit.disabled = true;
			btn_Exit.src = "../imgdat/btn/b_exit_x.gif";
			btn_Exit.style.cursor = "default";
		}else{
			btn_Exit.disabled = false;
			btn_Exit.src = "../imgdat/btn/b_exit.gif";
			btn_Exit.style.cursor = "hand";
		}
		if(cEx == "T"){
			btn_Excel.disabled = true;
			btn_Excel.src = "../imgdat/btn/b_excel_x.gif";	
			btn_Excel.style.cursor = "default";
		}else{
			btn_Excel.disabled = false;
			btn_Excel.src = "../imgdat/btn/b_excel.gif";
			btn_Excel.style.cursor = "hand";
		}
		if(cPr == "T"){
			btn_Print.disabled = true;
			btn_Print.src = "../imgdat/btn/b_print_x.gif";
			btn_Print.style.cursor = "default";
		}else{
			btn_Print.disabled = false;
			btn_Print.src = "../imgdat/btn/b_print.gif";
			btn_Print.style.cursor = "hand";
		}
		if(cDe == "T"){
			btn_Detail.disabled = true;
			btn_Detail.src = "../imgdat/btn/b_detail_x.gif";
			btn_Detail.style.cursor = "default";
		}else{
			btn_Detail.disabled = false;
			btn_Detail.src = "../imgdat/btn/b_detail.gif";
			btn_Detail.style.cursor = "hand";
		}
	}

	function fn_UrlEncode(han)	{
	//�ѱۺ�ȯ�Լ�
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

	 function fn_HideStatus(){ 
	//status�� ������ ǥ������ �ʴ´�
		  window.status="";
		  return true 
	} 
	
	function fn_Get_Curdate(dat)	{
	//���������о����
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
	
	function fn_BtnCont(btn_nam,btn_val){
		//�̹��������� ����� �����Ѵ�.
		if(btn_val == true){
			btn_nam.disabled = false;
			btn_nam.style.cursor = "hand";
		}else{
			btn_nam.disabled = true;
			btn_nam.style.cursor = "default";
		}
	}

	function fRtrim(pStr){
		//������������
		var tLen = 0;
		var i = 0;
		 
		if(pStr == '' || pStr == null) return '';

		i = pStr.length-1;
		while(1){
			tLen = i + 1;
			
			if(pStr.substring(i,tLen) == ' '){
				i--;
				if(i<0) return '';
			}else{
				return pStr.substring(0,tLen);
			}
		}
	}

	function fn_GridSort(dts_Code,row,colid,mySort){
		//�׸������ Ŭ���� ����
		if(row > 0) return;

		if(mySort == null || mySort == ""){
			var expr = dts_Code.SortExpr;
			if(expr == null || expr == ""){
				expr = "+";
			}else{
				expr = expr.substring(0,1);
				switch (expr){
					case '-':
						expr = "+";
						break;
					default :
						expr = "-";
				}
			}
			dts_Code.SortExpr = expr + colid;
		}else{
			dts_Code.SortExpr = mySort;
		}
		dts_Code.Sort();
		dts_Code.RowPosition = 1;
	}

	function fn_ComboAdd(dts_Code,cbo_Tmp,colCod,colNam){
		//�ڵ��޺��� ����Ʈ�� ä���
			cbo_Tmp.Data = "";

			document.body.style.cursor = "wait";	//�𷡽ð�
			dts_Code.Reset();
			
			var strCod = "";
			
			if(dts_Code.CountRow > 0){
				for (var i=1;i<=dts_Code.CountRow;i++){
					var col1=dts_Code.ColumnIndex(colCod);
					var col2=dts_Code.ColumnIndex(colNam);
					
					strCod = strCod 
						      +dts_Code.NameValue(i,colCod)+"^"
					          +dts_Code.NameValue(i,colNam)+","
				}
				cbo_Tmp.Data = strCod;
				//cbo_Tmp.Index="0";
			}
			document.body.style.cursor = "default";	//�⺻(ȭ��ǥ) 
	}

	function fn_FindDoNong(pVndcd)
	{
		//����ȸã��
		var result="";
		var code = pVndcd.substring(0,1);
		
		switch (code)
		{
		case '1':
			result = "120007";
			break;
		case '2':
			result = "225003";
			break;
		case '3':
			result = "399917";
			break;
		case '4':
			result = "410007";
			break;
		case '5':
			result = "510008";
			break;
		case '6':
			result = "610009";
			break;
		case '7':
			result = "710033";
			break;
		case '8':
			result = "810001";
			break;
		case '9':
			result = "910002";
			break;
		}
		return result;

	}

	function fn_Fit0020(){
	//������Ȳ
		var result = new Array();
		result = window.showModalDialog('/services/prjsvr/fi/fit0020S.html',"","dialogWidth:872px; dialogHeight:600px;center:yes;status:no");
	}

	function fn_FindManoItem(pMano,pItnbr,pItdsc)
	{
		//������ȣ,ǰ��ã�� ����ó��
		var result = new Array();
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");

		paramList[0] = pMano;
		paramList[1] = pItnbr;
		paramList[2] = pItdsc;
		paramList[3] = tdaecod;
		result = window.showModalDialog('/services/prjsvr/common/PitnbrFind.html',paramList,"dialogWidth:668px; dialogHeight:658px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		
		return result;
	}

	function fn_FindJaepum(pMano,pItnbr,pItdsc)
	{
		//��ǰã��
		var result = "";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");

		paramList[0] = pMano;
		paramList[1] = pItnbr;
		paramList[2] = pItdsc;
		paramList[3] = tdaecod;
		result = window.showModalDialog('/services/prjsvr/common/Pcatalog.html',paramList,"dialogWidth:675px; dialogHeight:665px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}
	
	function fn_FindCtmtbl(pName,pJuno,pGubun){
			//��ã��
			var result = "";
		
			var paramList = new Array();
			var tdaecod = GetCookie("VNDCD");
		
			paramList[0] = pName;
			paramList[1] = pJuno;
			paramList[2] = tdaecod;
			paramList[3] = pGubun;
			
			txt_msg.value = "���� ��ȸ�մϴ�.";
			result = window.showModalDialog('/services/prjsvr/common/Pctmtbl.html',paramList,"dialogWidth:600px; dialogHeight:580px;center:yes;status:no");
			
			txt_msg.value = "";

			if (result == -1 || result == null || result == "")	return null;
			return result;
	}

	function fn_FindVehtbl(pGubun,pCode)
	{
		//�������ã��
		var result ="";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");
		
		paramList[0] = pGubun;
		paramList[1] = pCode;
		paramList[2] = tdaecod;
		result = window.showModalDialog('/services/prjsvr/common/Pvehtbl.html',paramList,"dialogWidth:441px; dialogHeight:440px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}
	function fn_Ctmtbl() {
	//�����
		var result ="";
		var paramList = new Array();
		var tdaecod = GetCookie("VNDCD");
		
		paramList[0] = "1";//pGubun;
		paramList[1] = "";//pCode;
		paramList[2] = "";//tdaecod;
		paramList[3] = "";	
		result = window.showModalDialog('/services/prjsvr/cm/cmt0010s.html',paramList,"dialogWidth:875px; dialogHeight:570px;center:yes;status:no");
		
		if (result == -1 || result == null || result == "")	return null;
		return result;
	}

	//��¥check
	function gn_ArrayOfDay(l_sLeapYear) 
	{ 
	   this[0]=0;  // <- �ƹ��� �ǹ̰� ���� ����. �����ص� ����. 
	   this[1]=31; 
	   this[2]=28; 
	   if (l_sLeapYear) // ������ �ƴϸ�... 
		   this[2]=29; 
	   this[3]=31; 
	   this[4]=30; 
	   this[5]=31; 
	   this[6]=30; 
	   this[7]=31; 
	   this[8]=31; 
	   this[9]=30; 
	   this[10]=31; 
	   this[11]=30; 
	   this[12]=31; 
	} 

	function gv_date_check(l_sDate) // "19991231" �̷� ����`���� �ݵ�� �Ѱ��ٰ� 
	{                             // "1999/12/31" �̷� ������ ���� �ȵ�   
	   if (l_sDate == "" || l_sDate == null ) return false; 

	   if (l_sDate.length != 8) // ó���� �ڸ������� Check �Ѵ�. 
	   {           
		  return false; 
	   } 

	   /************************************************* 
		* text Box �� �Էµ� �ڷ� Check 
		*************************************************/         
	   var l_iYear  = parseInt(l_sDate.substring(0,4), 10);       
	   var l_iMonth = parseInt(l_sDate.substring(4,6), 10); 
	   var l_iDay   = parseInt(l_sDate.substring(6,8), 10);     
	   
	   
	   /****************************************************************** 
		* ���� Check! 
		******************************************************************/ 
	   var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0)); 
	   var monthDays  = new gn_ArrayOfDay(l_sLeapYear); 

	   if (l_iYear < 1900) 
	   { 
				 return false; 
	   } 
	   else if (l_iMonth > 12) // �޼��� 12�� ���� ũ��... 
	   {             
				  return false; 
	   } 
	   else if((parseInt(l_iDay) < 1) || (l_iDay > monthDays[l_iMonth])) // �� ���� ������ �� ���� ũ�ٸ�... 
	   {   
				  return false; 
	   } 
	   
	   return true; 
	}
	//Zero Charter Insert "0"
	function charAddZ(chr,maxlen){

		if(chr == null && chr.length ==0) return;

			var str="";		
			var  len=chr.length;	
			for( j=0; j<maxlen-len;j++)
			{
					str=str+"0";	
			}

			return str+chr;
	}

	//Space Charter Insert " "
	function charAddS(chr,maxlen){

		//if(chr == null && chr.length ==0) return;

			var str="";		
			var  len=chr.length;
			
			for( j=0; j<maxlen-len;j++)
			{
					str=str+" ";	
			}

			return chr+str;
	}
	//DB2�� �ѱ� �ʵ� move���� oeof Check�Ͽ� �ڸ�����ŭ �߶��ֱ�(
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


//****************************************************************************
// �������ϱ�
//****************************************************************************
function gn_getbyymm(v_yyyymm) {
	ls_yy = Mid(v_yyyymm,1,4);
	ls_mon = Mid(v_yyyymm,5,2);
	if (ls_mon == '01') {
		ls_bef_yyyymm = (parseInt(ls_yy,10)-1)+'12'
		
	}	
	else {

		if ((parseInt(ls_mon-1,10)) < 10 ) {
			ls_bef_yyyymm = ls_yy+'0'+ parseInt(ls_mon-1,10);
		}	
		else {
			ls_bef_yyyymm = ls_yy+ parseInt(ls_mon-1,10);
		}	
	}
	return(ls_bef_yyyymm);
}	


/******************************************************************************************
	Descrition : �Է°� üũ (db2 �Է½� �Է°� 2byte ��ȯ�� �ڸ��� üũ)
******************************************************************************************/
function bytelength(fe,bstr,mx) { 
	var xx = "";
	var yy = "";
	var len = bstr.length; 

	for (var i=0; i<bstr.length; i++) {
		xx = bstr.substr(i,1).charCodeAt(0); 
		if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0); 

		if (i==0) {
			if (xx>127) {	len++;len++; }
		} else {
			if (yy!="") {
				if (yy>127) { len++; } 
				else { if (xx>127) { len++;len++; } }
			}
		}
	} 

	if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;

	// Ŭ��� �޽��� �Ѹ��� 
	if (mx < len){ 
		alert('�Է��� ���� �� �߸��� �ֽ��ϴ�.\n�ٽ� �Է��Ͽ� �ֽʽÿ�'); 
		fe.focus(); 
		fe.select(); 
	} 

	return len; 
}


/******************************************************************************************
	Descrition : �μ���ȸ��  Level�� ���� Treecd ��ȯ
******************************************************************************************/
function fn_treecd(level,treecd) {

	var result="";

	switch (level)
	{
	case '1':
		result =treecd.substring(0,4);  
		break;
	case '2':
		result = treecd.substring(0,4);
		break;
	case '3':
		result = treecd.substring(0,6);
		break;
	case '4':
		result = treecd.substring(0,8);
		break;	
	}
	return result;
}

/******************************************************************************************
/*	Descrition : ȸ������� �ű� �Լ� 
/*             : �Լ��� gf_�Լ��� ( �Լ��� ù�ڸ��� �빮��)
******************************************************************************************/

/******************************************************************************************
	Descrition : �ֹι�ȣ üũ
	parameter  : �ֹι�ȣ
	retun      : true - ���� , false - �Ұ���
******************************************************************************************/
function gf_Resino(p) {

	var int_val=0;
	var s_chkval = "234567892345";
	var int_result="";

	for (i=0;i< 12;i++){
		int_val = int_val + parseInt(p.substring(i,i+1)) * parseInt(s_chkval.substring(i,i+1));
	}
  
	int_result = 11 - parseInt((int_val%11))
	if (int_result == parseInt(p.substring(12,13))){
		return true;
	}else {
		alert("�ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�.");
		return false;
	}
}

/******************************************************************************************
	Descrition : ����ڹ�ȣ üũ
	parameter  : ����ڹ�ȣ
	retun      : true - ���� , false - �Ұ���
******************************************************************************************/
function gf_Wkresino(p) {
	
	var int_val=0;
  var int_getpam =new Array(10);
	var int_chkval =new Array("1","3","7","1","3","7","1","3","5");
	var int_result=0;
	var int_chk=0;

	for (i=0;i<10;i++){int_getpam[i]= p.substring(i,i+1);} 
  for (j=0;j<9;j++){ int_val += int_getpam[j]*int_chkval[j];} 

	int_val=int_val + Math.floor((int_getpam[8]*5)/10);
  int_result = int_val%10; 

	if(int_result==0){ int_chk = 0;}
	else{ int_chk = 10 - int_result;}

	if(int_chk!= int_getpam[9]){
		alert("����ڵ�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�.");
		return false;
	}else{
		return true;
	}
}

/******************************************************************************
	Description : ���ʿ��� ���� �����ϱ�
******************************************************************************/
function gn_Replace(str, ws) {
	var retStr 	= '';
	var ch		= '';
	
	if (str == '' || str == null)
		return '';

	for (z=0; z < str.length; z++) {
		ch = str.charAt(z);
		if (ch != ws) {
			retStr += ch;
		}
	}

	return retStr;
}



/******************************************************************************************
	Descrition : �α��ν� �ش�μ��� ��ü ���ð�����.
	parameter  : �μ��ڵ�
	retun      : true - ���� , false - �Ұ���
	             gcds_name - dataset ��
******************************************************************************************/
function gf_Dept_Enable(p, gcds_name){
	gcds_name.DataID = g_servlet+"/Account.commdtil_s1?v_str1=2139"
																										+"&v_str2="+p
	                                                  +"&v_str3=";

 // prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			

	if(gcds_name.countrow>0){
		return true;
  }else { 
		return false;
	}
}


/******************************************************************************************
 	Descrition : �ܾױݾ� ����
	             �ϰ�ǥ/����ǥ/�հ��ܾ׽û�ǥ ���� ��ȸ�Ҷ�  
							 �Ϻ��հ��ܾ�, �Ϻ������׸�����, �����հ��ܾ�, ���������׸����� ���̺��� �ܾ׿�
							 ���ο� �ݾ��� �����ϸ� �������� ���� �� �߰��ϴ�  �ϰ� ���μ���
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_Up_Atcode_Create(){

  //����Ÿ�¼���
	//����Ÿ�»���
	//Addrow

	//tr

	//����Ÿ�� Delete
}


/******************************************************************************************
 	Descrition : ���� Sting�� �޸����
	parameter  : 
	retun      : 
******************************************************************************************/
function gf_setnum(src){ 
	
	var len	= 0;
	var comma = 0;
	var buf  = "";
	var dest = "";
	
	buf = "" + src + "";
	len = buf.length;
	
	for(i = 3; i < len; i+=3) {
		if((i < len) || (len < (i+4)))	comma++;
	}
	
	for(i = 0; i < len; i++) {
		if(i == (len - (3 * comma))) {
			dest += ",";
			dest += buf.charAt(i);
			comma--;
		}
		else {
			dest += buf.charAt(i);
		}
	}

	if (dest.substring(0,1)=="-") {
		if (dest.substring(1,2)==",") {
			dest = dest.substring(0,1) + dest.substring(2,dest.length);
		}
	}

	return dest;
}



/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ��� �迭�� ���
	parameter  : gcds_name      //����Ÿ�¸� 
	             fdcode    //�����ڵ�
							 actyymm   //ȸ����
							 atcode    //�����ڵ�
							 cocode    //�����
							 divcd     //����
							 temp      //����
	retun      : 
******************************************************************************************/
function gf_array_val2(gcds_name,fdcode, actyymm, cocode, divcd, temp){ 

  //alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	arrcode[0]="";

 // (1117000)+(1111400)                19��
	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
			if(cnt1==0)strData="";
      strData += temp.charAt(i);
			arrcode[cnt]=strData;          //(11
			
			if (cnt1==6) {
				gf_format_val(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd);
				arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");

				if(arrcode[cnt]==undefined){
					arrcode[cnt]=0;
				}
				//alert("arrcode[cnt]"+arrcode[cnt])
				//alert(gcds_name.namevalue(1,"TOTALVAL"));
				arrcode[cnt] = Math.floor(arrcode[cnt]);
				cnt1=0;
				cnt+=1;
				strData=""
			}else{
				cnt1+=1 ;
			}
		}else{                         //Ư������
	      strData="";
				strData = temp.charAt(i);  //()
        arrcode[cnt] =strData;     //(
				cnt1=0;
				cnt+=1;
		}
	}//for

	for(j=0;j<arrcode.length;j++){
    result+=arrcode[j];

	 // alert(result);
  }

	if(temp.length>=8){
		
		gf_cal_val(gcds_name2,result);
  }else{
		gcds_name2.ClearAll();
		var s_temp = "TOTALVALUE:STRING"
		gcds_name2.SetDataHeader(s_temp);
		gcds_name2.addrow();
    gcds_name2.namevalue(1,"TOTALVALUE")=result;
	}

}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ��� �迭�� ���
	parameter  : gcds_name      //����Ÿ�¸� 
	             fdcode    //�����ڵ�
							 actyymm   //ȸ����(to_
							 atcode    //�����ڵ�
							 cocode    //�����
							 divcd     //����
							 temp      //����
							 actyymmfr   //ȸ����(from
	retun      : 
******************************************************************************************/
function gf_array_val(gcds_name,fdcode, actyymm, cocode, divcd, temp,actyymmfr){ 

  //alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	var tempval=0;
	var totval=0;
	var miplus="+";
	arrcode[0]="";

 // alert("����"+temp);
	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
       miplus="";
    }else if( temp.charAt(i)=="+"){
       miplus="+";
			 cnt1=0;
		}else if(temp.charAt(i)=="-"){
       miplus="-";
       cnt1=0;
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
			if(cnt1==0)strData="";
      strData += temp.charAt(i);
			arrcode[cnt]=strData;          //(11
			
			if (cnt1==6) {
				gf_format_val(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd,actyymmfr);
				arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");
				if(arrcode[cnt]==undefined){
					arrcode[cnt]=0;
				}
				//alert("arrcode[cnt]"+arrcode[cnt]);
				//alert("tot"+totval);

				tempval = arrcode[cnt];
				if (miplus=="+"){
					totval += tempval;
				}else if(miplus=="-"){
          totval -= tempval;
				}
				
				//alert("totval:::"+totval + "::tempval::" + tempval)
				
				//alert("arrcode[cnt]"+arrcode[cnt])
				//alert(gcds_name.namevalue(1,"TOTALVAL"));
			  //arrcode[cnt] = Math.floor(arrcode[cnt]);
				cnt1=0;
				cnt+=1;
				strData=""
			}else{
				cnt1+=1 ;
			}
		}else{                     
				cnt1=0;
				cnt+=1;
		}
	}//for

	gcds_name2.ClearAll();
	var s_temp = "TOTALVALUE:DECIMAL"
	gcds_name2.SetDataHeader(s_temp);
	gcds_name2.addrow();
	gcds_name2.namevalue(1,"TOTALVALUE")=totval;
  
 // alert("end");
}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ���
	parameter  : gcds_name      //����Ÿ�¸� 
	             fdcode    //�����ڵ�
							 actyymm   //ȸ����
							 atcode    //�����ڵ�
							 cocode    //�����
							 divcd     //����
	retun      : 
******************************************************************************************/
function gf_format_val(gcds_name,fdcode, actyymm, atcode, cocode, divcd, actyymmfr){ 

    //alert("start");
		gcds_name.DataID = g_servlet+"/Account.comm_func_s1?v_str1="+fdcode
																										 +"&v_str2="+actyymm
																										 +"&v_str3="+atcode
																										 +"&v_str4="+cocode
																										 +"&v_str5="+divcd
			                                               +"&v_str6="+actyymmfr;
   // prompt("",gcds_name.DataID );																							
	  gcds_name.Reset();			
		
		 //alert("end");
}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ���
	parameter  : gcds_name2,      //����Ÿ�¸� 
	             dblvalue ���� 
	            
	retun      : 
******************************************************************************************/
function gf_cal_val(gcds_name2, dblvalue){ 

    //alert("start");
		gcds_name2.DataID = g_servlet+"/Account.comm_cal_s1?v_str1="+dblvalue;
 //   prompt("",gcds_name2.DataID );																							
	  gcds_name2.Reset();			
		 //alert("end");
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