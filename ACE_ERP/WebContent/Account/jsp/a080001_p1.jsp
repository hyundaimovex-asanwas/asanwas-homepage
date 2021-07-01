<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 계정코드(공통)	
+ 프로그램 ID	:  A080001_P1.html
+ 기 능 정 의	:  계정코드 팝업창
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.09.28
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>등록설정화면</title>


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

  gclx_start.index = 0;
  gclx_end.index = 11;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

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

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		window.returnValue = gclx_start.bindcolval  + ";" 
	                   	                + gclx_end.bindcolval;
	                   	                
           	                
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

<comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

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
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:378px;border:1 solid #708090">
	<tr><td height="4px"></td></tr>
	<tr>
		<td align="center">
      <comment id="__NSID__"><object  id=gclx_start classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
        style="position:relative;left:5px;top:0px;font-size:12px;width:40px;">
        <param name=CBData			    value="1^01,2^02,3^03,4^04,5^05,6^06,7^07,8^08,9^09,10^10,11^11,12^12">
        <param name=CBDataColumns		value="CDCODE,CDNAM">
        <param name=SearchColumn		value="CDNAM">
        <param name=Sort						value="false">
        <param name=ListExprFormat	value="CDNAM^0^40">
        <param name=BindColumn			value="CDCODE">
        <param name=enable					value="true">
      </object></comment><script>__ws__(__NSID__);</script> &nbsp;
      월 부터
			<comment id="__NSID__"><object  id=gclx_end classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:3px;top:1px;font-size:12px;width:40px;">
        <param name=CBData			    value="1^01,2^02,3^03,4^04,5^05,6^06,7^07,8^08,9^09,10^10,11^11,12^12">
        <param name=CBDataColumns		value="CDCODE,CDNAM">
        <param name=SearchColumn		value="CDNAM">
        <param name=Sort						value="false">
        <param name=ListExprFormat	value="CDNAM^0^40">
        <param name=BindColumn			value="CDCODE">
        <param name=enable					value="true">
			</object></comment><script>__ws__(__NSID__);</script> &nbsp;
      월까지 예산신청하겠습니다.
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 