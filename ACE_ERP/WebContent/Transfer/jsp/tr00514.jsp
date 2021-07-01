<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	물류관리 - 포장요율관리
+ 프로그램 ID	: TR00514.HTML
+ 기 능 정 의	: 조회,저장,삭제
+ 변 경 이 력	: 이민정
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

		var gs_userid = gusrid;
		
		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	
	ln_Before();

}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {

	gcem_eff_date.text='20060301';
	
	gcem_exp_date.text=gs_date;

	//포장구분[검색]
	gcds_pack_type_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0025"; 
	gcds_pack_type_fr.Reset();
	
	//포장구분
	gcds_pack_type.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0025"; 
	gcds_pack_type.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gclx_pack_type_fr.BindColVal;           //구분
	
	var str2 = txt_cbm.value;                          //CBM

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00514_s1?"
									 + "v_str1="+str1+"&v_str2="+str2;
									 
	gcds_data.Reset();
	
	ln_Format(1);
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	gcds_data.AddRow();
	//ln_Enable(t);
	gclx_pack_type.index = 0 ; 

	ln_Format(1);
	
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (gcds_data.IsUpdated){
	
				if(ln_Chk()){

				if (confirm("저장하시겠습니까?")){	

					gctr_data.Action = g_servlet+"/Transfer.tr00514_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_data.post();
			}
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") gcds_data.undo(gcds_data.rowposition)
	else gcds_data.deleterow(gcds_data.rowposition);
	ln_Save();
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
******************************************************************************/
function ln_Chk(){

		//필수항목체크
		if (fn_trim(gclx_pack_type.BindColVal)=="" ){
			alert("포장구분을 선택하십시요.");
			gclx_pack_type.focus();
			return false; 
		}

	return true; 
}

/******************************************************************************
	Description : 페이지 사용유무
******************************************************************************/
function ln_Format(e){
	if (gcds_data.sysStatus(e)=="1") {	//등록

		txt_chargecode.disabled	= false;
		gclx_pack_type.index = 1;
	
	} else {
		
		txt_chargecode.disabled	= true;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 포장구분 [검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_pack_type_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 포장구분  -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_pack_type classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00514_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00514_t1(I:USER=gcds_data)">
</OBJECT><%=HDConstant.COMMENT_END%>  
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	ft_cnt.innerText = "조회건수 : 총 ( " + row + " ) 건";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onRowPoschanged(row)">
	if (gcds_data.sysStatus(row)=="1") txt_chargecode.readOnly = false;
	else txt_chargecode.readOnly = true;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 포장구분 [검색] -->
<script language="javascript" for="gcds_pack_type_fr" event="onloadCompleted(row,colid)">
	gcds_pack_type_fr.InsertRow(1);
	gcds_pack_type_fr.NameValue(1,"MINORCD")="";
	gcds_pack_type_fr.NameValue(1,"MINORNM")="전체";
	gclx_pack_type_fr.index=0;
</script>

<!-- 포장구분 -->
<script language="javascript" for="gcds_pack_type" event="onloadCompleted(row,colid)">
	/*gcds_pack_type.InsertRow(1);
	gcds_pack_type.NameValue(1,"MINORCD")="";
	gcds_pack_type.NameValue(1,"MINORNM")="";
	gclx_pack_type.index=0;*/
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data.reset();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>

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
			<img src="../../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="../../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    	<img src="../../../Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  	</tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      		<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">포장구분</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_pack_type_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_pack_type_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^114">
								<param name=BindColumn			value=MINORCD>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:30px;">CBM</td>
					 <td class="tab21"> 
						 <input type="text" class="txt11" id="txt_cbm" style="width:100px;height:18px;IME-MODE: active" onkeydown="if(event.keyCode==13) ln_Query();">
					</td>
				</tr>
			</table>
		</td>
	</tr>
  <tr> 
    <td colspan="2"> 

      <table width="867" style="position:relative;left:0px;width:866px;top:3px;border:0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:420px; border:1 solid #708090" viewastext>
				              <PARAM NAME="DataID"			VALUE="gcds_data">
				              <PARAM NAME="BorderStyle" VALUE="0">
				              <PARAM NAME="Indwidth"		VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="sortview"		VALUE="left">
								<Param Name="Editable"    VALUE="false"> 
							  <PARAM NAME="Format"			VALUE=" 
								<C> Name='요율코드'			  ID='CHARGECODE' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left</C>
								<C> Name='포장구분'	   	  ID='PACK_TYPE'  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center,
								Editstyle='lookup', Data='gcds_pack_type:minorcd:minornm'</C> 
								<G> Name='적용 CBM'		    ID='FROM_CBM'		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80
								<C> Name='FORM'		        ID='FROM_CBM'		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right, </C>
								<C> Name='TO'	            ID='TO_CBM' 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right, </C>
								</G>
								<C> Name='단가'			      ID='UNIT_PRICE'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right
								</C> 
								<C> Name='적용금액'	      ID='RQST_PRICE'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right
								</C> 
								<C> Name='적용금액2'	    ID='RQST_PRICE2'		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right
								</C>
								<C> Name='AL 진공포장'	  ID='ACM_PRICE'  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right
								</C>
								<C> Name='적용시작일자'	  ID='EFF_DATE'  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center
								MASK='XXXX/XX/XX' </C>
								<C> Name='적용종료일자'		ID='EXP_DATE'       HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center
								MASK='XXXX/XX/XX'</C>
							">
            			</OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:90px;height:30px;" bgcolor="#eeeeee">&nbsp;요율코드</td>
								<td class="tab21" ><input type="text" class="txt11" id="txt_chargecode" style="width:100px;height:20px;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;포장구분</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_pack_type classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_pack_type">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^114">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;적용 CBM</td>
								<td class="tab21" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_from_cbm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:2px;height:20;width:80" >
										 <param name=Alignment					value=2>
					                     <param name=MaxDecimalPlace		value=2>
					                     <param name=Enable							value=true>
										 <param name=MaxLength	      	value=3>

                  						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp; 초과 ~ 
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_to_cbm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:2px;height:20;width:80" >
										 <param name=Alignment					value=2>
					                     <param name=MaxDecimalPlace		value=2>
					                     <param name=Enable							value=true>
  									 	<param name=MaxLength	      	value=3>

                  					</OBJECT><%=HDConstant.COMMENT_END%> &nbsp;&nbsp;이하
								</td>
							</tr>
							
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;단가</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_unit_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
					                     <param name=Alignment					value=2>
					                     <param name=MaxDecimalPlace		value=2>
					                     <param name=Enable							value=true>
										 <param name=Numeric            value="true">
                  					</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								</tr>
								<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;적용금액</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
					                     <param name=MaxDecimalPlace		value=2>
					                     <param name=Enable							value=true>
										
				                  </OBJECT><%=HDConstant.COMMENT_END%>
												</td>
												</tr>

								<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;적용금액2</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
			                     <param name=Alignment					value=2>
			                     <param name=MaxDecimalPlace		value=2>
			                     <param name=Enable							value=true>
										
			                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;AL 진공포장</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_acm_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
			                     <param name=Alignment					value=2>
			                     <param name=MaxDecimalPlace		value=2>
			                     <param name=Enable							value=true>
			                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;적용시작일자</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_eff_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  					</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:4px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_eff_date', 'Text');"> ~ 

									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_exp_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:6px;top:3px;height:20;width:70">
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
				                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:6px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_exp_date', 'Text');">
												</td>
											</tr>
											<tr>
									<td height="200px" style="border:1 solid 
									#708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--밑에 비고칸-->
									<td height="200px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
								</tr>
						</table>
					</td>
        		</tr>
      		</table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=CHARGECODE   Ctrl=txt_chargecode    Param=Value</C>
		<C>Col=PACK_TYPE    Ctrl=gclx_pack_type    Param=BindColVal</C>
		<C>Col=FROM_CBM     Ctrl=gcem_from_cbm     Param=Text</C>
		<C>Col=TO_CBM       Ctrl=gcem_to_cbm       Param=Text</C>
		<C>Col=UNIT_PRICE   Ctrl=gcem_unit_price   Param=Text</C>

		<C>Col=RQST_PRICE   Ctrl=gcem_rqst_price   Param=Text</C>
		<C>Col=RQST_PRICE2  Ctrl=gcem_rqst_price2  Param=Text</C>
		<C>Col=ACM_PRICE    Ctrl=gcem_acm_price    Param=Text</C>
		<C>Col=EFF_DATE     Ctrl=gcem_eff_date     Param=Text</C>
		<C>Col=EXP_DATE     Ctrl=gcem_exp_date     Param=Text</C>
	
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

