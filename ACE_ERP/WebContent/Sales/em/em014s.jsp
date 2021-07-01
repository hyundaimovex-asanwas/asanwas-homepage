<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 출력일보현항
+ 프로그램ID : em014s.jsp
+ 기능정의 : 
+ 작 성 자 : 정하나 
+ 작성일자 : 2008.4.20
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em014_S.java
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

	var gs_team_cd=""; //출력일보권한 - 소속팀


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

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S"
											 + "?v_str1=" + fn_trim(gcem_payym.Text)					//출력년월
											 + "&v_str2=" + fn_trim(gclx_deptcd.bindcolval)		//부서
											 + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval);		//소속
										
//prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){

	//부서  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM006";
	gcds_cm006.Reset();
	
	//소속팀  CM003
	gcds_cm003_G.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm003?v_str1=CM003";
	gcds_cm003_G.Reset();
	//부서  CM006
	gcds_cm006_G.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM006";
	gcds_cm006_G.Reset();

	//출력일보 담당자별 소속팀....
	gcds_cm034.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s2?v_str1=CM034&v_str2="+gusrid;
	gcds_cm034.Reset();
  
	gs_team_cd="";

	for(i=1;i<=gcds_cm034.countrow;i++){
		if(gcds_cm034.namevalue(i,"ITEM3")=="00000"){
			 gs_team_cd="00000";
			 break;   //전체일 경우
		}
		if(i==1) gs_team_cd = gcds_cm034.namevalue(i,"ITEM3");
		if(i>1)  gs_team_cd = gs_team_cd +"','"+gcds_cm034.namevalue(i,"ITEM3");
	}

	//소속팀  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s3?v_str1=CM003&v_str2="+gs_team_cd;
	gcds_cm003.Reset();

	//gcds_cm034.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s2?v_str1=CM034&v_str2=6070001";
	//gcds_cm034.Reset();

}

/*----------------------------------------------------------------------------
	Description : 엑셀
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName = "출력일보현황";
    var szPath = "C:\\Test\\em014s.xls";
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

	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
	if(gcds_cm034.namevalue(gcds_cm034.rowposition,"ITEM3")=="00000"){
		ln_Insert_Row(2,"gcds_cm003","gclx_teamcd");
	}
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
	<param name=UseFilter   value=true>
</OBJECT>

<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm003_G classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm006_G classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm034 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>
						<td align="right" height="30px">
 								<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
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
            <td bgcolor="#eeeeee" align="center">출력년월</td>
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
                style="position:relative;left:8px;top:1px;font-size:12px;width:140px;">
                <param name=ComboDataID			value="gcds_cm003">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^140">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
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
              <FC>ID=DEPT_CD			,	Name=부서      ,     Sort=True    ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm006_G:COM_CODE:COM_SNAME' ,  SumBgColor=#C3D0DB</FC>
							<FC>ID=TEAM_CD			,	Name=소속     ,     Sort=True ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm003_G:COM_CODE:COM_SNAME' ,suppress=1, subsumText={decode(CurLevel,1,'    소계',TEAM_NM)}, sumText='합계' SumBgColor=#C3D0DB</FC>
							<FC>ID=EMPNO				,	Name=사번     ,     Sort=True     ,width=55px,	align=center,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</FC>
							<FC>ID=EMPNMK      ,	Name=성명      ,     Sort=True    ,width=60px,	align=left,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</FC>
							<FC>Name=OT\\시간계,       ID=O_TIME_TOT , SumText=@sum, width=50 ,HeadBgColor=#C6DEFF, bgcolor=#C2DFFF, align=right, DEC=1, SumBgColor=#C3D0DB</FC>
									<C>ID=D01				,	Name=1        ,width=40px,	SumText={sum(tonumber(IF(D01=H,0,IF(D01=C,0,IF(D01=V,0,D01)))))}, color={decode(D01,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D02				,	Name=2        ,width=40px,	SumText={sum(tonumber(IF(D02=H,0,IF(D02=C,0,IF(D02=V,0,D02)))))}, color={decode(D02,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D03				,	Name=3        ,width=40px,	SumText={sum(tonumber(IF(D03=H,0,IF(D03=C,0,IF(D03=V,0,D03)))))}, color={decode(D03,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,    HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D04				,	Name=4        ,width=40px,	SumText={sum(tonumber(IF(D04=H,0,IF(D04=C,0,IF(D04=V,0,D04)))))}, color={decode(D04,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D05				,	Name=5        ,width=40px,	SumText={sum(tonumber(IF(D05=H,0,IF(D05=C,0,IF(D05=V,0,D05)))))}, color={decode(D05,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D06				,	Name=6        ,width=40px,	SumText={sum(tonumber(IF(D06=H,0,IF(D06=C,0,IF(D06=V,0,D06)))))}, color={decode(D06,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D07				,	Name=7        ,width=40px,	SumText={sum(tonumber(IF(D07=H,0,IF(D07=C,0,IF(D07=V,0,D07)))))}, color={decode(D07,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D08				,	Name=8        ,width=40px,	SumText={sum(tonumber(IF(D08=H,0,IF(D08=C,0,IF(D08=V,0,D08)))))}, color={decode(D08,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D09				,	Name=9        ,width=40px,	SumText={sum(tonumber(IF(D09=H,0,IF(D09=C,0,IF(D09=V,0,D09)))))}, color={decode(D09,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D10				,	Name=10       ,width=40px,    SumText={sum(tonumber(IF(D10=H,0,IF(D10=C,0,IF(D10=V,0,D10)))))}, color={decode(D10,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D11				,	Name=11       ,width=40px,	SumText={sum(tonumber(IF(D11=H,0,IF(D11=C,0,IF(D11=V,0,D11)))))}, color={decode(D11,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D12				,	Name=12       ,width=40px,	SumText={sum(tonumber(IF(D12=H,0,IF(D12=C,0,IF(D12=V,0,D12)))))}, color={decode(D12,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D13				,	Name=13       ,width=40px,	SumText={sum(tonumber(IF(D13=H,0,IF(D13=C,0,IF(D13=V,0,D13)))))}, color={decode(D13,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D14				,	Name=14       ,width=40px,	SumText={sum(tonumber(IF(D14=H,0,IF(D14=C,0,IF(D14=V,0,D14)))))}, color={decode(D14,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D15				,	Name=15       ,width=40px,	SumText={sum(tonumber(IF(D15=H,0,IF(D15=C,0,IF(D15=V,0,D15)))))}, color={decode(D15,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D16				,	Name=16       ,width=40px,	SumText={sum(tonumber(IF(D16=H,0,IF(D16=C,0,IF(D16=V,0,D16)))))}, color={decode(D16,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D17				,	Name=17       ,width=40px,	SumText={sum(tonumber(IF(D17=H,0,IF(D17=C,0,IF(D17=V,0,D17)))))}, color={decode(D17,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D18				,	Name=18       ,width=40px,	SumText={sum(tonumber(IF(D18=H,0,IF(D18=C,0,IF(D18=V,0,D18)))))}, color={decode(D18,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D19				,	Name=19       ,width=40px,	SumText={sum(tonumber(IF(D19=H,0,IF(D19=C,0,IF(D19=V,0,D19)))))}, color={decode(D19,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D20				,	Name=20       ,width=40px,	SumText={sum(tonumber(IF(D20=H,0,IF(D20=C,0,IF(D20=V,0,D20)))))}, color={decode(D20,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D21				,	Name=21       ,width=40px,	SumText={sum(tonumber(IF(D21=H,0,IF(D21=C,0,IF(D21=V,0,D21)))))}, color={decode(D21,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D22				,	Name=22       ,width=40px,	SumText={sum(tonumber(IF(D22=H,0,IF(D22=C,0,IF(D22=V,0,D22)))))}, color={decode(D22,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D23				,	Name=23       ,width=40px,	SumText={sum(tonumber(IF(D23=H,0,IF(D23=C,0,IF(D23=V,0,D23)))))}, color={decode(D23,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D24				,	Name=24       ,width=40px,	SumText={sum(tonumber(IF(D24=H,0,IF(D24=C,0,IF(D24=V,0,D24)))))}, color={decode(D24,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D25				,	Name=25       ,width=40px,	SumText={sum(tonumber(IF(D25=H,0,IF(D25=C,0,IF(D25=V,0,D25)))))}, color={decode(D25,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D26				,	Name=26       ,width=40px,	SumText={sum(tonumber(IF(D26=H,0,IF(D26=C,0,IF(D26=V,0,D26)))))}, color={decode(D26,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D27				,	Name=27       ,width=40px,	SumText={sum(tonumber(IF(D27=H,0,IF(D27=C,0,IF(D27=V,0,D27)))))}, color={decode(D27,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D28				,	Name=28       ,width=40px,	SumText={sum(tonumber(IF(D28=H,0,IF(D28=C,0,IF(D28=V,0,D28)))))}, color={decode(D28,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D29				,	Name=29       ,width=40px,	SumText={sum(tonumber(IF(D29=H,0,IF(D29=C,0,IF(D29=V,0,D29)))))}, color={decode(D29,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D30				,	Name=30       ,width=40px,	SumText={sum(tonumber(IF(D30=H,0,IF(D30=C,0,IF(D30=V,0,D30)))))}, color={decode(D30,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>
									<C>ID=D31				,	Name=31       ,width=40px,	SumText={sum(tonumber(IF(D31=H,0,IF(D31=C,0,IF(D31=V,0,D31)))))}, color={decode(D31,'H','#F6358A','V','#F6358A','C','#F6358A', 'black')}, Dec=1, align=right,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB</C>            
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
		&nbsp;
		<tr>
			<td valign="middle"><!-- 테이블 시작 -->
				<table border=0 cellpadding=1 cellspacing=1 style="width:300px;" bgcolor="#708090" align = left >
          <tr height="25">
            <td bgcolor="#eeeeee" align="center"  ><font color = "blue"> *H = "휴무"  *V = "휴가"  *C = "출면정지" </font></td>
            </tr>
            </table>
            </td>
            </tr>
	</table>
 
<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>