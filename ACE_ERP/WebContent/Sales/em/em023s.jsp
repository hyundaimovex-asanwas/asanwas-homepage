<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 급여조회
+ 프로그램ID : em023s.jsp
+ 기능정의 : 
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.11.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em023_S.java
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
	var year_date = gcurdate.substring(2,4);
	var yymmdd = gcurdate.substring(0,7);
	*/
	
	var gs_date = '<%=firstday%>';
	var year_date = gs_date.substring(2,4);
	var yymmdd = gs_date.substring(0,6);

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			ln_before();//선조회
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
      		gcem_payym.Text = yymmdd;

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

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em023_S"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//지급월
											 + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
											 + "&v_str3=" + fn_trim(gclx_team_cd.bindcolval)	//소속
											 + "&v_str4=" + fn_trim(txt_empno.value)			    //사번
											 + "&v_str5=" + fn_trim(txt_empnmk.value);			   //성명
  //prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
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

	//소속팀  CM003
	gcds_cm003_S.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm003?v_str1=CM003";
	gcds_cm003_S.Reset();
	//근무지  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm007?v_str1=CM007";
	gcds_cm007.Reset();
 	//대리점  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm005?v_str1=CM005";
	gcds_cm005.Reset();
	//지급구분  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();

	//직종  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();

	//기능구분  CM013
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM013";
	gcds_cm013.Reset();

	
	}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName = "급여조회";
    var szPath = "C:\\Test\\em023i.xls";
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
		gcrp_print.preview();

		/*
   
    if(gcds_data00.countrow<1){
      alert("출력하실 자료가 없습니다.");
    }
    else{

    gcds_print.ClearData();

			var ls_temp ="MM:STRING(40),rp_yymmdd:STRING(10),rp_month:STRING(10)";
      
      gcds_print.SetDataHeader(ls_temp);
      gcds_print.AddRow();


      var rp_str0 = "조선족 기능사원 급여대장";
      var rp_str1 = txt_rpval01.value;
      var rp_str2 = txt_rpval02.value;

          gcds_print.namevalue(1,"MM") = rp_str1 + "년" + rp_str2 + "월 " + rp_str0 ;
          gcds_print.namevalue(1,"rp_yymmdd") = rp_str1 + "년";
          gcds_print.namevalue(1,"rp_month") = rp_str2 + "월";
          gcrp_print2.preview();
    }
		*/
  }


</script>


<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>
<!-- 지급구분 -->
  <script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm018","gclx_paydiv");
  </script>
<!-- 소속팀 -->
  <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
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



    <script language=JavaScript for="gcds_data00" event=OnRowPosChanged(row)>
		/*
			var sum = eval(gcem_b_basic_tot.Text) +
                eval(gcem_o_time_tot.Text) + eval(gcem_senpay.Text)+
                eval(gcem_airpay.Text) + eval(gcem_b20pay.Text)+
                eval(gcem_bonpay.Text) + eval(gcem_lstpay.Text)+
                eval(gcem_retpay.Text)
								gcem_pay_sum.Text = sum;//지급합계
      var sum = eval(gcem_telpay.Text) + eval(gcem_advpay.Text)+
                eval(gcem_telubopay.Text) + eval(gcem_etcpay.Text) + eval(gcem_telsavepay.Text)
                gcem_deduct_sum.Text = sum;//공제합계
      var sum = eval(gcem_pay_sum.Text) - eval(gcem_deduct_sum.Text)
                gcem_real_pay_sum.Text = sum;//실지급액
		*/
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
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm003_S classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor= ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
              <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
         <!-- <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="ln_Add('01')" >
              <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete('01')" >
              <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save('01')"> -->
							<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print()">
              <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" onClick="ln_Excel()" >
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
           	<td bgcolor="#eeeeee" align="center" width="60">지급월</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;top:2px;cursor:hand" onclick="__GetCallMonth('gcem_payym', 'Text');">
              </td>
              <td bgcolor="#eeeeee" align="center" width="60">지급구분</td>
						  <td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:70px;">
                <param name=ComboDataID			value="gcds_cm018">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
              </td>
              <td bgcolor="#eeeeee" align="center" width="60">소속</td>
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
              <td bgcolor="#eeeeee" align="center" width="60">성명</td>
						  <td bgcolor="#FFFFFF">
                <input type="text" id="txt_empnmk" style="position:relative;left:15px;top:-2px;width:100px;" >
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:11px;top:2px;cursor:hand" onclick="ln_Find('01')">
								<input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
              </td>
            </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:829px;height:400px;">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111" width="280">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:280;height:400px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="viewsummary"		VALUE=1>
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			  ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,   align=right  SumBgColor=#C3D0DB </F> 
              <C>ID=PAY_YM,	    Name=지급년월,	width=50px,		align=center,	HeadBgColor=#B9D4DC	,Mask='XXXX/XX'  SumBgColor=#C3D0DB</C>
              <C>ID=EMPNO,	    Name=사번,	    width=50px,		align=center,	HeadBgColor=#B9D4DC sort=true	  SumBgColor=#C3D0DB</C>
              <C>ID=TEAM_CD,    Name=소속,	    width=75px,		align=left,		HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME' sort=true SumBgColor=#C3D0DB</C>
              <C>ID=EMPNMK,	    Name=이름,	    width=57px,		align=left,		HeadBgColor=#B9D4DC	sort=true   SumBgColor=#C3D0DB</C>
              <C>ID=PAY_SUM,    Name=지급합계,	width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false </C>
              <C>ID=BASIC_TOT,	Name=기본계,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=O_TIME,	    Name=OT시간,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=O_TIME_TOT,	Name=OT계,	    width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=SEN_PAY,	  Name=근속수당,	width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=AIR_PAY,	  Name=항공수당,	width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=B20_PAY,	  Name=기본급20,	width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=BON_PAY,	  Name=상여금,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=LST_PAY,	  Name=전월소급,	width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=RET_PAY,	  Name=퇴직금,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=DEDUCT_SUM, Name=공제합계,  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=TEL_PAY,	  Name=전화비,	  width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
							<C>ID=ADV_PAY,	  Name=가불,	    width=80px,		align=left,		HeadBgColor=#B9D4DC	show=false</C>
							<C>ID=TELUBO_PAY,   Name=전화비유보,     width=80px,	align=left,		HeadBgColor=#B9D4DC	show=false</C>
							<C>ID=TELSAVE_PAY,  Name=전화비유보지급, width=80px,	align=left,	  HeadBgColor=#B9D4DC	show=false</C>
							<C>ID=ETC_PAY,	    Name=기타,           width=80px,	align=left,		HeadBgColor=#B9D4DC	show=false</C>
              <C>ID=REAL_PAY_SUM, Name=실지급액,	     width=80px,	align=left,		HeadBgColor=#B9D4DC	show=false</C>

							">
							</OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:280;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
            <td>&nbsp;</td>
						<td>
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#b5b5b5">
							<tr height="25">
								<td align="center" width="90" bgcolor="#eeeeee">지급월 </td>
								<td bgcolor="#FFFFFF">
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_payym2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									class="g_input1" style="position:relative;width:50px;left:8px;">
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
									  <param name=ReadOnly      value="true">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee" >사번</td>
								<td bgcolor="#FFFFFF">
									<input type="text" id="txt_empno2" style="position:relative;;left:8px;width:80px;" readonly>
								</td>
								<td  align="center" bgcolor="#eeeeee" width="60">성명</td>
								<td bgcolor="#FFFFFF">
									<input type="text" id="txt_empnmk2" style="position:relative;;left:8px;width:80px;" readonly>
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">입사일 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_stdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=0>
                  <param name=Border	      value=true>
                  <param name=Format	      value="YYYY/MM/DD">
                  <param name=PromptChar	  value="_">
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee">퇴사일 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_eddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=0>
                  <param name=Border	      value=true>
                  <param name=Format	      value="YYYY/MM/DD">
                  <param name=PromptChar	  value="_">
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee">변경일 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_chgymd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=0>
                  <param name=Border	      value=true>
                  <param name=Format	      value="YYYY/MM/DD">
                  <param name=PromptChar	  value="_">
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<!-- <td  align="center" bgcolor="#eeeeee">지급일 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_paydt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=0>
                  <param name=Border	      value=true>
                  <param name=Format	      value="YYYY/MM">
                  <param name=PromptChar	  value="_">
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td> -->
							</tr>
							<tr height="25">
							 <td  align="center" bgcolor="#eeeeee" >소속 </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_team_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                  style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
                  <param name=ComboDataID			value="gcds_cm003_S">
                  <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                  <param name=SearchColumn		value=COM_SNAME>
                  <param name=Sort						value=false>
                  <param name=ListExprFormat	value="COM_SNAME^0^100">
                  <param name=BindColumn			value=COM_CODE>
									<param name=Enable          value="false">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee" >대리점 </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_agency_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                  style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
                  <param name=ComboDataID			value="gcds_cm005">
                  <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                  <param name=SearchColumn		value=COM_SNAME>
                  <param name=Sort						value=false>
                  <param name=ListExprFormat	value="COM_SNAME^0^100">
                  <param name=BindColumn			value=COM_CODE>
									<param name=Enable          value="false">
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee" >여권번호 </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%><OBJECT id=gcem_pass_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
									<param name=Alignment						value=0>
									<param name=Border							value=true>
									<param name=ReadOnly						value="true">
									<!-- <param name=ReadOnlyBackColor   value="#CCFFCC"> -->
									<param name=Format							value="##########">
									<param name=PromptChar					value="_">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr height="25">
							 <td  align="center" bgcolor="#eeeeee" >직종 </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_job_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
									<param name=ComboDataID			value="gcds_cm004">
									<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
									<param name=SearchColumn		value=COM_SNAME>
									<param name=Sort						value=false>
									<param name=Enable					value=false>
									<param name=ListExprFormat	value="COM_SNAME^0^100">
									<param name=BindColumn			value=COM_CODE>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee" >기능구분 </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%><OBJECT id=gclx_skill_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
									<param name=ComboDataID			value="gcds_cm013">
									<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
									<param name=SearchColumn		value=COM_SNAME>
									<param name=Sort						value=false>
									<param name=Enable					value=false>
									<param name=ListExprFormat	value="COM_SNAME^0^100">
									<param name=BindColumn			value=COM_CODE>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td  align="center" bgcolor="#eeeeee" >근속년차 </td>
								<td bgcolor="#FFFFFF" >
                  <input type="text" id="txt_con_year" style="position:relative;left:8px;width:30px;text-align:right;" readonly>&nbsp; 
								</td>
							</tr>
							<tr height="15">
							<td  align="center" bgcolor="#FFFFFF" colspan="6"></td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee"><B>지급항목 </B></td>
								<td bgcolor="#FFFFFF" colspan="3">
									<!-- 여백 -->
								</td>
								<td  align="center" bgcolor="#CCFFCC">지급합계 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_pay_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#CCFFCC">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_PAY_SUM" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">근무/휴무일 </td>
								<td bgcolor="#FFFFFF">
									<input type="text" id="txt_w_day" style="position:relative;left:8px;width:30px;text-align:right;" readonly>&nbsp; / <input type="text" id="txt_h_day" style="width:30px;text-align:right" readonly>
								</td>
								<td  align="center" bgcolor="#eeeeee">근무일1 </td>
								<td bgcolor="#FFFFFF">
                  <input type="text" id="txt_w_day1" style="position:relative;left:8px;width:30px;text-align:right;" readonly>&nbsp; 
								</td>
								<td  align="center" bgcolor="#eeeeee">근무일2 </td>
								<td bgcolor="#FFFFFF">
                   <input type="text" id="txt_w_day2" style="position:relative;left:8px;width:30px;text-align:right;" readonly>&nbsp; 
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">기본계 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_b_basic_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_otimetot" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">기본급1</td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                   <OBJECT id=gcem_b_pay1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_senpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">기본급2 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                   <OBJECT id=gcem_b_pay2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_airpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee" rowspan=2>O/T계 </td>
								<td bgcolor="#FFFFFF" rowspan=2>
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_o_time_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_otimetot" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee" >평일O/T </td>
								<td bgcolor="#FFFFFF" >
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_ro_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_senpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">휴일O/T </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_ho_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_airpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">평일O/T시간 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_o_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_otimetot" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">휴일OT일수 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                   <OBJECT id=gcem_ho_day classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_senpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">근속수당 </td>
								<td bgcolor="#FFFFFF">
                  <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_senpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_senpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">왕복항공임 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_airpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_airpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">기본급20 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_b20pay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_b20pay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">상여금 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_bonpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_bonpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">전월소급 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_lstpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_lstpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">퇴직금 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_retpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_retpay" style="position:relative;;left:8px;width:80px; text-align:right;"> -->
								</td>
							</tr>
					
							<tr height="15">
							<td  align="center" bgcolor="#FFFFFF" colspan="6"></td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee"><b>공제항목</b> </td>
								<td bgcolor="#FFFFFF" colspan="3"></td>
								<td  align="center" bgcolor="#CCFFCC">공제합계 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_deduct_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#CCFFCC">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_total02" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">전화비 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_telpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_telpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">가불 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_advpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_advpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">전화비유보 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_telubopay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_telubopay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#eeeeee">기타 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_etcpay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_etcpay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#eeeeee">전화비유보지급 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_telsavepay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#FDC699">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_telsavepay" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#FFFFFF" colspan="2"></td>
							</tr>
							<tr height="25">
								<td  align="center" bgcolor="#CCFFCC">실지급액 </td>
								<td bgcolor="#FFFFFF">
                <%=HDConstant.COMMENT_START%>
                  <OBJECT id=gcem_real_pay_sum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                  style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
                  <param name=Alignment			value=2>
                  <param name=Border	      value=true>
                  <param name=Decimal	      value=true>
									<param name=MaxDecimalPlace   value=2>
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#CCFFCC">
                  </OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input type="text" id="txt_total03" style="position:relative;;left:8px;width:80px;"> -->
								</td>
								<td  align="center" bgcolor="#FFFFFF" colspan="4"> </td>
							</tr>
             
						</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

	</table>

	<!-- 기본탭 -->
	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
			<C>Col=PAY_YM			   			Ctrl=gcem_payym2   					Param=Text</C>
			<C>Col=EMPNO				   		Ctrl=txt_empno2   					Param=Value</C>
			<C>Col=EMPNMK			   			Ctrl=txt_empnmk2   					Param=Value</C>
			<C>Col=START_DT		   			Ctrl=gcem_stdt   					  Param=Text</C>
			<C>Col=END_DT			   			Ctrl=gcem_eddt   					  Param=Text</C>
			<C>Col=AGENCY_CD		   		Ctrl=gclx_agency_cd   			Param=bindcolval</C>
			<C>Col=W_DAY          		Ctrl=txt_w_day      				Param=Value</C>
			<C>Col=H_DAY				   		Ctrl=txt_h_day   					  Param=Value</C>
			<C>Col=BASIC_TOT       		Ctrl=gcem_b_basic_tot 			Param=Text</C>
			<C>Col=O_TIME			   		  Ctrl=gcem_o_time   					Param=Text</C>
			<C>Col=O_TIME_TOT	   			Ctrl=gcem_o_time_tot  			Param=Text</C>
			<C>Col=SEN_PAY			   		Ctrl=gcem_senpay   					Param=Text</C>
			<C>Col=AIR_PAY			   		Ctrl=gcem_airpay   					Param=Text</C>
			<C>Col=B20_PAY			   		Ctrl=gcem_b20pay   					Param=Text</C>
			<C>Col=BON_PAY			   		Ctrl=gcem_bonpay   					Param=Text</C>
			<C>Col=LST_PAY			   		Ctrl=gcem_lstpay   					Param=Text</C>
			<C>Col=RET_PAY			   		Ctrl=gcem_retpay   					Param=Text</C>
			<C>Col=TEL_PAY			   		Ctrl=gcem_telpay   					Param=Text</C>
			<C>Col=ADV_PAY			   		Ctrl=gcem_advpay   					Param=Text</C>
			<C>Col=TELUBO_PAY	   			Ctrl=gcem_telubopay 				Param=Text</C>
			<C>Col=ETC_PAY			   		Ctrl=gcem_etcpay   					Param=Text</C>
			<C>Col=TELSAVE_PAY	   		Ctrl=gcem_telsavepay   			Param=Text</C>
			<C>Col=PAY_DT     	   		Ctrl=gcem_paydt   		    	Param=Text</C>
			<C>Col=PAY_SUM       		  Ctrl=gcem_pay_sum  				  Param=Text</C>
			<C>Col=DEDUCT_SUM       	Ctrl=gcem_deduct_sum  		  Param=Text</C>
			<C>Col=REAL_PAY_SUM       Ctrl=gcem_real_pay_sum		  Param=Text</C>
			<C>Col=CHGYMD             Ctrl=gcem_chgymd      		  Param=Text</C>
			<C>Col=TEAM_CD            Ctrl=gclx_team_cd_s      		Param=bindcolval</C>
			<C>Col=PASS_NO            Ctrl=gcem_pass_no        		Param=Text</C>
			<C>Col=W_DAY1             Ctrl=txt_w_day1      		    Param=Value</C>
			<C>Col=W_DAY2             Ctrl=txt_w_day2      		    Param=Value</C>
			<C>Col=B_PAY1             Ctrl=gcem_b_pay1      		  Param=Text</C>
			<C>Col=B_PAY2             Ctrl=gcem_b_pay2      		  Param=Text</C>
			<C>Col=RO_TIME            Ctrl=gcem_ro_time      		  Param=Text</C>
			<C>Col=HO_TIME            Ctrl=gcem_ho_time      		  Param=Text</C>
			<C>Col=HO_DAY             Ctrl=gcem_ho_day      		  Param=Text</C>
			<C>Col=JOB_CD             Ctrl=gclx_job_cd        		Param=bindcolval</C>
			<C>Col=SKILL_CD           Ctrl=gclx_skill_cd      		Param=bindcolval</C>
      <C>Col=CON_YEAR           Ctrl=txt_con_year   		    Param=Value</C>
		">
	</OBJECT><%=HDConstant.COMMENT_END%>

	<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분 - 급여명세서
-------------------------------------------------------------------------------------------->  
<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_data00">
	<param name="DetailDataID"			value="gcds_data00">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag			value=True>
	<PARAM NAME="Format" VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=685 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1879 ,top=119 ,right=1879 ,bottom=648 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=577 ,right=1881 ,bottom=577 </L>
	<T>id='귀하의 노고에 감사 드립니다.' ,left=34 ,top=579 ,right=1868 ,bottom=643 ,face='궁서' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=651 ,right=1879 ,bottom=651 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=418 ,right=1881 ,bottom=418 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=262 ,right=1879 ,bottom=262 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=29 ,top=193 ,right=1879 ,bottom=193 </L>
	<L> left=29 ,top=119 ,right=29 ,bottom=648 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=116 ,right=1879 ,bottom=116 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=341 ,right=1881 ,bottom=341 </L>
	<L> left=222 ,top=119 ,right=222 ,bottom=579 </L>
	<T>id='기본급계' ,left=40 ,top=278 ,right=220 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급월' ,left=40 ,top=132 ,right=220 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총액' ,left=1508 ,top=278 ,right=1871 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외계' ,left=228 ,top=278 ,right=405 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상여금' ,left=1140 ,top=278 ,right=1318 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='퇴직금' ,left=407 ,top=278 ,right=585 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=230 ,top=132 ,right=587 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=590 ,top=132 ,right=770 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직종' ,left=773 ,top=132 ,right=953 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='여권번호' ,left=958 ,top=132 ,right=1318 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=590 ,top=278 ,right=770 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='왕복항공임' ,left=773 ,top=278 ,right=953 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급20일' ,left=958 ,top=278 ,right=1135 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입사일' ,left=1323 ,top=132 ,right=1505 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=1323 ,top=278 ,right=1505 ,bottom=333 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=587 ,top=119 ,right=587 ,bottom=579 </L>
	<L> left=770 ,top=119 ,right=770 ,bottom=579 </L>
	<L> left=953 ,top=119 ,right=953 ,bottom=579 </L>
	<L> left=1505 ,top=119 ,right=1505 ,bottom=418 </L>
	<L> left=1320 ,top=122 ,right=1320 ,bottom=421 </L>
	<L> left=1320 ,top=418 ,right=1320 ,bottom=577 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1310 ,top=429 ,right=1310 ,bottom=577 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=405 ,top=265 ,right=405 ,bottom=579 </L>
	<L> left=1135 ,top=262 ,right=1135 ,bottom=577 </L>
	<T>id='공제내역' ,left=40 ,top=439 ,right=220 ,bottom=569 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전화비' ,left=228 ,top=439 ,right=405 ,bottom=495 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전화비유보' ,left=590 ,top=439 ,right=767 ,bottom=495 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타공제' ,left=955 ,top=439 ,right=1132 ,bottom=495 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=1140 ,top=439 ,right=1307 ,bottom=495 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=222 ,top=497 ,right=1873 ,bottom=497 </L>
	<T>id='실수령액' ,left=1331 ,top=434 ,right=1863 ,bottom=489 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=32 ,top=680 ,right=1881 ,bottom=680 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='PAY_YM', left=40, top=201, right=220, bottom=254 ,mask='XXXX년XX월', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1598 ,top=116 ,right=1598 ,bottom=262 </L>
	<C>id='EMPNMK', left=230, top=201, right=587, bottom=254, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BASIC_TOT', left=40, top=355, right=220, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전화비유보' ,left=773 ,top=437 ,right=950 ,bottom=468 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지급' ,left=773 ,top=466 ,right=950 ,bottom=497 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='O_TIME_TOT', left=228, top=355, right=405, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RET_PAY', left=407, top=355, right=585, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEN_PAY', left=590, top=355, right=770, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AIR_PAY', left=773, top=355, right=953, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='B20_PAY', left=958, top=355, right=1135, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BON_PAY', left=1140, top=355, right=1318, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LST_PAY', left=1323, top=355, right=1505, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_SUM', left=1508, top=355, right=1871, bottom=407, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TEL_PAY', left=228, top=511, right=405, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='가불' ,left=410 ,top=439 ,right=587 ,bottom=495 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ADV_PAY', left=410, top=511, right=587, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TELUBO_PAY', left=590, top=511, right=767, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TELSAVE_PAY', left=773, top=511, right=950, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETC_PAY', left=955, top=511, right=1132, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEDUCT_SUM', left=1140, top=511, right=1307, bottom=564, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REAL_PAY_SUM', left=1331, top=511, right=1863, bottom=564, align='right', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_DT', left=1323, top=201, right=1505, bottom=254 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=960, top=201, right=1310, bottom=254, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MM', left=29, top=13, right=1873, bottom=90, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=34 ,top=429 ,right=1310 ,bottom=429 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='TEAM_NM', left=590, top=201, right=770, bottom=254, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=773, top=201, right=953, bottom=254, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성별' ,left=1508 ,top=132 ,right=1598 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SEX', left=1511, top=201, right=1598, bottom=254, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='OT시간' ,left=1603 ,top=132 ,right=1736 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='휴일OT' ,left=1741 ,top=132 ,right=1873 ,bottom=188 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1736 ,top=116 ,right=1736 ,bottom=262 </L>
	<C>id='O_TIME', left=1603, top=201, right=1736, bottom=254, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일' ,left=1826 ,top=201 ,right=1871 ,bottom=257 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HO_DAY', left=1744, top=201, right=1826, bottom=254, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>



	">
	</OBJECT><%=HDConstant.COMMENT_END%>	
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>