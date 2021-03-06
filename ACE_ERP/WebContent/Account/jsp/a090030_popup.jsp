<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자산현황상세
+ 프로그램 ID	:  a090030_popup.html
+ 기 능 정 의	:  자산현황상세 
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2011.06.22
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a090030_popup_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산현황상세</title>
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

	//자산분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();

	//상각년월기본setting
	//gcem_hisdat_fr.text = strParam[1];

	gclx_fdcode.bindcolval  = strParam[4];
	gclx_asdivcod.bindcolval= strParam[5];
	txt_COSTNM.value  = strParam[3];
	txt_COSTCD.value  = strParam[2];

	ln_Query();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s3"
									   +"?v_str1="+gclx_fdcode.BindColVal
									   +"&v_str2="+gclx_asdivcod.BindColVal
									   +"&v_str3="
									   +"&v_str4="+txt_COSTCD.value
									   +"&v_str5="+strParam[0]
									   +"&v_str6="+strParam[1]
									   +"&v_str7="+strParam[6];
									 
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

/******************************************************************************
	Description : 엑셀 다운로드 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("자산현황상세","",2);
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

<!-- 자산분류 -->
<comment id="__NSID__"><OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
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

<!-- 자산분류 (검색)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="전체";
	gclx_asdivcod.BindColVal=strParam[0].substr(2,2);;
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
<table width="690" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a090030_popup_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif"  align=right>
		  <img src="../../Common/img/btn/com_b_excel.gif"	 style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" style='width:690px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="60px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab21" align=center>지점</td>
					<td class="tab12" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:90px;">&nbsp;
						<comment id="__NSID__">
							<object id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-5px;top:1px;font-size:12px;width:80px;">
								<param name=ComboDataID			value="gcds_fdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				    value=false>
								<param name=ListExprFormat	value="FDNAME^0^80">
								<param name=BindColumn			value="FDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td> 
					<td width="60px"  bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;"> 자산분류</td>  
					<td class="tab22" style="width:115px;" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;">&nbsp;
						<comment id="__NSID__">
						<object id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-5px;top:2px;font-size:12px;width:105px;">
							<param name=ComboDataID			value="gcds_asdivcod">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="CDNAM^0^105">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">원가</td> 
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:굴림;font-size:9pt;">&nbsp;    
						<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:150px; height:20px;" class="txtbox" >			
						<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
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
					style="position:relative;left:3px;width:688px; height:400px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		value="gcds_code01">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ViewSummary"	value="1">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		value="  
						<C> Name='자산번호'	     ID=ASTNBR 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  SumBgColor='#C3D0DB'	SumText='' </C> 
						<C> Name='자산명'		     ID=ASTNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=left  	SumBgColor='#C3D0DB'	SumText=''</C> 
						<C> Name='취득일자'		   ID=ASAQSDAT   HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  SumBgColor='#C3D0DB'	SumText='계' Mask=XXXX-XX-XX </C> 
						<C> Name='취득금액'		   ID=ASTAQAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right   SumBgColor='#C3D0DB'	SumText=@sum </C> 
						<C> Name='전기누계액'	   ID=ABDEPRAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right   SumBgColor='#C3D0DB'  SumText=@sum </C> 
						<C> Name='당기상각액'	   ID=ACDEPRAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	  SumBgColor='#C3D0DB'  SumText=@sum	</C> 
						<C> Name='잔존가액'		   ID=ASTRMAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right   SumBgColor='#C3D0DB'	Value={ASTAQAMT-(ABDEPRAMT+ACDEPRAMT)} SumText={sum(ASTAQAMT-(ABDEPRAMT+ACDEPRAMT))} </C>
						">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>

				<fieldset style="position:relative;left:3px;width:690px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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