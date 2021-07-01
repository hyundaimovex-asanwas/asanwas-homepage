<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  손상차손등록
+ 프로그램 ID	:  Redu_popup.html
+ 기 능 정 의	:  손상차손등록
+ 작   성  자 :  정영식
+ 작 성 일 자 :  2011.08.01
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
<title>손상차손등록</title>

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
var gs_hisdat = gs_date;
var gs_fdcode = gfdcode;

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

	//자산분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();

	gclx_fdcode.bindcolval = gs_fdcode;
}

/******************************************************************************
	Description : 조회  
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_fdcode.BindColVal;              //소속
	var str2 = gclx_asdivcod.BindColVal;            //자산분류
	var str3 = txt_COSTCD.value;	              	  //원가
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>Redu_popup_s1"
									  + "?v_str1="+str1
									  + "&v_str2="+str2
									  + "&v_str3="+str3;
										
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : 저장 (감가상각처리)
******************************************************************************/
function ln_Save(){

  if(confirm("손상차손관련 데이터를 저장하시겠습니까?")){
		gctr_code01.KeyValue   =  "Account.Redu_popup_t1?(I:USER=gcds_code01)";
		gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>Redu_popup_t1?";
		gctr_code01.Parameters =  "v_str1="+gs_userid;
		//prompt('',gcds_code01.text);
		gctr_code01.post();
	}
}

/******************************************************************************
	Description : 원가 팝업
	Parameter   : srow - grid의 row, strgb - 01: grid,  02:검색조건
******************************************************************************/
function ln_Popup4(srow,strgb){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//원가코드
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

 if(strgb=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD.value = ln_Trim(arrParam[0]);
			txt_COSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD.value = "";	
			txt_COSTNM.value = "";
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 지점 -->
<OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 자산분류 -->
<OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="Redu_popup_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 


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

<!-- 소속분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gclx_fdcode.index=0;
</script>

<!-- 자산분류 (검색)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="조회가 완료 되었습니다.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="전체";
	gclx_asdivcod.index=0;
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="860" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif">
			<img src="../img/redu_popup_head.gif">
		</td>
		<td width="325px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_save.gif"	     style="cursor:hand" onClick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand" onClick="ln_Query()">
		</td>
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:1px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" class="tab35" align=center >지점</td>
		<td width="150px" class="tab35" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=Sort				value=false>
				<param name=ListExprFormat		value="FDNAME^0^140">
				<param name=BindColumn			value="FDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px" class="tab35" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;"> 자산분류
		</td>  
	  	<td class="tab35" width="150px" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort				    value=false>
				<param name=ListExprFormat	value="CDNAM^0^140">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
    <td class="tab21" style="height:30px;width:80px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">원가명</td> 
		<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " >&nbsp;    
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:160px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
	<tr>
	</tr>
</table>
							
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:3px;width:280px;border:0 solid #708090;">
	<tr> 			
		<td style="width:280" ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:310px; border:1 solid #708090;display:block;" viewastext>
				<param name="DataID"		value="gcds_code01">
				<param name="IndWidth"		value='0'>
				<param name="BorderStyle"	value="0">
				<param name="Fillarea"		value="true">
				<param name="Sortview"		value="left">
				<param name="ColSizing"		value="true">
				<param name="Editable"		value="true"> 
				<param name=TitleHeight     value="30">
				<param name="Format"		value=" 
					<C> Name='자산번호'		  ID=ASTNBR  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  edit=none </C>
					<C> Name='자산명'			  ID=ASTNM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=left	  edit=none </C>
					<C> Name='원가명'			  ID=COSTNM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=left	  edit=none </C> 
					<C> Name='취득일자'		  ID=ASAQSDAT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	edit=none Mask=XXXX-XX-XX</C>
					<C> Name='내용\\년수'		  ID=ASTYUSE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=35	  align=center	edit=none dec=2</C>
					<C> Name='취득금액'		  ID=ASTAQAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	  edit=none </C>
					<G> Name='손상차손관련'      HeadAlign=Center HeadBgColor=#B9D4DC
						<C> Name='원화'	      ID=REDUAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	 </C>
						<C> Name='외화'	      ID=FOREAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	 </C>
						<C> Name='발생년월'	  ID=REDUYM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center Mask=XXXX-XX </C>
						<C> Name='잔존월수'	  ID=REDUMM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=right </C>
					</G>
					">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
	  <tr>
		<td><BR>
				* 손상차손관련 필드만 입력 가능합니다.<BR>
				* 금강산의 경우 원화, 외화 모두 입력합니다. <BR>
				* 발생년월은 손상차손금액이 발생한 년월을 입력합니다. <BR>
				* 잔존월수는 손상차손적용 직전 남은 감가상각 잔존월수를 입력합니다. <BR>
				* 동일 자산에 대하여 2번이상 손상차손이 발생할 경우 누적금액을 입력, 발생년월, 잔존월수는 마지막 발생을 기준함.
    </td>
  </tr>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================================
-->
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
