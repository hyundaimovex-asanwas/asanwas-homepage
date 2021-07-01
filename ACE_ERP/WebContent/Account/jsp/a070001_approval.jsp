<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  결재라인 
+ 프로그램 ID	:  a070001_approval
+ 기 능 정 의	:  
+ 작   성  자 :  이 동 훈
+ 작 성 일 자 :  2018.02.07
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>결재라인</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

//var strParam = new Array();
//strParam=window.dialogArguments;

function ln_Start(){
 
	ln_HederSet();
	
	gcds_data01.addrow();
	gcds_data01.namevalue(1,"GUBUN")="담당";

	gcds_data01.addrow();
	gcds_data01.namevalue(2,"GUBUN")="검토";

	gcds_data01.addrow();
	gcds_data01.namevalue(3,"GUBUN")="확인";	
	
	gcds_data01.addrow();
	gcds_data01.namevalue(4,"GUBUN")="승인";


}


/******************************************************************************
Description : Header 설정
******************************************************************************/
function ln_HederSet(){

		var THeader1 = "GUBUN:STRING,DPT_NM:STRING,JOB_NM:STRING,ENO_NM:STRING";
		
		gcds_data01.SetDataHeader(THeader1);
		
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(){

	window.returnValue = gcds_data01.namevalue(1,"ENO_NM") + ";"
						+ gcds_data01.namevalue(1,"DPT_NM") + ";"
						+ gcds_data01.namevalue(1,"JOB_NM") + ";"
						
						+ gcds_data01.namevalue(2,"ENO_NM") + ";"
						+ gcds_data01.namevalue(2,"DPT_NM") + ";"
						+ gcds_data01.namevalue(2,"JOB_NM") + ";"					
						
						+ gcds_data01.namevalue(3,"ENO_NM") + ";"
						+ gcds_data01.namevalue(3,"DPT_NM") + ";"
						+ gcds_data01.namevalue(3,"JOB_NM") + ";"

						+ gcds_data01.namevalue(4,"ENO_NM") + ";"
						+ gcds_data01.namevalue(4,"DPT_NM") + ";"
						+ gcds_data01.namevalue(4,"JOB_NM") ;						
						
	//alert(window.returnValue);
						
	window.close();
		
}

</script>



<script language=JavaScript for="gcgd_disp01" event=OnPopup(row,colid,data)>


		var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		
		arrParam[0]=""; //
		
		strURL =  "./empno_popup4.jsp";
		strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
		result = showModalDialog(strURL,arrParam,strPos);
		
		
		
		if (result != null) {
			
			//alert(result);
			
			arrResult = result.split(";");
			
			gcds_data01.namevalue(row,"ENO_NM") = arrResult[1];
			gcds_data01.namevalue(row,"DPT_NM") = arrResult[2];
			gcds_data01.namevalue(row,"JOB_NM") = arrResult[3];			
			
		}else{
			

		}


	
	
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 조회 -->
<comment id="__NSID__">
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="500px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
<br>
	<tr> 
		<td width="485px" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close()" >
		</td>
	</tr>
</table>

<br>

<table width="480px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01 style="position:relative;left:0px;width:480px; height:180px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="IndWidth"			VALUE ='0'>
				<PARAM NAME="BorderStyle" 		VALUE="0">
				<PARAM NAME="Fillarea"			VALUE="true">
				<PARAM NAME="Sortview"			VALUE="left">
				<param name="ColSizing"   		value="true">
				<param name="Editable"    		value="true">
				<param name="ViewSummary"		value=1>
				<PARAM NAME="Format"			VALUE="               
				<FC> Name='No'		ID=Currow 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  	align=center edit=none Value={CurRow} </C> 
				<FC> Name='구분'	ID=GUBUN	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  	align=center edit=none </FC> 
				<FC> Name='소속'	ID=DPT_NM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  	align=center edit=none </FC> 
				<FC> Name='직위'	ID=JOB_NM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  	align=center edit=none </FC> 
				<FC> Name='성명'	ID=ENO_NM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  	align=center editStyle=PopupFix</FC> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
</table>

* 저장되는 Data가 아닙니다.

</body>
</html>


