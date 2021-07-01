<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 급여계산
+ 프로그램ID : em026i.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.20
----------------------------------------------------------------------------------
+ 수정내용 : 급여계산로직 반영
+ 수 정 자 : 정영식
+ 수정일자 : 2008.01.09
----------------------------------------------------------------------------------
+ 서블릿명 : Em026_S.java
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
	//로컬에서 사용하기 위해 임의로 막음.
    /*
	var gs_date = gcurdate;
	*/
    var gs_date ='<%=firstday%>';

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

		}
/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(e){//성명조회

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

  if(e=='01'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno.value = arrParam[0];
        txt_empnmk.value = arrParam[1];
       }
       else{
        txt_empno.value = "";
        txt_empnmk.value = "";
      }
  }
}

/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){
	gcds_data0.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//급여년월
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
											 + "&v_str3=" + fn_trim(gcem_payym2.text);        //지급일자
  //prompt('',gcds_data0.DataID);
	gcds_data0.Reset();
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){
  //지급구분  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();
	//gcem_payym.text = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	gcem_payym.text = gs_date.substring(0,6);
}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
 /*
	function ln_Excel(){

    var szName = "급여대장";
    var szPath = "C:\\Test\\em024s.xls";
      if (gcds_data00.countrow<1){
        alert("다운로드 하실 자료가 없습니다");
      }
      else{
        gcgd_disp.GridToExcel(szName,szPath,2);
      }
  }//END ln_Excel
  */

/*----------------------------------------------------------------------------
	Description : 마감
----------------------------------------------------------------------------*/
function ln_Close(){
	ln_DataSet_Add();
	if (confirm("급여마감작업을 하시겠습니까?")){
		gctr_data99.KeyValue = "Em026_t1(I:USER=gcds_data)";
		gctr_data99.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t99?";
		gctr_data99.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data99.post();
	}

}

/*----------------------------------------------------------------------------
	Description : 급여계산시 데이타셋추가
----------------------------------------------------------------------------*/
function ln_DataSet_Add(){
  gcds_data.ClearAll();
	ln_SetDataHeader();
	gcds_data.addrow();
	gcds_data.namevalue(gcds_data.rowposition,"PAY_YM") = gcem_payym.text;
	gcds_data.namevalue(gcds_data.rowposition,"PAY_DIV") = "1";
	gcds_data.namevalue(gcds_data.rowposition,"I_EMPNO") = gusrid;
}


/*----------------------------------------------------------------------------
	Description : 급여계산 - 시작
	1. 급여대상자 생성
	2. 기본급2, 기본급3 생성
	3. 시급1, 시급2 생성
----------------------------------------------------------------------------*/
function ln_Create(){
	if(!ln_Save_Chk()) return;
	ln_DataSet_Add();
	if (confirm( gcem_payym.text.substring(0,4)+"년"+gcem_payym.text.substring(4,6)+"월 급여계산을 하시겠습니까?")){
		window.status="대상자생성,근무일수";
		gctr_data1.KeyValue = "Em026_t1(I:USER=gcds_data)";
		gctr_data1.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t1?";
		gctr_data1.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data1.post();
	}
}

/*----------------------------------------------------------------------------
	Description : 급여계산 - STEP 1 
	1. 기본계 계산
	2. OT계 계산
----------------------------------------------------------------------------*/
function ln_Cal_A(){
	 
	  window.status="기본급계산,OT계산";
		ln_DataSet_Add();
      gctr_data2.KeyValue = "Em026_t2(I:USER=gcds_data)";
		gctr_data2.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t2?";
		gctr_data2.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data2.post();
}

/*----------------------------------------------------------------------------
	Description : 급여계산 - STEP2
	1. 휴가 미실시 대상자 조회
	2. 20일분 계산을 위한 2년전 기본급 계산
	3. 근속수당 계산
	4. 항공운임 계산
	5. 20일분 계산
----------------------------------------------------------------------------*/
function ln_Cal_B(){
	  window.status="휴가 미실시관련-근속수당, 항공운임, 20일분 계산"; 
		ln_DataSet_Add();
    gctr_data3.KeyValue = "Em026_t3(I:USER=gcds_data)";
		gctr_data3.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t3?";
		gctr_data3.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data3.post();
}

/*----------------------------------------------------------------------------
	Description : 급여계산 -  STEP3
	1.상여금 계산
----------------------------------------------------------------------------*/
function ln_Cal_C(){
	  window.status="상여금 계산";
		ln_DataSet_Add();
    gctr_data4.KeyValue = "Em026_t4(I:USER=gcds_data)";
		gctr_data4.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t4?";
		gctr_data4.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data4.post();
}

/*----------------------------------------------------------------------------
	Description : 급여계산 -  STEP4
	1.퇴직금 계산
----------------------------------------------------------------------------*/
function ln_Cal_D(){
	  window.status="퇴직금 계산";
	  ln_DataSet_Add();
		gctr_data5.KeyValue = "Em026_t5(I:USER=gcds_data)";
		gctr_data5.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t5?";
		gctr_data5.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data5.post();
}


/*----------------------------------------------------------------------------
	Description : 급여계산 -  STEP6 공제처리 
  1.전화비,2.가불공제, 3.전화비유보, 4.전화비유보지급
----------------------------------------------------------------------------*/
function ln_Cal_G(){
	  window.status="공제 계산";
		ln_DataSet_Add();
    gctr_data8.KeyValue = "Em026_t8(I:USER=gcds_data)";
		gctr_data8.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t8?";
		gctr_data8.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data8.post();
}

/*----------------------------------------------------------------------------
	Description : 급여계산 -  STEP7
  1.예외처리 (전월소급, 기타공제 포함)
----------------------------------------------------------------------------*/
function ln_Cal_H(){
	  window.status="예외처리 계산";
		ln_DataSet_Add();
    gctr_data9.KeyValue = "Em026_t9(I:USER=gcds_data)";
		gctr_data9.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_t9?";
		gctr_data9.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data.text);
		gctr_data9.post();
}

/*----------------------------------------------------------------------------
	Description : 급여계산시 체크 
----------------------------------------------------------------------------*/
function ln_Save_Chk(){
	if(gcem_payym.text==""){
		alert("급여년월을 입력하십시요.");
		return false;	
	}

	//급여마감작업을 했을경우 재 계산 못함.
  gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em026_S1"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//급여년월
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval) 	//지급구분
											 + "&v_str3=" ;
  //prompt('',gcds_data0.DataID);
	gcds_data2.Reset();
  
	if(gcds_data2.countrow>=1){
		if(gcds_data2.namevalue(1,"WRKSTS")=="C"){
			alert("이미 마감 되었습니다. 급여계산을 할 수 없습니다.");
			return false;
		}
	}
  

	return true;
}

/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data.countrow<1){
		var s_temp = " PAY_YM:STRING(6),PAY_DIV:STRING(1),I_EMPNO:STRING(10)";
		gcds_data.SetDataHeader(s_temp);
	}
}


/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_Start_Load(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
  document.all.LowerFrame.style.visibility="visible";
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_End_Load(row,cnt){
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	eval(cnt).innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}
}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>
<!-- 지급구분 -->
<script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
		//ln_Insert_Row(1,"gcds_cm018","gclx_paydiv");
		gclx_paydiv.index=0;
</script>

<script language="javascript" for="gcds_data0" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data0" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/
%>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	 ln_Cal_A(); //기본급계산,OT계산
</script>
<script language="javascript" for="gctr_data1" event="onfail()">
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data2" event="onsuccess()">
  ln_Cal_B(); //휴가 미실시관련-근속수당, 항공운임, 20일분 계산
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data3" event="onsuccess()">
  ln_Cal_C(); //상여금 계산
</script>
<script language="javascript" for="gctr_data3" event="onfail()">
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data4" event="onsuccess()">
  ln_Cal_D(); //퇴직금
</script>
<script language="javascript" for="gctr_data4" event="onfail()">
	alert("Error Code : " + gctr_data4.ErrorCode + "\n" + "Error Message : " + gctr_data4.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data5" event="onsuccess()">
  	ln_Cal_G()
</script>
<script language="javascript" for="gctr_data5" event="onfail()">
	alert("Error Code : " + gctr_data5.ErrorCode + "\n" + "Error Message : " + gctr_data5.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data8" event="onsuccess()">
  	ln_Cal_H(); 
</script>
<script language="javascript" for="gctr_data8" event="onfail()">
	alert("Error Code : " + gctr_data8.ErrorCode + "\n" + "Error Message : " + gctr_data8.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data9" event="onsuccess()">
  window.status="급여계산 완료";
	alert("급여계산을 완료 했습니다.");
</script>
<script language="javascript" for="gctr_data9" event="onfail()">
  	alert("Error Code : " + gctr_data9.ErrorCode + "\n" + "Error Message : " + gctr_data9.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data99" event="onsuccess()">
  window.status="급여마감 완료";
	alert("급여마감작업을 완료 했습니다.");
</script>
<script language="javascript" for="gctr_data99" event="onfail()">
  	alert("Error Code : " + gctr_data9.ErrorCode + "\n" + "Error Message : " + gctr_data9.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_data0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 공통코드 -->
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data4" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data5" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data6" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data7" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data8" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data9" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<object id="gctr_data99" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
						    <img src="<%=dirPath%>/Sales/images/n_create.gif"	   style="cursor:hand"  onclick="ln_Create()"> 
 								<img src="<%=dirPath%>/Sales/images/refer.gif"   	   style="cursor:hand" onclick="ln_Query()">
								<img src="<%=dirPath%>/Sales/images/btn_close.gif"    style="cursor:hand;position:relative;top:1px;" onclick="ln_Close()">
							<!-- 	<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print('01')">
								<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="ln_Excel('01')"> -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center">급여년월</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_payym', 'Text');">
            </td>
            <td bgcolor="#eeeeee" align="center">지급구분</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm018">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
            <td bgcolor="#eeeeee" align="center">지급일자</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_payym2', 'Text');">
            </td>
          </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:819px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:819;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
                <C>ID=APPDT	,	  Name='급여년월',	width=55px,	align=center,	HeadBgColor=#B9D4DC</C>
                <C>ID=PAYDIV,	  Name='지급구분',	width=55px,	align=center,	HeadBgColor=#B9D4DC  EditStyle=Combo Data='1:급여'</C>
                <C>ID=PAYDIV,	  Name='급여구분',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAYDT	,	  Name='지급일'  ,	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PBDIV	,	  Name='항목구분',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAYCD	,	  Name='항목코드',	width=55px,	align=center,	HeadBgColor=#B9D4DC,show=false</C>
                <C>ID=PAY_NM,	  Name='급여항목',  width=80px,	align=left,	  HeadBgColor=#B9D4DC</C>
                <C>ID=FRDT	,	  Name='시작일'  ,	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XXXX/XX/XX'</C>
                <C>ID=FRTM	,	  Name='시작시간',	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XX:XX:XX'</C>
                <C>ID=TODT	,	  Name='종료일'  ,	width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XXXX/XX/XX'</C>
                <C>ID=TOTM	,	  Name='종료시간',  width=80px,	align=center,	HeadBgColor=#B9D4DC mask='XX:XX:XX'</C>
                <C>ID=WRKSTS,	  Name='상태'  ,	  width=55px,	align=center,	HeadBgColor=#B9D4DC EditStyle=Combo Data='1:진행중,2:완료,E:에러,C:마감'</C>
                <C>ID=MEMO	,	  Name='비고'  ,	  width=204px,align=left,	HeadBgColor=#B9D4DC</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:819;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- 기본탭 -->
					
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>