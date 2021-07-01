<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  전자세금계산서 - 매출관리 - Email 입력
+ 프로그램 ID	:  A040065_Email_popup.html
+ 기 능 정 의	:  이메일 재발송시 상대방 Email등을 수작업으로 입력함.
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2009.07.02
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
<title>Email 입력</title>

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
	var strEmail =  new Array();

	gclx_email.index=0;
	mailserver.readOnly = false;

    txt_title.value =strParam[0];
	strEmail = strParam[1].split("@");

	if (strEmail != null){
		emailid.value = strEmail[0];
        mailserver.value = strEmail[1]; 
	}else{
		emailid.value = "";
        mailserver.value = ""; 
	}

    mailserver.readOnly = true;
	
}


function ln_End(){

	//alert("end test");
	//opener.location.ln_Query();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){ 

    if(emailid.value==""||mailserver.value==""){
		alert("메일을 정확하게 입력해 주십시요.");
		return;
	}

	window.returnValue = emailid.value+"@"+mailserver.value; 
	window.close();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Close(){ 
  //window.opener.ln_Query();
	
	window.close();
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
<script language=JavaScript for= gclx_email event=OnSelChange()>
  
  	mailserver.readOnly = true;
	if(gclx_email.bindcolval =="00"){
    	mailserver.value="";
	}else if(gclx_email.bindcolval =="10"){
		mailserver.value="naver.com";
  	}else if(gclx_email.bindcolval =="20"){
    	mailserver.value="hanmail.net";
	}else if(gclx_email.bindcolval =="30"){
    	mailserver.value="dreamwiz.com";
	}else if(gclx_email.bindcolval =="40"){
    	mailserver.value="yahoo.co.kr";
	}else if(gclx_email.bindcolval =="50"){
    	mailserver.value="yahoo.com";
	}else if(gclx_email.bindcolval =="60"){
    	mailserver.value="paran.com";
	}else if(gclx_email.bindcolval =="70"){
    	mailserver.value="hotmail.com";
	}else if(gclx_email.bindcolval =="99"){
	  	emailid.value = "";
    	mailserver.value="";
		mailserver.readOnly = false;
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
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()"  onbeforeunload="ln_End()" >
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
			<td width="150px" class="tab18"><nobr><comment id="__NSID__">
				<input type="text" id="emailid"    size="13" maxlength="24"      class="txtbox" style= "position:relative;left:1px;top:-2px">
         @&nbsp;
        <input type="text" id="mailserver" size="14" maxlength="26"      class="txtbox"  style= "position:relative;left:-5px;top:-2px">
				<object id=gclx_email         classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;width:120px;">
					<param name=CBData			    value="00^선택,10^네이버,20^다음(한메일),30^드림위즈,40^야후! 코리아,50^야후! yahoo.com,60^파란닷컴,70^핫메일,99^직접입력">
					<param name=CBDataColumns	  value="CODE,NAME">
					<param name=SearchColumn	  value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="NAME^0^100">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script></nobr> 
			</td>
	 </tr>
	  <tr>
			<td height="3"></td>
	 </tr>
	  <tr>
			<td style="background-color:#FFCCFF;border:0;font-size:15;font-weight:bold">
				 <font size=2 > *.세금계산서 수신자의 Email을 입력하세요..</font>
      </td>
	 </tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
