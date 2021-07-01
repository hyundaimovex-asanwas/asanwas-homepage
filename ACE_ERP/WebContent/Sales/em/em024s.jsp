<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 급여대장
+ 프로그램ID : em024s.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em024_S.java
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
	var gs_date =  gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	var payymd = gcurdate.substring(0,7);
	*/
	var gs_date = '<%=firstday%>';
	var payymd =gs_date.substring(0,6);

  //alert(rp_month);
	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
     // txt_rpval01.value = yymmdd;
      //txt_rpval02.value = month_date;
      gcem_payym.Text = payymd;
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
  var strGB = "";
	if (chk_s.checked){
		strGB="T";
	}else{
    strGB="";
	}

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em024_S"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//급여년월
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
											 + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//소속
											 + "&v_str4=" + fn_trim(gclx_deptcd.bindcolval)	  //부서
											 + "&v_str5=" + fn_trim(txt_empno.value)	        //사번
											 + "&v_str6=" + fn_trim(gclx_agencycd.bindcolval)//대리점
											 + "&v_str7=" + strGB;// 소계
  //prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){
	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm003?v_str1=CM003";
	gcds_cm003.Reset();
	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm004?v_str1=CM004";
	gcds_cm004.Reset();
	//대리점  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm005?v_str1=CM005";
	gcds_cm005.Reset();
	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM006";
	gcds_cm006.Reset();
	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm007?v_str1=CM007";
	gcds_cm007.Reset();
	//지급구분  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();
	//지급구분  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM019";
	gcds_cm019.Reset();
	//기능구분  CM013
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM013";
	gcds_cm013.Reset();
	//근속년차  CM017
	gcds_cm017.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM017";
	gcds_cm017.Reset();
	}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
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

/*----------------------------------------------------------------------------
	Description : 프린트
----------------------------------------------------------------------------*/
  function ln_Print(){  
    if(gcds_data00.countrow<1){
      alert("출력하실 자료가 없습니다.");
    }else{
			gcds_print.ClearData();
			var ls_temp ="MM:STRING(40),CUDATE:STRING";   
      gcds_print.SetDataHeader(ls_temp);
      gcds_print.AddRow();
			
      var rp_str0 = "조선족 기능사원 급여대장("+gcds_data00.namevalue(1,"PREYYMM").substring(0,4)+"년"+gcds_data00.namevalue(1,"PREYYMM").substring(4,6)+"월분)";
			gcds_print.namevalue(1,"CUDATE") = gs_date;
			gcds_print.namevalue(1,"MM") = gcem_payym.text.substring(0,4) + "년" +gcem_payym.text.substring(4,6) + "월 " +rp_str0;
			gcrp_print.preview();
    }
  }

 function ln_ChkBox_Chk(){
		if (chk_s.checked){
			  gcds_data00.SubsumExpr = "1:TEAM_NM";
				gcrp_print.SuppressColumns="1:TEAM_NM";
		}else{
        gcds_data00.SubsumExpr ="";
				gcrp_print.SuppressColumns="";
		}
 }

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>
<!-- 부서 -->
  <script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm006","gclx_deptcd");
  </script>
<!-- 소속 -->
  <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm003","gclx_teamcd");
  </script>
<!-- 대리점 -->
  <script language="javascript" for="gcds_cm005" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm005","gclx_agencycd");
  </script>
<!-- 지급구분 -->
  <script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm018","gclx_paydiv");
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

		<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
		window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
		document.all.LowerFrame.style.visibility="visible";
		</script>
		<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + gcds_data00.RealCount(1,gcds_data00.CountRow) + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
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
</OBJECT>
<OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
  <PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
  <PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- 공통코드 -->
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
 								<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
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
						<td bgcolor="#eeeeee" align="center" width="100">성명</td>
            <td bgcolor="#FFFFFF" colspan=3>
                <input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:11px;top:2px;cursor:hand" onclick="ln_Find('01')">
                <input type="text" id="txt_empnmk" style="position:relative;left:15px;top:-2px;width:100px;" >
                <input type="hidden" id="txt_title" style="position:relative;left:15px;top:-2px;width:100px;" >
                <input type="hidden" id="txt_rpval01" style="position:relative;left:15px;top:-2px;width:100px;" >
                <input type="hidden" id="txt_rpval02" style="position:relative;left:15px;top:-2px;width:100px;" >
            </td>
          </tr>
          <tr height="25">
            <td bgcolor="#eeeeee" align="center" width="100">부서</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm006">
                <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
						<td bgcolor="#eeeeee" align="center" width="100">소속</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_teamcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
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
            <td bgcolor="#eeeeee" align="center" width="100">대리점</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_agencycd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm005">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>

						<td align="center" width="70" bgcolor="#eeeeee">소계</td>
						<td bgcolor="#FFFFFF" width="70">
							<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:0px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk()" >
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
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<param name=ViewSummary    value=1>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right SumBgColor=#C3D0DB</F> 
              <C>ID=PAY_YM			,	Name=급여년월      ,width=55px,	align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX' show=false SumBgColor=#C3D0DB</C>
							<C>ID=VEND_NM			,	Name=근무업체      ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm019:COM_CODE:COM_SNAME' show=false  SumBgColor=#C3D0DB</C>
              <C>ID=DEPT_NM			,	Name=부서          ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm006:COM_CODE:COM_SNAME' show=false  SumBgColor=#C3D0DB</C>
							<C>ID=TEAM_NM			,	Name=소속          ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME' ,suppress=1, subsumText={decode(CurLevel,1,'    소계',TEAM_NM)}, sumText='합계' SumBgColor=#C3D0DB</C>
              <C>ID=WORK_NM			,	Name=근무지        ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm007:COM_CODE:COM_SNAME'  subsumText={decode(CurLevel,1,subcount(empno)-1&'명',WORK_NM)}, sumText={RealCount&'명'} SumBgColor=#C3D0DB  SumTextAlign='left'</C>
							<C>ID=START_DT    ,	Name=부임일        ,width=70px,	align=left,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  Mask='XXXX/XX/XX'</C>
							<C>ID=EMPNO				,	Name=사번          ,width=55px,	align=center,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
							<C>ID=EMPNMK      ,	Name=성명          ,width=60px,	align=left,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>            
							<C>ID=AGENCY_NM   ,	Name=대리점        ,width=60px,	align=left,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=SEX         ,	Name=성별,         ,width=30px,	align=center,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=PASS_NO     ,	Name=여권번호      ,width=60px,	align=left,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
							<C>ID=CUST_SID		,	Name='사업자;번호' ,width=55px,	align=center,	HeadBgColor=#B9D4DC show = false SumBgColor=#C3D0DB</C> 
              <C>ID=PAY_DT			,	Name=급여지급일    ,width=75px,	align=center,	HeadBgColor=#B9D4DC,Mask='XXXX/XX/XX' show =false SumBgColor=#C3D0DB</C>
              <C>ID=PAY_DIV			,	Name='급여지급;구분',	width=60px,	align=left,	HeadBgColor=#B9D4DC show=false SumBgColor=#C3D0DB</C>
              <C>ID=JOB_NM			,	Name=직종          ,width=50px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm004:COM_CODE:COM_SNAME'  SumBgColor=#C3D0DB</C>
              <C>ID=SKILL_NM		,	Name=기능구분      ,width=70px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm013:COM_CODE:COM_SNAME'  SumBgColor=#C3D0DB</C>
              <C>ID=CON_YEAR_NM	,	Name='근속;년차'   ,width=40px,	align=center,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm017:COM_CODE:COM_SNAME' SumBgColor=#C3D0DB</C>
              <C>ID=B_PAY0			,	Name=기본급1       ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
							<C>ID=B_PAY1			,	Name=기본급2       ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=B_PAY2			,	Name=기본급3       ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=T_PAY1			,	Name=시급1         ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=T_PAY2			,	Name=시급2         ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=H_DAY				,	Name='휴무;일수'   ,width=40px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=W_DAY1			,	Name='근무;일수1'  ,width=40px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=W_DAY2			,	Name='근무;일수2'  ,width=40px,	align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
              <C>ID=O_TIME			,	Name=OT시간        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=O_TIME_TOT	,	Name=OT계          ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=BASIC_TOT		,	Name=기본계        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=RET_PAY			,	Name=퇴직금        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=SEN_PAY			,	Name=근속수당      ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=AIR_PAY			,	Name=왕복항공      ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=B20_PAY			,	Name='기본급;(20일분)',width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=BON_PAY			,	Name=상여금        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=LST_PAY			,	Name=전월소급      ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=PAY_SUM			,	Name=총액          ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
							<C>ID=TEL_PAY			,	Name=전화비        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=ADV_PAY			,	Name=가불          ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=TELUBO_PAY	,	Name=전화비유보    ,width=70px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=TELSAVE_PAY	,	Name='전화비유보;지급',width=70px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=ETC_PAY			,	Name=기타금액      ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
              <C>ID=DEDUCT_SUM	,	Name=공제계        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
							<C>ID=EX_AIR_PAY	,	Name=항공료외      ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB show=false</C>
              <C>ID=SND_PAY			,	Name=송금액        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB show=false</C>
              <C>ID=REAL_PAY_SUM,	Name=지급액        ,width=60px,	align=right,	HeadBgColor=#B9D4DC SumText=@sum SumBgColor=#C3D0DB</C>
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
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
							<PARAM NAME="DataID"				VALUE="gcds_data00">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
								<C>Col=VEND_CD   			Ctrl=txt_vend_cd   					Param=Value</C>
								<C>Col=DEPT_CD				Ctrl=txt_dept_cd						Param=Value</C>
								<C>Col=TEAM_CD   			Ctrl=txt_team_cd   					Param=Value</C>
								<C>Col=WORK_CD   			Ctrl=txt_job_cd   					Param=Value</C>
								<C>Col=TO_MAN 				Ctrl=gcem_toman  						Param=Text</C>
								<C>Col=TO_WOM 				Ctrl=gcem_towom  						Param=Text</C>
								<C>Col=ARR_MAN  			Ctrl=gcem_arrman 						Param=Text</C>
								<C>Col=ARR_WOM  			Ctrl=gcem_arrwom 						Param=Text</C>
								<C>Col=BAK_MAN  			Ctrl=gcem_bakman 						Param=Text</C>
								<C>Col=BAK_WOM  			Ctrl=gcem_bakwom 						Param=Text</C>
								<C>Col=TOTOT  		  	Ctrl=gcem_totot 						Param=Text</C>
								<C>Col=ARRTOT  		  	Ctrl=gcem_arrtot 						Param=Text</C>
								<C>Col=BAKTOT  		  	Ctrl=gcem_baktot 						Param=Text</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
  <!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_print">
	<param NAME="DetailDataID"			VALUE="gcds_data00">
	<PARAM NAME="PaperSize"					VALUE="A3">
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"						VALUE="
<B>id=FHeader ,left=0,top=0 ,right=4101 ,bottom=249 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=3014 ,top=37 ,right=4014 ,bottom=243 ,border=true ,penstyle=solid ,penwidth=3</X>
	<L> left=3014 ,top=106 ,right=4014 ,bottom=106 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3257 ,top=40 ,right=3257 ,bottom=238 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3506 ,top=40 ,right=3506 ,bottom=238 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=3749 ,top=40 ,right=3749 ,bottom=238 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='팀장' ,left=3270 ,top=45 ,right=3495 ,bottom=101 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부서장' ,left=3522 ,top=45 ,right=3739 ,bottom=101 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총소장' ,left=3762 ,top=45 ,right=3998 ,bottom=101 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=225, top=198, right=529, bottom=230, align='left' ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='Print Date:' ,left=13 ,top=198 ,right=228 ,bottom=230 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담당' ,left=3029 ,top=45 ,right=3241 ,bottom=101 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=733 ,top=122 ,right=2905 ,bottom=222 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<C>id='MM', left=762, top=130, right=2881, bottom=214, face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=180 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='퇴직금' ,left=2066 ,top=69 ,right=2188 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='O/T계' ,left=1770 ,top=69 ,right=1910 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본계' ,left=1918 ,top=69 ,right=2058 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상여금' ,left=2582 ,top=69 ,right=2704 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=2712 ,top=69 ,right=2834 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총액' ,left=2842 ,top=69 ,right=2982 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전화비' ,left=2990 ,top=69 ,right=3112 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가불' ,left=3119 ,top=69 ,right=3241 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타' ,left=3508 ,top=69 ,right=3630 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=3638 ,top=69 ,right=3778 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전화비' ,left=3379 ,top=74 ,right=3500 ,bottom=111 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='유보분' ,left=3379 ,top=106 ,right=3500 ,bottom=143 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급' ,left=3379 ,top=138 ,right=3500 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전화비' ,left=3249 ,top=90 ,right=3371 ,bottom=127 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='유보' ,left=3249 ,top=122 ,right=3371 ,bottom=159 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=2453 ,top=90 ,right=2574 ,bottom=127 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='왕복' ,left=2326 ,top=90 ,right=2447 ,bottom=127 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속' ,left=2196 ,top=90 ,right=2318 ,bottom=127 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수당' ,left=2196 ,top=122 ,right=2318 ,bottom=159 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='항공' ,left=2326 ,top=122 ,right=2447 ,bottom=159 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='20일분' ,left=2453 ,top=122 ,right=2574 ,bottom=159 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=11 ,top=180 ,right=4014 ,bottom=180 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2061 ,top=61 ,right=2061 ,bottom=180 </L>
	<L> left=11 ,top=8 ,right=4014 ,bottom=8 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=87 ,top=8 ,right=87 ,bottom=180 </L>
	<L> left=11 ,top=8 ,right=11 ,bottom=180 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=296 ,top=8 ,right=296 ,bottom=180 </L>
	<L> left=569 ,top=8 ,right=569 ,bottom=180 </L>
	<L> left=624 ,top=8 ,right=624 ,bottom=180 </L>
	<L> left=788 ,top=8 ,right=788 ,bottom=180 </L>
	<L> left=937 ,top=8 ,right=937 ,bottom=180 </L>
	<L> left=1103 ,top=8 ,right=1103 ,bottom=180 </L>
	<L> left=1191 ,top=8 ,right=1191 ,bottom=180 </L>
	<L> left=1275 ,top=8 ,right=1275 ,bottom=180 </L>
	<L> left=1360 ,top=8 ,right=1360 ,bottom=180 </L>
	<L> left=1445 ,top=8 ,right=1445 ,bottom=180 </L>
	<L> left=1535 ,top=8 ,right=1535 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1606 ,top=8 ,right=1606 ,bottom=180 </L>
	<L> left=1685 ,top=8 ,right=1685 ,bottom=180 </L>
	<L> left=1765 ,top=8 ,right=1765 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='NO' ,left=21 ,top=21 ,right=82 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=304 ,top=21 ,right=410 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=630 ,top=21 ,right=786 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부임일' ,left=794 ,top=21 ,right=934 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직종' ,left=942 ,top=21 ,right=1098 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴무' ,left=1543 ,top=21 ,right=1601 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=1111 ,top=45 ,right=1188 ,bottom=82 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=1111 ,top=77 ,right=1188 ,bottom=114 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1111 ,top=108 ,right=1188 ,bottom=146 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3' ,left=1281 ,top=108 ,right=1357 ,bottom=146 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=1281 ,top=48 ,right=1357 ,bottom=85 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본' ,left=1196 ,top=45 ,right=1273 ,bottom=82 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=1196 ,top=77 ,right=1273 ,bottom=114 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1196 ,top=108 ,right=1273 ,bottom=146 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시급' ,left=1365 ,top=64 ,right=1442 ,bottom=101 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1365 ,top=95 ,right=1442 ,bottom=132 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급' ,left=1281 ,top=77 ,right=1357 ,bottom=114 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시급' ,left=1453 ,top=64 ,right=1529 ,bottom=101 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1453 ,top=95 ,right=1529 ,bottom=132 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무' ,left=1611 ,top=48 ,right=1680 ,bottom=85 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일수' ,left=1611 ,top=79 ,right=1680 ,bottom=116 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1' ,left=1611 ,top=111 ,right=1680 ,bottom=148 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2' ,left=1691 ,top=111 ,right=1759 ,bottom=148 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='일수' ,left=1691 ,top=79 ,right=1759 ,bottom=116 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근무' ,left=1691 ,top=48 ,right=1759 ,bottom=85 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1913 ,top=8 ,right=1913 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='시간외' ,left=1770 ,top=16 ,right=1910 ,bottom=61 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=3781 ,top=8 ,right=3781 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=4014 ,top=8 ,right=4014 ,bottom=180 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2985 ,top=8 ,right=2985 ,bottom=180 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='임금산정' ,left=1918 ,top=13 ,right=2977 ,bottom=58 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공제내역' ,left=2992 ,top=13 ,right=3768 ,bottom=58 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급액' ,left=3789 ,top=21 ,right=4003 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='남' ,left=574 ,top=64 ,right=619 ,bottom=101 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='녀' ,left=574 ,top=95 ,right=619 ,bottom=132 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=93 ,top=21 ,right=291 ,bottom=175 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=415 ,top=8 ,right=415 ,bottom=180 </L>
	<T>id='대리점' ,left=423 ,top=19 ,right=564 ,bottom=172 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1765 ,top=61 ,right=3781 ,bottom=61 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2191 ,top=61 ,right=2191 ,bottom=180 </L>
	<L> left=2320 ,top=61 ,right=2320 ,bottom=180 </L>
	<L> left=2450 ,top=61 ,right=2450 ,bottom=180 </L>
	<L> left=2577 ,top=61 ,right=2577 ,bottom=180 </L>
	<L> left=2707 ,top=61 ,right=2707 ,bottom=180 </L>
	<L> left=2836 ,top=61 ,right=2836 ,bottom=180 </L>
	<L> left=3114 ,top=61 ,right=3114 ,bottom=180 </L>
	<L> left=3244 ,top=61 ,right=3244 ,bottom=180 </L>
	<L> left=3373 ,top=61 ,right=3373 ,bottom=180 </L>
	<L> left=3503 ,top=61 ,right=3503 ,bottom=180 </L>
	<L> left=3633 ,top=61 ,right=3633 ,bottom=180 </L>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=21, top=8, right=82, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,subcount(empno)-1,EMPNMK)}', left=304, top=8, right=410, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,SEX)}', left=574, top=8, right=619, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,PASS_NO)}', left=630, top=8, right=786, bottom=69, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REAL_PAY_SUM,0,,REAL_PAY_SUM)}', left=3789, top=8, right=4003, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(DEDUCT_SUM,0,,DEDUCT_SUM)}', left=3638, top=8, right=3778, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(ETC_PAY,0,,ETC_PAY)}', left=3508, top=8, right=3630, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(TELSAVE_PAY,0,,TELSAVE_PAY)}', left=3379, top=8, right=3500, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(TELUBO_PAY,0,,TELUBO_PAY)}', left=3249, top=8, right=3371, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(ADV_PAY,0,,ADV_PAY)}', left=3119, top=8, right=3241, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(TEL_PAY,0,,TEL_PAY)}', left=2990, top=8, right=3112, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(PAY_SUM,0,,PAY_SUM)}', left=2842, top=8, right=2982, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(LST_PAY,0,,LST_PAY)}', left=2712, top=8, right=2834, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(BON_PAY,0,,BON_PAY)}', left=2582, top=8, right=2704, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(B20_PAY,0,,B20_PAY)}', left=2453, top=8, right=2574, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(AIR_PAY,0,,AIR_PAY)}', left=2326, top=8, right=2447, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(SEN_PAY,0,,SEN_PAY)}', left=2196, top=8, right=2318, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(RET_PAY,0,,RET_PAY)}', left=2066, top=8, right=2188, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(BASIC_TOT,0,,BASIC_TOT)}', left=1918, top=8, right=2058, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(O_TIME_TOT,0,,O_TIME_TOT)}', left=1770, top=8, right=1910, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(W_DAY2,0,,W_DAY2)}', left=1691, top=8, right=1759, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(W_DAY1,0,,W_DAY1)}', left=1611, top=8, right=1680, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(H_DAY,0,,H_DAY)}', left=1543, top=8, right=1601, bottom=69, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(T_PAY2,0,,T_PAY2)}', left=1453, top=8, right=1529, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(T_PAY1,0,,T_PAY1)}', left=1365, top=8, right=1442, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
	<C>id='{decode(B_PAY2,0,,B_PAY2)}', left=1281, top=8, right=1357, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B_PAY1,0,,B_PAY1)}', left=1196, top=8, right=1273, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(B_PAY0,0,,B_PAY0)}', left=1111, top=8, right=1188, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,JOB_NM)}', left=942, top=8, right=1098, bottom=69, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,,START_DT)}', left=794, top=8, right=934, bottom=69 ,mask='XXXX/XX/XX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=11 ,top=71 ,right=4014 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=11 ,top=3 ,right=11 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=87 ,top=3 ,right=87 ,bottom=69 </L>
	<L> left=296 ,top=3 ,right=296 ,bottom=69 </L>
	<L> left=569 ,top=3 ,right=569 ,bottom=69 </L>
	<L> left=624 ,top=3 ,right=624 ,bottom=69 </L>
	<L> left=788 ,top=3 ,right=788 ,bottom=69 </L>
	<L> left=937 ,top=3 ,right=937 ,bottom=69 </L>
	<L> left=1103 ,top=3 ,right=1103 ,bottom=69 </L>
	<L> left=1191 ,top=3 ,right=1191 ,bottom=69 </L>
	<L> left=1275 ,top=3 ,right=1275 ,bottom=69 </L>
	<L> left=1360 ,top=3 ,right=1360 ,bottom=69 </L>
	<L> left=1445 ,top=3 ,right=1445 ,bottom=69 </L>
	<L> left=1535 ,top=3 ,right=1535 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1606 ,top=3 ,right=1606 ,bottom=69 </L>
	<L> left=1685 ,top=3 ,right=1685 ,bottom=69 </L>
	<L> left=1765 ,top=3 ,right=1765 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1913 ,top=3 ,right=1913 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2061 ,top=3 ,right=2061 ,bottom=69 </L>
	<L> left=2191 ,top=3 ,right=2191 ,bottom=69 </L>
	<L> left=2320 ,top=3 ,right=2320 ,bottom=69 </L>
	<L> left=2450 ,top=3 ,right=2450 ,bottom=69 </L>
	<L> left=2577 ,top=3 ,right=2577 ,bottom=69 </L>
	<L> left=2707 ,top=3 ,right=2707 ,bottom=69 </L>
	<L> left=2836 ,top=3 ,right=2836 ,bottom=69 </L>
	<L> left=2985 ,top=3 ,right=2985 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=3114 ,top=3 ,right=3114 ,bottom=69 </L>
	<L> left=3244 ,top=3 ,right=3244 ,bottom=69 </L>
	<L> left=3373 ,top=3 ,right=3373 ,bottom=69 </L>
	<L> left=3503 ,top=3 ,right=3503 ,bottom=69 </L>
	<L> left=3633 ,top=3 ,right=3633 ,bottom=69 </L>
	<L> left=3781 ,top=3 ,right=3781 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=4014 ,top=3 ,right=4014 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=415 ,top=3 ,right=415 ,bottom=69 </L>
	<C>id='{decode(curlevel,1,\'       소   계\',TEAM_NM)}', left=93, top=8, right=291, bottom=69, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(curlevel,1,\'명\',AGENCY_NM)}', left=423, top=8, right=564, bottom=69, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=4101 ,bottom=96 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=13 ,top=0 ,right=4016 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=11 ,top=0 ,right=11 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1765 ,top=0 ,right=1765 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1913 ,top=0 ,right=1913 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{Sum(O_TIME_TOT)} ', left=1770, top=5, right=1910, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<C>id='{Sum(BASIC_TOT)} ', left=1918, top=5, right=2058, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2061 ,top=0 ,right=2061 ,bottom=69 </L>
	<C>id='{Sum(RET_PAY)} ', left=2066, top=5, right=2188, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2191 ,top=0 ,right=2191 ,bottom=69 </L>
	<L> left=2320 ,top=0 ,right=2320 ,bottom=69 </L>
	<C>id='{Sum(SEN_PAY)} ', left=2196, top=5, right=2318, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<C>id='{Sum(AIR_PAY)} ', left=2326, top=5, right=2447, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2450 ,top=0 ,right=2450 ,bottom=66 </L>
	<C>id='{Sum(B20_PAY)} ', left=2453, top=5, right=2577, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2577 ,top=0 ,right=2577 ,bottom=69 </L>
	<C>id='{Sum(BON_PAY)} ', left=2582, top=5, right=2704, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2707 ,top=0 ,right=2707 ,bottom=69 </L>
	<L> left=4014 ,top=0 ,right=4014 ,bottom=64 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='{Sum(LST_PAY)} ', left=2712, top=5, right=2834, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2836 ,top=0 ,right=2836 ,bottom=69 </L>
	<C>id='{Sum(PAY_SUM)} ', left=2842, top=5, right=2982, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=2985 ,top=0 ,right=2985 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{Sum(TEL_PAY)} ', left=2990, top=5, right=3112, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=3114 ,top=0 ,right=3114 ,bottom=69 </L>
	<L> left=3244 ,top=0 ,right=3244 ,bottom=69 </L>
	<C>id='{Sum(ADV_PAY)} ', left=3119, top=5, right=3241, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=3373 ,top=0 ,right=3373 ,bottom=69 </L>
	<C>id='{Sum(TELUBO_PAY)} ', left=3249, top=5, right=3371, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<C>id='{Sum(TELSAVE_PAY)} ', left=3379, top=5, right=3500, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=3503 ,top=0 ,right=3503 ,bottom=69 </L>
	<C>id='{Sum(ETC_PAY)} ', left=3508, top=5, right=3630, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<C>id='{Sum(DEDUCT_SUM)} ', left=3638, top=5, right=3778, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=3633 ,top=0 ,right=3633 ,bottom=69 </L>
	<L> left=3781 ,top=0 ,right=3781 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{Sum(REAL_PAY_SUM)} ', left=3789, top=5, right=4003, bottom=61, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0, Dec=2</C>
	<L> left=11 ,top=69 ,right=4014 ,bottom=69 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='합 계' ,left=13 ,top=3 ,right=299 ,bottom=64 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<S>id='Count' ,left=304 ,top=5 ,right=410 ,bottom=61 ,mask='XXXX명' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</S>
	<T>id='명' ,left=423 ,top=5 ,right=564 ,bottom=61 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=Footer ,left=0 ,top=2759 ,right=4101 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=34 ,top=19 ,right=4006 ,bottom=98 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../common/img/icon.jpg' ,left=3596 ,top=8 ,right=3977 ,bottom=87</I>
	<L> left=24 ,top=5 ,right=4006 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</OBJECT><%=HDConstant.COMMENT_END%>
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>