
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 환경설정
+ 프로그램ID : ks_em020i.jsp
+ 기능정의 : 
+ 작 성 자 : 정 하 나
+ 작성일자 : 2008.9.18
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : em020i_s.java
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());			
	
%>
<!-- HTML 시작-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
	var useid = gusrid;

/*----------------------------------------------------------------------------
	 페이지로딩
 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_Luxequery();//공통코드 조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			ln_Query();
			
		
			for(k=1;k<=4;k++){
				eval("gclx_wktm_gb"+k).enable =  false;
				eval("gclx_stdt_gb"+k).enable =  false;
				eval("gcem_start_dt"+k).enable =  false;
				eval("gclx_eddt_gb"+k).enable =  false;
				eval("gcem_end_dt"+k).enable =  false;
				eval("gcem_t_unit"+k).enable =  false;
				eval("gcem_stpe_tm"+k).enable =  false;
				eval("gcem_edpe_tm"+k).enable =  false;
			}
			
			gcra_dedu_yn.enable =  false;
			gcem_retm1_fr.enable =  false;     
			gcem_retm1_to.enable =  false;		
			gcem_retm2_fr.enable =  false;		
			gcem_retm2_to.enable =  false;			
	
		
		}
		



/******************************************************************************
	Description : 공통코드 조회[검색]
******************************************************************************/
function ln_Luxequery() { 

ln_SetDataHeader();

gcds_cm00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS016";

				gcds_cm00.Reset();

//prompt('',gcds_cm00.DataID);

gcds_cm10.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS017";

				gcds_cm10.Reset();
				
gcds_cm20.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS018";

				gcds_cm20.Reset();				
	
gcds_cm30.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS018";

				gcds_cm30.Reset();		
	

	gcds_cm11.ImportData(gcds_cm10.ExportData(1,gcds_cm10.CountRow,false));
	gcds_cm12.ImportData(gcds_cm10.ExportData(1,gcds_cm10.CountRow,false));
	gcds_cm13.ImportData(gcds_cm10.ExportData(1,gcds_cm10.CountRow,false));
	
	gcds_cm21.ImportData(gcds_cm20.ExportData(1,gcds_cm20.CountRow,false));
	gcds_cm22.ImportData(gcds_cm20.ExportData(1,gcds_cm20.CountRow,false));
	gcds_cm23.ImportData(gcds_cm20.ExportData(1,gcds_cm20.CountRow,false));
	
	gcds_cm31.ImportData(gcds_cm30.ExportData(1,gcds_cm30.CountRow,false));
	gcds_cm32.ImportData(gcds_cm30.ExportData(1,gcds_cm30.CountRow,false));
	gcds_cm33.ImportData(gcds_cm30.ExportData(1,gcds_cm30.CountRow,false));		
	
	

}


/******************************************************************************
	Description : Dataset Head 설정 -
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){

		if (gcds_cm00.countrow<1){  
		    var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm00.SetDataHeader(s_temp);
		}

		if (gcds_cm10.countrow<1){  
			var s_temp ="COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm10.SetDataHeader(s_temp);
		}
			
		if (gcds_cm11.countrow<1){  
		
		//prompt('',gcds_cm11.DataID);
		   var s_temp ="COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm11.SetDataHeader(s_temp);
		}
	
		if (gcds_cm12.countrow<1){  
	   	    var s_temp ="COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm12.SetDataHeader(s_temp);
		}
	
		if (gcds_cm13.countrow<1){  
		   var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm13.SetDataHeader(s_temp);
		}
	
		if (gcds_cm20.countrow<1){  
		   var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm20.SetDataHeader(s_temp);
		}
		
			
		if (gcds_cm21.countrow<1){  
		   var s_temp ="COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm21.SetDataHeader(s_temp);
		}
		
		if (gcds_cm22.countrow<1){  
		    var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm22.SetDataHeader(s_temp);
		}
		
		if (gcds_cm23.countrow<1){  
		   var s_temp ="COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm23.SetDataHeader(s_temp);
		}				

		if (gcds_cm30.countrow<1){  
		   var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm30.SetDataHeader(s_temp);
		}	
		
		
		if (gcds_cm31.countrow<1){  
		   var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm31.SetDataHeader(s_temp);
		}	

		if (gcds_cm32.countrow<1){  
		  var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm32.SetDataHeader(s_temp);
		}	

		if (gcds_cm33.countrow<1){  
		   var s_temp = "COM_CODE:STRING(10),COM_SNAME:STRING(50),ITEM2:STRING(20) ";
			gcds_cm33.SetDataHeader(s_temp);
		}							
		
	}
	
/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

		
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>ks_em020i_S"
											 + "?v_str1=" + gclx_work_gb.BindColVal;	// 근무구분      
	//prompt('',gcds_data00.DataID);							 
	gcds_data00.Reset();
	
			for(k=1;k<=4;k++){
				eval("gclx_wktm_gb"+k).enable = true;
				eval("gclx_stdt_gb"+k).enable =  true;
				eval("gcem_start_dt"+k).enable =  true;
				eval("gclx_eddt_gb"+k).enable =  true;
				eval("gcem_end_dt"+k).enable =  true;
				eval("gcem_t_unit"+k).enable =  true;
				eval("gcem_stpe_tm"+k).enable =  true;
				eval("gcem_edpe_tm"+k).enable =  true;
			}
		
		gcra_dedu_yn.enable =  true;
		gcem_retm1_fr.enable =  true;     
		gcem_retm1_to.enable =  true;		
		gcem_retm2_fr.enable =  true;		
		gcem_retm2_to.enable =  true;		
	

}	

/******************************************************************************
	 등록
******************************************************************************/
function ln_Add(){

	
		gcds_data00.addrow();
		
			for(k=1;k<=4;k++){
				eval("gclx_wktm_gb"+k).enable = true;
				eval("gclx_stdt_gb"+k).enable =  true;
				eval("gcem_start_dt"+k).enable =  true;
				eval("gclx_eddt_gb"+k).enable =  true;
				eval("gcem_end_dt"+k).enable =  true;
				eval("gcem_t_unit"+k).enable =  true;
				eval("gcem_stpe_tm"+k).enable =  true;
				eval("gcem_edpe_tm"+k).enable =  true;
			}
		
		gcra_dedu_yn.enable =  true;
		gcem_retm1_fr.enable =  true;     
		gcem_retm1_to.enable =  true;		
		gcem_retm2_fr.enable =  true;		
		gcem_retm2_to.enable =  true;	
					
		chk_use_yn1.checked = false;
		chk_use_yn2.checked = false;
		chk_use_yn3.checked = false;
		chk_use_yn4.checked = false;
		
		gcds_data00.namevalue( gcds_data00.rowposition,"USE_YN1") = "F";
		gcds_data00.namevalue( gcds_data00.rowposition,"USE_YN2") = "F"; 
		gcds_data00.namevalue( gcds_data00.rowposition,"USE_YN3") = "F";
		gcds_data00.namevalue( gcds_data00.rowposition,"USE_YN4") = "F";

}


/******************************************************************************
	Descrition : CheckBox
******************************************************************************/
function ln_Chkbox(e,a){

	var row = gcds_data00.rowposition;

	if (e.checked) gcds_data00.namevalue(row,a) = "T";
	else gcds_data00.namevalue(row,a) = "F";
}
	
/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){


	//alert("df:::"+gcds_data00.SysStatus(gcds_data00.rowposition));



	if (!ln_Chk_Save()) return;

	
	if (gcds_data00.IsUpdated) {
		prompt(this,gcds_data00.text);
		if(confirm("정보를 저장하시겠습니까?")){
			gctr_data00.KeyValue = "ks_em020i_t(I450:USER=gcds_data00)";
			gctr_data00.Parameters ="v_str2="+useid;
			gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>ks_em020i_t?";
			gctr_data00.post();
		}
	}
}


/******************************************************************************
	Description : 입력값 체크[근태관리]
******************************************************************************/
function ln_Chk_Save() {


	if (gclx_work_gb.BindColVal == "") { 
		alert("근무구분을 선택해주십시오.");
		return false;
	}




	for(k=1;k<=4;k++){
		if (gcds_data00.namevalue(gcds_data00.rowposition,"USE_YN"+k) == "T" ) {
			if (!ln_Chk_Wktm_gb("gclx_wktm_gb"+k)) return false;
			if (!ln_Chk_Dt_gb("gclx_stdt_gb"+k)) return false;
			if (!ln_Chk_Tm("gcem_start_dt"+k)) return false;
			if (!ln_Chk_Dt_gb("gclx_eddt_gb"+k)) return false;
			if (!ln_Chk_Tm("gcem_end_dt"+k)) return false;
			if (!ln_Chk_Tm("gcem_t_unit"+k)) return false;
			if (!ln_Chk_Tm("gcem_stpe_tm"+k)) return false;
			if (!ln_Chk_Tm("gcem_edpe_tm"+k)) return false;						
		}
	}

	
		
	for(i=1;i<=4;i++){		
		for(j=1;j<=4;j++){
			if(i!=j){
			   alert("Wktm_gb:::::::::"+("gclx_wktm_gb"+i)+":::::::::"+("gclx_wktm_gb"+j));
       			alert(gcds_data00.namevalue(gcds_data00.rowposition,"WKTM_GB"+i));
       			alert(gcds_data00.namevalue(gcds_data00.rowposition,"WKTM_GB"+j));
				if(gcds_data00.namevalue(gcds_data00.rowposition,"WKTM_GB"+i)==gcds_data00.namevalue(gcds_data00.rowposition,"WKTM_GB"+j)) {
					alert("근무시각 구분을 확인하여주십시오.");
//					return false;
				}
			}
		}
	}
	
	return false;

	
	if (!ln_Chk_Date("gcem_start_dt1")) return false;
	if (!ln_Chk_Date("gcem_end_dt1")) return false;
	if (!ln_Chk_Date2("gcem_t_unit1")) return false;
	if (!ln_Chk_Date("gcem_start_dt2")) return false;
	if (!ln_Chk_Date("gcem_end_dt2")) return false ;
	if (!ln_Chk_Date2("gcem_t_unit2")) return false;
	if (!ln_Chk_Date("gcem_start_dt3")) return false;
	if (!ln_Chk_Date("gcem_end_dt3")) return false;
	if (!ln_Chk_Date2("gcem_t_unit3")) return false;
	if (!ln_Chk_Date("gcem_start_dt4")) return false;
	if (!ln_Chk_Date("gcem_end_dt4")) return false;
	if (!ln_Chk_Date2("gcem_t_unit4")) return false;
	

	return true;

	
}


/******************************************************************************
	Description : 시간 값 체크
******************************************************************************/

function ln_Chk_Date(obj) {
    
     var temp = eval(obj).text.substring(0,2);
	 var temp2 = eval(obj).text.substring(2,4);
	 
	 alert("obj::"+obj+"::temp::"+temp+"::temp2::"+temp2);
	 
	 if(temp>"23"||temp2>"59"){
	 	alert("시작시각과 종료시각을 확인하세요.");
	 	return false;
	 }return true;
}


		
function ln_Chk_Date2(obj) {

  var temp3 = eval(obj).text.substring(0,2);
  if(temp3>"59"){
		alert("시간을 확인하세요.");
	 	return false;
	 }return true;	
	
}	


/******************************************************************************
	Description : 빈 공간 체크
******************************************************************************/

function ln_Chk_Wktm_gb(obj) {	

       alert("ln_Chk_Wktm_gb:::::::::"+eval(obj).BindColVal+":::::::::");

		if(eval(obj).BindColVal == "" ){
			alert("근무시간 명칭을 넣어주십시오.");
			return false;
		} return true;
			
}
	
function ln_Chk_Dt_gb(obj) {	

	if(eval(obj).BindColVal == "" ){
		alert("시각 구분을 넣어주십시오.");
		return false;
	} return true;
			
}
	
function ln_Chk_Tm(obj) {	

	if(eval(obj).text == "" ){
		alert("시각을 넣어주십시오.");
		return false;
	} return true;
			
}
	
	
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>




  <script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
 	
	if (gcds_data00.namevalue(row,"USE_YN1") == "T" ) {
		chk_use_yn1.checked = true;
	}	else {
				chk_use_yn1.checked = false;
	}
	if (gcds_data00.namevalue(row,"USE_YN2") == "T" ){
			 chk_use_yn2.checked = true;
	}	else {
				chk_use_yn2.checked = false;
	}
	if (gcds_data00.namevalue(row,"USE_YN3") == "T" ){
			chk_use_yn3.checked = true;
	}	else {
				chk_use_yn3.checked = false;
	}
	if (gcds_data00.namevalue(row,"USE_YN4") == "T" ) {
				chk_use_yn4.checked = true;
	}	else {
				chk_use_yn4.checked = false;
	} 
    </script>
    
    

<!-- 근무시간명칭 -->
  <script language="javascript" for="gcds_cm10" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm10","gclx_wktm_gb1");
  </script>
    <script language="javascript" for="gcds_cm11" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm11","gclx_wktm_gb2");
  </script>
    <script language="javascript" for="gcds_cm12" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm12","gclx_wktm_gb3");
  </script>
    <script language="javascript" for="gcds_cm13" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm13","gclx_wktm_gb4");
  </script>
<!-- 시작시각  -->
  <script language="javascript" for="gcds_cm20" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm20","gclx_stdt_gb1");
  </script>
  <script language="javascript" for="gcds_cm21" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm21","gclx_stdt_gb2");
  </script>
  <script language="javascript" for="gcds_cm22" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm22","gclx_stdt_gb3");
  </script>
  <script language="javascript" for="gcds_cm23" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm23","gclx_stdt_gb4");
  </script>     
  
<!-- 종료시각  -->
  <script language="javascript" for="gcds_cm30" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm30","gclx_eddt_gb1");
  </script>
  <script language="javascript" for="gcds_cm31" event="onloadCompleted(row,colid)">
     ln_Insert_Row(2,"gcds_cm31","gclx_eddt_gb2");
  </script>
  <script language="javascript" for="gcds_cm32" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm32","gclx_eddt_gb3");
  </script>
  <script language="javascript" for="gcds_cm33" event="onloadCompleted(row,colid)">
  ln_Insert_Row(2,"gcds_cm32","gclx_eddt_gb4");
  </script>        
  
 

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">
		</script>



<%

/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 근무구분-->
<OBJECT id=gcds_cm00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 근무시간명칭 -->
<OBJECT id=gcds_cm10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>

<!-- 시작시각  -->
<OBJECT id=gcds_cm20 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm21 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm22 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm23 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>

<!-- 종료시각  -->
<OBJECT id=gcds_cm30 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm31 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm32 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<OBJECT id=gcds_cm33 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="False">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>



<%=HDConstant.COMMENT_START%>
<object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>

<%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	
<script language="javascript" for="gctr_data00" event="OnSuccess()">//
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data00" event="onFail()">
	alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");

	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black board="3" ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="10px">
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand;position:relative;left:3px;top:3px" onclick="ln_Query()">						
							<img src="<%=dirPath%>/Sales/images/plus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="ln_Add()">						
							<img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:hand;position:relative;left:3px;top:3px" onClick="ln_Save()">						
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
			          <tr height="25">        
			             <td bgcolor="#eeeeee" align="center" width="100">근무구분</td>
			             <td bgcolor="#FFFFFF">
			              <%=HDConstant.COMMENT_START%>
			                <OBJECT id=gclx_work_gb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
			                <param name=ComboDataID			value="gcds_cm00">
			                <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
			                <param name=SearchColumn		value=COM_SNAME>
			                <param name=Sort						value=false>
			                <param name=Index						value=0>
			                <param name=ListExprFormat	value="COM_SNAME^0^100">
			                <param name=BindColumn			value=COM_CODE>
			                </OBJECT><%=HDConstant.COMMENT_END%>
			             </td>					
					     
					 </tr>
				</table>
		   </td>
		</tr>
	    <tr>
		   <td >
			   <table  cellpadding="0" cellspacing="0" style="width:829px;font-size:9pt;background-color:#ffffff;">
					<tr> 
						<td width="100px" height="25"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>사용유무</nobr></td>					
						<td width="200px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>근무시간명칭</nobr></td>					
						<td width="200px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>시작시각</nobr></td>					
						<td width="200px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>종료시각</nobr></td>					
						<td width="100px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>시간집계단위</nobr></td>					
					    <td width="100px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>시작허용(분)</nobr></td>	
						<td width="100px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>종료허용(분)</nobr></td>	
					</tr>
					<tr >  
						<td  style="" align=center cellspacing=5 >
					  		<input type="checkbox" id=chk_use_yn1   align=center value="F"  style= "position:relative;left:3px;top:0px;" onclick="ln_Chkbox(this,'USE_YN1')">
					  	</td>
	 					<td style="" bgcolor="#FFFFFF" align=center>
	 						 <%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_wktm_gb1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
						    <param name=ComboDataID			value="gcds_cm10">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
						</td>					
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_stdt_gb1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm20">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_start_dt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_eddt_gb1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm30">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_end_dt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_t_unit1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_stpe_tm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
							
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_edpe_tm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
		 
					</tr>
					<tr>  
						<td  style="" align=center >
					  		<input type="checkbox" id=chk_use_yn2  align=center value="F"  style= "position:relative;left:3px;top:0px;" onclick="ln_Chkbox(this,'USE_YN2')">
					  	</td>
	 					<td  style="" bgcolor="#FFFFFF" align=center>
	 						 <%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_wktm_gb2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
						    <param name=ComboDataID			value="gcds_cm11">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
						</td>					
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_stdt_gb2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm21">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_start_dt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_eddt_gb2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm31">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_end_dt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
				 		
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_t_unit2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
							
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_stpe_tm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
							

				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_edpe_tm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
					 
					</tr>
					<tr>  
						<td  style="" align=center >
					  		<input type="checkbox" id=chk_use_yn3   align=center value="F"  style= "position:relative;left:3px;top:0px;" onclick="ln_Chkbox(this,'USE_YN3')">
					  	</td>
	 					<td  style="" bgcolor="#FFFFFF" align=center>
	 						 <%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_wktm_gb3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
						    <param name=ComboDataID			value="gcds_cm12">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
						</td>					
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_stdt_gb3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm22">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_start_dt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_eddt_gb3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm32">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_end_dt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 		</td>
				 		
				 		
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_t_unit3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
							
							
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_stpe_tm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
							
							
				 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_edpe_tm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>
									 
					</tr>
					<tr>  
						<td  style="" align=center >
					  		<input type="checkbox" id=chk_use_yn4   align=center value="F"  style= "position:relative;left:3px;top:0px;" onclick="ln_Chkbox(this,'USE_YN4')">
					  	</td>
	 					<td  style="" bgcolor="#FFFFFF" align=center>
	 						 <%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_wktm_gb4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
						    <param name=ComboDataID			value="gcds_cm13">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
						</td>					
						<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_stdt_gb4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm23">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
											
						
							<comment id="__NSID__">
							<object  id=gcem_start_dt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 			</td>
							<td  style="" bgcolor="#FFFFFF" align=center>
						 	<%=HDConstant.COMMENT_START%>
						    <OBJECT id=gclx_eddt_gb4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						    style="position:relative;left:0px;top:1px;font-size:12px;width:60px;">
						    <param name=ComboDataID			value="gcds_cm33">
						    <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
						    <param name=SearchColumn		value=COM_SNAME>
						    <param name=Sort						value=false>
						    <param name=Index						value=0>
						    <param name=ListExprFormat	value="COM_SNAME^0^100">
						    <param name=BindColumn			value=COM_CODE>
						    </OBJECT><%=HDConstant.COMMENT_END%>
						    															
							<comment id="__NSID__">
							<object  id=gcem_end_dt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##:##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>					
				 			</td>				 	
					 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_t_unit4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>													
				 			<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_stpe_tm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>									
					 		<td  style=""  align=center><nobr>
							<comment id="__NSID__">
							<object  id=gcem_edpe_tm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style= "position:relative;left:10px;top:1px;width:20px;height:20px;">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="##">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						   </object></comment><script>__ws__(__NSID__);</script>									 		
							&nbsp;&nbsp;&nbsp;분 </nobr></td>			 
					</tr>															
			   </table>
		  </td>
	 </tr>
	  <tr>
	  		<td align=left ><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;">
			          <tr height="25">        
			             <td colspan=2 bgcolor="#eeeeee" class="tab15"  align="center" width="829">휴식시간 설정</td>								     
					 </tr>			             		
     	      	     <tr>
						<td>
							<table cellpadding="0" cellspacing="1" style="width:260px;height:30px;font-size:9pt;">
								<tr>
									<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>공제유무</nobr></td>
								    <td style="height:30px;border:0 ;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__">
									   <object id=gcra_dedu_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:180;cursor:hand;" class="txtbox">
										<param name=Cols     value="3">
										<param name=Format   value="1^예,2^아니오">
									</object></comment><script>__ws__(__NSID__);</script>
								</tr>
								<tr> <td height=30  width=150></td></tr>
							</table>
						</td>
						<td >
							<table cellpadding="0" cellspacing="5" style="width:200px;height:30px;font-size:9pt;">
								<tr>
									<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>휴식시간1</nobr></td>
									<td  style=""  ><nobr>
									<comment id="__NSID__">
									<object  id=gcem_retm1_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="##:##">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								   </object></comment><script>__ws__(__NSID__);</script>	
									</nobr></td>
									<td  style=""  ><nobr>
									<comment id="__NSID__">
									<object  id=gcem_retm1_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:20px;top:1px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="##:##">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								   </object></comment><script>__ws__(__NSID__);</script>	
									</nobr></td>
								</tr>
								<tr> 
									<td width="80px" height="20"  style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>휴식시간2</nobr></td>
									<td  style="" ><nobr>
									<comment id="__NSID__">
									<object  id=gcem_retm2_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:10px;top:1px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="##:##">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								   </object></comment><script>__ws__(__NSID__);</script>	
									</nobr></td>
									<td  style=""  ><nobr>
									<comment id="__NSID__">
									<object  id=gcem_retm2_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:20px;top:1px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="##:##">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
						   			</object></comment><script>__ws__(__NSID__);</script>	
									</nobr></td>													
								</tr>
							</table>
						</td>
					</tr>			
				</table>							 
			</td>
		</tr>
</table>


<comment id="__NSID__"><object	id=gcbn_pay classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data00>
	<param name=BindInfo		value='
		<C>Col=WORK_GB				Ctrl=gclx_work_gb      	Param=BindColVal</C>
		
		<C>Col=USE_YN1				  	Ctrl=chk_use_yn1         Param=value</C>
		<C>Col=WKTM_GB1				Ctrl=gclx_wktm_gb1		Param=BindColVal</C>
		<C>Col=STDT_GB1				Ctrl=gclx_stdt_gb1		Param=BindColVal</C>
		<C>Col=START_DT1				Ctrl=gcem_start_dt1		Param=text</C>
		<C>Col=EDDT_GB1				Ctrl=gclx_eddt_gb1		Param=BindColVal</C>
		<C>Col=END_DT1					Ctrl=gcem_end_dt1		Param=text</C>
		<C>Col=T_UNIT1					Ctrl=gcem_t_unit1			Param=text</C>
		<C>Col=STPE_TM1				Ctrl=gcem_stpe_tm1		Param=text</C>
		<C>Col=EDPE_TM1				Ctrl=gcem_edpe_tm1	Param=text</C>

		<C>Col=USE_YN2					Ctrl=chk_use_yn2      	Param=value</C>        
		<C>Col=WKTM_GB2				Ctrl=gclx_wktm_gb2		Param=BindColVal</C>  
		<C>Col=STDT_GB2				Ctrl=gclx_stdt_gb2		Param=BindColVal</C>  
		<C>Col=START_DT2				Ctrl=gcem_start_dt2		Param=text</C>        
		<C>Col=EDDT_GB2				Ctrl=gclx_eddt_gb2		Param=BindColVal</C>  
		<C>Col=END_DT2					Ctrl=gcem_end_dt2		Param=text</C>        
		<C>Col=T_UNIT2					Ctrl=gcem_t_unit2			Param=text</C>        
		<C>Col=STPE_TM2				Ctrl=gcem_stpe_tm2		Param=text</C>        
		<C>Col=EDPE_TM2				Ctrl=gcem_edpe_tm2	Param=text</C>        

		<C>Col=USE_YN3					Ctrl=chk_use_yn3         Param=value</C>       
		<C>Col=WKTM_GB3				Ctrl=gclx_wktm_gb3	 	Param=BindColVal</C> 
		<C>Col=STDT_GB3				Ctrl=gclx_stdt_gb3	 	Param=BindColVal</C>  
		<C>Col=START_DT3				Ctrl=gcem_start_dt3	 	Param=text</C>        
		<C>Col=EDDT_GB3				Ctrl=gclx_eddt_gb3	 	Param=BindColVal</C>  
		<C>Col=END_DT3					Ctrl=gcem_end_dt3		Param=text</C>        
		<C>Col=T_UNIT3					Ctrl=gcem_t_unit3			Param=text</C>       
		<C>Col=STPE_TM3				Ctrl=gcem_stpe_tm3	 	Param=text</C>        
		<C>Col=EDPE_TM3				Ctrl=gcem_edpe_tm3	Param=text</C>       
		
		<C>Col=USE_YN4					Ctrl=chk_use_yn4         Param=value</C>  
		<C>Col=WKTM_GB4				Ctrl=gclx_wktm_gb4		Param=BindColVal</C> 		
		<C>Col=STDT_GB4				Ctrl=gclx_stdt_gb4	 	Param=BindColVal</C> 
		<C>Col=START_DT4				Ctrl=gcem_start_dt4	 	Param=text</C> 
		<C>Col=EDDT_GB4				Ctrl=gclx_eddt_gb4	 	Param=BindColVal</C>        
		<C>Col=END_DT4					Ctrl=gcem_end_dt4	 	Param=text</C> 
		<C>Col=T_UNIT4					Ctrl=gcem_t_unit4			Param=text</C>       		
		<C>Col=STPE_TM4				Ctrl=gcem_stpe_tm4	 	Param=text</C>       
		<C>Col=EDPE_TM4				Ctrl=gcem_edpe_tm4	Param=text</C> 
		
		<C>Col=DEDU_YN				Ctrl=gcra_dedu_yn     	Param=CodeValue</C>
		<C>Col=RETM1_FR			  	Ctrl=gcem_retm1_fr       Param=text</C>
		<C>Col=RETM1_TO				Ctrl=gcem_retm1_to		Param=text</C>
		<C>Col=RETM2_FR				Ctrl=gcem_retm2_fr		Param=text</C>
		<C>Col=RETM2_TO				Ctrl=gcem_retm2_to		Param=text</C> 		
	'>
</object></comment><script>__ws__(__NSID__);</script>

			
<!--------------------------------- 코딩 부분 끝 -------------------------------->
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>
