<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 기본급 관리
+ 프로그램ID : em021i.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em021_S.java,Em021_T.java
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
	var year_date = gcurdate.substring(0,7);
	var yymmdd = gcurdate;
	*/
	
	var gs_date = '<%=firstday%>';
	var year_date = gs_date.substring(0,6);
	var yymmdd = gs_date;
	
    var useid = gusrid;

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



/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em021_S"
											 + "?v_str1=" + fn_trim(gcem_yymm1.Text);					//기준년월
//	prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
}


/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//기능구분  CM013
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_CM010?v_str1=CM013";
	gcds_cm013.Reset();
	//근속년차  CM017
	gcds_cm017.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_CM010?v_str1=CM017";
	gcds_cm017.Reset();	

  gcds_date.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em021_S2";
  gcds_date.Reset();	

	if(gcds_date.countrow>0){
		gcem_yymm1.text = gcds_date.namevalue(gcds_date.rowposition,"YYYYMM");
	}else{
		gcem_yymm1.Text = year_date;
	}
}

  /*----------------------------------------------------------------------------
		Description : 추가 - 인사마스터
----------------------------------------------------------------------------*/
	function ln_Add(e){
		 gcds_data00.addrow();
	}
/*----------------------------------------------------------------------------
	Description : 저장 - 인사마스터
----------------------------------------------------------------------------*/
function ln_Save(e){
		if(e=='01'){
				if (gcds_data00.IsUpdated) {				
					 if (confirm("새로운 정보를 저장하시겠습니까?")){				
  						gctr_data00.KeyValue = "Em021_T(I:USER=gcds_data00)";
							gctr_data00.Parameters ="v_str1="+useid;
							//alert(year_date+"::"+useid);
							//prompt('',gcds_data00.text);
							//alert(gctr_data00.Parameters);
							gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em021_T";
							gctr_data00.post();
					 }
				}
		}
 }
/*----------------------------------------------------------------------------
	Description : 삭제 - 인사마스터
----------------------------------------------------------------------------*/
function ln_Delete(e){
		if (e=='01') {
					if (confirm("선택한 정보를 삭제하시겠습니까?")) {
							gcds_data00.deleterow(gcds_data00.rowposition);
							gctr_data00.KeyValue = "Em021_T(I:USER=gcds_data00)";
							gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em021_T";
							gctr_data00.post();
					}
		}
}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
function ln_Excel(){

 var szName = "기본급 관리";
 var szPath = "C:\\Test\\em021i.xls";
	if (gcds_data00.countrow<1){
	alert("다운로드 하실 자료가 없습니다");
	}else{
	gcgd_disp.GridToExcel(szName,szPath,2);
	}
}


/******************************************************************************
	Description : 일괄생성
******************************************************************************/
function ln_Batch(){
	if(!ln_Batch_Chk()) return;
  var arrParam	= new Array();
	var strURL = "../popup/em021_popup.jsp";
	var strPos = "dialogWidth:400px;dialogHeight:240px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
}


/******************************************************************************
	Description : 일괄생성 체크
******************************************************************************/
function ln_Batch_Chk(){
	
	return true
}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>


<%/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/%>

    <script language="javascript" for="gctr_data00" event="OnSuccess()">
      alert("요청하신 작업을 성공적으로 수행하였습니다.");
    </script>
    <script language="javascript" for="gctr_data00" event="OnFail()">
      alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
    </script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>



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
<%
/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/
%>


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
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 공통코드 -->
<OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_date  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
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
							<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Batch()">
							<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
							<img src="<%=dirPath%>/Sales/images/plus.gif"	    style="cursor:hand" onClick="ln_Add('01')" >
							<img src="<%=dirPath%>/Sales/images/minus.gif"     style="cursor:hand" onClick="ln_Delete('01')" >		
							<img src="<%=dirPath%>/Sales/images/save.gif"		  style="cursor:hand" onClick="ln_Save('01')">
							<img src="<%=dirPath%>/Sales/images/excel.gif"     style="cursor:hand" onClick="ln_Excel('01')" >		
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
           	<td bgcolor="#eeeeee" align="center" width="60">기준년월</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_yymm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_yymm1', 'Text');">
              </td>
            </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:600px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:600;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=37,  align=right </F> 
              <C>ID=YYYYMM,  	Name=기준년월,	width=90px,		 align=center,		HeadBgColor=#B9D4DC	,Mask='XXXX/XX'</C>	
              <C>ID=SKILL_CD,	Name=기능구분,	width=100px,	 align=center,		HeadBgColor=#B9D4DC	,EditStyle=Lookup,Data='gcds_cm013:COM_CODE:COM_SNAME'  sort=true</C>	
              <C>ID=CON_YEAR,	Name=근속년차,	width=100px,	 align=center,		HeadBgColor=#B9D4DC	,EditStyle=Lookup,Data='gcds_cm017:COM_CODE:COM_SNAME'  sort=true</C>	
              <C>ID=B_PAY,   	Name=기본급,		width=125px,	 align=right,		  HeadBgColor=#B9D4DC	</C>	
              <C>ID=T_PAY,   	Name=시급,	width=125px,		   align=right,		  HeadBgColor=#B9D4DC	 dec=2</C>	
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:600;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td>
							<table cellpadding=0 cellspacing=0 style="width:218px;height:390px;">
								<tr height="18">
                  <td bgcolor="#eeeeee" align="center" width="60" class="tab_z1010">기준년월</td>
                  <td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_yymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_yymm2', 'Text');">
                  </td>
								</tr>
                <tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">기능구분</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_skill_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm013">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">근속년차</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_con_year classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm017">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >기본급</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_bpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=2>
                    <param name=Border	      value=true>
                    <param name=Numeric       value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >시급</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_t_pay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:80px;  font-family:굴림; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=2> 
                    <param name=Border	      value=true>
										<param name=MaxDecimalPlace   value=2>
                    <param name=Numeric       value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
                <tr height="200">
                  <td bgcolor="#eeeeee" class="tab_z1011">&nbsp;</td>
                  <td bgcolor="#FFFFFF" class="tab_z1111">&nbsp;</td>
                </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- 기본탭 -->
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data00">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
                <C>Col=YYYYMM     			Ctrl=gcem_yymm2   				Param=Text</C>
                <C>Col=SKILL_CD   			Ctrl=gclx_skill_cd   			Param=bindcolval</C>
                <C>Col=CON_YEAR   			Ctrl=gclx_con_year   			Param=bindcolval</C>
                <C>Col=B_PAY      			Ctrl=gcem_bpay   					Param=Text</C>
                <C>Col=T_PAY      			Ctrl=gcem_t_pay   				Param=Text</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>