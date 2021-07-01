<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  전자세금계산서 - 매출관리 - 취소 및 거부사유 입력 팝업
+ 프로그램 ID	:  Comfirm_popup.html
+ 기 능 정 의	:  취소 및 거부사유 입력 팝업
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2009.07.01
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
<title>사유 입력</title>


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
	              전표의 계정을 예산 먼저 체크해서 존재하면 예산
								존재하지 않으면 자금 체크해서 자금존재 하면 자금
******************************************************************************/
function ln_Start(){
	var strParam=window.dialogArguments;
  txt_title.value =strParam[0];
}


/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){ 

  if(txt_sbdescription.value==""){
	  alert("사유는 필수항목입니다. 입력해 주십시요.")
		return;
	}

	window.returnValue = txt_sbdescription.value ; 
	window.close();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Close(){ 
	window.close();
}

/******************************************************************************
	Description : 창이 닫히기 전에 발생하는 이벤트 
	              확인, 취소, X버튼 모두 이 함수를 탄다.
								각각 구분하여 적용해야할 것 같음.
******************************************************************************/
function ln_End(){
	
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
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

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

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
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()"  onbeforeunload="ln_End()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:330px">
	<tr>
		<td  width="150" align="left" style="padding-top:4px;">
			<input type="text" class="txt41"  id="txt_title"  style="background-color:#FFFF99;border:0;font-size:15;font-weight:bold" readOnly></td>
    </td>
		<td  width="180" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_btn_send.gif"  style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Close()">
		</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:6px;top:5px;width:330px;border:1 solid #708090">
   <tr>
			<td>
				 <textarea id="txt_sbdescription" class="txtbox"  style= "position:relative;left:2px;width:324px;height:50px; overflow:auto;"  maxlength="30"></textarea>
      </td>
	 </tr>
	  <tr>
			<td height="3"></td>
	 </tr>
	  <tr>
			<td style="background-color:#FFCCFF;border:0;font-size:15;font-weight:bold">
				 <font size=2 > *공백 포함해서 30자 이내로 입력해 주십시요.</font>
      </td>
	 </tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
