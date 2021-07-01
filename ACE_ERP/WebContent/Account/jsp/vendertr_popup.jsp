<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 신용카드가맹점
+ 프로그램 ID	: vendertr_popup.html
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: vendertr_popup_s1, vendertr_popup_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>신용카드가맹점</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css"></style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩시
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(p){
	if (p=="01"){
		var str1 = gcem_vend_cd_fr01.text;
		var str2 = txt_vend_nm_fr01.value;
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendertr_popup_s1?v_str1="+str1+"&v_str2="+str2; 
		gcds_code01.Reset();
	}
}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Add(p){
	if (p=="01"){
		gcds_code01.addrow();
		ln_Enable("t",p);
		gcem_vend_cd.focus();
	}
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(p){
	if (p=="01"){
		if (gcds_code01.IsUpdated){
			if(ln_Chk(p)){
				if (confirm("저장하시겠습니까?")){	
					gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendertr_popup_t1?";
					gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;		
					gctr_code01.post();
					ln_Query('01');
				}	
			}
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(p){
	if (p=="01"){
		if (confirm("삭제하시겠습니까?")){	
			gcds_code01.deleterow(gcds_code01.rowposition);
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendertr_popup_t1?";
			gctr_code01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;
			gctr_code01.post();
			ln_Query('01');
		}
	}
}

/******************************************************************************
	Description : Dataset Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "CORP_CD:STRING,VEND_GB:STRING,VEND_CD:STRING,VEND_NM:STRING,"
						 + "VD_DIRECT:STRING,BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:DECIAML,"
						 + "VD_FAXNO:STRING,POST_NO1:STRING,POST_NO2:STRING,ADDRESS1:STRING,"
						 + "ADDRESS2:STRING,C_BANKCD:STRING,C_ACCTNO:STRING,C_ACCTNO_NM:STRING,"
						 + "C_ACCTNM:STRING,B_BANKCD:STRING,B_ACCTNO:STRING,B_ACCTNO_NM:STRING,"	
						 + "B_ACCTNM:STRING,O_VENDGB:STRING,O_VENDCD:STRING,VEND_MAG:STRING,"
						 + "USE_TAG:STRING,REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING";
	gcds_code01.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){

}

/******************************************************************************
	Description : 입력체크 
	parameter   : 01 - 거래처
******************************************************************************/
function ln_Chk(p){
	if (p=="01"){
		if (fn_trim(gcem_vend_cd.text)=="" ){
			alert("거래처코드를 입력하십시요.");
			gcem_vend_cd.focus();
			return false; 
		}

		if (fn_trim(txt_vend_nm.value)==""){
			alert("거래처명을 입력하십시요.");
			txt_vend_nm.focus();
			return false; 
		}
	}
	return true; 
}

/***********************************************************************************************
	Description : 우편번호 찾기
	parameter   : p==> 01 - 거래처
**********************************************************************************************/
function ln_Popup(e){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:425px;status:no;scroll:no;resizable:no";
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

/***********************************************************************************************
	Description : Enable _ Disable 
	parameter   : p2==> t - Enable, f - Disable
	              p==> 01 - 거래처
***********************************************************************************************/
function ln_Enable(p2,p) {
	if (p=="01"){
		if (p2=="t")	txt_vend_nm.disabled=false;
		else if (p2=="f")	txt_vend_nm.disabled=true;
	}
}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"VEND_CD") + ";" 
	                   	 + gcds_code01.namevalue(row,"VEND_NM") + ";" 
											 + gcds_code01.namevalue(row,"VD_DIRECT");
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_code01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="vendertr_popup_t1(I:USER=gcds_code01)"> 
</object></comment><script>__ws__(__NSID__);</script> 

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
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp01" event=OnDblClick(row)>
	ln_Close('A');
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

</head>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">  

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
  <tr align=right> 
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"></td>
  </tr>
	<tr>
		<td colspan=2> 
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;width:865px;border:1 solid #708090;">
				<tr> 				
					<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">거래처코드</td>
					<td class="tab23" style="width:98px">&nbsp;
						<comment id="__NSID__"><object  id=gcem_vend_cd_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86px;height:20px;position:relative;left:0px;top:2px" onkeydown="if(event.keyCode==13) ln_Query('01');">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="#############">
							<param name=PromptChar    value="">
							<param name=maxlength     value="13">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td width="80" class="tab12" bgcolor="#eeeeee" align="center">거래처명</td>
					<td>
						<input id="txt_vend_nm_fr01" type="text" class="txtbox"  style= "width:120px; height:20px;position:relative;left:6px" maxlength="72" onkeydown="if(event.keyCode==13) ln_Query('01');" onBlur="bytelength(this,this.value,30);"> 
					</td>
					<td width="1px" align=right>&nbsp;</td>
					<td align="right" valign="bottom"  style="position:relative;right:0px;top:0px;">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="우편번호를 검색합니다" style="cursor:hand;position:relative;left:-80px;top:158px" align=center onclick="ln_Popup('c')">
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:5px" onClick="ln_Delete('01')" >
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:5px" onClick="ln_Add('01')" >
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:5px" onClick="ln_Save('01')">
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;top:5px" onclick="ln_Query('01')">&nbsp;
					</td>
				</tr>
			</table>
		</td>
		</tr>
		
		<tr><td height="2px" colspan =2></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;width:400px;border:0 solid #708090;">
					<tr> 			
						<td>
						<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
							style="position:relative;left:2px;width:400px;top:1px;height:381px; border:1 solid #708090;">
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='코드'					    ID=VEND_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center sort=true </C> 
								<C> Name='거래처명'					ID=VEND_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=LEFT	sort=true </C> 
								<C> Name='대표자'						ID=VD_DIRECT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	sort=true</C> 
								<C> Name='업태'							ID=BSNS_CND     HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	sort=true</C> 
								<C> Name='업종'	    				ID=BSNS_KND     HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT	sort=true</C> 
								<C> Name='전화번호'	    		ID=VD_TELNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='팩스번호'	    		ID=VD_FAXNO     HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT	sort=true</C> 
								<C> Name='우편번호'					ID=POST_NM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=LEFT	  sort=true Mask='XXX-XXX'</C> 
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
								<C> Name='구거래구분'		    ID=O_VENDGB 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT	 sort=true </C> 
								<C> Name='구거래처코드'		  ID=O_VENDCD 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=LEFT	 sort=true </C> 
								<C> Name='관리번호'					ID=VEND_MAG 		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=LEFT	 sort=true </C> 
								<C> Name='사용유무'					ID=USE_TAG			HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=LEFT	sort=true </C> 
								<C> Name='비고'							ID=REMARK			HeadAlign=Center HeadBgColor=#B9D4DC Width=290	align=LEFT	sort=true </C> 												">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:2px;width:402px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">조회건수 :</font>
						</fieldset>
				</td>
			</tr>
		</table>
		</td>
		<td align="left">
			<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:-7px;top:1px;width:460px;border:0 solid #708090;">
			 <tr>
				<td class="tab15" style="width:90px;" bgcolor="#eeeeee" align=center >거래처코드</td>
			 	<td class="tab18" colspan="3"  >&nbsp; 
					<comment id="__NSID__"><object  id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:86	px;height:20px;position:relative;left:2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#############">
						<param name=maxlength     value="13">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			<tr>
			<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >거래처명</td>
			<td class="tab19" style= "width:280px;" colspan="3" > 
				<input id="txt_vend_nm" type="text" class="txtbox"  style= "width:350px; height:20px;position:relative;left:6px" maxlength="32">
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >대표자명</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_vd_direct" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="12" >
				</td>
				</tr>
				<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center class="txtbox">업태</td>
				<td class="tab19">&nbsp;
				<input id="txt_bsns_cnd" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="22" onfocus ="bytelength(this,this.value,30);">
				</td> 
				 <td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >업종</td>
					<td class="tab19" style="height:25px;" >&nbsp; 
					 <input id="txt_bsns_knd" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:-2px" maxlength="22" > 
				</td>
				</tr>
				<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center>전화번호</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_vd_telno" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="14" onBlur="bytelength(this,this.value,14);" >
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >팩스번호</td>
				<td class="tab19"  > &nbsp;
					<input id="txt_vd_faxno" type="text" class="txtbox"  style= "width:94px; height:20px;position:relative;left:-2px" maxlength="14" > 
				</td>
			</tr>
			
			<tr>
				<td class="tab17" style="width:90px;height:25px" bgcolor="#eeeeee" align=center>우편번호</td>
				<td class="tab19" style="width:280px;" colspan="3"><nobr>
				 <comment id="__NSID__"><object  id=gcem_post_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:5px;top:3px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2;">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=Enable	      value="false">
						<param name=PromptChar	  value="_">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;<input id="txt_address1" type="text" class="txtbox" style="height:20px;width:255px;position:relative;left:46px;top:-1px" maxlength="75" onBlur="bytelength(this,this.value,30);" readOnly><comment id="__NSID__"><object  id=gcem_post_no1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					 style="width:2px;height:20px;position:relative;left:0px;top:0px">				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible			  value="false">
					</object></comment><script>__ws__(__NSID__);</script>  &nbsp; 
					<comment id="__NSID__"><object  id=gcem_post_no2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
					style="width:2px;height:20px;position:relative;left:0px;top:0px" >				
						<param name=Enable	      value="false">
						<param name=Border        value=true>
						<param name=format        value="000">
						<param name=maxlength     value="3">
						<param name=BackColor     value="#CCCCCC">
						<param name=Visible				value="false">
					</object></comment><script>__ws__(__NSID__);</script> </nobr>
				</td>
			</tr>
			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >기타주소</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_address2" type="text" class="txtbox"  style= "width:350px; height:20px;position:relative;left:6px" maxlength="72" onBlur="bytelength(this,this.value,72);"> 
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center>현금은행코드</td>
				<td class="tab19">&nbsp;
					<comment id="__NSID__"><object  id=gcem_c_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:2px;top:2px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#####">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>  
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center>현금계좌번호</td>
				<td class="tab19" >&nbsp;
					<comment id="__NSID__"><object  id=gcem_c_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				</tr>
			 <tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >현금계좌명</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_c_acctno_nm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center>현금계좌예금주</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_c_acctnm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center>어음은행코드</td>
				<td class="tab19">&nbsp;
					<comment id="__NSID__"><object  id=gcem_b_bankcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:2px;top:2px">		
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="#####">
						<param name=maxlength     value="5">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>  
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center>어음계좌번호</td>
				<td class="tab19" >&nbsp;
						<comment id="__NSID__"><object  id=gcem_b_acctno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:145px;height:20px;position:relative;left:2px;top:2px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=format        value="######################">
						<param name=maxlength     value="22">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
		 <tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >어음계좌명</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_b_acctno_nm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
			</tr>
			<tr>
				<td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center>어음계좌예금주</td>
				<td class="tab19" style= "width:280px;" colspan="3" > 
				 <input id="txt_b_acctnm" type="text" class="txtbox"  style= "width:193px; height:20px;position:relative;left:6px" maxlength="32" onBlur="bytelength(this,this.value,30);">
				</td>
			</tr>
			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >구거래구분</td>
					<td class="tab19" >&nbsp; 
					 <input id="txt_o_vendgb" type="text" class="txtbox"  style= "position:relative;left:-2px;;width:94px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" >
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >구거래처코드</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_o_vendcd" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,13);" >
				</td> 
			</tr> 
			<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >관리번호</td>
					<td class="tab19" >&nbsp; 
					 <input id="txt_vend_mag" type="text" class="txtbox"  style= "position:relative;left:-2px;;width:94px; height:20px;" maxlength="10" onBlur="bytelength(this,this.value,10);" >
				</td>
				<td class="tab19" style="width:90px;" bgcolor="#eeeeee" align=center >사용유무</td>
				<td class="tab19"  >&nbsp;
				<input id="txt_use_tag" type="text" class="txtbox"  style= "position:relative;left:-2px;width:98px; height:20px;" maxlength="1" onBlur="bytelength(this,this.value,1);" >
				</td> 
				</tr>
				<tr>
				 <td class="tab17" style="width:90px;" bgcolor="#eeeeee" align=center >비고</td>
					<td class="tab19" style= "width:280px;" colspan="3" > 
					 <input id="txt_remark" type="text" class="txtbox"  style= "width:350px; height:20px;position:relative;left:6px" maxlength="66" onBlur="bytelength(this,this.value,66);"> 
				</td>
				</tr>
		</table> 
	  </td>
  </tr> 
</table> 
						<!-- <table border=0 cellpadding=0 cellspacing=0 width=875>
							<tr><td height=10></td></tr>
							<tr><td>&nbsp;조회건수 : <label id="lbl_search1"></label></td></tr>
						</table> -->
						<table border=0 cellpadding=0 cellspacing=0 width=807>
							<tr>
								<td width="400px" height="30px;" align="center">
									<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
									<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
								</td>
								<td width="350px">&nbsp;</td>
							</tr>
						</table>

    </td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=VEND_CD			 Ctrl=gcem_vend_cd				Param=text</C>
		<C>Col=VEND_NM			 Ctrl=txt_vend_nm					Param=value</C>
		<C>Col=VD_DIRECT		 Ctrl=txt_vd_direct 			Param=value</C>
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
		<C>Col=REMARK 			 Ctrl=txt_remark					Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 