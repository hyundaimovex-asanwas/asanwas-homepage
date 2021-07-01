<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 채권가압류관리
+ 프로그램 ID: a070023.jsp
+ 기 능 정 의	: 채권가압류관리
+ 작  성   자  : 정 영 식
+ 작 성 일 자 : 2013.03.13
-----------------------------------------------------------------------------
+ 수 정 내 용 : 전표 및 매입매출 등록처리시 등록 자금 ( 경영관리팀 요청 ) 
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2017.03.02
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a070023_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>채권가압류관리</title>

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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;

<%
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	gclx_credgb_0.index = 0 ;
	
	gcem_recdat_fr.text = gs_date2+"01";
	gcem_recdat_to.text = gs_date;	
 }
 
<%
/******************************************************************************
	Description : 조회
	//검색조건
    //저장전 -   지점, 회계년월, 정산일자
    //저장후 -   지점, 회계년월, 지급일자  
******************************************************************************/
%>
function ln_Query(){ 
 
  	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s1"
								     + "?v_str1="+gclx_credgb_0.BindColVal     
								 	 + "&v_str2="+txt_vend_nm_0.value   
								 	 + "&v_str3="+txt_vend_cd_0.value     
									 + "&v_str4="+gcem_recdat_fr.text       
									 + "&v_str5="+gcem_recdat_to.text;								 	 
								 	       
									     
	 //prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


<%
/******************************************************************************
	Description : 엑셀
******************************************************************************/
%>
function ln_Excel(){
     var strTitle="";
     strTitle ="채권(가)압류 현황 ";
     gcgd_disp01.SetExcelTitle(1, "value:"+strTitle+"; font-face:±¼¸²u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	 gcgd_disp01.GridToExcel(strTitle,"",1);
}


<%
/******************************************************************************
	Description : 출력  
******************************************************************************/
%>
function ln_Print(){

	        if (gcds_master.countrow<1){ 
	           var s_temp = "TITLE:STRING,USEDATE:STRING";
				gcds_master.SetDataHeader(s_temp);
			}
			
	        gcds_master.addrow();
	        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "채권(가)압류 현황";
	        gcds_master.namevalue(gcds_master.rowposition,"USEDATE") = gs_date;                                         
			gcrp_print.Preview();
			  
}


<%
/******************************************************************************
	Description : 거래처 (조회)
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm_0.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd_0.value = arrParam[0];
		 txt_vend_nm_0.value = arrParam[1];
	} else {
		 txt_vend_cd_0.value = "";
		 txt_vend_nm_0.value = "";
    }
}

<%
/******************************************************************************
	Description : 거래처 (입력)
******************************************************************************/
%>
function ln_Popup_Vendcd2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd.value = arrParam[0];
		 txt_vend_nm.value = arrParam[1];
		 gcem_vend_id.text = arrParam[5];
		 
	} else {
		 txt_vend_cd.value = "";
		 txt_vend_nm.value = "";
		 gcem_vend_id.text ="";
    }
}


<%
/******************************************************************************
	Description : 추가  
******************************************************************************/
%>
function ln_Add(){
	ln_SetDataHeader();;
	gcds_code01.Addrow();

}

<%
/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
%>

function ln_SetDataHeader(){

	if (gcds_code01.countrow<1){
		var s_temp = "VEND_CD:STRING(13),VEND_SEQ:STRING(3),VEND_NM:STRING(62),VEND_ID:STRING(15),CREDITOR:STRING(100),DEMAMT:DECIMAL(15),"
		           + "RECDAT:STRING(8),DEPDAT:STRING(8),CANDAT:STRING(8),CREDGB:STRING(1),REMARK:STRING(32),"
		           + "I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10)";
		gcds_code01.SetDataHeader(s_temp);
	}
}



<%
/******************************************************************************
	Description : 체크  
******************************************************************************/
%>
function ln_Chk(){

   // 거래처 코드 가 없는지 체크 
      for (var i =1; i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"VEND_CD")==""){
			alert( i + "행의 거래처 코드를 확인 하세요");
			return false;
		}
    }
       
    if(!ln_Chk_Credgb()) return false; 
	
	//공탁일자 - 채권구분 ( 공탁 )
	//해지일자 - 채권구분 ( 해지 )
	return true;
}

<%
/******************************************************************************
	Description : 저장 
******************************************************************************/
%>
function ln_Save(){

	if(!ln_Chk()) return;

	if (gcds_code01.IsUpdated ){
		if (confirm("저장하시겠습니까 ?")) {
		  
			gctr_code01.KeyValue = "Account.a070023_t1(I:USER=gcds_code01)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t1";
            gctr_code01.Parameters="v_str1="+gusrid;

			gctr_code01.post();
		}
	}
}


<%
/******************************************************************************
	Description : 공탁, 해지일 체크 
	수정 : 2017.03.03 채권(가)압류 - 1, 2 일 경우 공탁일자 입력가능  by 오연주
	
******************************************************************************/
%>
function ln_Chk_Credgb(){

	if(gcem_depdat.text==""&&gclx_credgb.bindcolval=="3"){
		alert("공탁일자를 확인하세요");
		return false;
	}else if (gcem_depdat.text!=""&&gclx_credgb.bindcolval!="3"){
		if(gclx_credgb.bindcolval=="4"){
			alert("채권구분을  확인하세요");
			return false;	
		}
	}else if(gcem_candat.text==""&&gclx_credgb.bindcolval=="4"){
		alert("해지일자를 확인하세요");
		return false;
	}else if (gcem_candat.text!=""&&gclx_credgb.bindcolval!="4"){
		//alert("채권구분을  확인하세요");
		//return false;
	}
	
	return true;
}

<%
/******************************************************************************
	Description : 삭제 
******************************************************************************/
%>
function ln_Delete(){

	if (confirm("선택하신 채권가압류 데이터를 삭제하시겠습니까?")){
		gcds_code01.deleterow(gcds_code01.rowposition);
		gctr_code01.KeyValue = "a070023_t1(I:USER=gcds_code01)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t1";
		gctr_code01.post();
	}
}



<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query2(strrow){ 
	
	if (gcds_code01.namevalue(strrow,"VEND_CD")==""){
		alert("거래처명을 선택 하여 주십시요.");
		return false;
	}
 
  	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s2"
					   + "?v_str1="+gcds_code01.namevalue(strrow,"VEND_CD");     								 	 							    				
	
  	//prompt('',gcds_code02.DataID );
  	gcds_code02.Reset();
}


<%
/******************************************************************************
	Description : 삭제 
******************************************************************************/
%>
function ln_Delete2(){

	if (confirm("선택하신 전표잠금해지 데이터를 삭제하시겠습니까?")){
		gcds_code02.deleterow(gcds_code02.rowposition);
		gctr_code01.KeyValue = "a070023_t2(I:USER=gcds_code02)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t2";
		gctr_code01.post();
	}
}
<%
/******************************************************************************
	Description : 추가  
******************************************************************************/
%>
function ln_Add2(){
	ln_SetDataHeader2();
	gcds_code02.Addrow();
	
	gcds_code02.namevalue(gcds_code02.rowposition,"VEND_CD")=gcds_code01.namevalue(gcds_code01.rowposition,"VEND_CD");
	gcds_code02.namevalue(gcds_code02.rowposition,"VEND_NM")=gcds_code01.namevalue(gcds_code01.rowposition,"VEND_NM");
	
	if(gcds_code02.rowposition==1){
		gcds_code02.namevalue(gcds_code02.rowposition,"HIS_SEQ")=1;	
	}else if(gcds_code02.rowposition>1) {
		gcds_code02.namevalue(gcds_code02.rowposition,"HIS_SEQ")=gcds_code02.namevalue(gcds_code02.rowposition-1,"HIS_SEQ")+1;
	}
	
	gcds_code02.namevalue(gcds_code02.rowposition,"CERTI_DATE")=gs_date;
}

<%
/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
%>
function ln_SetDataHeader2(){

	if (gcds_code02.countrow<1){
		var s_temp = "VEND_CD:STRING(13),VEND_NM:STRING(62),HIS_SEQ:DECIMAL(2),CERTI_EMPNO:STRING(10),ENO_NM:STRING(20),CERTI_DATE:STRING(8),"
		           + "WRID:STRING(10),WRDT:STRING(10),UPID:STRING(10),UPDT:STRING(10)";
		gcds_code02.SetDataHeader(s_temp);
	}
}

<%
/******************************************************************************
	Description : 저장 
******************************************************************************/
%>
function ln_Save2(){

	if(!ln_Chk2()) return;

	if (gcds_code02.IsUpdated ){
		if (confirm("저장하시겠습니까 ?")) {
		  
			gctr_code01.KeyValue = "Account.a070023_t2(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_t2";
            gctr_code01.Parameters="v_str1="+gusrid;

			gctr_code01.post();
		}
	}
}

<%
/******************************************************************************
	Description : 체크  
******************************************************************************/
%>
function ln_Chk2(){

   // 거래처 코드 가 없는지 체크 
    for (var i =1; i<=gcds_code02.countrow;i++){
		if(gcds_code02.namevalue(i,"VEND_CD")==""){
			alert( i + "행의 거래처 코드를 확인 하세요");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"VEND_NM")==""){
			alert( i + "행의 거래처 명을 확인 하세요");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"CERTI_EMPNO")==""){
			alert( i + "행의 전표작성자 사번을 확인 하세요");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"ENO_NM")==""){
			alert( i + "행의 전표작성자 명을 확인 하세요");
			return false;
		}
		
		if(gcds_code02.namevalue(i,"CERTI_DATE")==""){
			alert( i + "행의 전표작성일자를 확인 하세요");
			return false;
		}		
    }
       
	return true;
}

<%
/******************************************************************************
	Description : 인증 전표작성자 찾기 
******************************************************************************/
%>
function ln_Popup_Certi_Empno(row){
	
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_code02.namevalue(row,"CERTI_EMPNO")   = arrParam[1];
		gcds_code02.namevalue(row,"ENO_NM")        = arrParam[0];
	}else{
		gcds_code02.namevalue(row,"CERTI_EMPNO")="";
		gcds_code02.namevalue(row,"EMO_NM")  ="";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- 가압류현황 조회  -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
	<param name=SubSumExpr    value="1:VEND_CD">
</object>

<object  id=gcds_master classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 전표잠금 history  -->
<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
       	ft_cnt01.innerText="데이타 조회중입니다.";
   	   document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
    var icnt=0;

   	if(gcds_code01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else {
	  	ft_cnt01.innerText = "조회건수 : " + gcds_code01.RealCount(1,row) + " 건";
	}
 
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>


<script language=JavaScript for=gcds_code02 event=OnDataError()>

alert("Error Code : " + gcds_code02.ErrorCode + "\n" +"Error Message : " + gcds_code02.ErrorMsg + "\n");

</script>
 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 
<script language=JavaScript for=gcem_depdat event=onKillFocus()>
	if(!ln_Chk_Credgb()) return; 
 </script>


<script language=JavaScript for=gcem_candat event=onKillFocus()>
	if(!ln_Chk_Credgb()) return; 
 </script>
 
 
<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	ln_Query2(row);
</script>
 
<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	
	if(row>0){
		if(colid=="CERTI_EMPNO"){
			ln_Popup_Certi_Empno(row); 
		}
	}
</script>
  


<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
    alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a070023_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_print.gif"       style="cursor:hand"  onclick="ln_Print()">
		    <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">

	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>접수일자</td> 
		<td class="tab24"  colspan="7">&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		 value=0>
			<param name=Border	         value=true>
			<param name=Format	         value="YYYY/MM/DD">
			<param name=PromptChar	 value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>

	<tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>채무자</td>
		<td width="300px" class="tab28"  colspan =3>&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm_0" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vend_cd_0" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> 채권구분</td>  
	    <td width="300px"  class="tab28"  colspan=3>&nbsp;
			<comment id="__NSID__">
			<object id=gclx_credgb_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
				<param name=CBData			         value="A^전체,1^채권(가)압류,3^공탁,4^해지">
				<param name=CBDataColumns	 value="CODE,NAME">
				<param name=SearchColumn	     value=NAME>
				<param name=Sort			             value=false>
				<param name=ListExprFormat       value="NAME">								
				<param name=BindColumn		     value="CODE">
			</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
</table>

<table id="div_disp1"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;width:858px; height:330px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='거래처'	              ID=VEND_CD	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  show =false</C>
					<C> Name='거래처명(채무자)'      ID=VEND_NM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='사업자번호'		      ID=VEND_ID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}MASK='XXX-XX-XXXXX'</C>
					<C> Name='채권자 '			  ID=CREDITOR	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} Value={Decode(curlevel,1,'소  계',CREDITOR)}</C>
					<C> Name='청구금액'             ID=DEMAMT       HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right	  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='접수일자'             ID=RECDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX' </C>
					<C> Name='공탁일자'             ID=DEPDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX'  </C>
					<C> Name='해지일자'		      ID=CANDAT       HeadAlign=Center HeadBgColor=#B9D4DC Width=69     align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='채권구분'	          ID=CREDGB   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=125    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} EditStyle=Combo  Data='1:채권가압류,2:채권압류 및 추심명령,3:공탁,4:해지'</C>
					<C> Name='비고'	        	  ID=REMARK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td class="tab31" ><b><font size="2" color="blue">[가압류 등록]</font></b></td>
          <td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:2px;" onclick="ln_Delete()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	    style="cursor:hand;position:relative;top:2px;" onClick="ln_Add()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
		  </td>
    </tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>채무자</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" readOnly>
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:0px;top:1px" align=center onclick="ln_Popup_Vendcd2();">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:50px;height:20px;" readOnly >	
			<input id="txt_vend_seq" type="hidden" class="txtbox"  style= "position:relative;left:0px;top:0px;width:50px;height:20px;" maxlength="6" >			
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>사업자등록번호</nobr></td>
		<td width="200px"   class="tab24" ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:100px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly      value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> 접수일자</td>  
	    <td width="130px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_recdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_recdat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>채권자</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_creditor" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>청구금액</nobr></td>
		<td width="200px"   class="tab24" ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_demamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:100px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=2>
				<param name=Border	        value=True>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> 공탁일자</td>  
	    <td width="130px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_depdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_depdat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>채권구분</td>
		<td width="310px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_credgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:180px;">
				<param name=CBData			         value="1^채권가압류,2^채권압류 및 추심명령,3^공탁,4^해지">
				<param name=CBDataColumns	 value="CODE,NAME">
				<param name=SearchColumn	     value=NAME>
				<param name=Sort			             value=false>
				<param name=ListExprFormat       value="NAME">								
				<param name=BindColumn		     value="CODE">
			</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td> 
		
		<td width="80px"     class="tab24"   bgcolor="#eeeeee"  align=center ><nobr>비고</nobr></td>
		<td width="200px"   class="tab24"   ><nobr>&nbsp;
		    <comment id="__NSID__"><nobr> 
			<object id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:2px;width:180px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=0>
				<param name=Border	        value=True>
	            <param name=GeneralEdit   value="true">		
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr> 
		</td>
	
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center> 해지일자</td>  
	    <td width="130px"  class="tab24" >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_candat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_candat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td class="tab31" ><b><font size="2" color="blue">[전표잠금해지]</font></b></td>
          <td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:0px;" onclick="ln_Delete2()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:0px;" onClick="ln_Add2()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:0px;" onclick="ln_Save2()">
		  </td>
    </tr>
    
    <tr>
    	<td colspan =2>
    		<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			  style="position:relative;left:0px;width:858px; height:110px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code02">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='거래처'	            ID=VEND_CD		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='거래처명'	        ID=VEND_NM        HeadAlign=Center HeadBgColor=#B9D4DC Width=200    align=left    edit=none  bgcolor='#eeeeee'</C>
					<C> Name='순번'	        	ID=HIS_SEQ   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30     align=center  edit=none  bgcolor='#eeeeee'</C>
                    <C> Name='전표작성자'	        ID=CERTI_EMPNO	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  EditStyle=Popup </C>
                    <C> Name='전표작성자'	        ID=ENO_NM	      HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='전표작성일자'		ID=CERTI_DATE  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee' </C>
					<C> Name='작성자'	            ID=WRID     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee'</C>
					<C> Name='처리일시'		    ID=WRDT     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  edit=none  bgcolor='#eeeeee' </C>	
					<C> Name='수정자'	            ID=UPID     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  show = false bgcolor='#eeeeee'</C>
					<C> Name='수정일지'		    ID=UPDT     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=center  show=false  bgcolor='#eeeeee'</C>	
					">
			</object></comment><script>__ws__(__NSID__);</script>
    	</td>
    </tr>
</table>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			value="gcds_master">
	<param name="DetailDataID"			value="gcds_code01">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="PaperSize"				VALUE="A4">	
	<PARAM NAME="FixPaperSize"		    VALUE="true">
	<PARAM NAME="PrintMargine"			VALUE="false">
	<PARAM NAME="NullRecordFlag"	    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=995 ,top=98 ,right=1929 ,bottom=376 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1344 ,top=310 ,right=1320 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1580 ,top=312 ,right=1556 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1804 ,top=310 ,right=1781 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1103 ,top=312 ,right=1080 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=304 ,right=1924 ,bottom=304 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=156 ,right=1924 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=98 ,right=1693 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1463 ,top=98 ,right=1463 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1228 ,top=98 ,right=1228 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='승  인' ,left=1699 ,top=101 ,right=1924 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=1466 ,top=101 ,right=1691 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=1233 ,top=101 ,right=1458 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담  당' ,left=1000 ,top=101 ,right=1225 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=995 ,top=32 ,right=1929 ,bottom=98 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='년     월     일   (  기안 :               )' ,left=1024 ,top=40 ,right=1900 ,bottom=93 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>	
	
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=288 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=1508 ,top=143 ,right=1929 ,bottom=191 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=19 ,top=204 ,right=1958 ,bottom=204 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TITLE', left=50, top=45, right=1926, bottom=132, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='채권구분' ,left=1651 ,top=213 ,right=1950 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='해지일' ,left=1463 ,top=213 ,right=1638 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='공탁일' ,left=1283 ,top=213 ,right=1458 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='접수일' ,left=1103 ,top=213 ,right=1278 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='청구금액' ,left=844 ,top=213 ,right=1090 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='채권자' ,left=463 ,top=213 ,right=836 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='채무자' ,left=21 ,top=213 ,right=450 ,bottom=288 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>

	<L> left=19 ,top=204 ,right=19 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1958 ,top=204 ,right=1958 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=455 ,top=204 ,right=455 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=839 ,top=204 ,right=839 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1095 ,top=204 ,right=1095 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1281 ,top=204 ,right=1281 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1463 ,top=204 ,right=1463 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1643 ,top=204 ,right=1643 ,bottom=288 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='USEDATE', left=45, top=143, right=265, bottom=191, align='left' ,mask='XXXX.XX.XX', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=74 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=19 ,top=0 ,right=19 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=74 ,right=1958 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=19 ,top=0 ,right=1958 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(CREDGB,1,\'채권가압류\',2,\'채권압류 및 추심명령\',3,\'공탁\',4,\'해지\',CREDGB)}', left=1651, top=5, right=1950, bottom=66, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1643 ,top=0 ,right=1643 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='CANDAT', left=1463, top=5, right=1638, bottom=66, align='center' ,mask='XXXX/XX/XX', face='굴림', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1463 ,top=0 ,right=1463 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DEPDAT', left=1283, top=5, right=1458, bottom=66, align='center' ,mask='XXXX/XX/XX', face='굴림', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1281 ,top=0 ,right=1281 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='RECDAT', left=1103, top=5, right=1278, bottom=66, align='center' ,mask='XXXX/XX/XX', face='굴림', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1095 ,top=0 ,right=1095 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='DEMAMT', left=844, top=5, right=1090, bottom=66, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=839 ,top=0 ,right=839 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'               계\',CREDITOR)}', left=463, top=5, right=836, bottom=66, align='left', face='굴림', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=455 ,top=0 ,right=455 ,bottom=71 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'               소\',VEND_NM)}', left=21, top=5, right=450, bottom=66, align='left', face='굴림', size=9,  forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
	<L> left=45 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_code01">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value</C>
	<C>Col=VEND_SEQ		  Ctrl=hid_vend_seq	    Param=value</C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value</C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text</C>
	<C>Col=CREDITOR		  Ctrl=txt_creditor	    Param=value</C>
	<C>Col=DEMAMT		  Ctrl=gcem_demamt	    Param=Text</C>
	<C>Col=RECDAT		  Ctrl=gcem_recdat	    Param=Text</C>
	<C>Col=DEPDAT   	  Ctrl=gcem_depdat      Param=Text</C>
	<C>Col=CANDAT		  Ctrl=gcem_candat		Param=Text</C>
	<C>Col=CREDGB		  Ctrl=gclx_credgb		Param=bindcolval</C>
	<C>Col=REMARK		  Ctrl=gcem_remark		Param=Text</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 