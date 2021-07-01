<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:  기준정보관리	- 방북자정보관리
+ 프로그램 ID	:  TR00510.html
+ 기 능 정 의	:  방북자정보를 조회한다.
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
	
	ln_Before();

	ln_SetDataHeader();
}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {

  //소속
	gcds_company.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0015"; 
	gcds_company.Reset();

}
/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00510_s1?"+"v_str1="+gcem_person_no_fr.text + "&v_str2=" + txt_psn_kname_fr.value; 
		gcds_code01.Reset();

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
  
		gcds_code01.addrow();
	
		txt_psn_kname.focus();
	
}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
	if (gcds_code01.IsUpdated){
		if(ln_Chk()){
			if (confirm("저장하시겠습니까?")){	
				//prompt('',gcds_code01.text);
				gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00510_t1?";
				gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
				gctr_code01.post();
				//ln_Query();
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
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00510_t1?";
		gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
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
******************************************************************************/
function ln_Chk(){

		//필수항목체크
		if (fn_trim(txt_psn_kname.value)==""){
			alert("이름을 입력하십시요.");
			txt_psn_kname.focus();
			return false; 
		} 
		if (fn_trim(gcem_reg_no.text)==""){
			alert("주민등록번호를 입력하십시요.");
			gcem_reg_no.focus();
			return false; 
		} 
		if (fn_trim(gclx_gender.text)==""){
			alert("성별을 선택하십시요.");
			gclx_gender.focus();
			return false; 
		} 
		
	return true; 
}

/***********************************************************************************************
	Description : 우편번호 찾기
	
**********************************************************************************************/
function ln_Popup(e){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval("gcem_"+"zipcode").text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+"address1").value = val;
	
	}
}

/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp = "PERSON_NO:STRING,PSN_KNAME:STRING,PSN_ENAME:STRING,ZIPCODE:STRING,ADDRESS1:STRING,"
		           + "ADDRESS2:STRING,REG_NO:STRING,GENDER:STRING,COMPANY:STRING,POSITION:STRING,"
							 + "INVITENO_STRING,INVITESTS:STRING";
							
		gcds_code01.SetDataHeader(s_temp);
}

</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 소속 -->
<%=HDConstant.COMMENT_START%><OBJECT id="gcds_company" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t0(I:USER=gcds_code01)"> 
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
<!-- <script language=JavaScript for="gcgd_disp01" event=OnClick(row,colid)>
	if (row < 1) ln_Enable("f");
	return; 
</script>  -->

<!-- 소속 -->
<script language="javascript" for="gcds_company" event="onloadCompleted(row,colid)">
	gcds_company.InsertRow(1);
	gcds_company.NameValue(1,"MINORCD")="";
	gcds_company.NameValue(1,"MINORNM")="전체";
	gclx_company.index=0;
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
   <td background="../../common/img/com_t_bg.gif"><img src="../img/TR00510_head.gif"></td>
   <td background="../../common/img/com_t_bg.gif"  align=right>
    <img src="../../common/img/btn/com_b_delete.gif"	 style="position:relative;top:2px;cursor:hand" onClick="ln_Delete()">
		<img src="../../common/img/btn/com_b_insert.gif"	 style="position:relative;top:2px;cursor:hand" onClick="ln_Add()"> 
		<img src="../../common/img/btn/com_b_save.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Save()">
		<img src="../../common/img/btn/com_b_query.gif"		 style="position:relative;top:2px;cursor:hand" onClick="ln_Query()">   	
	 </td>
	</tr>
	<tr>  
    <td align="center" colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td class="tab12" style="height:30px;width:100px;" bgcolor="#eeeeee">일련번호</td>
					<td class="tab23" style="width:150px">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gcem_person_no_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query();">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="##########">
							<param name=PromptChar    value="">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">이름</td>
					<td>
						<input id="txt_psn_kname_fr" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
		<tr><td height="3px" colspan =2 align="left" valign="top"></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:530px;border:0 solid #708090;">
					<tr> 			
						<td>
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:0px;width:530px; top:1px;height:411px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
							<PARAM NAME="Format"			VALUE="  
								<C> Name='일련번호'			       ID=PERSON_NO   HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center sort=true </C> 
								<C> Name='이름'			    		   ID=PSN_KNAME		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=LEFT	 sort=true </C> 
								<C> Name='영문성명'					   ID=PSN_ENAME   HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=LEFT	 sort=true show=false</C> 
								<C> Name='우편번호'				     ID=ZIPCODE     HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center sort=true
								Mask='XXX-XXX' show=false</C>  
								<C> Name='주소1'	    			   ID=ADDRESS1    HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	 sort=true show=false</C> 
								<C> Name='주소2'	    		     ID=ADDRESS2    HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=LEFT	 sort=true show=false</C>
								<C> Name='전화번호'	    	     ID=TEL_NO    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=left	 sort=true</C> 
								<C> Name='주민등록번호'	       ID=REG_NO      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center sort=true
								Mask='XXXXXX-XXXXXXX'</C>  
								<C> Name='성별'		    			   ID=GENDER    	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center sort=true 
								Value = {Decode(GENDER,'M','남','F','여')}  </C> 
								<C> Name='소속'					       ID=COMPANY   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	 sort=true
								EditStyle=Lookup Data='gcds_company:MINORCD:MINORNM'</C> 
								<C> Name='직책'						     ID=POSITION  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=LEFT	 sort=true</C> 
								<C> Name='초청장발급번호'	     ID=INVITENO		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=LEFT   sort=true	show=false</C> 
								<C> Name='초청장발급상태'	     ID=INVITESTS		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=LEFT   sort=true	
								Value = {Decode(INVITESTS, 'Y','예','N','아니오')} show=false</C> 
								<C> Name='초청장최초발급일자'	 ID=APPRDATE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=center sort=true Mask='XXXX/XX/XX' show=false</C> 
								<C> Name='초청장갱신일자'		   ID=RENEWDATE   HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center sort=true Mask='XXXX/XX/XX' show=false</C> 
								<C> Name='초청장마감일자'	     ID=ENDDATE			HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center sort=true	Mask='XXXX/XX/XX' show=false</C> 
								<C> Name='방문목적'		         ID=PURPOSE			HeadAlign=Center HeadBgColor=#B9D4DC Width=280	align=LEFT	 sort=true show=false </C> 
								">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="position:relative;left:0px;width:532px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
			</tr>
		</table>
	</td>

		<td valign="top">

			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:2px;top:1px;width:340px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:120px;" bgcolor="#eeeeee">&nbsp;일련번호</td>
			 	<td class="tab18" > 
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_person_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70	px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="##########">
						<param name=maxlength     value="10">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<!-- <param name=ReadOnly      value=true> -->
						<param name=Enable        value=false>

					</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>
		<tr>
			<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;이름</td>
			<td class="tab19"  > 
			 <input id="txt_psn_kname" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="30" >
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;영문성명</td>
			<td class="tab19"   > 
			 <input id="txt_psn_ename" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="30">
			</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;우편번호</td>
				<td class="tab19"  >
				 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_zipcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:5px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</OBJECT><%=HDConstant.COMMENT_END%> &nbsp; 
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Popup('c')"> &nbsp;
				</td> 
			</tr>

			<tr>
				 <td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;주소1</td>
					<td class="tab19" > 
					 <input id="txt_address1" type="text" class="txtbox"  style= "width:196px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="72" onBlur="bytelength(this,this.value,72);" > 
					 
				</td>
			</tr>

			<tr>
				 <td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;주소2</td>
					<td class="tab19"  >
					 <input id="txt_address2" type="text" class="txtbox"  style= "width:196px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="72" onBlur="bytelength(this,this.value,72);" > 
				</td>
			</tr>
			<tr>
				 <td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;전화번호</td>
					<td class="tab19"  > 
					 <input id="txt_tel_no" type="text" class="txtbox"  style= "width:110px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="16" onBlur="bytelength(this,this.value,16);" > 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;주민등록번호</td>
				<td class="tab19"  >
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_reg_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:92px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="000000-0000000">
						<param name=maxlength     value="14">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT><%=HDConstant.COMMENT_END%>  
				</td>
				</tr>
				<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;성별</td>
				<td class="tab19"  > 
					<%=HDConstant.COMMENT_START%><OBJECT id=gclx_gender classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
								<param name=CBData					value="M^남,F^여">
								<param name=CBDataColumns		value="Code,Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^40">
								<param name=BindColumn			value="Code">
						</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;소속</td>
				<td class="tab19"  >
			
					<%=HDConstant.COMMENT_START%><OBJECT id=gclx_company classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:110px;">
								<param name=ComboDataID			value="gcds_company">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn      value="MINORCD"> 
								<param name=Sort			      value=True>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
						</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;직책</td>
				<td class="tab19"  >
				<input id="txt_position" type="text" class="txtbox"  style= "width:110px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="20"
				onBlur="bytelength(this,this.value,20);"> 
					<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_c_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:96px;height:20px;position:relative;left:2px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%> -->
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;초청장발급번호</td>
				<td class="tab19"  > 
				 <input id="txt_inviteno" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="9" onBlur="bytelength(this,this.value,9);">
					<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcem_atupnam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:4px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">           
					</OBJECT><%=HDConstant.COMMENT_END%> -->
				</td>
			</tr>
			 <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;초청장발급상태</td>
				<td class="tab19"  > 
					<%=HDConstant.COMMENT_START%><OBJECT id=gclx_invitests classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:60px;height:200px;" >
								<param name=CBData					value="Y^예,N^아니오">
								<param name=CBDataColumns		value="Code,Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^60">
								<param name=BindColumn			value="Code">
						</OBJECT><%=HDConstant.COMMENT_END%>
				 <!-- <input id="txt_invitests" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);"> -->
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;초청장최초발급일자</td>
				<td class="tab19" > 
					 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_apprdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:8px;top:1px;height:20;width:70" >
								<param name=Alignment			value=1>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<img src="../img/btn_calendar.gif" style="position:relative;left:10px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_apprdate', 'Text');"> 

				<!--  <input id="txt_apprdate" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);" > -->
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee">&nbsp;초청장갱신일자</td>
				<td class="tab19"> 
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_renewdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:8px;top:1px;height:20;width:70" >
								<param name=Alignment			value=1>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<img src="../img/btn_calendar.gif" style="position:relative;left:10px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_renewdate', 'Text');"> 
					</td>
				</tr>
				<tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;초청장 마감일자</td>
				<td class="tab19" > 
						<%=HDConstant.COMMENT_START%><OBJECT id=gcem_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:8px;top:1px;height:20;width:70" >
								<param name=Alignment			value=1>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<img src="../img/btn_calendar.gif" style="position:relative;left:10px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_enddate', 'Text');"> 
				</td>
			</tr>
		 <tr>
				<td class="tab17" style="width:120px;" bgcolor="#eeeeee" >&nbsp;방문목적</td>
				<td class="tab19"  >
				<textarea id="txt_purpose" class="txtbox"  style= "width:200px; height:23px; overflow:auto;position:relative;left:8px;IME-MODE: active" maxlength="100" onBlur="bytelength(this,this.value,100);"></textarea></td>
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
		<C>Col=PERSON_NO		 Ctrl=gcem_person_no			Param=text</C>
		<C>Col=PSN_KNAME  	 Ctrl=txt_psn_kname				Param=value</C>
		<C>Col=PSN_ENAME		 Ctrl=txt_psn_ename 			Param=value</C>
		<C>Col=ZIPCODE			 Ctrl=gcem_zipcode				Param=text</C>
		<C>Col=ADDRESS1			 Ctrl=txt_address1				Param=value</C>
		<C>Col=ADDRESS2			 Ctrl=txt_address2				Param=value</C>
		<C>Col=TEL_NO  			 Ctrl=txt_tel_no  				Param=value</C>
		<C>Col=REG_NO   		 Ctrl=gcem_reg_no				  Param=text</C>
		<C>Col=GENDER			   Ctrl=gclx_gender  				Param=BindColVal</C>
		<C>Col=COMPANY			 Ctrl=gclx_company			 	Param=BindColVal</C>
		<C>Col=POSITION			 Ctrl=txt_position				Param=value</C>
		<C>Col=INVITENO			 Ctrl=txt_inviteno				Param=value</C>
		<C>Col=INVITESTS		 Ctrl=gclx_invitests			Param=BindColVal</C>
		<C>Col=APPRDATE		   Ctrl=gcem_apprdate			  Param=text</C>
		<C>Col=RENEWDATE     Ctrl=gcem_renewdate   	  Param=text</C>
		<C>Col=ENDDATE	     Ctrl=gcem_enddate    	  Param=text</C>
		<C>Col=PURPOSE			 Ctrl=txt_purpose		  		Param=value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

