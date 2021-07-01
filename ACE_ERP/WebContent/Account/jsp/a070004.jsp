
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:   자금관리 - 월간자금신청
+ 프로그램 ID	:   A700004.html
+ 기 능 정 의	:   입력,조회,수정,삭제 화면이다.
+ 작   성  자 :   
+ 서 블 릿 명	:	
------------------------------------------------------------------------------
+ 수 정 내 용  :	팝업창 수정 및 개선사항 수정   
+ 수   정  자  :	이민정
+ 수 정 일 자  :  2006.12.13
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a070004_s1, a070004_s2, a070004_t1
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>월간자금신청</title> 


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;				  //지점코드   
		var str2  = gclx_cadeptcd.BindColVal;					//부서코드       
		var str3  = fn_trim(gcem_sgetdatefr1.text);	  //신청년월fr
		var str4  = fn_trim(gcem_sgetdateto1.text);	  //신청년월to
		var str5  = gs_userid;          //ID 체크 
		var str6 = "";	//구분값

		if (str5 =="ACCOUNT"||str5 =='2060005' ||str5=='2020029'||str5=='6060001') {
			str6 = "1";
		}else  {
			str6 = "2";
		}


		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070004_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4//+"&v_str5="+gs_chk
	 										+ "&v_str6="+str5+"&v_str7="+str6;

		gcds_data1.Reset();

	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;				  //지점코드   
		var str2  = gclx_cadeptcd2.BindColVal;				//부서코드       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	  //신청년월
		var str4  = gs_userid;          //ID 체크 
		var str5 = "";	//구분값


		if (str4 =="ACCOUNT"||str4 =='2060005' ||str4=='2020029'||str4=='6060001') {
			str5 = "1";
		}else  {
			str5 = "2";
		}



		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070004_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str3+"&v_str5="+str4+"&v_str6="+str5;


		//prompt('',gcds_data2.DataID);			
		gcds_data2.Reset();
	}
}

/******************************************************************************
	Description : 중복체크
******************************************************************************/
function double_check(){
		var str1  = gclx_sfdcode2.BindColVal;				    //지점코드   
		var str2  = gclx_cadeptcd2.BindColVal;					//부서코드       
		var str3  = fn_trim(gcem_sgetdatefr2.text);	           //신청년월

		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070004_s1"
									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;		
										
		gcds_data4.Reset();
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_HederSet(){
	var THeader1 = "FDCODE:STRING,ACYYMM:STRING,DEPTCD:STRING,REMCODE:STRING,AMTDIV:STRING,"
				 + "PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,STATDIV:STRING,"
				 + "ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING";
	gcds_data2.SetDataHeader(THeader1);
}

/******************************************************************************
	Description : Header 설정
******************************************************************************/
function ln_PrintHederSet(){

	var THeader1 = "FDCODE:STRING,ACYYMM:STRING,DEPTCD:STRING,REMCODE:STRING,AMTDIV:STRING,"
				 + "PLAMT:DECIMAL,EXAMT:DECIMAL,REMARK:STRING,EXDATE:STRING,STATDIV:STRING,"
				 + "ATKORNAM:STRING,VENDCD:STRING,VENDNM:STRING,AMTDIV1:STRING";
	gcds_temp01.SetDataHeader(THeader1);

	var THeader2 = "CURDT:STRING,KBUNAM:STRING";
	gcds_temp02.SetDataHeader(THeader2);

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(e){
  if(e=="01") {
		if(gcds_data1.countrow<1) {
			alert("출력할 정보가 없습니다.");
		}else{
			gcds_temp01.clearall();
			gcds_temp02.clearall();
			ln_PrintHederSet();
			gcds_temp01.ImportData(gcds_data1.ExportData(1,gcds_data1.countrow,false));
			gcds_temp02.addrow();
			gcds_temp02.namevalue(gcds_temp02.rowposition,"CURDT")
				= gcem_sgetdatefr1.text+gcem_sgetdateto1.text;
			gcds_temp02.namevalue(gcds_temp02.rowposition,"KBUNAM")=gclx_cadeptcd.text;
			for(i=1;i<=gcds_temp01.countrow;i++) {
				if(gcds_temp01.namevalue(i,"AMTDIV")=="C")
					gcds_temp01.namevalue(i,"AMTDIV1")="현금";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="B")
					gcds_temp01.namevalue(i,"AMTDIV1")="어음";
				else if(gcds_temp01.namevalue(i,"AMTDIV")=="D")
					gcds_temp01.namevalue(i,"AMTDIV1")="보통예금";
			}
			gcrp_print1.preview();
		}
	}
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2;
	gcem_sgetdateto1.text = gs_date2;
	gcem_sgetdatefr2.text = gs_date2;

	gclx_amtdiv2.bindcolval = "C";	//지급기준(현금)
	
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_sfdcode2.Reset();

	gcds_dept1.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept1.Reset();

	gcds_dept2.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept2.Reset();

	//gcds_com.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0054";
	//gcds_com.Reset();

	gcds_dept00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	gcds_dept00.Reset();
}

/******************************************************************************
	Description : 등록버튼
******************************************************************************/
function ln_Insert(){
	ln_HederSet();
	var row = gcds_data2.rowposition;
	gcds_data2.AddRow();
	gclx_amtdiv2.bindcolval = "C";	
}

/******************************************************************************
	Description : 저장버튼
******************************************************************************/
function ln_Save(){
	if(gcds_data2.countrow>0){
		if(ln_Chk()) {
			if (gcds_data2.IsUpdated){
				var str1 = gclx_sfdcode2.BindColVal;				//지점코드  
				var str2 = fn_trim(gcem_sgetdatefr2.text);	//신청년월
				var str3 = gclx_cadeptcd2.BindColVal;				//부서코드
				gctr_code02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070004_t1?";
				gctr_code02.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3
									  + ",v_str4="+gs_date+",v_str5="+gs_userid;
				prompt('',gcds_data2.text);
				prompt('gctr_code02.Parameters',gctr_code02.Parameters);
				gctr_code02.post();
			}else alert("변경된 정보가 없습니다.");
		}	  
	}else alert("저장할 정보가 없습니다.");	  
}

/******************************************************************************
	Description : 필수항목 입력체크 
******************************************************************************/
function ln_Chk() {
	if(fn_trim(txt_atcode_fr.value)=="") {
		alert('정확한 계정과목을 선택하십시요.');
		txt_atcodenm_fr.focus();
		return false;
	}

	if(gcem_plamt2.text==0||gcem_plamt2.text=="") {
		alert('정확한 신청금액을 입력하십시요.');
		gcem_plamt2.focus();
		return false;
	}
	return true;
}

/******************************************************************************
	Description : 삭제버튼
******************************************************************************/
function ln_Delete(){
	if(gcds_data2.countrow>0){
		var str1  = gclx_sfdcode2.BindColVal;				    //지점코드  
	  var str2  = fn_trim(gcem_sgetdatefr2.text);	    //신청년월
		var str3  = gclx_cadeptcd2.BindColVal;					//부서코드 	
		if (confirm("삭제 하시겠습니까?")){
			gcds_data2.deleterow(gcds_data2.rowposition);
			gctr_code02.action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070004_t1?";
			gctr_code02.Parameters = "v_str1=" + str1 +",v_str2=" + str2+",v_str3=" + str3;
			gctr_code02.post();
			ln_Query('02');
		}
	}else alert("삭제할 정보가 없습니다.");
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp01.RunExcel('신청현황');
	}
}

/***********************************************************************************************
	Description : 계정코드 
	parameter   : p1 - 구분  p2-구분2, p3-자금구분값 obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){//계정과목
		strURL = "./actcode_fund_popup.jsp";
		arrParam[0]=eval(obj1).value;
		arrParam[1]=eval(obj2).value;
		arrParam[2]="C";//"'10'";p3;
		arrParam[3]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}

		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}
}

/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성
	                   02 내역조회
								p2 - atcode:계정
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
			 
		}
	}
}

/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_vendcd.value  = arrParam[0];
		txt_vendnm.value	= arrParam[1];
	} else {
		txt_vendcd.value	= "";
		txt_vendnm.value	= "";
	}
}



/******************************************************************************
	Description : 탭구분
	prameter    :
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_dept2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_com" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_dept00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp01" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp02" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
<PARAM NAME="KeyValue" VALUE="a070003_t1(I:USER=gcds_data2)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.BindColVal   =  gs_fdcode;
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	gclx_sfdcode2.BindColVal   =  gs_fdcode;
</script>


<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";     
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal   =  gs_deptcd; 
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_dept2.InsertRow(1);
	gcds_dept2.NameValue(1,"DEPTCD")="";
	gcds_dept2.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd2.BindColVal  =  gs_deptcd;
</script>

<!-- <script language="javascript" for="gcds_com" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";       
	gcds_com.InsertRow(1);
	gcds_com.NameValue(1,"CDCODE")="";
	gcds_com.NameValue(1,"CDNAM")="";
	gclx_com.index=0;
</script> -->

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다."); 
</script>

<script language="javascript" for="gctr_code02" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	ln_Query('02');
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070004_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:-6px;">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						<PARAM NAME="BackColor"					VALUE="#cccccc">
   						<PARAM NAME="titleHeight"				VALUE="20px">
						 <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						 <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=신청현황</T>									
							    <T>divid=div_2		title=자금신청</T>							 
								">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- 신청현황 ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >

	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab23" style="width:90px"><comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>부서</nobr></td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="DEPTNM^0^110">
								<param name=BindColumn			value="DEPTCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>신청년월</nobr></td>
					<td style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar		value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM">
						<param name=PromptChar		value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')">
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"			VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='No.'				ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='신청년월'		ID=ACYYMM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX'</C>
								<C> Name='계정과목'		ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'			ID=VENDNM		HeadAlign=Center	 HeadBgColor=#B9D4DC Width=250	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'		ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='지급기준'		ID=AMTDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumText=''		SumBgColor='#C3D0DB' EditStyle='combo' Data='C:현금,B:어음,D:보통예금'</C>
								<C> Name='결재일자'		ID=EXDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
								<C> Name='적요'				ID=REMARK		HeadAlign=left	 HeadBgColor=#B9D4DC Width=250	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>  
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 


<!-- 자금신청 ===========================================================================================================-->
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="position:absolute;top:66px;display:none;">	
<tr><td height="3px"><td></tr>
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:0px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>지점구분</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>부서</nobr></td>
					<td class="tab23" style="width:120px">
						<comment id="__NSID__"><OBJECT id=gclx_cadeptcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
							<param name=ComboDataID			value="gcds_dept2">
							<param name=CBDataColumns		value="DEPTCD,DEPTNM">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="DEPTNM^0^110">
							<param name=BindColumn			value="DEPTCD">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 			
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>신청년월</nobr></td>
					<td style="width:150px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:0px; width:55px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border				value=true>
						<param name=Format				value="YYYY/MM">
						<param name=PromptChar		value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
					</td>
					<td align="right">&nbsp;<nobr>
						<IMG src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Delete()"> <IMG  src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Insert()" >
						<IMG  src="../../Common/img/btn/com_b_save.gif"    style="cursor:hand;position:relative;top:2px;right:2px"  onclick="ln_Save()">
						<IMG src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_data2 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:520px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data2">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 						
								<C> Name='계정과목'	ID=ATKORNAM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		SumText='계'	SumBgColor='#C3D0DB'</C>
								<C> Name='거래처'		ID=VENDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='신청금액'	ID=PLAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right		SumText=@sum	SumBgColor='#C3D0DB' Edit=Numeric</C>	
								<C> Name='적요'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=210	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:-1px;width:522px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
					</fieldset>
						</td>
						<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:343px;height:402px;border:1 solid #708090;position:relative;left:1px'>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">계정과목</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
									<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" disabled>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">거 래 처</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_vendnm" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" >
									<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup();">
									<input id="txt_vendcd" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" disabled>
								</td>
							</tr>
							
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">신청금액</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object  id=gcem_plamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:0px;">		
										<param name=Text          value="">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="000,000,000">
										<param name=MaxLength     value=13>
										<param name=IsComma	      value=true>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11"  bgcolor="#eeeeee">지급기준</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;width:130px"><comment id="__NSID__">
									<object  id=gclx_amtdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
										<param name=CBData					value="^,C^현금,B^어음,D^보통예금">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort						value="false">
										<param name=ListExprFormat	value="CDNAM^0^110">
										<param name=BindColumn			value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
	                        <tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">결재일자</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;"><comment id="__NSID__">
									<object id=gcem_exdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="YYYY/MM/DD">
										<param name=PromptChar	value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_exdate2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;">적&nbsp;&nbsp;&nbsp;&nbsp;요</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;">
									<input id="txt_remark2" type="text" class="txtbox" style= "width:250px;height:20px;position:relative;left:5px;" MaxLength=132>			
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;">&nbsp;
								</td>
							</tr>
							<!-- <tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">항&nbsp;&nbsp;&nbsp;&nbsp;목</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;border-bottom-width:0px"><comment id="__NSID__"><OBJECT id=gclx_com classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:2px;font-size:12px;width:120px;">
										<param name=ComboDataID			value="gcds_com">
										<param name=CBDataColumns		value="CDCODE,CDNAM">
										<param name=SearchColumn		value="CDNAM">
										<param name=Sort				value=false>
										<param name=ListExprFormat		value="CDNAM^0^120">
										<param name=BindColumn			value="CDCODE">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 
								</td>
							</tr>
	            <tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-bottom-width:0px;">신청금액</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-bottom-width:0px"><comment id="__NSID__">
									<object  id=gcem_PLAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:0px;">		
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
								<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">적&nbsp;&nbsp;&nbsp;&nbsp;요</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-bottom-width:1px">
									<input id="txt_REMARK" type="text" class="txtbox"  style= "width:250px;height:20px;position:relative;left:5px;" MaxLength=132>			
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
								</td>
							</tr> -->
						</table>
								</TD>
							</tr>
						</table>
					</td>
				 </tr>
			 </table>
		</td> 
	</tr> 
</table> 
			 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value=' 
		<C>Col=REMCODE		Ctrl=txt_atcode_fr			Param=value</C>
		<C>Col=ATKORNAM		Ctrl=txt_atcodenm_fr		Param=value</C>
		<C>Col=VENDCD			Ctrl=txt_vendcd				Param=value</C>
		<C>Col=VENDNM			Ctrl=txt_vendnm				Param=value</C>
		<C>Col=PLAMT			Ctrl=gcem_plamt2			Param=text</C>
		<C>Col=AMTDIV			Ctrl=gclx_amtdiv2			Param=bindcolval</C>
		<C>Col=EXDATE			Ctrl=gcem_exdate2			Param=text</C>
		<C>Col=REMARK			Ctrl=txt_remark2				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<!--param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;"-->
	<param name="MasterDataID"		value="gcds_temp02">
	<param name="DetailDataID"		value="gcds_temp01">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="false">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="Format"					value="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=556 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=48 ,top=204 ,right=886 ,bottom=280 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='신 청 부 서 :' ,left=48 ,top=426 ,right=278 ,bottom=479 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신 청 일 자 :' ,left=48 ,top=365 ,right=278 ,bottom=421 ,align='left' ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=42 ,top=191 ,right=876 ,bottom=270 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='월 간  자 금  신 청 서' ,left=45 ,top=198 ,right=870 ,bottom=259 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='CURDT', left=283, top=365, right=876, bottom=421, align='left' ,mask='XXXX/XX ~ XXXX/XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='KBUNAM', left=283, top=426, right=876, bottom=479, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1175 ,top=400 ,right=1950 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1175 ,top=193 ,right=1950 ,bottom=193 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='현' ,left=1180 ,top=228 ,right=1233 ,bottom=278 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='업' ,left=1180 ,top=323 ,right=1233 ,bottom=373 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1238 ,top=193 ,right=1238 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1175 ,top=193 ,right=1175 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1950 ,top=193 ,right=1950 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1770 ,top=193 ,right=1770 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1593 ,top=193 ,right=1593 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1416 ,top=193 ,right=1416 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1238 ,top=254 ,right=1950 ,bottom=254 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='본부장' ,left=1778 ,top=201 ,right=1945 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부 장' ,left=1598 ,top=201 ,right=1767 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀 장' ,left=1421 ,top=201 ,right=1590 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담 당' ,left=1244 ,top=201 ,right=1413 ,bottom=249 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=97 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=40 ,top=3 ,right=1950 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='일자' ,left=56 ,top=50 ,right=124 ,bottom=93 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적 요' ,left=794 ,top=19 ,right=1220 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='신청금액' ,left=1289 ,top=19 ,right=1498 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급기준' ,left=1543 ,top=19 ,right=1717 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급기한' ,left=1757 ,top=19 ,right=1939 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=98 ,right=1950 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=40 ,top=3 ,right=40 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=754 ,top=5 ,right=754 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=3 ,right=238 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=40 ,top=3 ,right=238 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1270 ,top=3 ,right=1270 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1508 ,top=3 ,right=1508 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1746 ,top=3 ,right=1746 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1950 ,top=3 ,right=1950 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=278 ,top=19 ,right=706 ,bottom=82 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=156 ,top=11 ,right=225 ,bottom=53 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1746 ,top=0 ,right=1746 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1508 ,top=0 ,right=1508 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=0 ,right=238 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=754 ,top=0 ,right=754 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1270 ,top=0 ,right=1270 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ACYYMM', left=48, top=3, right=233, bottom=64 ,mask='XXXX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=762, top=3, right=1265, bottom=64, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=246, top=3, right=749, bottom=64, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMTDIV1', left=1513, top=3, right=1741, bottom=64, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EXDATE', left=1757, top=3, right=1939, bottom=64 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PLAMT', left=1275, top=3, right=1503, bottom=64, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1950 ,top=0 ,right=1950 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=40 ,top=66 ,right=1950 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=397 ,face='Arial' ,size=10 ,penwidth=1
	<S>id='{Sum(PLAMT)}' ,left=1275 ,top=3 ,right=1505 ,bottom=64 ,align='right' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=1950 ,top=0 ,right=1950 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1270 ,top=0 ,right=1270 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=754 ,top=0 ,right=754 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=0 ,right=238 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=40 ,top=0 ,right=40 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1508 ,top=0 ,right=1508 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1746 ,top=0 ,right=1746 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계' ,left=45 ,top=3 ,right=235 ,bottom=64 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=40 ,top=66 ,right=1950 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1175 ,top=381 ,right=1950 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='리' ,left=1180 ,top=254 ,right=1233 ,bottom=304 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1175 ,top=175 ,right=1950 ,bottom=175 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1238 ,top=175 ,right=1238 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1175 ,top=175 ,right=1175 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1950 ,top=175 ,right=1950 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1770 ,top=175 ,right=1770 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1593 ,top=175 ,right=1593 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1416 ,top=175 ,right=1416 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1238 ,top=235 ,right=1950 ,bottom=235 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='본부장' ,left=1778 ,top=183 ,right=1945 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=1598 ,top=183 ,right=1767 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='팀 장' ,left=1421 ,top=183 ,right=1590 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담 당' ,left=1244 ,top=183 ,right=1413 ,bottom=230 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='경' ,left=1180 ,top=191 ,right=1233 ,bottom=241 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부' ,left=1180 ,top=318 ,right=1233 ,bottom=368 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=Footer ,left=0 ,top=2774 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1577 ,top=3 ,right=1955 ,bottom=85</I>
	<L> left=40 ,top=0 ,right=1947 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>