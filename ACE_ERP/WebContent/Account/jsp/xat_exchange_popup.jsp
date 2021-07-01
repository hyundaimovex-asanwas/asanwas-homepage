<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 매장 원가 매핑 
+ 프로그램 ID  :  xat_dfscost_popup
+ 기 능 정 의	: 조회
+ 작    성     자  : 정영식
+ 작  성  일  자  : 2018.04.25
-----------------------------------------------------------------------------
+ 변 경 이 력	:
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>매장 원가 정보</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
var gs_userid = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	ln_Query();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){
	
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat_exchange_popup_s1?v_str1="+ gcem_dfscost.text;
		
		//prompt("",gcds_data.DataID )
	    gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();
	gcds_data.namevalue(gcds_data.rowposition,"DFSCD")="S16744";
	gcds_data.namevalue(gcds_data.rowposition,"DFSNM")="현대면세점-청도";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			
			gctr_t1.KeyValue = "xat_exchange_popup_t1(I:USER=gcds_data)";		
			gctr_t1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat_exchange_popup_t1";
			gctr_t1.Parameters = "v_str1=" + gs_userid;
						
			gctr_t1.post();
			
			return ln_Query();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_t1.KeyValue = "xat_exchange_popup_t1(I:USER=gcds_data)";
		gctr_t1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat_exchange_popup_t1";
		gctr_t1.Parameters = "v_str1=" + gs_userid;
					
		gctr_t1.post();
		return ln_Query();
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


<%//매장 찾기   %>
function ln_Popup_DfsCost(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0] = "001"; //매장정보
	
	strURL = "./xat_dfscost_popup.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_dfscost.text    = arrParam[0];
	}else{
	    gcem_dfscost.text    = "";
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="gctr_t1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script> <!-- 카드관리 -->
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_t1" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_t1" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
  alert("Error Code : " + gctr_t1.ErrorCode + "\n" + "Error Message : " + gctr_t1.ErrorMsg + "\n");
</script><!-- 환율관리 -->


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:540px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="70px;" bgcolor="#eeeeee">매장정보</td>
		<td width="250px">
			<comment id="__NSID__">
			<object id=gcem_dfscost classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:180px">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit     value="true">
				<param name=Enable          value=false>
				<param name=PromptChar	    value="_">
			</object>
		    </comment><script>__ws__(__NSID__);</script></nobr>&nbsp;
    	
    		<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_DfsCost()">
		</td>
		<td>
		    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;left:35px;top:0px" onClick="ln_Delete()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;left:35px;top:0px" onClick="ln_Add()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	style="cursor:hand;position:relative;left:35px;top:0px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand;position:relative;left:35px;top:0px" onClick="ln_Query()">  
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:540;height:300px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		       <PARAM NAME="DataID"			VALUE="gcds_data">
			   <PARAM NAME="BorderStyle"    VALUE="0">
			   <PARAM NAME="Indwidth"		VALUE="0">
			   <param name="Editable"		value='true'> 
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"      value=left>
			    <PARAM NAME="Format"		VALUE="  
					<C>ID=DFSCD,		Name=코드,	    width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none</C>
					<C>ID=DFSNM,		Name=매장명,		width=150,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none</C>
					<C>ID=SALEDT,		Name=매출일자,	width=100,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  MASK='XXXX-XX-XX'</C>
					<C>ID=CNYER,	    Name=위안화환율,   width=100,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,  sort = true  </C>
					<C>ID=USDER,	    Name=달러환율,	width=100,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,  sort = true  </C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:558;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	