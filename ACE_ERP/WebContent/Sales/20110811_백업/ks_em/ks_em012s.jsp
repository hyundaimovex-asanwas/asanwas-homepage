<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 노력발령관리
+ 프로그램ID : ks_em012s.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈 
+ 작성일자 : 2008.09.16
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em012_S1, KS_Em012_t1
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
			     		
      		
		}

/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){



      gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em012_S1";
         //                + "?v_str1=" + fn_trim(gcem_payym.Text)					//급여년월
         //                + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//지급구분
        //                 + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//소속
         //                + "&v_str4=" + fn_trim(gclx_deptcd.value)	      //부서
         //                + "&v_str5=" + fn_trim(txt_empno.value);	        //사번

      
       gcds_data01.Reset();
  

}
/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function ln_before(){


	//발령구분
	gcds_ks010.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS010";
	gcds_ks010.Reset();

	//직장  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();
    
  	gcds_ord_dt_fr.text = gs_date;
  	gcds_ord_dt_to.text = gs_date;

	}

/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(e){//성명조회

  var arrParam	= new Array();
  
 	var strURL   = "./ks_com_pop.jsp"; 

	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	
	var arrResult = showModalDialog(strURL,window,strPos);
  
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



/*----------------------------------------------------------------------------
	Description : 적용
----------------------------------------------------------------------------*/
  function ln_APPLY(){

        if(!ln_APPLY_Chk()) return;



	for(i=1;i<=gcds_data01.countrow;i++){
	
		if(gcds_data01.namevalue(i,"CHK")=="T"){
		
				//인사적용일
				gcds_data01.namevalue(i,"INSA_DAY") = gcds_ord_dt_fr.text;

		}
		
	}
	
		if(confirm("이대로 저장하시겠습니까?")){
		
				alert ("근데 뭘 해야되는건가요???");	
		
			//gctr_data.KeyValue = "KS_Em012_t1(I:USER=gcds_data01)";
			
			//gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em012_t1?";

			//gctr_data.Parameters ="v_str1="+gusrid;
						
			//prompt(this,gcds_data02.text);
			
			//gctr_data.post();
			
		}			



  }
  
  
  
/*----------------------------------------------------------------------------
	Description : 적용시 체크
----------------------------------------------------------------------------*/
function ln_APPLY_Chk(){

  var chk=0;
	
	for(i=1;i<=gcds_data01.countrow;i++){
	
		if(gcds_data01.namevalue(i,"CHK")=="T"){
		
			chk = 1;

			if(gcds_ord_dt_fr.text != gcds_ord_dt_to.text)
			{
			alert ("웬만하면 좀 맞춰주시죠!");
			return;
			}
			
		}	

	}
	
	if(chk==0){
	
		alert("대상자를 선택하십시요.");
		
		return;		
	}

	return true;
}

/******************************************************************************
	Description : 데이타 셋 헤드 설정
******************************************************************************/
function ln_SetDataHeader(){

	if (gcds_data01.countrow<1){
	
		var s_temp = "ORD_DTD:STRING(8),"
									 + "ORD_CD:STRING(3),"
									 + "ORD_NM:STRING(10),"
									 
									 + "EMPNMK:STRING(30),"				
									 + "EMPNO:STRING(10),"
					 
									 + "VEND_CD:STRING(10),"
									 + "VEND_NM:STRING(20),"									 						 
									 + "DEPT_CD:STRING(10),"
									 + "DEPT_NM:STRING(20),"
									 
									 + "WORK_CD:STRING(10),"
									 + "WORK_NM:STRING(20),"									 
									 + "C_VEND_CD:STRING(10),"
									 + "C_VEND_NM:STRING(20),"
									 
									 + "CLASS_CD:STRING(10),"
									 + "CLASS_NM:STRING(20),"									 									 
									 + "JOB_CD:STRING(10),"
									 + "JOB_NM:STRING(20),"		
									 								 
									 + "START_DT:STRING(8),"	
									 + "SEQ:DECIMAL(2),"
									 + "INSA_DAY:STRING(8)";
							
		gcds_data01.SetDataHeader(s_temp);
		
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
			DataSet Component's Event Message Scripts 시작
=============================================================================*/
%>


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


<script language=JavaScript for=gcrp_print event=OnError()>

alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>


<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>


<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- -->
<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 발령구분-->
<OBJECT id=gcds_ks010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black border=0><!-- body table -->
	<tr height="20px"><!-- 버튼 영역 시작-->
		<td align="left" colspan="3">
			<table width="829" border="0"  cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" height="30px">		
						<img src="<%=dirPath%>/Sales/images/apply.gif"   	style="cursor:hand" onclick="ln_APPLY()">
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>																		
			</table>
		</td>
	 </tr>
	 <tr height=20><!-- 조회 영역 시작-->
		<td>
			<table cellpadding=0 cellspacing=1 style="width:829px;height:20px;" bgcolor="#708090">
				<tr>
				  <td bgcolor="#eeeeee" width="50" align = center>소 속</td>
					<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcds_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:70px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="true">
										</OBJECT>
										<OBJECT id=gcds_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>										
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('01');">
									</td>										
									<td bgcolor="#eeeeee" width="50" align = center>직장구분</td>
									<td bgcolor="#FFFFFF">
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
									<td bgcolor="#eeeeee" width="50" align = center>근무현장</td>
									<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcds_work_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:70px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gcds_work_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>	
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('04');">
									</td>					
									</tr>
									<tr>
									  <td bgcolor="#eeeeee" width="50" align = center>발령일자</td>
										<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
														<OBJECT id=gcds_ord_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
														style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														</OBJECT><%=HDConstant.COMMENT_END%>								
																<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcds_ord_dt_fr', 'Text');">
																	<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>								
																<%=HDConstant.COMMENT_START%>
																	<OBJECT id=gcds_ord_dt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
																	style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " >
																	<param name=Alignment			value=0>
																	<param name=Border	      value=true>
																	<param name=Format	      value="YYYY/MM/DD">
																	<param name=PromptChar	  value="_">								
																	</OBJECT><%=HDConstant.COMMENT_END%>								
																<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcds_ord_dt_to', 'Text');">
															</td>
														<td bgcolor="#eeeeee" width="50" align = center>발령구분</td>
														<td bgcolor="#FFFFFF">
														<%=HDConstant.COMMENT_START%>
														<object id=gcds_ord_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
														style="position:relative;left:8px;top:1px;font-size:12px;width:120px;" >
														<param name=ComboDataID			value="gcds_ks010">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort				    value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^120">
														<param name=BindColumn			value=COM_CODE>
														</object></comment>	<script>__ws__(__NSID__);</script>					
													</td>						
									<td align="center" width="50" bgcolor="#eeeeee">성명</td>
									<td bgcolor="#FFFFFF">
									  <input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
										<img src="<%=dirPath%>/Sales/images/help.gif" alt="성명을 검색합니다" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
									  <input type="text" id="txt_empno" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
									</td>
								</tr>
							</table>
						  </td>
					    </tr>
						<tr>
							<td valign="top" bgcolor="#FFFFFF"><br>
								<table cellpadding=0 cellspacing=1 style="width:827px;height:390px;" bgcolor="">
									<tr>
										<td bgcolor="#FFFFFF" align="left" class="tab_z1111">
											<%=HDConstant.COMMENT_START%>
											<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:805;height:370px;border:0 ">
											<PARAM NAME="DataID"		VALUE="gcds_data01">
											<PARAM NAME="BorderStyle"   VALUE="0">
											<PARAM NAME="Indwidth"		VALUE="0">
											<PARAM NAME="Fillarea"		VALUE="true">
											<PARAM NAME="Colsizing"		VALUE="true">
											<PARAM NAME="TitleHeight"	VALUE=30>
											<param name="editable"      value="true">
											<param name="sortview"      value=left>
											<PARAM NAME="Format"			VALUE="              	 			
											<FC>ID=CurRow,	  Name=순번,	 width=30,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center  edit=none value={CurRow}</FC>
											<FC>ID=CHK,		  Name=선택,	 width=30,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, EditStyle='CheckBox'</FC>
				             				<FC>ID=ORD_DT,    Name=발령일자 ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC  mask='XXXX/XX/XX' </FC>
				              				<FC>ID=ORD_CD,    Name=발령구분 ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC  value={IF (ORD_CD='1','신규',IF (ORD_CD='2','조동' ,IF (ORD_CD='3','퇴사' ,'')))}</FC>				             				
				             				<C>ID=EMPNMK,	  Name=성명     ,width=65px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
				              				<C>ID=EMPNO,	  Name=직번     ,width=60px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
				              				<C>ID=VEND_NM,	  Name=소속     ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
											<C>ID=DEPT_NM,	  Name=직장구분 ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
											<C>ID=WORK_NM,	  Name=근무현장 ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC  </C>
											<C>ID=C_VEND_NM,  Name=비용부담업체 ,width=80px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
											<C>ID=CLASS_NM,	  Name=직영구분     ,width=70px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
											<C>ID=JOB_NM,	  Name=직종         ,width=50px,	align=center,	edit=none HeadBgColor=#B9D4DC   </C>
											<C>ID=INSA_DAY,	  Name=인사적용일   ,width=70px,	align=right, HeadBgColor=#B9D4DC  mask='XXXX/XX/XX' </C>													
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