<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 인사현황
+ 프로그램ID : em013s.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.02
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em013_S.java
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
/*
	var gs_date = gcurdate;
	var year_date = gcurdate.substring(2,4);
	var yymmdd = gcurdate;
*/

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			//gcem_contr_fr.Text = yymmdd;
		}
/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em013_S"
											 + "?v_str1=" + fn_trim(gclx_vend_cd.bindcolval)			//근무업체
											 + "&v_str2=" + fn_trim(gclx_job_cd.bindcolval)			  //직종
											 + "&v_str3=" + fn_trim(gcem_contr_fr.Text)					  //계약일 from
											 + "&v_str4=" + fn_trim(gcem_contr_to.Text)					  //계약일 to
											 + "&v_str5=" + fn_trim(gclx_dept_cd.bindcolval)			//부서
											 + "&v_str6=" + fn_trim(gclx_agency_cd.bindcolval)		//인력대리점
											 + "&v_str7=" + fn_trim(gcem_stdt_fr.Text)	          //입사일 from 
											 + "&v_str8=" + fn_trim(gcem_stdt_to.Text)						//입사일 to
											 + "&v_str9=" + fn_trim(gclx_team_cd.bindcolval)			//소속팀
											 + "&v_str10=" + fn_trim(gclx_country_cd.bindcolval)	//국적
											 + "&v_str11=" + fn_trim(gcem_passdt_fr.Text)				  //여권만료일 from
											 + "&v_str12=" + fn_trim(gcem_passdt_to.Text)				  //여권만료일 to
											 + "&v_str13=" + fn_trim(gclx_work_cd.bindcolval)		  //근무지
											 + "&v_str14=" + fn_trim(gclx_nation_cd.bindcolval)	  //민족
											 + "&v_str15=" + fn_trim(gclx_sex.bindcolval)				  //성별
											 + "&v_str16=" + fn_trim(gclx_usts.bindcolval)				//재직구분
											 + "&v_str17=" + fn_trim(gclx_con_year.bindcolval)		//근속년차
											 + "&v_str18=" + fn_trim(gclx_att_cd.bindcolval)			//학력
											 + "&v_str19=" + fn_trim(gclx_rem_bnk.bindcolval) 		//송금은행
											 + "&v_str20=" + fn_trim(gclx_retgb_cd.bindcolval) 		//귀국구분
											 + "&v_str21=" + fn_trim(blchk.value);		            //BLACKLIST

//	prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
}


/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

		//근무업체  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();

	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();

	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();

	//인력대리점  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM005";
	gcds_cm005.Reset();

	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();

	//국적  SY005
	gcds_cm020.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm020?v_str1=SY005";
	gcds_cm020.Reset();

	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();

	//민족  CM020
	gcds_cu003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM020";
	gcds_cu003.Reset();

	//근속년차
	gcds_cm017.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM017";
	gcds_cm017.Reset();

	//학력  
	gcds_cm028.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM028";
	gcds_cm028.Reset();

	//송금은행 
	gcds_cm027.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM027";
	gcds_cm027.Reset();

	//귀국구분 
	gcds_cm032.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032.Reset();

	}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "인사 현황";
    var szPath = "C:\\Test\\em013s.xls";
       if (gcds_data00.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }

 /*----------------------------------------------------------------------------
	Description : 출력
----------------------------------------------------------------------------*/
	 function ln_Print(){
			alert("개발 중");
	 }

 /*----------------------------------------------------------------------------
	Description : black list 체크박스
----------------------------------------------------------------------------*/
function ln_ChkBox_Chk(){
	if(blchk.checked==true){
		blchk.value="Y";
	}else{
		blchk.value="";
	}
}
</script>
<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    
    
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>
	<!-- 근무업체 -->
	<script language="javascript" for="gcds_cm019" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm019","gclx_vend_cd");
	</script>
	<!-- 직종 -->
	<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
	  ln_Insert_Row(2,"gcds_cm004","gclx_job_cd");
	</script>
	<!-- 부서 -->
	<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm006","gclx_dept_cd");
	</script>
	<!-- 인력대리점 -->
	<script language="javascript" for="gcds_cm005" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm005","gclx_agency_cd");
	</script>
	<!-- 소속팀 -->
	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
	</script>
	<!-- 국적 -->
	<script language="javascript" for="gcds_cm020" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm020","gclx_country_cd");
	</script>
	<!-- 근무지 -->
	<script language="javascript" for="gcds_cm007" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm007","gclx_work_cd");
	</script>
	<!-- 민족 -->
	<script language="javascript" for="gcds_cu003" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cu003","gclx_nation_cd");
	</script>

	<script language="javascript" for="gcds_cm017" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm017","gclx_con_year");
	</script>

	<script language="javascript" for="gcds_cm028" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm028","gclx_rem_bnk");
	</script>

	<script language="javascript" for="gcds_cm027" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm027","gclx_att_cd");
	</script>

		<script language="javascript" for="gcds_cm032" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm032","gclx_retgb_cd");
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>


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



<!-- 인사기본 -->
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
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
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
<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm028 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm027 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm032 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
							<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel()">
							<!-- <img src="<%=dirPath%>/Sales/images/print.gif"	style="cursor:hand"  onclick="ln_Print()"> -->
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center" >재직구분</td>
            <td  bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%><OBJECT id=gclx_usts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
              style="position:relative;left:7px;top:1px;font-size:12px;width:100px;">
              <param name=CBData					value="^[전체],1^재직^,2^휴직,3^퇴직">
              <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
              <param name=Index						value=0>
              <param name=SearchColumn		value="COM_SNAME">
              <param name=ListExprFormat	value="COM_SNAME^0^70">								
              <param name=BindColumn			value="COM_CODE">
              <param name=Enable					value="true">
              </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
						<td bgcolor="#eeeeee" align="center">근속년차</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_con_year classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm017">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">학력</td>
						<td bgcolor="#FFFFFF"  ><%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_att_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm027">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">계약일</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_contr_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_contr_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_contr_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_contr_to', 'Text');"> 
						</td>
						
          </tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">근무업체</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_vend_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm019">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">직종</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_job_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm004">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">성별</td>
						<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%>
								<object id=gclx_sex classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
								<param name=CBData					value="^[전체],M^남,F^여">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
								<param name=index						value="0">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^100">
								<param name=BindColumn			value="Code">
								</object><%=HDConstant.COMMENT_END%>
						</td>
            <td bgcolor="#eeeeee" align="center">입사일</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_stdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_stdt_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_stdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_stdt_to', 'Text');">
						</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">부서</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">인력대리점</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_agency_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm005">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">송금은행</td>
						<td bgcolor="#FFFFFF" ><%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_rem_bnk classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm028">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

						<td bgcolor="#eeeeee" align="center">여권만료일</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_passdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_passdt_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_passdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_passdt_to', 'Text');">
						</td>
						
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">소속팀</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">국적</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_country_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm020">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">귀국구분</td>
						<td bgcolor="#FFFFFF" colspan=3>
						  <%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_retgb_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm032">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">근무지</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_work_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm007">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">민족</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_nation_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cu003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

			     <td bgcolor="#eeeeee" align="center">Black List</td>
					 <td bgcolor="#FFFFFF" colspan=3>								
					      <input type="checkbox" id=blchk   value=""    style="position:relative;left:4px;top:0px;cursor:hand;width:22px" onClick="ln_ChkBox_Chk()">
					 </td> 

						<!-- <td bgcolor="#eeeeee" align="center">출력구분</td>
						<td bgcolor="#FFFFFF" colspan=3><%=HDConstant.COMMENT_START%>
								<object id=gclx_hm_gbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
								<param name=CBData					value=" ^ ,1^명부현황,2^인원현황">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
								<param name=index						value="0">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^100">
								<param name=BindColumn			value="Code">
								</object><%=HDConstant.COMMENT_END%>
						</td> -->
				
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=0 style="width:827px;height:327px;">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:827;height:307px;border:0">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"     value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO				  ID={CurRow}         HeadAlign=Center   HeadBgColor=#B9D4DC Width=30,  align=right </F> 
								<FC>Name=근무업체,  ID=VEND_CD			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm019:COM_CODE:COM_SNAME', </FC>
								<FC>Name=부서,      ID=DEPT_CD					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm006:COM_CODE:COM_SNAME', </FC>
								<FC>Name=소속팀,    ID=TEAM_CD				  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', </FC>
								<FC>Name=근무지,    ID=WORK_CD				  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm007:COM_CODE:COM_SNAME', </FC>
								<FC>Name=사번,      ID=EMPNO					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=left,  sort = true </FC>
								<FC>Name=성명,      ID=EMPNMK					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=left,  sort = true </FC>						
								<C>Name=직종,       ID=JOB_CD					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm004:COM_CODE:COM_SNAME', </C>
								<C>Name=대리점,     ID=AGENCY_CD        HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm005:COM_CODE:COM_SNAME', </C>
								<C>Name=국적,       ID=COUNTRY_CD			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm020:COM_CODE:COM_SNAME', </C>
								<C>Name=민족,       ID=NATION_CD			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cu003:COM_CODE:COM_SNAME', </C>
								<C>Name=계약일,     ID=CSTART_DT		    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=입사일,     ID=ASTART_DT			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=여권번호,   ID=PASS_NO          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=여권만료일, ID=PASS_EXPIRE_DATE HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=성별,       ID=SEX							HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true, value={if(SEX='M','남',IF(SEX='F','여',''))}</C>
								<C>Name=년차,       ID=CON_YEAR 			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm017:COM_CODE:COM_SNAME', </C>
								<C>Name=학력,       ID=ATT_CD  			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm027:COM_CODE:COM_SNAME', </C>
								<G>Name=중국내연락처  HeadBgColor=#B9D4DC,
                <C>Name=성명,       ID=CHI_NM           HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=관계,       ID=CHI_RNM          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=전화번호,   ID=CHI_TEL          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								<C>Name=주소,       ID=CHI_ADD          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								</G>
								<G>Name=송금정보    HeadBgColor=#B9D4DC,
								<C>Name=은행,       ID=REM_BNK 			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm028:COM_CODE:COM_SNAME', </C>
								<C>Name=예금주,     ID=SAV_NM           HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=전화번호,   ID=SAV_TEL          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true  </C>
								<C>Name=송금계좌,   ID=REM_ACC          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								</G>
								<C>Name=재직,       ID=USESTS					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true EditStyle=Combo,Data='1:재직,2:휴직,3:퇴직', </C>
								<C>Name=귀국구분,   ID=RETGB					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,EditStyle=Lookup,Data='gcds_cm032:COM_CODE:COM_SNAME',</C>
								<C>Name=블랙리스트, ID=BLCHK					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
									<fieldset style="width:827;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
									</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>
