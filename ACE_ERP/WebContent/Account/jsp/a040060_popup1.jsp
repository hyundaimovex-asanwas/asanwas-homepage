<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  정발행 매출(전자)팝업 1
+ 프로그램 ID	:  A040060_popup1.html
+ 기 능 정 의	:  정발행 매출(전자)팝업 1
+ 작   성  자 :   정 하 나
+ 작 성 일 자 :  2009.10.12
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A040060_popup2.html, a040060_s22,a040060_t22
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>거래처코드조회</title>

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
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	var strParam = new Array();
	strParam=window.dialogArguments;
	
	gcem_staxnbr.text = strParam[0];
	//prompt(this,gcds_code01.DataID);
	ln_Before();
   ln_Query2();
}

function ln_Before() {

  	//지점구분
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

}


/******************************************************************************
	Description : 사업자등록번호로 조회가능
******************************************************************************/
function ln_Query2(){
	gcds_code01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_s22?v_str1="+gcem_staxnbr.text;                           
	gcds_code01.Reset();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
 if (!ln_Check()) return;
 else if (gcds_code01.IsUpdated ){
			if (confirm("저장하시겠습니까 ?")) {
				gctr_data.KeyValue = "Account.a040060_t3(I:USER=gcds_code01)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040060_t3";
				gctr_data.Parameters = "v_str1=" + gs_userid+",v_str2="+gs_date;
				gctr_data.post();
				alert("저장되었습니다.");
			}
	}
}


/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){
		var arrVENDID	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVENDID[0] = gcds_code01.namevalue(gcds_code01.rowposition,"VEND_ID");

		strURL = "./a040060_popup2.jsp";
		strPos = "dialogWidth:334px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVENDID,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_empnm.text  = arrParam[0]; //담당자명
			gcem_email.text	= arrParam[1]; // email
			gcem_seq.text	= arrParam[2];
		} //else {
		//	gcem_empnm.text	= "";
		//	gcem_email.text	= "";
		//	gcem_seq.text = "";
		//}
}

/******************************************************************************
	Description : 체크하기
	
******************************************************************************/
function ln_Check(){
	if ((gcem_email.text  == "")||(gcem_empnm.text  == "")){
					alert("거래처 담당정보를 선택해 주십시오");
					return false;
				}return true;
	}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"EMAIL") ;
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

<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_code01>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	 if (kcode==13) ln_Close('A');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:500px;border:0 solid #708090">
	<tr>
		<td colspan="4" align="right">  <img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">  </td>
	</tr>
	<tr> 
		<td class="tab37" width="100px" align="center"  bgcolor="#eeeeee" ><nobr>지점코드</nobr></td>
		<td class="tab18" width="169px;"><comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:160px;height:110px;">
				<param name=ComboDataID			value="gcds_comfield">
				<param name=CBDataColumns		value="FDCODE,FDNAME">
				<param name=SearchColumn		value="FDNAME">
				<param name=Sort						value=false>
				<param name=Enable					value=false>
				<param name=ListExprFormat	value="FDNAME^0^160">
				<param name=BindColumn			value="FDCODE">
				<param name=ReadOnly      value=true>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td class="tab14" width="100px" bgcolor="#eeeeee">계산서번호</td>
		<td class="tab18" width="160px"><comment id="__NSID__">
			<object  id=gcem_staxnbr class="txtbox" style="position:relative;left:5px;top:1px;width:90px;height:20px;"  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F ">
				<param name=Text          value="">
				<param name=Alignment			value=0>
				<param name=Border	      value=True>
				<param name=ClipMode			value=true>
				<param name=Format	      value="#######-####">
				<param name=MaxLength     value=11>
				<param name=PromptChar	  value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				<param name=Enable				value=true>
				<param name=ReadOnly      value=true>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>

    <tr>
			<td class="tab33"  bgcolor="#eeeeee" align="center">사업자번호</td>
			<td class="tab19" colspan="3" ><comment id="__NSID__">
				<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:80px";">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit value="true">
					<param name=PromptChar	value="_">
					<param name=ReadOnly      value=true>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>

		<tr> 
			<td class="tab33"  bgcolor="#eeeeee"><nobr>거&nbsp;래&nbsp;처</nobr></td>
			<td class="tab19"  colspan="3"><nobr><comment id="__NSID__">
				<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#############">
					<param name=PromptChar	value="_">
					<!-- <param name=Enable			value="false"> -->
					<param name=ReadOnly      value=true>
					<param name=ReadOnlyBackColor   value="#CCFFCC">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
				<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
				<input id=txt_fdcodenm2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:230px;" readOnly>
			</td>
		<tr>

		<tr> 
			<td class="tab33" bgcolor="#eeeeee"><nobr>거래처담당정보</nobr></td>
			<td class="tab19"  colspan=3><nobr><comment id="__NSID__">
				<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:2px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value=true>
					<param name=Language			value=1>
					<param name=ReadOnly      value=true>
					<param name=ReadOnlyBackColor   value="#CCFFCC">
				</object>&nbsp;&nbsp;             	
				
				 <object  id=gcem_email classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:162px;height:20px;position:relative;left:7px;top:2px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value=true>
					<param name=Language			value=1>
					<param name=ReadOnly      value=true> 
					<param name=ReadOnlyBackColor   value="#CCFFCC">
				</object>&nbsp;

				<object  id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:10px;height:20px;">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value=true>
					<param name=Language			value=1>
					<param name=Visible       value=false>
				</object>&nbsp;
				</comment><script>__ws__(__NSID__);</script> </nobr>
			</td>           
		</tr>

		 <tr> 
			<td class="tab33"  bgcolor="#eeeeee"><nobr>적&nbsp;&nbsp;&nbsp;&nbsp;요</nobr></td>
			<td class="tab19"  colspan="3"><nobr><comment id="__NSID__">
				<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:350px;height:20px;position:relative;left:5px;top:0px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value=true>
					<param name=Language			value=1>
					<param name=ReadOnly      value=true>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>
		</tr>

		 <tr> 
			<td class="tab33"  bgcolor="#eeeeee"><nobr>금&nbsp;&nbsp;&nbsp;&nbsp;액</nobr></td>
			<td class="tab19"  colspan="3"><nobr><comment id="__NSID__">
				<object  id=gcem_taxtot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
					<param name=Text					value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=GeneralEdit   value=true>
					<param name=Language			value=1>
					<param name=ReadOnly      value=true>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>
		</tr>
		<tr>
			<td  colspan=4>
				<fieldset id=ft_div1 style="width:490;height:20px;border:0 solid #708090;border-top-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
				</fieldset>
			</td>
		</tr>

	<tr><td height="4px" colspan=4></td></tr>
	
	<tr>
		<td height="30px;" align="center" colspan=4>
			<!--<img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">-->
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>


</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N   -  
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"			VALUE="gcds_code01">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
	<C>Col=FDCODE			Ctrl=gclx_fdcode			Param=BindColVal		</C>
	<C>Col=TAXNBR			Ctrl=gcem_staxnbr			Param=text				</C>
	<C>Col=VEND_ID			Ctrl=gcem_vend_id			Param=text				</C>
	<C>Col=VEND_CD			Ctrl=gcem_vendcd			Param=text				</C>
	<C>Col=VEND_NM			Ctrl=txt_fdcodenm2			Param=value				</C>
	<C>Col=EMPNM			Ctrl=gcem_empnm				Param=text				</C>
	<C>Col=EMAIL			Ctrl=gcem_email				Param=text				</C> 
	<C>Col=SEQ				Ctrl=gcem_seq				Param=text				</C>
	<C>Col=REMARK			Ctrl=gcem_remark			Param=text				</C>
	<C>Col=TAXTOT			Ctrl=gcem_taxtot			Param=text				</C>
">
</object></comment><script>__ws__(__NSID__);</script> 

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:100px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
