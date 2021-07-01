<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  반출주문조회
+ 프로그램 ID	: TR00104.HTML
+ 기 능 정 의	: 반출배정관리
+ 변 경 이 력	: 정미선
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

		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start() {

		//프로젝트[검색]
		gcds_relpart_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
		gcds_relpart_fr.Reset();
	
		//프로젝트[입력]
		gcds_relpart.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
		gcds_relpart.Reset();

}
/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00605_s1?NOH=Y"
									 + "&gstr1=" + txt_userid_fr.value 
									 + "&gstr2=" + txt_usernm_fr.value
									 + "&gstr3=" + gclx_relpart_fr.bindColVal 
									 + "&gstr4=" + txt_regnm_fr.value;
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.AddRow();
	gcds_data.namevalue(gcds_data.rowposition,"TEMPFLAG") = "N";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_data.IsUpdated){
		if(ln_Chk()){
			if (confirm("입력하신 물류 사용자 정보를 저장하시겠습니까?")){	
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
	if (confirm("선택하신 사용자를 삭제하시겠습니까?")){
		var row = gcds_data.rowposition;
		if (gcds_data.sysStatus(row)=="1") gcds_data.undo(row);
		else {
			gcds_data.deleterow(row);
			gctr_data.post();
		}
	}
}
/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

		if (gcds_data.countrow<1) alert("다운로드하실 자료가 없습니다.");
		else gcgd_disp.RunExcel('물류사용자');
	
}

/******************************************************************************
	Description : 입력체크 
******************************************************************************/
function ln_Chk(){
	if (fn_trim(txt_userid.value)=="" ){
			alert("아이디를 입력하십시요.");
			return false; 
	}
	if (fn_trim(txt_userpw.value)=="" ){
		alert("비밀번호를 입력하십시요.");
		txt_userpw.focus();
		return false; 
	}

	if (fn_trim(gcem_regno.text)=="" ){
		alert("사업자번호를 입력하십시요.");
		gcem_regno.focus();
		return false; 
	}

	return true;
}

/******************************************************************************
	Description : 우편번호 찾기
******************************************************************************/
function ln_Popup(){
	if (gcds_data.countrow<1) return;

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//strURL = "../common/html/com_zipcd.html";
	strURL = "./com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		var post_no1 = arrParam[0];
		gcem_zipcd.text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		txt_addr1.value = val;
	
	}
}

/******************************************************************************
	Description : 아이디체크 
******************************************************************************/
function ln_Popup01(){
	if (gcds_data.countrow<1) return;
	if (gcds_data.sysStatus(gcds_data.rowposition)!="1") return;

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//strURL = "/Transfer/html/TR00605_popup.html";
	strURL = "./tr00605_popup.jsp";
	strPos = "dialogWidth:370px;dialogHeight:160px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);
		
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_userid.value = arrParam[0].toUpperCase();
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 프로젝트 [검색] -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_relpart_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-- 프로젝트 -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_relpart classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action"		VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00605_t1">
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue"	VALUE="tr00605_t1(I:USER=gcds_data)">
</OBJECT>
<%=HDConstant.COMMENT_END%>  

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
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
	
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
</script>

<!-- 프로젝트 [검색] -->
<script language="javascript" for="gcds_relpart_fr" event="onloadCompleted(row,colid)">
	gcds_relpart_fr.InsertRow(1);
	gcds_relpart_fr.NameValue(1,"MINORCD")="";
	gcds_relpart_fr.NameValue(1,"MINORNM")="전체";
	gclx_relpart_fr.index=0;
</script>

<!-- 프로젝트  -->
<script language="javascript" for="gcds_relpart" event="onloadCompleted(row,colid)">
	gcds_relpart.InsertRow(1);
	gcds_relpart.NameValue(1,"MINORCD")="";
	gcds_relpart.NameValue(1,"MINORNM")="전체";
	gclx_relpart.index=0;
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
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
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="877" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif">
		
			<img src= "<%=dirPath%>/Common/img/btn/com_b_excel.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Excel()">
			<img src= "<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src= "<%=dirPath%>/Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
			<img src= "<%=dirPath%>/Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
	    	<img src= "<%=dirPath%>/Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:90px;height:30px;">사용자 ID</td>
					<td class="tab21"><input type="text" class="txt11" id="txt_userid_fr" style="width:100px;height:18px;IME-MODE: inactive;" onkeydown="if(event.keyCode==13) ln_Query();" ></td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:90px;">사용자명</td>
					<td class="tab21"><input type="text" class="txt11" id="txt_usernm_fr" style="width:90px;height:18px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:90px;">프로젝트</td>
					<td class="tab21" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gclx_relpart_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:150px;">
								<param name=ComboDataID			value="gcds_relpart_fr">
								<param name=SearchColumn			value="MINORNM">
								<param name=ListExprFormat			value="MINORNM^0^160">
								<param name=BindColumn				value="MINORCD">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
					</td> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:90px;">담당자명</td>
					<td class="tab21"><input type="text" class="txt11" id="txt_regnm_fr" style="width:90px;height:18px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height=3></td></tr>
	<tr>
		<td colspan=2>
      <table width="867" cellpadding="1" cellspacing="0" border="0">
				<tr> 
          <td style="width:503" valign=top>
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:421px; border:1 solid #708090" viewastext>
              				<PARAM NAME="DataID"		VALUE="gcds_data">
							<PARAM NAME="SortView"		VALUE="left">
			              	<PARAM NAME="TitleHeight"   VALUE="22">
			              	<PARAM NAME="RowHeight"		VALUE="20">
			              	<PARAM NAME="BorderStyle"   VALUE="0">
			              	<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"      VALUE="false"> 
						  	<PARAM NAME="Format"		VALUE=" 
							  <F> Name='순번'		       	ID='SEQ' 	       	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	Value={ToString(CurRow)}</F>
								<C> Name='사용자ID' 		  	ID='USERID' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left, sort=true</C>
								<C> Name='비밀번호'			ID='USERPW' 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left</C>
								<C> Name='사용자명'		   	ID='USERNM'     	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left, sort=true</C>
								<C> Name='사업자번호'	        ID='REGNO' 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center Mask='XXX-XX-XXXXX'</C>
								<C> Name='담당자명'	      	ID='REGNM'   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C>
								<C> Name='전화번호'	      	ID='TEL' 	      	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center </C>
								<C> Name='휴대폰번호'		    ID='MOBILE' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=center </C>
								<C> Name='프로젝트'			ID='RELPART' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=157	align=left EditStyle=Lookup Data='gcds_relpart:minorcd:minornm', sort=true </C>
								">
            			</OBJECT>
            			<%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:29px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:7px;"></font>
						</fieldset>
					</td>
					<td valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:120px;height:25px;" bgcolor="#eeeeee">&nbsp;사용자ID</td>
								<td class="tab21" > 
									<input type="text" class="txt11" id="txt_userid" style="width:100px;height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" disabled >
									<img src="<%=dirPath%>/Common/img/btn_find.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_Popup01();" > </td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;비밀번호</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_userpw" style="width:100px;height:20px;IME-MODE: active;"maxlength="10"
									onBlur="bytelength(this,this.value,10);" ></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;사용자명</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_usernm" style="width:200px;height:20px;IME-MODE: active;" maxlength="30" onBlur="bytelength(this,this.value,30);" ></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;사업자번호</td>
								<td class="tab21">
								 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:90" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="###-##-#####">
											<param name=PromptChar	  value="_">
                  				</OBJECT><%=HDConstant.COMMENT_END%> 
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;우편번호</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_zipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
											style="position:relative;left:8px;top:5px;width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
												<param name=Alignment			value=0>
												<param name=Border	      value=true>
												<param name=Format	      value="000-000">
												<param name=Enable	      value="false">
												<param name=PromptChar	  value="_">
										</OBJECT><%=HDConstant.COMMENT_END%> &nbsp; 
										<img SRC="<%=dirPath%>/Common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Popup('c')"> &nbsp;
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;주소1</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_addr1" style="width:230px;height:20px;" disabled></td> 
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;주소2</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_addr2" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;담당자명</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_regnm" style="width:140px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;전화번호</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_tel1" style="width:30px;height:20px;" maxlength=3>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_tel2" style="width:30px;height:20px;" maxlength=4>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_tel3" style="width:30px;height:20px;IME-MODE: active;" maxlength=4></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;팩스번호</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_fax1" style="width:30px;height:20px;IME-MODE: active;" maxlength=3>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_fax2" style="width:30px;height:20px;IME-MODE: active;" maxlength=4>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_fax3" style="width:30px;height:20px;IME-MODE: active;" maxlength=4></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;휴대폰번호</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_mobile1" style="width:30px;height:20px;IME-MODE: active;" maxlength=3>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_mobile2" style="width:30px;height:20px;IME-MODE: active;" maxlength=4>&nbsp;&nbsp;&nbsp;-<input type="text" class="txt11" id="txt_mobile3" style="width:30px;height:20px;IME-MODE: active;" maxlength=4></td> 
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;이메일</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_email" style="width:230px;height:20px;IME-MODE: active;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;프로젝트</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_relpart classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:150px;">
												<param name=ComboDataID			value="gcds_relpart">
												<param name=SearchColumn		value="MINORNM">
												<param name=ListExprFormat	value="MINORNM^0^130">
												<param name=BindColumn			value="MINORCD">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td> 
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;등록여부</td>
								<td class="tab21">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_regflag classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=CBData			   value="Y^Y,N^N">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^40">
											<param name=BindColumn			value="Code">
											<param name=Enable  		    value="false">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;임시허용여부</td>
								<td class="tab21">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_tempflag classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=CBData			   value="Y^Y,N^N">
											<param name=CBDataColumns		value="Code,Parm">
											<param name=SearchColumn		value="Parm">
											<param name=Sort						value="false">
											<param name=ListExprFormat	value="Parm^0^40">
											<param name=BindColumn			value="Code">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;관세사구분</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gclx_user_div classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:90px;">
											<param name=CBData			   value="T^관세사,F^일반화주">
											<param name=CBDataColumns		value="code,parm">
											<param name=SearchColumn		value="parm">
											<param name=ListExprFormat	value="parm^0^90">
											<param name=BindColumn			value="code">
									</OBJECT>
									<%=HDConstant.COMMENT_END%>
								</td>
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
		<C>Col=USERID       Ctrl=txt_userid 		  Param=Value</C>
		<C>Col=USERPW       Ctrl=txt_userpw 	  	Param=Value</C>
		<C>Col=USERNM       Ctrl=txt_usernm     	Param=Value</C>
		<C>Col=REGNO        Ctrl=gcem_regno  		  Param=Text</C>
		<C>Col=ZIPCD        Ctrl=gcem_zipcd   		Param=Text</C>
		<C>Col=ADDR1        Ctrl=txt_addr1        Param=Value</C>
		<C>Col=ADDR2        Ctrl=txt_addr2    		Param=Value</C>
		<C>Col=REGNM        Ctrl=txt_regnm        Param=Value</C>
		<C>Col=TEL1     		Ctrl=txt_tel1     		Param=Value</C>
		<C>Col=TEL2     		Ctrl=txt_tel2        	Param=Value</C>
		<C>Col=TEL3     		Ctrl=txt_tel3     		Param=Value</C>
		<C>Col=TEL       		Ctrl=txt_tel      		Param=Value</C>
		<C>Col=FAX1     		Ctrl=txt_fax1     		Param=Value</C>
		<C>Col=FAX2   		  Ctrl=txt_fax2  			  Param=Value</C>
		<C>Col=FAX3     		Ctrl=txt_fax3     		Param=Value</C>
		<C>Col=MOBILE1  	  Ctrl=txt_mobile1		  Param=Value</C>
		<C>Col=MOBILE2		  Ctrl=txt_mobile2		  Param=Value</C>
		<C>Col=MOBILE3		  Ctrl=txt_mobile3		  Param=Value</C>
		<C>Col=EMAIL  	    Ctrl=txt_email		    Param=Value</C>
		<C>Col=RELPART		  Ctrl=gclx_relpart		  Param=BindColVal</C>
		<C>Col=REGFLAG 		  Ctrl=gclx_regflag		  Param=BindColVal</C>
		<C>Col=TEMPFLAG		  Ctrl=gclx_tempflag		Param=BindColVal</C>
		<C>Col=USER_DIV		  Ctrl=gclx_user_div		Param=BindColVal</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>