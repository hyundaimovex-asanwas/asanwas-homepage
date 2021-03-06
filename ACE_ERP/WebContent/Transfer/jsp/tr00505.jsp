<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:  기준정보관리	- 정산코드관리
+ 프로그램 ID	:  TR00505.html
+ 기 능 정 의	:  거래처코드를 조회한다.
+ 작   성  자 :  이민정
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
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
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
		get_cookdata();

		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		var gs_userid = gusrid;
		
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	  ln_SetDataHeader();
	
	  gcem_settle_cd.enabled= false;

}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00505_s1?"+"v_str1="+gcem_settle_cd_fr01.text + "&v_str2=" + txt_settle_nm_fr01.value; 

		gcds_code01.Reset();


}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
  
		gcds_code01.addrow();
		
		//ln_Enable("t");
		gcem_settle_cd.focus();
	
}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	

	if (gcds_code01.IsUpdated){
		if(ln_Chk()){
			if (confirm("저장하시겠습니까?")){	

				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>transfer.tr00505_t1?";

				
				gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
				gctr_code01.post();
				
			}
		}	
	}
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

	if (confirm("삭제하시겠습니까?")){	
	
		gcds_code01.deleterow(gcds_code01.rowposition);
		
		gctr_code01.Action =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>transfer.tr00505_t1?";
		gctr_code01.Parameters = "v_str1=" + gs_userid;
		
		gctr_code01.post();
		
		ln_Query();
	}	
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 입력체크 
	parameter   : 01 - 거래처, 02 - 지점, 03 - 사업장 
******************************************************************************/
function ln_Chk(){

		//필수항목체크
		if (fn_trim(gcem_settle_cd.text)=="" ){
			alert("정산코드를 입력하십시요.");
			gcem_settle_cd.focus();
			return false; 
		}

		if (fn_trim(txt_settle_nm.value)==""){
			alert("정산코드명을 입력하십시요.");
			txt_settle_nm.focus();
			return false; 
		} 
	
	return true; 
}


/***********************************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
***********************************************************************************************/

/*function ln_Enable(p) {
	if (p=="t"){
		gcem_settle_cd.enable=true;
	}else if (p=="f"){
		gcem_settle_cd.enable=false;

	}
}
*/
/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp = "SETTLE_CD:STRING,SETTLE_NM:STRING,ACC_CODE:STRING,SELL_TYPE:STRING,SORT_NO:DECIAML,"
								+ "REMARK:STRING,CREAT_USR:STRING,UPDATE_USR:STRING";
			
		gcds_code01.SetDataHeader(s_temp);
}


</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="tr00505_t1(I:USER=gcds_code01)"> 
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : 총 ( " + row + " ) 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcds_code01 event=OnClick(Row,Colid)>
	if(Row>0) ;//ln_Enable01("f");
</script>

<script language=javascript for=gcds_code01 event="OnRowPosChanged(row)">
	if (gcds_code01.sysStatus(row)=="0") gcem_settle_cd.enable = false;
	else gcem_settle_cd.enable = true;
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_code01" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr>
    	<td width="876" align="right" background="../../common/img/com_t_bg.gif">
    	<td width="876" align="right" background="../../common/img/com_t_bg.gif">    	
		<img src="../../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()" >
		<img src="../../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()" >
		<img src="../../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()"> 
		<img src="../../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
	 </td>
	</tr>
	<tr>  
    <td align="center" colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td class="tab12" style="height:30px;width:100px;" bgcolor="#eeeeee">정산코드</td>
					<td class="tab23" style="width:150px">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_settle_cd_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#############">
							<param name=PromptChar    value="">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">정산코드명</td>
					<td>
						<input id="txt_settle_nm_fr01" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px;IME-MODE: active" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 
					</td>
				</tr>
			</table>
		</td>
	</tr>
		
		<tr><td height="3px" colspan =2 align="left" valign="top"></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:540px;border:0 solid #708090;">
					<tr> 			
						<td>
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code01  
							style="position:relative;left:0px;width:540px;top:1px;height:420px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='정산코드'					    ID=SETTLE_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  </C> 
								<C> Name='정산코드명'						ID=SETTLE_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	 </C> 
								<C> Name='회계계정코드'					ID=ACC_CODE				HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	 </C> 
								<C> Name='매출구분'							ID=SELL_TYPE			HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=LEFT	 </C> 
								<C> Name='비고'	    						ID=REMARK			    HeadAlign=Center HeadBgColor=#B9D4DC Width=110		align=LEFT	</C> 
								">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						<fieldset style="position:relative;left:0px;width:542px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
			</tr>
		</table>
	</td>

		<td valign="top">

			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:2px;top:1px;width:330px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;정산코드</td>
				<td class="tab18"> 
					 <%=HDConstant.COMMENT_START%>
					 <OBJECT id=gcem_settle_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:36px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
					 	<param name=BackColor     value="#CCCCCC"> 
						<param name=InheritColor  value=false>
						<param name=format        value="0000">
						<param name=maxlength     value="4">
						<param name=PromptChar		value="_">
					</OBJECT>
					<%=HDConstant.COMMENT_END%> 
				</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;정산코드명</td>
			<td class="tab19"> 
				 <input id="txt_settle_nm" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="50" >
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;회계계정코드</td>
			<td class="tab19"> 
			<input id="txt_acc_code" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="10" >

			
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;매출구분</td>
				<td class="tab19"> 
				 <input id="txt_sell_type" type="text" class="txtbox"  style= "width:226px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="4" >
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:30px;" bgcolor="#eeeeee" >&nbsp;Sort</td>
				<td class="tab19" > 
					 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_sort_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
					 	<param name=BackColor     value="#CCCCCC"> 
						<param name=InheritColor  value=false>
						<param name=format        value="####">
						<param name=maxlength     value="4">
						<param name=Alignment			value=2>
						<param name=PromptChar		value="">
					</OBJECT><%=HDConstant.COMMENT_END%> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;height:80px;" bgcolor="#eeeeee" >&nbsp;비고</td>
				<td class="tab19"> 
					<textarea id="txt_remark" class="txtbox"  style= "width:226px; height:68px; overflow:auto;position:relative;left:8px;IME-MODE: active" maxlength="50" onBlur="bytelength(this,this.value,50);"></textarea>
				</td>
			</tr>
		
				<tr>
					<td height="211px" style="border:1 solid #708090;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--밑에 비고칸-->
					<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
				</tr>
		
		</table> 
	  </td>
  </tr> 

</table> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=SETTLE_CD			 Ctrl=gcem_settle_cd				Param=text</C>
		<C>Col=SETTLE_NM			 Ctrl=txt_settle_nm					Param=Value</C>
		<C>Col=ACC_CODE				 Ctrl=txt_acc_code		 			Param=Value</C>
		<C>Col=SELL_TYPE			 Ctrl=txt_sell_type					Param=Value</C>
		<C>Col=SORT_NO				 Ctrl=gcem_sort_no					Param=text</C>
		<C>Col=REMARK					 Ctrl=txt_remark						Param=value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


