<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 노력발령관
+ 프로그램ID : ks_em012s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.09.16
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em025_S.java
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
	*/
	var gs_date ='<%=firstday%>';
	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
      gcem_payym.Text = gs_date;
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

  if(gclx_print.bindcolval=='1'){

      gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em025_S2"
                         + "?v_str1=" + fn_trim(gcem_payym.Text)					//급여년월
                         + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
                         + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//소속
                         + "&v_str4=" + fn_trim(gclx_deptcd.value)	      //부서
                         + "&v_str5=" + fn_trim(txt_empno.value)	        //사번
                         + "&v_str6=" + fn_trim(gclx_agencycd.bindcolval);//대리점
      //prompt('',gcds_data00.DataID);
      gcds_data00.Reset();
  }else if(gclx_print.bindcolval=='2'){
    alert("본사용 - 개발중입니다.");
  }else if(gclx_print.bindcolval=='3'){
		alert("본사용 - 개발중입니다.");    
  }else if(gclx_print.bindcolval=='4'){
    alert("본사용 - 개발중입니다.");    
  }
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm004?v_str1=CM004";
	gcds_cm004.Reset();
	//대리점  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM005";
	gcds_cm005.Reset();
 	//지급구분  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();
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
	Description : 엑셀
----------------------------------------------------------------------------*/
  function ln_Excel(){

    if(gclx_print.bindcolval=='1'){
        var szName = "급여지급현황";
        var szPath = "C:\\Test\\em025s1.xls";
          if (gcds_data00.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
          }
          else{
          gcgd_disp.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='2'){
    
        var szName = "대리점별지급현황";
        var szPath = "C:\\Test\\em025s2.xls";
          if (gcds_data01.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
          }
          else{
          gcgd_disp1.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='3'){

        var szName = "소속별증감표";
        var szPath = "C:\\Test\\em025s3.xls";
          if (gcds_data02.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
          }
          else{
          gcgd_disp2.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='4'){

        var szName = "직종별증감";
        var szPath = "C:\\Test\\em025s4.xls";
          if (gcds_data03.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
          }
          else{
          gcgd_disp3.GridToExcel(szName,szPath,2);
          }
    }
  }

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
   
  if(gclx_print.bindcolval=='1'){
		ln_SetDataHeader();
		gcds_rptmst.Addrow();
		gcds_rptmst.namevalue(gcds_rptmst.rowposition,"CTITLE") = gcem_payym.text.substring(0,4)+"년"+gcem_payym.text.substring(4,6)+"월 조선족 기능사원 급여지급현황";		
		gcds_rptmst.namevalue(gcds_rptmst.rowposition,"CPRTDT") = gs_date;

 		ln_Report('0'); //총계
		ln_Report('1'); //직영계
		ln_Report('2'); //면회소
		ln_Report('3'); //협력업체계
		ln_Report('9'); //직영상세

		gcrp_print.Preview();

	}
}


/******************************************************************************
	Description : 출력
	Parameter   : gbn 0 - 총계,  1-직영계,  2-면회소,  3-협력업체계,  9-직영상세
******************************************************************************/

function ln_Report(gbn){
  if(gclx_print.bindcolval=='1'){ //급여지급현황
	    eval("gcds_report"+gbn).DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em025_S1"
                          + "?v_str1=" + fn_trim(gcem_payym.Text)					  //급여년월
                          + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
                          + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//소속
                          + "&v_str4=" + fn_trim(gclx_deptcd.value)	        //부서
                          + "&v_str5=" + fn_trim(txt_empno.value)	          //사번
                          + "&v_str6=" + fn_trim(gclx_agencycd.bindcolval)  //대리점
													+ "&v_str7=" + gbn ; //구분
      //prompt('',eval("gcds_report"+gbn).DataID);
      eval("gcds_report"+gbn).Reset();
	}
}



/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_rptmst.countrow<1){
		var s_temp = "CTITLE:STRING(100),CPRTDT:STRING(8)";
							
		gcds_rptmst.SetDataHeader(s_temp);
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
	<!-- 소속팀 
	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		gcds_cm003.insertrow(1);
		gcds_cm003.namevalue(1,"COM_CODE") = "";
		gcds_cm003.namevalue(1,"COM_SNAME") = "전체";
		gclx_team_cd.index = 0;
	</script>-->

<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/%>




<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>

<script language=JavaScript for= gclx_print event=OnSelChange()>
	
var key = gclx_print.bindcolval;

	if(key==1){
	document.all["div_1"].style.display="block";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="none";
	}else if(key==2){
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="block";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="none";
	}else if(key==3){
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="block";
	document.all["div_4"].style.display="none";
	}else{
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="block";
	}


</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>
<!-- 대리점 -->
  <script language="javascript" for="gcds_cm005" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm005","gclx_agencycd");
  </script>
<!-- 지급구분 -->
  <script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm018","gclx_paydiv");
  </script>
<!-- 소속 -->
  <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm003","gclx_teamcd");
  </script>



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

  <script language="javascript" for="gcds_data02" event="OnLoadStarted()">
  window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
  document.all.LowerFrame.style.visibility="visible";
  </script>
  <script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
    window.status="조회가 완료 되었습니다.";
    document.all.LowerFrame.style.visibility="hidden";
    ft_cnt1.innerText = "조회건수 : " + row + " 건";
    if (row <1) {
    alert("검색된 데이터가 없습니다.");
    }
  </script>

  <script language="javascript" for="gcds_data03" event="OnLoadStarted()">
  window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
  document.all.LowerFrame.style.visibility="visible";
  </script>
  <script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
    window.status="조회가 완료 되었습니다.";
    document.all.LowerFrame.style.visibility="hidden";
    ft_cnt1.innerText = "조회건수 : " + row + " 건";
    if (row <1) {
    alert("검색된 데이터가 없습니다.");
    }
  </script>

	<script language=JavaScript for=gcrp_print event=OnError()>

alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

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
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <param name=SortExpr	value="+VEND_NM"> -->
</OBJECT>
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
 <OBJECT id=gcds_rptmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 공통코드 -->
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
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
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
								<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" onclick="ln_Query()">
								<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print('01')">
								<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="ln_Excel('01')">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center"></td>
            <td bgcolor="#eeeeee" align="center"></td>
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
            <td bgcolor="#eeeeee" align="center"></td>
            <td bgcolor="#FFFFFF">

            </td>
            <td bgcolor="#eeeeee" align="center" width="100"></td>
            <td bgcolor="#FFFFFF">

            </td>
          </tr>
          <tr height="25">
            <td bgcolor="#FFFFFF">

            </td>
            <td bgcolor="#eeeeee" align="center" width="100"></td>
            <td bgcolor="#FFFFFF">

            </td>
            <td bgcolor="#eeeeee" align="center" width="100">성명</td>
            <td bgcolor="#FFFFFF" colspan="3">
                <input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:11px;top:2px;cursor:hand" onclick="ln_Find('01')">
                <input type="text" id="txt_empnmk" style="position:relative;left:15px;top:-2px;width:100px;" >
                <input type="hidden" id="gclx_deptcd" style="position:relative;left:15px;top:-2px;width:100px;" >
            </td>

          </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>

				<table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
		          <!-- <param name="LineColor"		value=Green> -->
							<param name=ViewSummary    value=1>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30, align=center SumBgColor=#C3D0DB  </F> 
							<FC>ID=VEND_NM			Name=근무업체	 		    ,width=70px,	align=left,	  HeadBgColor=#B9D4DC,  SumBgColor=#C3D0DB  SumText='' suppress=1</FC>
              <FC>ID=GROUPNM			Name=구분						  ,width=70px,	align=left,	  HeadBgColor=#B9D4DC,  SumBgColor=#C3D0DB  SumText='합 계'</FC>
              <C>ID=BASIC_TOT    ,Name=기본             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=O_TIME_TOT	 ,Name=OT계             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=RET_PAY			,	Name=퇴직금           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=REWARD_PAY	,	Name=미실시\\보상금   ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=BON_PAY			,	Name=상여금           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=LST_PAY			,	Name=전월소급         ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=PAY_SUM			,	Name=지급계           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=#CCFFCC</C>
							<C>ID=TEL_PAY			,	Name=전화비           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=ADV_PAY			,	Name=가불             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=TELUBO_PAY	, Name=전화비\\유보     ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=TELSAVE_PAY	,	Name=전화비\\유보지급 ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=ETC_PAY			,	Name=기타             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=DEDUCT_SUM	,	Name=공제계           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=#CCFFCC </C>
							<C>ID=REAL_PAY_SUM,	Name=실지급액         ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=Yellow</C>
							">																																											 
							</OBJECT><%=HDConstant.COMMENT_END%>																		 
              <fieldset style="width:829;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
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