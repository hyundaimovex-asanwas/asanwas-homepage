<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 공제입력
+ 프로그램ID : em022i.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em022_S | Em022_S2 | Em022_T | Em022_T2.java
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
    //로컬에서 사용하기 위해 임의로 막음.
    /*
	var year_date = gcurdate.substring(0,7);
    */
    var gs_date ='<%=firstday%>';
    var year_date =gs_date.substring(0,6);

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
      gcem_paym.Text = year_date;
      sp0.style.display = ""
		}
/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(e){//성명조회
  /*
  if(e=='02'){

	}else if(e=='03'){

	}
	*/

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	

  if(e=='01'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno.value = arrParam[0];
        txt_empnmk.value = arrParam[1];
      } else {
        txt_empno.value = "";
        txt_empnmk.value = "";
      }
  }else if(e=='02'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno_T.value = arrParam[0];
        txt_empnmk_T.value = arrParam[1];
        txt_deptcd_T1.value = arrParam[2];
        txt_teamcd_T1.value = arrParam[3];
        txt_cust_T.value = arrParam[4];
        txt_jobcd_T1.value = arrParam[5];
        txt_deptcd_T2.value = arrParam[6];
        txt_teamcd_T2.value = arrParam[7];
        txt_vendcd_T.value = arrParam[8];
        txt_workcd_T.value = arrParam[9];
      } else {
        txt_empno_T.value = "";
        txt_empnmk_T.value = "";
        txt_deptcd_T1.value = "";
        txt_teamcd_T1.value = "";
        txt_cust_T.value = "";
        txt_jobcd_T1.value = "";
        txt_deptcd_T2.value = "";
        txt_teamcd_T2.value = "";
        txt_vendcd_T.value = "";
        txt_workcd_T.value = "";
      }
  }else if(e=='03'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno_R.value = arrParam[0];
        txt_empnmk_R.value = arrParam[1];
        txt_deptcd_R1.value = arrParam[2];
        txt_teamcd_R1.value = arrParam[3];
        txt_cust_R.value = arrParam[4];
        txt_jobcd_R1.value = arrParam[5];
        txt_deptcd_R2.value = arrParam[6];
        txt_teamcd_R2.value = arrParam[7];
        txt_vendcd_R.value = arrParam[8];
        txt_workcd_R.value = arrParam[9];
        
				
        if(fn_trim(gcem_payym00.text)!="")gcem_payym03.text=gcem_payym00.text;
        if(fn_trim(gcem_pay_ym00.text)!="")gcem_pay_ym.text=gcem_pay_ym00.text;
				if(fn_trim(gcem_pay_amt00.text)!="")gcem_pay_amt.text=gcem_pay_amt00.text;
				

      } else {
        txt_empno_R.value = "";
        txt_empnmk_R.value = "";
        txt_deptcd_R1.value = "";
        txt_teamcd_R1.value = "";
        txt_cust_R.value = "";
        txt_jobcd_R1.value = "";
        txt_deptcd_R2.value = "";
        txt_teamcd_R2.value = "";
        txt_vendcd_R.value = "";
        txt_workcd_R.value = "";

        
				if(fn_trim(gcem_payym00.text)=="")gcem_payym03.text="";
        if(fn_trim(gcem_pay_ym00.text)=="")gcem_pay_ym.text="";
				if(fn_trim(gcem_pay_amt00.text)=="")gcem_pay_amt.text=0;
				
      }
  }
}


/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

  // if(gcte_disp.ActiveIndex =='1'){ //전화비
  //    gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_S"
  //                       + "?v_str1=" + fn_trim(gcem_paym.Text)				//급여년월
  //                       + "&v_str2=" + fn_trim(txt_empno.value);			//사번
  //    gcds_data00.Reset();
  // }else if(gcte_disp.ActiveIndex =='2' ){ //가불
      gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_S2"
                         + "?v_str1=" + fn_trim(gcem_paym.Text)				//급여년월
                         + "&v_str2=" + fn_trim(txt_empno.value)			//사번
												 + "&v_str3=" + gcem_dav_dt_fr.text			     //가불일자
												 + "&v_str4=" + gcem_dav_dt_to.text;			   //사번
      gcds_data01.Reset();
   //}
 }
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm004?v_str1=CM004";
	gcds_cm004.Reset();
	//근무업체  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm019?v_str1=CM019";
	gcds_cm019.Reset();
	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM006";
	gcds_cm006.Reset();
	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm003?v_str1=CM003";
	gcds_cm003.Reset();
	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm007?v_str1=CM007";
	gcds_cm007.Reset();
	
}

/*----------------------------------------------------------------------------
		Description : 추가 - 
----------------------------------------------------------------------------*/
	function ln_Add(){

			//if(gcte_disp.ActiveIndex =='1'){
			//		gcds_data00.addrow();
			//		var row = gcds_data00.rowposition;
			//		if (row<1) return;
			//}else if(gcte_disp.ActiveIndex =='2'){
					gcds_data01.addrow();
					var row = gcds_data01.rowposition;
					if (row<1) return;
     // }
	}
/*----------------------------------------------------------------------------
	Description : 저장 - 
----------------------------------------------------------------------------*/
  function ln_Save(){
			//	if(gcte_disp.ActiveIndex =='1'){
			//		if (gcds_data00.IsUpdated) {
			//			if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1'){
			//						confirm("새로운 정보를 저장하시겠습니까?")
			//			}else if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='3'){
			//						confirm("변경된 정보를 저장하시겠습니까?")
			//			}
			//			gctr_data00.KeyValue = "Em022_T(I:USER=gcds_data00)";
			//			gctr_data00.Parameters ="v_str1="+useid;
			//			gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_T";
			//			gctr_data00.post();
			//		}
			//	}else if(gcte_disp.ActiveIndex =='2'){
					if (gcds_data01.IsUpdated) {
							if (confirm("선택한 정보를 저장하시겠습니까?")) {
								gctr_data01.KeyValue = "Em022_T2(I:USER=gcds_data01)";
								gctr_data01.Parameters ="v_str1="+useid;
								gctr_data01.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_T2";
								gctr_data01.post();
							}
					}
      // }
   }
/*----------------------------------------------------------------------------
	Description : 삭제 - 
----------------------------------------------------------------------------*/
  function ln_Delete(){
		 // if (gcte_disp.ActiveIndex =='1') {
		 //			if (confirm("선택한 정보를 삭제하시겠습니까?")) {
		 //				gcds_data00.deleterow(gcds_data00.rowposition);
		 //				gctr_data00.KeyValue = "Em022_T(I:USER=gcds_data00)";  //전화비
		 //				gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_T";
						//prompt('',gcds_data00.text)
	   //					gctr_data00.post();
		 //		}
		 // } else if(gcte_disp.ActiveIndex =='2'){  //가불
          if (confirm("선택한 정보를 삭제하시겠습니까?")) {
						gcds_data01.deleterow(gcds_data01.rowposition);
						gctr_data01.KeyValue = "Em022_T2(I:USER=gcds_data01)";
						gctr_data01.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em022_T2";
						gctr_data01.post();
					}
     // }
  }
/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
function ln_Excel(){

 // if(gcte_disp.ActiveIndex =='1'){
 //	var szName = "전화비유보";
 //	var szPath = "C:\\Test\\em022i.xls";
 //	if (gcds_data00.countrow<1){
 //			alert("다운로드 하실 자료가 없습니다");
//		}else{
//			gcgd_disp.GridToExcel(szName,szPath,2);
//		}
 // }else{
		var szName = "전화비유보";
		var szPath = "C:\\Test\\em022i.xls";
		if (gcds_data01.countrow<1){
			alert("다운로드 하실 자료가 없습니다");
		}else{
			gcgd_disp1.GridToExcel(szName,szPath,2);
		}
 // }
}//END ln_Excel

</script>
<%/*=============================================================================
				Developer Java Script 끝
=============================================================================*/%>

<%/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/%>
	<script language="javascript" for="gcte_disp" event="onselChanged(index)">
			if(index==1){ //전화비
				 sp0.style.display = "none";
				 //top_param.="급여년월";
			}else{
				 sp0.style.display = "";  //가불
				 //top_param.text="공제년월";
			}
	</script>

<%/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/	%>

    <script language="javascript" for="gctr_data00" event="OnSuccess()">
      alert("요청하신 작업을 성공적으로 수행하였습니다.");
    </script>
    <script language="javascript" for="gctr_data00" event="OnFail()">
      alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
    </script>
    <script language="javascript" for="gctr_data01" event="OnSuccess()">
      alert("요청하신 작업을 성공적으로 수행하였습니다.");
    </script>
    <script language="javascript" for="gctr_data01" event="OnFail()">
      alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
    </script>
<%/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/%>

<%/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/%>
  	<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
		</script>
		<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
		</script>

    <script language="javascript" for="gcds_data01" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
		</script>
		<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
		</script>

<%/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/%>


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
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 공통코드 -->
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cu003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gctr_data01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
							<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
              <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="ln_Add()" >
              <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete()" >		
              <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" onClick="ln_Excel('01')" >		
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		
		<tr height="30">
			<td valign="top" height="30"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="30">
           	<td bgcolor="#eeeeee" align="center" width="80"><font id="top_param">급여년월</font></td>
						<td bgcolor="#FFFFFF" width="110">
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_paym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:2px;cursor:hand" onclick="__GetCallMonth('gcem_paym', 'Text');">
            </td>
            <td bgcolor="#eeeeee" align="center" width="60">성명</td>
						<td bgcolor="#FFFFFF">
              <input type="text" id="txt_empno" style="position:relative;left:8px;width:60px;">
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand"  onclick="ln_Find('01')">
              <input type="text" id="txt_empnmk" style="position:relative;left:8px;top:-1px;width:120px;" readonly>
            </td>
						<td bgcolor="#FFFFFF">
							<span id=sp0 style="display:none;height:30px" bgcolor="#708090">
              <table cellpadding=0 cellspacing=1 style="width:330px;height:28px" >
							  <tr height="28">
									<td bgcolor="#eeeeee" align="center" width="60">가불일자</td>
									<td bgcolor="#FFFFFF" colspan =3>
										<%=HDConstant.COMMENT_START%>
										<OBJECT id=gcem_dav_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:4px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:4px;cursor:hand" onclick="__GetCallCalendar7('gcem_dav_dt_fr','Text');">
										 &nbsp;&nbsp;&nbsp;~
										<%=HDConstant.COMMENT_START%>
										<OBJECT id=gcem_dav_dt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:4px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:4px;cursor:hand" onclick="__GetCallCalendar7('gcem_dav_dt_to','Text');">
									</td>
								</tr>
							</table>
					  </span>
						</td>
          </tr>
				</table>
			</td>
		</tr>
		<tr height="3"> <td></td></tr>
		<!-- 공제입력 -->
		 <tr>
			<td>
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="30">
           	<td bgcolor="#B3D392" align="center" width="80">입력설정</td>
						<td bgcolor="#D0F2ED" align="center" width="80">가불일자</td>
						<td bgcolor="#FFFFFF">
							 <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_payym00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_payym00', 'Text');">
						</td>
					 	<td bgcolor="#D0F2ED" align="center" width="80">급여공제년월</td>
						<td bgcolor="#FFFFFF">
							  <%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_pay_ym00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
								<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_pay_ym00', 'Text');">
						</td>
            <td bgcolor="#D0F2ED" align="center" width="80">가불금액</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_pay_amt00 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=2>
							<param name=Border	      value=true>
							<param name=Numeric       value="true">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 
					</tr>
				</table>
			</td>
		</tr> 

		<tr>
			<td align="left"><br>
				<table width="829" height="20px" border="0"  cellspacing="0" cellpadding="0" border=1><!-- 탭 영역 시작-->
					<tr>
            <td height="20px" colspan="2">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252  VIEWASTEXT style="width:660px;height:20px;position:relative;right:0px;">
              <PARAM NAME="BackColor"   VALUE="#cccccc">
              <PARAM NAME="titleHeight" VALUE="20px">
              <PARAM NAME="DisableBackColor" VALUE="#eeeeee">
              <PARAM NAME="Format" VALUE="
              <T>divid=layer2  title=가불</T>      ">
              </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
					</tr>																		
				</table>
			</td>
		</tr>

		<tr>
		<!-- 전화비유보 -->
		
		<td valign="top" bgcolor="#FFFFFF"  border="7" >
       <!--  <div id="layer1">
				<table cellpadding=0 cellspacing=1 style="width:550px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:550;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
                <C>ID=YYYYMM,       Name=급여\\년월,       width=50px,	align=center,		HeadBgColor=#B9D4DC,	Mask='XXXX/XX' sort=true</C>
								<C>ID=TEAM_NM,      Name=소속,             width=80px,	align=left,			HeadBgColor=#B9D4DC	sort=true</C> 
								<C>ID=EMPNO,        Name=사번,             width=55px,	align=center,		HeadBgColor=#B9D4DC	sort=true</C>
                <C>ID=EMPNMK,       Name=성명,             width=55px,	align=left,			HeadBgColor=#B9D4DC	sort=true</C>
                <C>ID=TELUBO_PAY,		Name=전화비유보,       width=70px,	align=right,		HeadBgColor=#B9D4DC	</C>
                <C>ID=TELSAVE_PAY,	Name=전화비\\유보지급, width=70px,	align=right,		HeadBgColor=#B9D4DC	</C>
                <C>ID=REMARK,		    Name=비고,			       width=125px,	align=left,			HeadBgColor=#B9D4DC	</C>
							">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:550;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
              &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
              </td>
              <td bgcolor="#FFFFFF">&nbsp;</td>
              <td>
							<table cellpadding=0 cellspacing=0 style="width:268px;height:390px;">
                <tr height="18">
									<td width="120"   align="center" bgcolor="#eeeeee" class="tab_z1010">성명</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <input type="text" id="txt_empnmk_T" style="position:relative;left:8px;width:80px;" readonly><input type="hidden" id="txt_empno_T" style="position:relative;left:8px;width:80px;">
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand"  onclick="ln_Find('02')">
									</td>
								</tr>
								 <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >부서</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_deptcd_T2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_deptcd_T1" style="position:relative;left:8px;width:80px;" readonly>
                    <input type="hidden" id="txt_cust_T" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_vendcd_T" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_workcd_T" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_jobcd_T1" style="position:relative;left:8px;width:40px;" readonly>
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >소속</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_teamcd_T2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_teamcd_T1" style="position:relative;left:8px;width:80px;" readonly>
									</td>
								</tr>
               
								<tr height="18">
                  <td align="center" bgcolor="#eeeeee" class="tab_z1010">급여년월</td>
                  <td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_payym02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallMonth('gcem_payym02', 'Text');">
                  </td>
								</tr>
                <tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">전화비유보</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_telubopay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=2>
                    <param name=Border	      value=true>
                    <param name=Numeric       value="true">
                    <param name=Format       value=0000000000>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >전화비유보분지급</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_telsavepay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=2>
                    <param name=Border	      value=true>
                    <param name=Numeric      value="true">
                    <param name=Format       value=0000000000>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr height="40">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >비고</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <textarea id="txt_remark" class="txtbox"  style= "width:120px; height:30px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</nobr>
									</td>
								</tr>
                <tr height="160">
                  <td bgcolor="#eeeeee" class="tab_z1011" >&nbsp;</td>
                  <td bgcolor="#FFFFFF" class="tab_z1111" >&nbsp;</td>
                </tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
 -->
			<!-- 가불 -->
      <div id="layer2" >
				<table cellpadding=0 cellspacing=1 style="width:550px;height:357px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp1 style="width:550;height:337px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO			  ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
                <C>ID=PAY_YM,     Name=공제\\년월,width=50px,	align=center,		HeadBgColor=#B9D4DC,	Mask='XXXX/XX' sort=true</C>
                <C>ID=TEAM_NM,    Name=소속,      width=80px,	  align=left,			HeadBgColor=#B9D4DC	sort=true</C> 
								<C>ID=EMPNO,      Name=사번,      width=55px,	  align=center,		HeadBgColor=#B9D4DC	sort=true</C>
                <C>ID=EMPNMK,     Name=성명,      width=55px,	  align=left,			HeadBgColor=#B9D4DC	sort=true</C>																																					 
                <C>ID=PAY_AMT,	  Name=가불금액,	width=70px,  	align=right,		HeadBgColor=#B9D4DC	</C>																																							 
 								<C>ID=DAV_DT,		  Name=가불일자,	width=70px,		align=center,		HeadBgColor=#B9D4DC	,Mask='XXXX/XX/XX' sort=true</C>
								<C>ID=REMARK,		  Name=비고,	    width=120px,	align=left,			HeadBgColor=#B9D4DC	</C>																																							 
							">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:550;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
              &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
              </td>
              <td bgcolor="#FFFFFF">&nbsp;</td>
              <td>
							<table cellpadding=0 cellspacing=0 style="width:268px;height:357px;">
                <tr height="20">
									<td width="120" align="center" bgcolor="#eeeeee" class="tab_z1010">성명</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <input type="text" id="txt_empnmk_R" style="position:relative;left:8px;width:80px;" readonly><input type="hidden" id="txt_empno_R" style="position:relative;left:8px;width:80px;">
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand"  onclick="ln_Find('03')">
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >부서</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_deptcd_R2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_deptcd_R1" style="position:relative;left:8px;width:80px;" readonly>
                    <input type="hidden" id="txt_cust_R" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_vendcd_R" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_workcd_R" style="position:relative;left:8px;width:80px;">
                    <input type="hidden" id="txt_jobcd_R1" style="position:relative;left:8px;width:40px;" readonly>
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >소속</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <input type="text" id="txt_teamcd_R2" style="position:relative;left:8px;width:40px;" readonly>
                    <input type="text" id="txt_teamcd_R1" style="position:relative;left:8px;width:80px;" readonly>
									</td>
								</tr>
								<tr height="20">
                  <td align="center"  bgcolor="#eeeeee" class="tab_z1010">가불일자</td>
                  <td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_payym03 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_payym03', 'Text');">
                  </td>
								</tr>
                <tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">급여공제년월</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_pay_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_pay_ym', 'Text');">
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >가불금액</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_pay_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=2>
                    <param name=Border	      value=true>
                    <param name=Numeric       value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr height="40">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >비고</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <textarea id="txt_remark_R" class="txtbox"  style= "width:120px; height:30px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
									</td>
								</tr>
                <tr height="160">
                  <td bgcolor="#eeeeee" class="tab_z1011" >&nbsp;</td>
                  <td bgcolor="#FFFFFF" class="tab_z1111" >&nbsp;</td>
                </tr>
							</table>
						</td>
					</tr>
				</table>
				</div>
			</td>
		</tr>

	</table>
	<!-- 기본탭 -->
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data00">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
								<C>Col=EMPNO     			Ctrl=txt_empno_T     					Param=Value</C>
								<C>Col=EMPNMK   			Ctrl=txt_empnmk_T   					Param=Value</C>
								<C>Col=TEAM_CD				Ctrl=txt_teamcd_T2						Param=Value</C>
								<C>Col=TEAM_NM   			Ctrl=txt_teamcd_T1   					Param=Value</C>
								<C>Col=DEPT_CD   			Ctrl=txt_deptcd_T2   					Param=Value</C>
								<C>Col=DEPT_NM 				Ctrl=txt_deptcd_T1  					Param=Value</C>
								<C>Col=CUST_SID				Ctrl=txt_cust_T  						  Param=Value</C>
								<C>Col=JOB_CD   			Ctrl=txt_jobcd_T1 						Param=Value</C>
                <C>Col=VEND_CD  		  Ctrl=txt_vendcd_T 				  	Param=Value</C>
								<C>Col=WORK_CD  		  Ctrl=txt_workcd_T	  			  	Param=Value</C>
								<C>Col=YYYYMM   			Ctrl=gcem_payym02 						Param=Text</C>
								<C>Col=TELUBO_PAY			Ctrl=gcem_telubopay						Param=Text</C>
								<C>Col=TELSAVE_PAY		Ctrl=gcem_telsavepay					Param=Text</C>
								<C>Col=REMARK  		  	Ctrl=txt_remark 					  	Param=value</C>

							">
						</OBJECT><%=HDConstant.COMMENT_END%>

            <%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data01 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data01">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
								<C>Col=EMPNO     			Ctrl=txt_empno_R     					Param=Value</C>
								<C>Col=EMPNMK   			Ctrl=txt_empnmk_R   					Param=Value</C>
								<C>Col=TEAM_CD				Ctrl=txt_teamcd_R2						Param=Value</C>
								<C>Col=TEAM_NM   			Ctrl=txt_teamcd_R1   					Param=Value</C>
								<C>Col=DEPT_CD   			Ctrl=txt_deptcd_R2   					Param=Value</C>
								<C>Col=DEPT_NM 				Ctrl=txt_deptcd_R1  					Param=Value</C>
								<C>Col=CUST_SID				Ctrl=txt_cust_R  						  Param=Value</C>
								<C>Col=JOB_CD   			Ctrl=txt_jobcd_R1 						Param=Value</C>
                <C>Col=VEND_CD  		  Ctrl=txt_vendcd_R 				  	Param=Value</C>
                <C>Col=WORK_CD  		  Ctrl=txt_workcd_R				    	Param=Value</C>
								<C>Col=DAV_DT	   			Ctrl=gcem_payym03 						Param=Text</C>
								<C>Col=PAY_YM				  Ctrl=gcem_pay_ym					  	Param=Text</C>
								<C>Col=PAY_AMT		    Ctrl=gcem_pay_amt				    	Param=Text</C>
								<C>Col=REMARK  		  	Ctrl=txt_remark_R 					 	Param=value</C>

							">
						</OBJECT><%=HDConstant.COMMENT_END%>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>