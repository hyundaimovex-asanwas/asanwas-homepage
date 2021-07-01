<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 미인선현황
+ 프로그램ID : em012s.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.05
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

	//로컬에서 사용하기 위해 임의로 막음.
   /*
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	var yymmdd = gcurdate;
	*/
	
	var gs_date ='<%=firstday%>';
	var yymmdd ='<%=firstday%>';
	
	var useid = gusrid;
  
	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			gcem_contr_fr.Text = yymmdd;

			gcem_toman.Enable=false;
			gcem_towom.Enable=false;
			gcem_arrman.Enable=false;
			gcem_arrwom.Enable=false;;
			gcem_bakman.Enable=false;
			gcem_bakwom.Enable=false;
		}
/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){
	var empno_yy = gs_date;
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em012_S"
									 + "?v_str1=" + fn_trim(gcem_contr_fr.Text);	//계약일 from

	gcds_data.Reset();
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();
	//근무업체  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();
	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();

//--우측 바인딩부분
  	//직종  CM004
	gcds_R4.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_R4.Reset();
	//근무업체  CM019
	gcds_R19.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_R19.Reset();
	//부서  CM006
	gcds_R6.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_R6.Reset();
	//소속팀  CM003
	gcds_R3.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_R3.Reset();
	
	gcem_arrdt.text = gs_date.substring(4,8);

}
/*----------------------------------------------------------------------------
	Description : 저장 - 인사마스터
----------------------------------------------------------------------------*/
function ln_Save(){

	if(gcds_data.namevalue(1,'CHK')==0){
			gcds_data00.UseChangeInfo = "false";
			confirm("새로운 정보를 저장하시겠습니까?")
	}else{
			gcds_data00.UseChangeInfo = "true";
			confirm("변경된 정보를 저장하시겠습니까?")
	}

	if(gcds_data00.IsUpdated) {
		gctr_data00.KeyValue = "Em012_T1(I:USER=gcds_data00)";
		gctr_data00.Parameters ="v_str1="+useid;
		gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em012_T1";
		gctr_data00.post();
	}
}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
function ln_Excel(){

		var szName1 = "미인선 현황";
		var szPath = "C:\\Test\\em012s.xls";
		if (gcds_data00.countrow<1){
			alert("다운로드 하실 자료가 없습니다");
		}else{
			gcgd_disp.GridToExcel(szName1,szPath,2);
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
	<!-- 직종 -->
	<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
		gcds_cm004.insertrow(1);
		gcds_cm004.namevalue(1,"COM_CODE") = "";
		gcds_cm004.namevalue(1,"COM_SNAME") = "전체";
		gclx_job_cd.index = 0;
	</script>
	<!-- 근무업체 -->
	<script language="javascript" for="gcds_cm019" event="onloadCompleted(row,colid)">
		gcds_cm019.insertrow(1);
		gcds_cm019.namevalue(1,"COM_CODE") = "";
		gcds_cm019.namevalue(1,"COM_SNAME") = "전체";
		gclx_vend_cd.index = 0;
	</script>
	<!-- 부서 -->
	<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
		gcds_cm006.insertrow(1);
		gcds_cm006.namevalue(1,"COM_CODE") = "";
		gcds_cm006.namevalue(1,"COM_SNAME") = "전체";
		gclx_dept_cd.index = 0;
	</script>
	<!-- 소속팀 -->
	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		gcds_cm003.insertrow(1);
		gcds_cm003.namevalue(1,"COM_CODE") = "";
		gcds_cm003.namevalue(1,"COM_SNAME") = "전체";
		gclx_team_cd.index = 0;
	</script>
	<!-- 근무지 -->
	<script language="javascript" for="gcds_cm007" event="onloadCompleted(row,colid)">
		gcds_cm007.insertrow(1);
		gcds_cm007.namevalue(1,"COM_CODE") = "";
		gcds_cm007.namevalue(1,"COM_SNAME") = "전체";
		gclx_work_cd.index = 0;
	</script>

	<!-- 근무업체 -->
	<script language="javascript" for="gcds_R19" event="onloadCompleted(row,colid)">
		gcds_R19.insertrow(1);
		gcds_R19.namevalue(1,"COM_CODE") = "";
		gcds_R19.namevalue(1,"COM_SNAME") = "";
		gclx_vend_r.index = 0;
	</script>
	<!-- 부서 -->
	<script language="javascript" for="gcds_R6" event="onloadCompleted(row,colid)">
		gcds_R6.insertrow(1);
		gcds_R6.namevalue(1,"COM_CODE") = "";
		gcds_R6.namevalue(1,"COM_SNAME") = "";
		gclx_dept_r.index = 0;
	</script>
	<!-- 소속팀 -->
	<script language="javascript" for="gcds_R3" event="onloadCompleted(row,colid)">
		gcds_R3.insertrow(1);
		gcds_R3.namevalue(1,"COM_CODE") = "";
		gcds_R3.namevalue(1,"COM_SNAME") = "";
		gclx_team_r.index = 0;
	</script>
	<!-- 직종 -->
	<script language="javascript" for="gcds_R4" event="onloadCompleted(row,colid)">
	  gcds_R4.insertrow(1);
		gcds_R4.namevalue(1,"COM_CODE") = "";
		gcds_R4.namevalue(1,"COM_SNAME") = "";
		gclx_job_r.index = 0;
	</script>

 <script language="javascript" for="gcds_data" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
		var gc_yy = gcem_arrdt.Text;
		var gc_mm = gcem_arrdt.Text;
		gc_yy = gc_yy.substring(0,2);
		gc_mm = gc_mm.substring(2,4);
		gcgd_disp.columnprop("id1","name") = gc_yy + "/"+ gc_mm +" 입경 " ;
 </script>

	<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

			if(gcds_data.namevalue(1,'CHK')==0 ){
				gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em012_S2"
													 + "?v_str1=" + fn_trim(gcem_contr_fr.Text)					//기준일 
													 + "&v_str2=" + fn_trim(gclx_job_cd.bindcolval)			//직종
													 + "&v_str3=" + fn_trim(gclx_vend_cd.bindcolval)		//근무업체
													 + "&v_str4=" + fn_trim(gclx_dept_cd.bindcolval)		//부서
													 + "&v_str5=" + fn_trim(gclx_team_cd.bindcolval)		//소속팀
													 + "&v_str6=" + fn_trim(gclx_work_cd.bindcolval)		//근무지
													 + "&v_str7=" + gs_date;                   				  //현재시스템날짜
				//prompt('',gcds_data00.DataID );
				gcds_data00.Reset();
				txt_vstr.value = "신규";
			}else{
				gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em012_S1"
													 + "?v_str1=" + fn_trim(gcem_contr_fr.Text)					  //기준일 
													 + "&v_str2=" + fn_trim(gclx_job_cd.bindcolval)			  //직종
													 + "&v_str3=" + fn_trim(gclx_vend_cd.bindcolval)			//근무업체
													 + "&v_str4=" + fn_trim(gclx_dept_cd.bindcolval)			//부서
													 + "&v_str5=" + fn_trim(gclx_team_cd.bindcolval)			//소속팀
													 + "&v_str6=" + fn_trim(gclx_work_cd.bindcolval) 		  //근무지
													 + "&v_str7=" + gs_date;                              //현재시스템날짜
				gcds_data00.Reset();
				txt_vstr.value = "수정";
			}
	</script>

  <script language="javascript" for="gcds_data00" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
	</script>
	<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">

			if(gcds_data00.countrow>0){
					gcem_toman.Enable=true;
					gcem_towom.Enable=true;
					gcem_arrman.Enable=true;
					gcem_arrwom.Enable=true;
					gcem_bakman.Enable=true;
					gcem_bakwom.Enable=true;
			}else{
					gcem_toman.Enable=false;
					gcem_towom.Enable=false;
					gcem_arrman.Enable=false;
					gcem_arrwom.Enable=false;
					gcem_bakman.Enable=false;
					gcem_bakwom.Enable=false;
			}

			/*

			var sum = eval(gcem_toman.Text) + eval(gcem_towom.Text);
			gcem_totot.Text = sum;
			var sum = eval(gcem_arrman.Text) + eval(gcem_arrwom.Text);
			gcem_arrtot.Text = sum;
			var sum = eval(gcem_bakman.Text) + eval(gcem_bakwom.Text);
			gcem_baktot.Text = sum;
			*/

			if(gcds_data.namevalue(1,'CHK')==0){
				for(i=1;i<=row;i++){
					gcds_data00.namevalue(i,"SEQ")=i;
				}
			}
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
	</script>

<!-- T/O -->
	<script language=JavaScript for=gcem_toman event=OnKillFocus()>
		  if(fn_trim(gcem_toman.Text)=="")gcem_toman.Text=0;
			if(fn_trim(gcem_towom.Text)=="")gcem_towom.Text=0;
			gcem_totot.text = parseFloat(gcem_toman.Text) + parseFloat(gcem_towom.Text);
	</script>
	<script language=JavaScript for=gcem_towom event=OnKillFocus()>
	    if(fn_trim(gcem_toman.Text)=="")gcem_toman.Text=0;
			if(fn_trim(gcem_towom.Text)=="")gcem_towom.Text=0;
			gcem_totot.text = parseFloat(gcem_toman.Text) + parseFloat(gcem_towom.Text);		
	</script>
<!-- 입경자 -->
	<script language=JavaScript for=gcem_arrman event=OnKillFocus()>
      if(fn_trim(gcem_arrman.Text)=="")gcem_arrman.Text=0;
			if(fn_trim(gcem_arrwom.Text)=="")gcem_arrwom.Text=0;
			gcem_arrtot.text = parseFloat(gcem_arrman.Text) + parseFloat(gcem_arrwom.Text);	
	</script>
	<script language=JavaScript for=gcem_arrwom event=OnKillFocus()>
		  if(fn_trim(gcem_arrman.Text)=="")gcem_arrman.Text=0;
			if(fn_trim(gcem_arrwom.Text)=="")gcem_arrwom.Text=0;
			gcem_arrtot.text = parseFloat(gcem_arrman.Text) + parseFloat(gcem_arrwom.Text);	
	</script>
<!-- 귀국예정자 -->
	<script language=JavaScript for=gcem_bakman event=OnKillFocus()>
			if(fn_trim(gcem_bakman.Text)=="")gcem_bakman.Text=0;
			if(fn_trim(gcem_bakwom.Text)=="")gcem_bakwom.Text=0;
			gcem_baktot.text = parseFloat(gcem_bakman.Text) + parseFloat(gcem_bakwom.Text);	
	</script>
	<script language=JavaScript for=gcem_bakwom event=OnKillFocus()>
	    if(fn_trim(gcem_bakman.Text)=="")gcem_bakman.Text=0;
			if(fn_trim(gcem_bakwom.Text)=="")gcem_bakwom.Text=0;
			gcem_baktot.text = parseFloat(gcem_bakman.Text) + parseFloat(gcem_bakwom.Text);	
	</script>
<!--     <script language=JavaScript for=gcds_data00 event=OnRowPosChanged(row)>

//alert("OnRowPosChanged");
         var skm_cnt_amt;

//           skm_cnt_amt = gcds_data00.Sum(9,0,0);
//           gcgd_disp.ColumnProp('SKM_CNT','SumText')="skm_cnt_amt";
           gcgd_disp.ColumnProp('SKM_CNT','SumText') = gcds_data00.Sum(9,0,0);
    </script> -->

<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/	%>
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


<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"        VALUE="false">
  <PARAM NAME="UseChangeInfo"   VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>


<!-- 공통코드 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cu003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_R4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_R19 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_R3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_R6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">		
							<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand"  onclick="ln_Save()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">기준년월</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_contr_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_contr_fr', 'Text');">
						</td>
						<td bgcolor="#eeeeee" align="center">직종</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_job_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm004">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">근무업체</td>
						<td bgcolor="#FFFFFF" colspan="3">
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
            <td bgcolor="#eeeeee" align="center">입경일</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_arrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="##/##">
								<param name=PromptChar	  value="_">
								<param name=ReadOnly      value="true">
                <param name=ReadOnlyBackColor      value=#CCFFCC>
								</OBJECT><%=HDConstant.COMMENT_END%>
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
						<td bgcolor="#eeeeee" align="center">근무지</td>
						<td bgcolor="#FFFFFF" colspan="3">
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
                <input type="hidden" id="txt_nowdate">
						</td>
            <td bgcolor="#FFFFFF" colspan="2"><input type="text" id="txt_vstr" style="position:relative;left:5px;width:40px;color:red" readonly></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:625px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:625;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
              <param name="viewsummary"		value="1">
							<param name="sortview"     value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO				  ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=25,  align=right  SumBgColor=#C3D0DB</F> 
								<FC>Name='근무업체',ID=VEND_CD, width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,EditStyle=Lookup,Data='gcds_cm019:COM_CODE:COM_SNAME', sort = true,sumText='합 계' SumBgColor=#C3D0DB</FC>
                <FC>Name=부서,      ID=DEPT_CD, width=80,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,EditStyle=Lookup,Data='gcds_cm006:COM_CODE:COM_SNAME', sort = true SumBgColor=#C3D0DB</FC>
                <FC>Name=소속팀,    ID=TEAM_CD, width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', sort = true SumBgColor=#C3D0DB</FC>
                <FC>Name=직종,      ID=JOB_CD,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,EditStyle=Lookup,Data='gcds_cm004:COM_CODE:COM_SNAME', sort = true SumBgColor=#C3D0DB</FC>
                <G> name='T/O'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=TO_MCNT  ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=TO_FCNT  ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=TO_CNT   ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,sumText=@sum SumBgColor=#C3D0DB</C>
                </G>
                <G> name='현재원'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=CUR_MCNT ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=CUR_FCNT ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=CUR_CNT  ,width=27,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                </G>
                <G> id='id1' name=''  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=ARR_MCNT  ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=ARR_FCNT  ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=ARR_CNT   ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                </G>
                <G> name='휴가자'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=HOL_MCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=HOL_FCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=HOL_CNT  ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, sumText=@sum SumBgColor=#C3D0DB</C>
                </G>
                <G> name='미인선인원'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=SKM_MCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, bgcolor='#CCFFCC',value={subsum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT)} ,sumText={sum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT)} SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=SKM_FCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, bgcolor='#CCFFCC',value={subsum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT)} ,sumText={sum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT)} SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=SKM_CNT ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right   bgcolor='#CCFFCC',value={subsum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT)+subsum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT)},sumText={sum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT)+sum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT)}  SumBgColor=#C3D0DB</C>
                </G>
                <G> name='귀국예정자'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=BAK_MCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=BAK_FCNT ,width=20,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', sumText=@sum SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=BAK_CNT  ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', sumText=@sum SumBgColor=#C3D0DB</C>
                </G>
                <G> name='충원인원'  HeadBgColor=#B9D4DC,
                <C>Name='남',ID=CHO_MCNT ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, bgcolor='#CCFFCC' ,value={subsum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT+BAK_MCNT)} ,sumText={sum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT+BAK_MCNT)} SumBgColor=#C3D0DB</C>
                <C>Name='여',ID=CHO_FCNT ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right, bgcolor='#CCFFCC' ,value={subsum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT+BAK_FCNT)} ,sumText={sum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT+BAK_FCNT)} SumBgColor=#C3D0DB</C>
                <C>Name='계',ID=CHO_CNT ,width=30,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,  bgcolor='#CCFFCC' ,value={subsum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT+BAK_MCNT)+subsum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT+BAK_FCNT)} ,sumText={sum(TO_MCNT-CUR_MCNT+ARR_MCNT-HOL_MCNT+BAK_MCNT)+sum(TO_FCNT-CUR_FCNT+ARR_FCNT-HOL_FCNT+BAK_FCNT)} SumBgColor=#C3D0DB</C>
                </G>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:625;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td>
							<table cellpadding=0 cellspacing=0 style="width:193px;height:390px;">
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" width="80">근무업체</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" width="95">
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_vend_r classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:95px;">
                    <param name=ComboDataID			value="gcds_R19">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    <param name=Enable2         value=false>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >부서</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_dept_r classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:95px;">
                    <param name=ComboDataID			value="gcds_R6">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    <param name=Enable2         value=false>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >소속</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_team_r classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:1px;font-size:12px;width:95px;">
                    <param name=ComboDataID			value="gcds_R3">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    <param name=Enable2         value=false>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >직종</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_job_r classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                    style="position:relative;left:8px;top:0px;font-size:12px;width:95px;">
                    <param name=ComboDataID			value="gcds_R4">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
                    <param name=Enable2         value=false>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="10">
								<td colspan="2" class="tab_z0010">&nbsp;</td>
								</tr>
								<tr>
									<td align="left" bgcolor="#eeeeee" class="tab_z1010" ><b>T/O</b><font style="position:relative;left:51px;">남</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_toman classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px;  font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<!-- <input type="text" id="gcem_toman" style="position:relative;left:5px;width:30px"> -->
									</td>
								</tr>
								<tr>
									<td align="right" bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:2px;">여</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_towom classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<!-- <input type="text" id="txt_towom" style="position:relative;left:5px;width:30px"> -->
									</td>
								</tr>
								<tr>
									<td align="right" bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:2px;">계</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_totot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
                    <param name=ReadOnly      value="true">
                    <param name=ReadOnlyBackColor      value=#CCFFCC>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<!-- <input type="text" id="gcem_totot" style="position:relative;left:5px;width:30px"> -->
									</td>
								</tr>
								<tr>
									<td align="left" bgcolor="#eeeeee" class="tab_z1010" ><b>입경자</b><font style="position:relative;left:33px;">남</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_arrman classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_arrman" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
								<tr>
									<td align="right" bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:2px;">여</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_arrwom classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_arrwom" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
								<tr>
									<td align="right" bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:2px;">계</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_arrtot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=GeneralEdit   value="true">
                    <param name=ReadOnly      value="true">
                    <param name=ReadOnlyBackColor      value=#CCFFCC>
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_arrtot" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
								<tr>
									<td align="left" bgcolor="#eeeeee" class="tab_z1010" ><b>귀국예정자</b><font style="position:relative;left:8px;">남</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_bakman classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_bakman" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
								<tr>
									<td align="right"  bgcolor="#eeeeee" class="tab_z1010" ><font style="position:relative;right:2px;">여</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_bakwom classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=SelectAll     value="true">
										<param name=SelectAllOnClick   value="true">
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_bakwom" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
								<tr>
									<td align="right" bgcolor="#eeeeee" class="tab_z1011" ><font style="position:relative;right:2px;">계</font></td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_baktot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:굴림; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=2>
										<param name=Border	      value=true>
										<param name=Numeric       value="true">
										<param name=Format	      value="000">
										<param name=GeneralEdit   value="true">
                    <param name=ReadOnly      value="true">
                    <param name=ReadOnlyBackColor      value=#CCFFCC>
										</OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <input type="text" id="gcem_baktot" style="position:relative;left:5px;width:30px"> -->
                  </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- 바인딩 -->
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data00">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
              <C>Col=VEND_CD   			Ctrl=gclx_vend_r   					Param=bindcolval</C>
              <C>Col=DEPT_CD				Ctrl=gclx_dept_r						Param=bindcolval</C>
              <C>Col=TEAM_CD   			Ctrl=gclx_team_r   					Param=bindcolval</C>
              <C>Col=JOB_CD   			Ctrl=gclx_job_r   					Param=bindcolval</C>
              <C>Col=TO_MCNT 				Ctrl=gcem_toman  						Param=Text</C>
              <C>Col=TO_FCNT 				Ctrl=gcem_towom  						Param=Text</C>
              <C>Col=TO_CNT  		  	Ctrl=gcem_totot 						Param=Text</C>
              <C>Col=ARR_MCNT  			Ctrl=gcem_arrman 						Param=Text</C>
              <C>Col=ARR_FCNT  			Ctrl=gcem_arrwom 						Param=Text</C>
              <C>Col=ARR_CNT 		  	Ctrl=gcem_arrtot 						Param=Text</C>
              <C>Col=BAK_MCNT  			Ctrl=gcem_bakman 						Param=Text</C>
              <C>Col=BAK_FCNT  			Ctrl=gcem_bakwom 						Param=Text</C>
              <C>Col=BAK_CNT 		  	Ctrl=gcem_baktot 						Param=Text</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>