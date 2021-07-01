<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  회계관리 - 수정세금계산서 -당초승인번호 찾기
+ 프로그램 ID	:  a040077_popup1.jsp
+ 기 능 정 의	:  당초승인번호 찾기
+ 작   성   자     :  정 영 식
+ 서 블 릿 명	:  a040077_popup1_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>당초승인번호찾기</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	 
	//txt_atcode_fr.value= strParam.g_arrParam[0];
	
	gcem_frdt.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
	gcem_todt.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	
	gcem_empno.text=gusrid;
	
}

/******************************************************************************************
	Description : 조회

******************************************************************************************/
function ln_Query(){
		
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040077_popup_s1"+"?v_str1="+gcem_frdt.text+"&v_str2="+gcem_todt.text
	                                                                             +"&v_str3="+gcem_vendnm.text+"&v_str4="+gcem_vendcd.text	
	                                                                             +"&v_str5="+gcem_empno.text;	
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();
  
}

/******************************************************************************
Description : 창닫기
parameter   : A - 선택
******************************************************************************/
function ln_Close(){
	var row = gcds_data.rowposition;
	window.returnValue = gcds_data.namevalue(row,"APPROVE_ID")   + ";" 
	                   + gcds_data.namevalue(row,"BYR_COM_NAME") + ";" 
					   + gcds_data.namevalue(row,"ORI_BYR_COM_REGNO")+ ";" 
	                   + gcds_data.namevalue(row,"SUP_TEL_NUM") + ";" 
	                   + gcds_data.namevalue(row,"SUP_EMP_NAME") + ";" 
	                   + gcds_data.namevalue(row,"SUP_EMAIL") + ";" 
	                   + gcds_data.namevalue(row,"DTI_WDATE") + ";" 
	                   + gcds_data.namevalue(row,"SUP_AMOUNT") + ";" 
	                   + gcds_data.namevalue(row,"TAX_AMOUNT") + ";" 
	                   + gcds_data.namevalue(row,"TOTAL_AMOUNT") + ";" 
	                   + gcds_data.namevalue(row,"DTI_TYPE_NM")+ ";"
	                   + gcds_data.namevalue(row,"VEND_CD")+ ";"
	                   + gcds_data.namevalue(row,"VEND_ID")+ ";"
	                   + gcds_data.namevalue(row,"VEND_NM")+ ";"
	                   
	                   ;
	window.close();

}

/******************************************************************************
Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){
	var arrVAT	= new Array(); 
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrVAT,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_vendcd.text    = arrParam[0];
		gcem_vendnm.text	= arrParam[1];
	} else {
		gcem_vendcd.text	= "";
		gcem_vendnm.text	= "";
	}
}

/******************************************************************************
Description : 찾기 - 작성자 
******************************************************************************/
function ln_Popup_Empno(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./empno_popup3.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_empno.text    = arrParam[0];
	}else{
	    gcem_empno.text    = "";
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_disp01 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data.countrow;i++) {
			if(i != Row) {
				gcds_data.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<!-- 매입 ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr>
		<td height="30px">
			<b><font size="2" color="blue">&nbsp;◎ 당초승인번호</font></b>
		<td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0"  style="width:869px;height:20px;border:1 solid #708090">
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>작성일자</nobr></td>
					<td class="tab22" style="width:480px">
						<comment id="__NSID__">
						    <object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							 style="position:relative;left:4px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment     value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">	
							</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:7px;top:1px;cursor:hand;">&nbsp;&nbsp;~&nbsp;
						<comment id="__NSID__"><object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:4px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:7px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					
					<td class="tab22"  align="right" colspan=2><nobr> 
					    <img src="../../Common/img/btn/com_b_select.gif"  style="cursor:hand;"   onClick="ln_Close()"> &nbsp;&nbsp;&nbsp;
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;"   onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래처</nobr></td>
					<td class="tab23" style="width:480px" >
						<comment id="__NSID__">
						    <object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup()">
						 <comment id="__NSID__"><object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text='';gcem_vendcd.text='';">
					</td>
					<td class="tab12"  width="100px"  bgcolor="#eeeeee"><nobr>&nbsp;작성자&nbsp;</nobr></td>
					<td ><nobr>
						<comment id="__NSID__">
						   <object  id=gcem_empno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:150px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit   value="true">
								<param name=Enable          value=false>
								<param name=PromptChar	value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-1px;cursor:hand"	 onclick="ln_Popup_Empno()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:460px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"            VALUE="gcds_data">
							<PARAM NAME="Editable"			VALUE="true">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"          VALUE="true">
							<param name=SortView            value="Left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<Param Name="UsingOneClick"     value="1">
							<PARAM NAME="Format"            VALUE="  
								<F> Name='선택'        ID=CHK		    HeadAlign=center,HeadBgColor=#B9D4DC,width=30,  align=center,   EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB</F>
								<F> Name='승인번호'	  ID=APPROVE_ID	    HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=center	SumText=@count	SumBgColor='#C3D0DB' edit = none </F> 
								<F> Name='작성일자'  	  ID=DTI_WDATE 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	SumText='계'	    SumBgColor='#C3D0DB' edit = none sort=true </F>
							    <G> Name='공급받는자'    HeadAlign=Center HeadBgColor=#B9D4DC	
								<F> Name='사업자번호'	  ID=BYR_COM_REGNO  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center	SumText=''	    SumBgColor='#C3D0DB' edit = none sort=true mask={decode(BYR_COM_REGNO_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')} </C>
								<F> Name='업체명'	      ID=BYR_COM_NAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left  	SumText=''	    SumBgColor='#C3D0DB' edit = none sort=true </F>
								</G>
								<F> Name='공급가액'     ID=SUP_AMOUNT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </F>
							    <F> Name='세액'   	  ID=TAX_AMOUNT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </F>
							    <F> Name='합계'   	  ID=TOTAL_AMOUNT	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </F>
																
								<C> Name='종류'		  ID=DTI_TYPE_NM    HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center	SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </C>
								<C> Name='상태'        ID=DTI_STATUS	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
								<C> Name='담당자'		  ID=BYR_EMP_NAME   HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=left		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </C>
								<C> Name='담당자Email' ID=BYR_EMAIL	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </C>
								<C> Name='작성자'      ID=ENO_NM    	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left		SumText=@sum	SumBgColor='#C3D0DB' edit = none sort=true </C>
								
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
						
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
</table> 
			 
<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
