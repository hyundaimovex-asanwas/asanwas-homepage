<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 출력 현황
+ 프로그램ID : ks_em026s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.09.30
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 : 
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em026_S1.java
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

			gcem_att_dt.Text = gs_date;


		}

/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data00.UseChangeInfo ="true"; 

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em026_S1"
											 + "?v_str1=" + gclx_dept_cd.bindcolval	// 직장구분       
						//					 + "&v_str2=" + gcem_att_dt.text					// 출근일자        
											 + "&v_str3=" + txt_empno.value 			    // 직번       
											 + "&v_str4=" + txt_empnmk.value;			  // 성명       
  	
	gcds_data00.Reset();
	
}

/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){
 
 	ln_SetDataHeader();

	//직장
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS006";
	gcds_ks006.Reset();


}

/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(){//성명조회

  	var arrParam	= new Array();  
 	var strURL   = "./ks_com_pop.jsp";   	
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}


/******************************************************************************
	Description :  사용함.
******************************************************************************/
function ln_SetDataHeader(){

	if (gcds_data00.countrow<1){
	
				var s_temp = "ATT_DT:STRING(10),"				
									 + "EMPNO:STRING(10),"
									 + "EMPNMK:STRING(10),"
									 
									 + "VEND_CD:STRING(10),"
									 + "VEND_NM:STRING(20),"									 						 
									 + "DEPT_CD:STRING(10),"
									 + "DEPT_NM:STRING(20),"
									 + "JOB_CD:STRING(10),"
									 + "JOB_NM:STRING(20),"	
									 
									 + "WORK_CD:STRING(10),"
									 + "WORK_NM:STRING(20),"
									 + "C_VEND_CD:STRING(10),"
									 + "C_VEND_NM:STRING(20),"
									 + "SKILL_CD:STRING(10),"
									 + "SKILL_NM:STRING(20),"
									
									 + "CLASS_CD:STRING(10),"
									 + "CLASS_NM:STRING(20),"

									 + "WEEK_GB:STRING(1),"
									 + "WORK_GB:STRING(1),"
									 + "SAYU_GB:STRING(1),"
									 + "MODI_YN:STRING(1),"

									 + "M_PAY:DECIMAL(10.3),"
									 + "D_PAY:DECIMAL(10.3),"									 
									 + "T_PAY:DECIMAL(10.3),"
									 									 
									 + "A_TM:STRING(4),"
									 + "L_TM:STRING(4),"
									 + "E_TM:STRING(4),"
									 + "G_TM:STRING(4),"
									 + "R_TM:STRING(4),"
									 + "FINI_GB:STRING(1),"
									 + "C_A_TM:STRING(4),"
									 + "C_L_TM:STRING(4),"
									 + "C_E_TM:STRING(4),"

									 + "M_H:DECIMAL(4.1),"
									 + "A_H:DECIMAL(4.1),"									 
									 + "O_H:DECIMAL(4.1),"
									 + "N_H:DECIMAL(4.1),"
									 + "E_H:DECIMAL(4.1),"									 
									 + "T_H:DECIMAL(4.1),"
									 + "G_H:DECIMAL(4.1),"
									 
									 + "CHK:STRING(1),"			
										 					 
									 + "I_DATE:STRING(20),"
									 + "U_DATE:STRING(20),"
									 + "I_EMPNO:STRING(10),"
									 + "U_EMPNO:STRING(10)";
								 					
				gcds_data00.SetDataHeader(s_temp);
		
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
			Transaction Component's Event Message Scripts 시작
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업성공-TR1
	%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
	
		 alert("저장에 성공하였습니다");
		 ln_Query();
		 
	</script>
	
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
	%>
	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
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
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- 버튼 영역 시작-->
					<tr>									
						<td align="right" height="30px">		

							<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onclick="ln_Query()">

						</td>
					</tr>																		
				</table>
			</td>
		</tr>	
		<tr>
			<td valign="top"><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					  <td bgcolor="#eeeeee" align="center">출근일자</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_att_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      value=true>
				              <param name=Format	      value="YYYY/MM/DD">
				              <param name=PromptChar	  value="_">
				              </OBJECT><%=HDConstant.COMMENT_END%>
				              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_fr', 'Text');">
						</td>      
						<td align="center" width="120" bgcolor="#eeeeee">성명 </td>
						<td bgcolor="#FFFFFF">
						<input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:80px;top:-1px;">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" alt="성명을 검색합니다" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
					  <input type="text" id="txt_empno" style="position:relative;;left:8px;width:80px;top:-1px;">&nbsp;
					</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">직장</td>
						<td bgcolor="#FFFFFF" colspan ="3">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_ks006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
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
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=0 style="width:829px;height:390px;position:relative;top:-5px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="editable"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<param name="ViewSummary"  value="1">
  						<PARAM NAME="Format"			VALUE="  
                				<F> Name=NO				  	ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=center  SumBgColor=#C3D0DB edit=none</F> 
                				<FC>Name=직장,   			ID=DEPT_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  SumBgColor=#C3D0DB edit=none</FC>
								<FC>Name=평일구분,       ID=WEEK_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true  SumBgColor=#C3D0DB edit=none</FC> 
                				<FC>Name=근무구분,     ID=WORK_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true SumBgColor=#C3D0DB edit=none</FC>
                				<FC>Name=로임,    	 ID=MONEY_NM ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true  SumBgColor=#C3D0DB edit=none</FC>
                				<FC>Name=직번,       ID=EMPNO   ,width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true SumBgColor=#C3D0DB edit=none</FC>
								<FC>Name=성명,       ID=EMPNMK  ,width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true SumBgColor=#C3D0DB edit=none</FC>								
								<C>Name=사유,  		ID=SAYU_GB  ,width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center SumBgColor=#C3D0DB 
								value={IF (SAYU_GB='1','근무',IF (SAYU_GB='2','조퇴' ,IF (SAYU_GB='3','결근' ,IF (SAYU_GB='4','정기휴가' ,IF (SAYU_GB='5','보조휴가' ,IF (SAYU_GB='6','보충휴가', IF (SAYU_GB='7','산전휴가',IF (SAYU_GB='8','산후휴가',IF (SAYU_GB='9','기타','' )))))))))} </C>								
								<C>Name=수정,  		ID=MODI_YN ,width=55,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center SumBgColor=#C3D0DB value={IF (FINI_GB='N','미수정',IF (FINI_GB='Y','수정' ,''))} show=false</C>               				
                				<C>Name=출근시간,     ID=A_TM,  width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  SumBgColor=#C3D0DB edit=none mask='XX:XX'</C>
                				<C>Name=퇴근시간,     ID=L_TM ,width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   SumBgColor=#C3D0DB edit=none mask='XX:XX'</C>
                				<C>Name=조퇴시간,       ID=E_TM   ,width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, SumBgColor=#C3D0DB edit=none mask='XX:XX'</C>
								<C>Name=외출시간,       ID=G_TM  ,width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, SumBgColor=#C3D0DB edit=none mask='XX:XX'</C>
								<C>Name='복귀시간',  ID=R_TM  ,width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, SumBgColor=#C3D0DB edit=none mask='XX:XX'</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset style="width:829;height:20px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
								</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- 기본탭 -->
	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
		  <C>Col=EMPNO       		 	 Ctrl=empno      			   				Param=Value</C>
			<C>Col=EMPNMK       		Ctrl=empnmk       						Param=Value</C>
			<C>Col=VEND_CD   			  Ctrl=txt_vend_cd     					  	Param=Value</C>
			<C>Col=VEND_NM    			Ctrl=txt_vend_nm       					Param=Value</C>
			<C>Col=DEPT_CD   			  Ctrl=txt_dept_cd     					  	Param=Value</C>
			<C>Col=DEPT_NM    			Ctrl=txt_dept_nm       					Param=Value</C>			
			<C>Col=JOB_CD   			  Ctrl=txt_job_cd     					  	Param=Value</C>			
			<C>Col=JOB_NM    				Ctrl=txt_job_nm       						Param=Value</C>
			<C>Col=WORK_CD   			  Ctrl=txt_work_cd     					  	Param=Value</C>			
			<C>Col=WORK_NM    			Ctrl=txt_work_nm       					Param=Value</C>
			<C>Col=C_VEND_CD   			  Ctrl=txt_c_vend_cd     					  	Param=Value</C>			
			<C>Col=C_VEND_NM    			Ctrl=txt_c_vend_nm       					Param=Value</C>						
			<C>Col=CLASS_CD     			Ctrl=txt_class_cd      						Param=Value</C>
			<C>Col=CLASS_NM   			Ctrl=txt_class_nm     						Param=Value</C>
			<C>Col=WEEK_GB   			  	Ctrl=gclx_week_gb     						Param=bindcolval</C>
			<C>Col=MODI_YN   				Ctrl=gcem_modi_yn   						Param=Text</C>
			<C>Col=M_PAY     			Ctrl=gcem_m_pay    					Param=Text</C>
			<C>Col=D_PAY 				Ctrl=gcem_d_pay 						Param=Text</C>
			<C>Col=T_PAY 				Ctrl=gcem_t_pay 							Param=Text</C>		
			<C>Col=FINI_GB     			Ctrl=gcem_fini_gb      					Param=Text</C>
		">
	</OBJECT><%=HDConstant.COMMENT_END%>
	</table>

<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>





