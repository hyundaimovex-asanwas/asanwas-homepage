<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  거래처 조회
+ 프로그램 ID	:  a5000000_popup1.jsp
+ 기 능 정 의	:  거래처 조회 
+ 작   성  자 :  이 동 훈
+ 작 성 일 자 :  2016.12.15
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a5000000_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>거래처 조회</title>
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
	Description : 선 조회
******************************************************************************/
function ln_Before() {



}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 
 
		
	if(txt_vendnm.value == ""){	
		
		alert("거래처명을 입력하십시요.");
	
	
	}else{
		
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500000_s4"
																	+"?v_str1="+txt_vendnm.value;

		gcds_code01.Reset(); 		
		
	}
	
}



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">

		var row = gcds_code01.rowposition;
		
		window.returnValue = gcds_code01.namevalue(row,"VEND_CD") + ";" 
	                   	 	+ gcds_code01.namevalue(row,"VEND_NM")+";";
	                   	 		                   	 	
		window.close();

</script>


<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>

	if (kcode==13){
		
		var row = gcds_code01.rowposition;
		
		window.returnValue = gcds_code01.namevalue(row,"VEND_CD") + ";" 
   	 						+ gcds_code01.namevalue(row,"VEND_NM")+";";
   	 	
		window.close();		

	} 

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Before()" >

<table width="470" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 

    <td background="../../Common/img/com_t_bg.gif"  align=right style="padding-top:10px;">

			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand" onClick="ln_Query()">
	</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
    
  <tr>  
    <td>
		<table  cellpadding="1" cellspacing="0" style='width:470px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">거래처명</td> 
				  	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:굴림;font-size:9pt;">&nbsp;    
						<input id="txt_vendnm" type="text"  style= "position:relative;top:-1px;left:-1px; width:150px; height:20px;" class="txtbox" onkeydown="if(event.keyCode==13) ln_Query();">			
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
					style="position:relative;left:3px;width:470px; height:290px; border:1 solid #708090;display:block;" viewastext>
						<param name="DataID"		value="gcds_code01">
						<param name="IndWidth"		value ='0'>
						<param name="BorderStyle"	value="0">
						<param name="Fillarea"		value="true">
						<param name="Sortview"		value="left">
						<param name="ViewSummary"	value="1">
						<param name="ColSizing"		value="true">
						<param name="Editable"		value="false"> 
						<param name="Format"		value="  
						<C> Name='No'	     	    ID={CURROW}    HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center  SumBgColor='#C3D0DB'	</C> 
						<C> Name='거래처코드'		    ID=VEND_CD 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=left  	SumBgColor='#C3D0DB'	</C> 
						<C> Name='거래처명'		   	ID=VEND_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=250	  align=center  SumBgColor='#C3D0DB'	</C> 
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



