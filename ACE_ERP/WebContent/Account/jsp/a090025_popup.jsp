<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자산이동 및 이체 내역
+ 프로그램 ID	:  A090025_popup.html
+ 기 능 정 의	:  
+ 작   성  자 :  정영식
+ 작 성 일 자 :  2011.04.18
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산이동(이체)내역</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_deptcd="";
var gs_deptnm="";
var strParam = new Array();
strParam=window.dialogArguments;

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

	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
  gclx_fdcode.bindcolval =strParam[0];
	gcem_astnbr.text= strParam[1];
	gcem_astnm.text = strParam[2];
	
	ln_Query();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 

	var str1 = strParam[0]; //지점
	var str2 = strParam[1]; //자산번호
	var str3 = strParam[2]; //자산명
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_popup_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3;

  //prompt('',gcds_code01.DataID);
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : 체크
******************************************************************************/
function ln_Chk(p1){

	if (p1=="01"){
		if(gclx_fdcode.BindColVal=""){
			alert("소속코드를 입력하세요.");
			return false;
		}
		return true; 
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 지점 -->
<comment id="__NSID__"><OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


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
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.BindColVal=strParam[0].substr(0,2);
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="650" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a090025_popup_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif"  align=right>
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:650px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="60px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab21" align=center>지점</td>
					<td class="tab12" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:130px;">&nbsp;
						<comment id="__NSID__">
							<object id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-16px;top:1px;font-size:12px;width:90px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				    value=false>
								<param name=ListExprFormat	value="FDNAME^0^80">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td> 
					<td width="60px"  bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;"> 자산번호</td>  
					<td class="tab22" style="width:130px;" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;">&nbsp;
						<comment id="__NSID__">
						<object id=gcem_astnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">자산명</td> 
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="130px;" >&nbsp;    
						<comment id="__NSID__">
						<object id=gcem_astnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:2px;left:0px;width:110px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value="true">
							<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>  
							
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:3px;width:280px;border:0 solid #708090;">
		<tr> 			
			<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				<comment id="__NSID__">
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
					style="position:relative;left:3px;width:648px; height:300px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		value="gcds_code01">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		value="  
						<C> Name='자산번호'	   ID=ASTNBR 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=53	    align=center  </C> 
						<C> Name='자산명'		   ID=ASTNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120    align=left  	</C> 
						<C> Name='구분'   		 ID=ASTGUBUN  HeadAlign=Center HeadBgColor=#B9D4DC Width=35 	  align=center	  EditStyle=Combo Data='0:정상,1:매각,2:폐기,8:이체,9:이동' </C> 
						<C> Name='이동일자'    ID=MOVDATE   HeadAlign=Center HeadBgColor=#B9D4DC Width=67 	  align=center	  MASK='XXXX/XX/XX'</C> 
						<C> Name='사용부서'		 ID=AUSEDPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left   </C> 
						<C> Name='관리부서'	   ID=AMNGDPTNM HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left   </C> 
						<C> Name='원가명'	     ID=ACOSTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left	 </C> 
						<C> Name='사용자'	  	 ID=AUSERNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	  align=left   </C>
						">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>

				<fieldset style="position:relative;left:3px;width:650px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================================
-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 