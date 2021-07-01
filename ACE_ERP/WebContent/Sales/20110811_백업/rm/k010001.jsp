
<%
/****************************************************************************
 * 시스템명 		: 호텔 정보
 * 프로그램ID 	: SAMPLE (코드는 대문자)
 * J  S  P		: K010001.jsp
 * 서 블 릿		: 
 * 작 성 자		: 주성근
 * 작 성 일		: 2006-05-02
 * 기능정의		:  조회, 등록, 삭제 엑셀,
 * 수정내용		: 2006-05-02 : XXXXX 발주 XXXXX 수정요청 (완료/미완료)
 * 수 정 자		: 주성근
 * 최종수정일자 	: 2006-05-04 
 * 
 * 
 *
 ***************************************************************************/
 %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath();
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>호텔정보 </title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
/*=============================================================================
				Style Sheet, Common Java Script Link
=============================================================================*/
%>		
		<link rel="stylesheet" href="<%=dirPath%>/Sales/common/include/common.css">

		<Script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>



<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
    	get_cookdata();
        var gs_userid = gusrid;
        var gs_fdcode = gfdcode;

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
			function fnOnLoad(){
			fnInit();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
// Parameter 	: 
%>
			function fnInit(){ 
			ln_SetDataHeader1();
			ln_SetDataHeader2();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  조회1
// Parameter 	: 
%>
    function fn_Query(){ 
         //if(gcds_data1.IsUpdated || gcds_data2.IsUpdated) {
					//alert("수정중인 행이 있습니다.");
					//return;
				//}
         //else {
					gcds_data1.DataId = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=S&dsType=1&s_Head=" + txt_head.value + "&s_HeadName=" + txt_head_name.value;
					gcds_data1.Reset();
//}
			//}   
	 
	 //gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020i?proType=&dsType=&s_Head=" + txt_head.value + "&s_HeadName=" + txt_head_name.value;
	 //gcds_data1.Reset(); 		

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  조회2
// Parameter 	: 
%>
function fn_Query2(){   
	
gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=S&dsType=2&s_UpjangSid&s_SaupSid="+gcds_data1.namevalue(gcds_data1.rowposition,"SAUP_SID");
gcds_data2.Reset();


}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  추가 
// Parameter 	: 
%>
function fn_Add2(){
    if (confirm("입력하신 사항을 추가하시겠습니까?")){
	    gcds_data2.addrow();
	    gcds_data2.namevalue(gcds_data2.rowposition,"SAUP_SID")=gcds_data1.namevalue(gcds_data1.rowposition,"SAUP_SID");
       gcds_data2.namevalue(gcds_data2.rowposition,"SAUP_SID")=Number();
       gcgd_data2.setcolumn("DETAIL");
	   txt_focus.value=gcds_data2.rowposition;
	     window.status="Detail 행이 삽입되었습니다.";
 }
}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  저장 2
// Parameter 	: 
%>
        function fn_Save2(){
            var row1=gcds_data1.countrow;
	        var row2=gcds_data2.countrow;
                  if (confirm(" 저장을하시겠습니까?")){
	                 if (gcds_data2.IsUpdated) {
                         if (fn_Chk()) {
			gctr_data2.KeyValue = "a0010_t0(I:USER=gcds_data2)";
			gctr_data2.Action ="<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=A&dsNum=1";
			gctr_data2.post();
		}
	}
}
}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  저장 
%>
function fn_Save(){

	var row1=gcds_data1.countrow;
	var row2=gcds_data2.countrow;
	if (confirm("입력하신 사항을 저장하시겠습니까?")){
		if (gcds_data2.IsUpdated) {

			if (fn_Chk()) {
			
				gctr_data2.KeyValue = "a0010_t0(I:USER=gcds_data2)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=A&dsNum=1";
				gctr_data2.post();
			}
		}
	}


}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  입력값 체크 
// Parameter 	: 
%>
function fn_Chk() {
	
var row1=gcds_data1.countrow;
var row2=gcds_data2.countrow;
	for(i=1;i<=row1;i++) {
		if(gcds_data1.namevalue(i,"SAUP_SID")=="") {
	alert(" 입력해 주십시오");
		return false;
	}
	}
for(i=1;i<=row2;i++) {
	if (gcds_data2.namevalue(i,"DETAIL")=="") {			
		alert(" 입력해 주십시오");
		return false;
	}
	}
return true;

}


<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  삭제 
// Parameter 	: 
%>
function fn_Delete(){

	if (confirm("입력하신 사항을 삭제하시겠습니까?")){
	gcds_data2.deleteall();
		gcds_data2.deleterow(gcds_data2.rowposition);
	fn_Save2();
		window.status="Detail 행이 삭제되었습니다.";
	}

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  출력 
// Parameter 	: 
%>
function fn_Print(){

gcrp_print1.preview();

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  엑셀 
// Parameter 	: 
%>

function fn_Excel(){

gcgd_data2.runexcel("호텔 정보");

}


<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function ln_SetDataHeader1(){
			if (gcds_data1.countrow<1){
				var s_temp = "SAUP_SID:STRING,SAUP_NM:STRING,SAUP_ENG_NM:STRING,U_DATE:STRING";
			gcds_data1.SetDataHeader(s_temp);
			}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
%>	

			function ln_SetDataHeader2(){
			if (gcds_data2.countrow<1){
				var s_temp = "SAUP_SID:STRING,UPJANG_SID:STRING,UPJANG_NM:STRING,"
						   + "UPJANG-SID:STRING,UPJANG_CD:STRING,UPJANG_NM:STRING,UPJANG_ENG_NM:STRING,DIRECT_SID:STRING"
					       + "SAUP_SID:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";   
				gcds_data2.SetDataHeader(s_temp);
			}
		}	






 </script>

<%
/*----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------*/
%>
<object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name= SortExpr 	value="+HEAD">
</object>
<object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+HEAD">
</object>
<%
/*-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------*/
%>
<object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
<object  id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
<script language="javascript"  for=gcgd_data1  event=OnClick(row,colid)>
  fn_Query2();
  </script>
 <script language=JavaScript for=gcgd_data1 event=OnEnter(row,colid)>
  if(colid=="SAUP_SID") {
	if(txt_status_head1.value!="") {
		alert("키값은 수정할 수 없습니다.");
		gcds_data1.namevalue(row,colid)=txt_status_head1.value;
		return;
		}
	}
</script>


<%
/* ---------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
---------------------------------------------------------------------------- */
%>

<script language=JavaScript  for=gcds_data1 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadError()">
	alert("에러가 발생했습니다 : " + gcds_data1.ErrorMsg );
	window.status="조회가 완료 되었습니다.";
  document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if( row < 1){
		alert("검색된 데이타가 없습니다."); 
	}
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
     alert("에러가 발생했습니다 : " + gcds_data2.ErrorMsg );
	window.status="조회가 완료 되었습니다.";
  document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	
</script>


<%
/*-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------*/
%>

</HEAD>

<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" onload="fnOnLoad()" style="overflow:hidden">
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;" >
  <tr> 
    <td background="/Sales/common/img/com_t_bg.gif"><img src="../img/tsy160.gif"></td>
    <td align="right" style="padding-top:10px;" background="/Sales/common/img/com_t_bg.gif">&nbsp;&nbsp;</td>
  </tr>
  </table>
<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
				    <td>
                       <input id="txt_head" type="hidden" size="1">
					<input id="txt_head_name" type="hidden" size="1">
						<input id="txt_focus" type="hidden" size="1">
					</td>
					<td align="right" width=100%>					
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_excel.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Excel()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_print.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Print()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fn_Delete()" >
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;left:-5px;top:3px"  onClick="fn_Add2()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fn_Save()">
						    <img src="<%=dirPath%>/Sales/common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Query()">
				     </td>
				</tr>
	</table>	
    <table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:200px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
						<tr> 
										<td>
											  <object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data1  style="WIDTH:140px;HEIGHT:400px;border:1 solid #777777;">
												<PARAM NAME="DataID"			 VALUE="gcds_data1">
												<PARAM NAME="Editable"        VALUE=" true">
												<PARAM NAME="BorderStyle"   VALUE="0">
												<param name="Fillarea"		     VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"       value="0">
												<PARAM NAME="Format"		      VALUE="  
													<C> Name='' ID={CURROW} HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center </C>						
													<C> Name='지역코드'  ID=SAUP_CD   HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left </C>	
													<C> Name='지역명'  ID=SAUP_NM  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left </C>	
												">
											</object> 
										</td>
		
										<td>
											<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH:650px;HEIGHT:400px;border:1 solid #777777;">
												<PARAM NAME="DataID"			 VALUE="gcds_data2">
												<PARAM NAME="Editable"        VALUE="True">
												<PARAM NAME="BorderStyle"    VALUE="0">
												<param name="Fillarea"		     VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"        value="0">
												<PARAM NAME="Format"		     VALUE="  
									     <C> Name=' '					ID={CURROW}			HeadAlign=Center HeadBgColor=#B9D4DC Width=30 align=center </C>	
									    <C> Name='영업장코드'  ID=UPJANG_CD			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='영업장명'		ID= UPJANG_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='영문명'			ID=UPJANG_ENG_NM  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='직영여부'		ID=DIRECT_YN			HeadAlign=Center         EditStyle=CheckBox    
										HeadBgColor=#B9D4DC Width=100 align=Center </C>
										<C> Name='최종수정자사번'	  ID=U_EMPNO	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>										
										<C> Name='최종수정'		ID=U_IP 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left </C>
										<C> Name='사업자SID'		ID=SAUP_ID 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left </C>
										">
									</object>
									</td>
								</tr>
	</table>
			
<%
/*-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------*/
%>

<object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
	<C>Col=HEAD                    Ctrl=gcem_head              Param=text</C>
	<C>Col=HEAD_NAME               Ctrl=gcem_head_name         Param=text</C>
	'>
</object>
<%
/*-----------------------------------------------------------------------------
					출력물 정의부분
-----------------------------------------------------------------------------*/
%>
<object  id="gcrp_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_data2">
	<param NAME="DetailDataID"			VALUE="gcds_data2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">	
	<PARAM NAME="Format"                VALUE="
<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=238 ,face='Arial' ,size=12 ,penwidth=2
	<L> left=25 ,top=237 ,right=2778 ,bottom=237 </L>
	<T>id='호텔정보' ,left=0 ,top=25 ,right=2791 ,bottom=122 ,face='HY헤드라인M' ,size=18 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='#p/#t' ,left=2641 ,top=178 ,right=2756 ,bottom=234 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Page:' ,left=2328 ,top=178 ,right=2591 ,bottom=234 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
">
</object> 

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="/Sales/common/img/flash/loading.swf" width="320px" height="42px">
</iframe> 

</body>
</html>


