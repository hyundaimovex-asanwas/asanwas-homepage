<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:  기준정보관리	- 거래처코드관리
+ 프로그램 ID	:  TR00503.html
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

/*----------------------------------------------------------------------------
	 * 페이지로딩
----------------------------------------------------------------------------*/
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

 
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

		gcds_code01.DataID = 
		g_servlet+"/Account.a010003_s0?"+"v_str1="+gcem_vend_cd_fr01.text + "&v_str2=" + txt_vend_nm_fr01.value; 
		gcds_code01.Reset();

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

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

/***********************************************************************************************
	Description : 우편번호 찾기
	
**********************************************************************************************/
function ln_Popup(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		var post_no1 = arrParam[0];
		eval("gcem_"+"post_nm").text = arrParam[0];
	
		eval("gcem_"+"post_no1").text = post_no1.substring(0,3);
		eval("gcem_"+"post_no2").text = post_no1.substring(3,6);
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+"address1").value = val;
	
	}
}


/******************************************************************************
	Description : 거래처코드 찾기
	parameter   : p - fr : 분류코드 , p- to
******************************************************************************/
function ln_Popup03(p2,p){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Gczm_vender_popup.html";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (p=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr") {
					gcem_vend_cd_fr01.text = arrParam[0];
					txt_vend_nm_fr01.value = arrParam[1];
		
		} else {
			if(p2=="fr") {
				gcem_vend_cd_fr01.text = "";
				txt_vend_nm_fr01.value ="";
				
				}
			}
		}
	}
}



/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
    var s_temp = "CORP_CD:STRING,			  VEND_GB:STRING, 			VEND_CD:STRING,			VEND_NM:STRING,			"
		           + "VD_DIRECT:STRING,	    BSNS_CND:STRING,	    BSNS_KND:STRING,  	VD_TELNO:DECIAML, 	"
							 + "VD_FAXNO:STRING,			POST_NO1:STRING,	    POST_NO2:STRING,  	ADDRESS1:STRING,		"
							 + "ADDRESS2:STRING,			C_BANKCD:STRING,			C_ACCTNO:STRING,		C_ACCTNO_NM:STRING,	"
							 + "C_ACCTNM:STRING,	    B_BANKCD:STRING,	    B_ACCTNO:STRING,	  B_ACCTNO_NM:STRING,	"	
							 + "B_ACCTNM:STRING,			O_VENDGB:STRING,			O_VENDCD:STRING,	  VEND_MAG:STRING,		"
							 + "USE_TAG:STRING ,     	CREAT_DT:STRING,	    CREAT_NM:STRING	      ";
		gcds_code01.SetDataHeader(s_temp);
}



</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a010003_t0(I:USER=gcds_code01)"> 
</OBJECT>
<%=HDConstant.COMMENT_END%>

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
<!-- 거래처코드 -->
 <script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<!-- 거래처코드 -->
<script language=JavaScript for="gcgd_disp01" event=OnClick(row,colid)>
	if (row < 1) ln_Enable("f");
	return; 
</script> 


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
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
  		<img src="../../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()" >
	 	</td>
	</tr>
	<tr>  
    <td align="center" colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td class="tab12" style="height:30px;width:100px;" bgcolor="#eeeeee">거래처코드</td>
					<td class="tab23" style="width:150px">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_vend_cd_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query();">		
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
					<td width="100" class="tab12" bgcolor="#eeeeee" align="center">거래처명</td>
					<td>
						<input id="txt_vend_nm_fr01" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 
					</td>
				</tr>
			</table>
		</td>
		</tr>
		<tr><td height="3px" colspan =2 align="left" valign="top"></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:460px;border:0 solid #708090;">
					<tr> 			
						<td>
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:0px;width:460px; top:1px;height:426px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='코드'					    ID=VEND_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center sort=true </C> 
								<C> Name='거래처명'					ID=VEND_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true </C> 
								<C> Name='대표자'						ID=VD_DIRECT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true</C> 
								<C> Name='업태'							ID=BSNS_CND     HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	sort=true</C> 
								<C> Name='업종'	    				ID=BSNS_KND     HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT	sort=true</C> 
								<C> Name='전화번호'	    		ID=VD_TELNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='팩스번호'	    		ID=VD_FAXNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='우편번호'					ID=POST_NM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=LEFT	sort=true Mask='XXX-XXX'</C> 
								<C> Name='주소1'						ID=ADDRESS1   	HeadAlign=Center HeadBgColor=#B9D4DC Width=280		align=LEFT	sort=true</C> 
								<C> Name='주소2'						ID=ADDRESS2  		HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true</C> 
								<C> Name='현금은행코드'	    ID=C_BANKCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT sort=true	</C> 
								<C> Name='현금계좌번호'	    ID=C_ACCTNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT sort=true	</C> 
								<C> Name='현금계좌명'		    ID=C_ACCTNO_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200		align=LEFT	 sort=true </C> 
								<C> Name='현금계좌예금주'		ID=C_ACCTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=180		align=LEFT	 sort=true </C> 
								<C> Name='어음은행코드'	    ID=B_BANKCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT sort=true	</C> 
								<C> Name='어음계좌번호'		  ID=B_ACCTNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=LEFT	sort=true </C> 
								<C> Name='어음계좌명'				ID=B_ACCTNO_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=200		align=LEFT	sort=true </C> 
								<C> Name='어음계좌예금주'		ID=B_ACCTNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=180		align=LEFT	 sort=true </C> 
								<C> Name='구거래구분'		    ID=O_VENDGB 		HeadAlign=Center HeadBgColor=#B9D4DC Width=120		align=LEFT	 sort=true </C> 
								<C> Name='구거래처코드'		  ID=O_VENDCD 		HeadAlign=Center HeadBgColor=#B9D4DC Width=120		align=LEFT	 sort=true </C> 
								<C> Name='관리번호'					ID=VEND_MAG 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT	 sort=true </C> 
								<C> Name='사용유무'					ID=USE_TAG			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT	sort=true </C> 
								">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="position:relative;left:0px;width:462px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
			</tr>
		</table>
	</td>
		<td valign="top">
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:2px;top:1px;width:410px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:90px;" bgcolor="#eeeeee">&nbsp;거래처코드</td>
			 	<td class="tab18" colspan="3"> 
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86	px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#############">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;거래처명</td>
			<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_vend_nm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="32" readonly="true">
			</td>
		</tr>
		<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;대표자명</td>
			<td class="tab19" style= "width:280px;" colspan="3" > 
			 <input id="txt_vd_direct" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="12" readonly="true" >
				</td>
				</tr>
				<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" class="txtbox">&nbsp;업태</td>
				<td class="tab19">
				<input id="txt_bsns_cnd" type="text" class="txtbox"  style= "position:relative;left:8px;width:98px; height:20px;" maxlength="22" onfocus ="bytelength(this,this.value,30);" readonly="true">
				</td> 
				 <td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;업종</td>
					<td class="tab19" style="height:25px;" >
					 <input id="txt_bsns_knd" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:8px" maxlength="22" readonly="true"> 
				</td>
				</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;전화번호</td>
				<td class="tab19"  >
				<input id="txt_vd_telno" type="text" class="txtbox"  style= "position:relative;left:8px;width:98px; height:20px;" maxlength="14" onBlur="bytelength(this,this.value,14);" readonly="true">
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;팩스번호</td>
				<td class="tab19">
					<input id="txt_vd_faxno" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:8px" maxlength="14" readonly="true"> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;우편번호</td>
				<td class="tab19" style= "width:280px;" colspan="3"  >
				 <%=HDConstant.COMMENT_START%>
				 <OBJECT id=gcem_post_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
					style="position:relative; left:8px;top:5px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%> &nbsp; 
				<img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:1px;top:1px" align=center onclick="ln_Popup('c')"> &nbsp;
			 
				  <%=HDConstant.COMMENT_START%>
				  <OBJECT id=gcem_post_no1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					 style="width:28px;height:20px;position:relative;left:6px;top:3px">				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible			  value="false">
					</OBJECT>
					<%=HDConstant.COMMENT_END%> &nbsp; 
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gcem_post_no2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="width:28px;height:20px;position:relative;left:4px;top:3px" >				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible				value="false">
					</OBJECT>
					<%=HDConstant.COMMENT_END%>  
				</td> 
			</tr>
			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;주소1</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_address1" type="text" class="txtbox"  style= "width:296px; height:20px;position:relative;left:8px" maxlength="72" onBlur="bytelength(this,this.value,30);" readOnly> 
				</td>
			</tr>

			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;주소2</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_address2" type="text" class="txtbox"  style= "width:296px; height:20px;position:relative;left:8px" maxlength="72" onBlur="bytelength(this,this.value,30);" readonly="true"> 
					
				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;현금은행코드</td>
				<td class="tab19">
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_c_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:8px;top:1px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#####">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%> 
				</td>
			
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;현금계좌번호</td>
				<td class="tab19">
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_c_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:96px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>

			 <tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;현금계좌명</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_c_acctno_nm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="32" onBlur="bytelength(this,this.value,30);" readonly="true">

				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;현금계좌예금주</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_c_acctnm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="32" onBlur="bytelength(this,this.value,30);" readonly="true">

				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;어음은행코드</td>
				<td class="tab19">
					<%=HDConstant.COMMENT_START%><OBJECT id=gcem_b_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:8px;top:1px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#####">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%> 
				</td>

				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;어음계좌번호</td>
				<td class="tab19" >
						<%=HDConstant.COMMENT_START%><OBJECT id=gcem_b_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:96px;height:20px;position:relative;left:8px;top:1px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=ReadOnly      value=true>
					</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
		</tr>

		 <tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;어음계좌명</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_b_acctno_nm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="32" onBlur="bytelength(this,this.value,30);" readonly="true">


				</td>
			</tr>

			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee">&nbsp;어음계좌예금주</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_b_acctnm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:8px" maxlength="32" onBlur="bytelength(this,this.value,30);" readonly="true">

				</td>
			</tr>
			
			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;구거래구분</td>
					<td class="tab19" >
					 <input id="txt_o_vendgb" type="text" class="txtbox"  style= "position:relative;left:8px;;width:94px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" readonly="true">

				</td>
			
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;구거래처코드</td>
				<td class="tab19"  >
				<input id="txt_o_vendcd" type="text" class="txtbox"  style= "position:relative;left:8px;width:98px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,13);" readonly="true">

				</td> 
			</tr> 

			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;관리번호</td>
					<td class="tab19" > 
					 <input id="txt_vend_mag" type="text" class="txtbox"  style= "position:relative;left:8px;;width:94px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" readonly="true">

				</td>
			
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;사용유무</td>
				<td class="tab19"  >
				<input id="txt_use_tag" type="text" class="txtbox"  style= "position:relative;left:8px;width:98px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" readonly="true">
				</td> 
				</tr> 
				<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" >&nbsp;아이디</td>
					<td class="tab19">
					 <input id="txt_msn" type="text" class="txtbox"  style= "position:relative;left:8px;;width:94px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" readonly="true">
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" >&nbsp;비밀번호</td>
				<td class="tab19">
				<input id="txt_mpwd" type="text" class="txtbox"  style= "position:relative;left:8px;width:98px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" readonly="true">
				</td> 
				</tr>
				<tr>
					<td height="3px" style="border:1 solid 
					#708090;border-right-width:0px;border-top-width:0px;" colspan="3">&nbsp;</td><!--밑에 비고칸-->
					<td height="3px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;">&nbsp;</td>
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
		<C>Col=VEND_CD			 Ctrl=gcem_vend_cd				Param=text</C>
		<C>Col=VEND_NM			 Ctrl=txt_vend_nm					Param=value</C>
		<C>Col=VD_DIRECT			 Ctrl=txt_vd_direct 			Param=value</C>
		<C>Col=BSNS_CND			 Ctrl=txt_bsns_cnd				Param=value</C>
		<C>Col=BSNS_KND			 Ctrl=txt_bsns_knd				Param=value</C>
		<C>Col=VD_TELNO			 Ctrl=txt_vd_telno				Param=value</C>
		<C>Col=VD_FAXNO			 Ctrl=txt_vd_faxno				Param=value</C>
		<C>Col=POST_NM			 Ctrl=gcem_post_nm				Param=text</C>
		<C>Col=POST_NO1			 Ctrl=gcem_post_no1				Param=text</C>
		<C>Col=POST_NO2			 Ctrl=gcem_post_no2				Param=text</C>
		<C>Col=ADDRESS1			 Ctrl=txt_address1				Param=value</C>
		<C>Col=ADDRESS2			 Ctrl=txt_address2				Param=value</C>
		<C>Col=C_BANKCD			 Ctrl=gcem_c_bankcd			  Param=text</C>
		<C>Col=C_ACCTNO			 Ctrl=gcem_c_acctno			  Param=text</C>
		<C>Col=C_ACCTNO_NM	 Ctrl=txt_c_acctno_nm		  Param=value</C>
		<C>Col=C_ACCTNM			 Ctrl=txt_c_acctnm				Param=value</C>
		<C>Col=B_BANKCD			 Ctrl=gcem_b_bankcd				Param=text</C>
		<C>Col=B_ACCTNO			 Ctrl=gcem_b_acctno				Param=text</C>
		<C>Col=B_ACCTNO_NM	 Ctrl=txt_b_acctno_nm		  Param=value</C>
		<C>Col=B_ACCTNM			 Ctrl=txt_b_acctnm				Param=value</C>
		<C>Col=O_VENDGB			 Ctrl=txt_o_vendgb				Param=value</C>
		<C>Col=O_VENDCD			 Ctrl=txt_o_vendcd				Param=value</C>
		<C>Col=VEND_MAG			 Ctrl=txt_vend_mag				Param=value</C>
		<C>Col=USE_TAG			 Ctrl=txt_use_tag					Param=value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

