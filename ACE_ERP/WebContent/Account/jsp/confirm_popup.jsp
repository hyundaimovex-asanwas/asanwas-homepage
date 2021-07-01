<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 전표 결재요청 팝업	
+ 프로그램 ID	:  Comfirm_popup.html
+ 기 능 정 의	:  결재요청  팝업창
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.01.11
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 예산타입이 적용일 때 예산담당자 자동 설정  
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2006.06.08
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>결재요청</title>

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
get_cookdata();
var g_cdcodenam="";
var g_bgtgb="";    //예산구분필드에 추가함.(전표결재시 Y인 건은 전표등록에서 회계일자를 변경해야함.)
var g_bgttype="";
var g_gubun="";   //예산구분함.
/******************************************************************************
	Description : 페이지 로딩
	              전표의 계정을 예산 먼저 체크해서 존재하면 예산
								존재하지 않으면 자금 체크해서 자금존재 하면 자금
******************************************************************************/
function ln_Start(){
	var strParam=window.dialogArguments;

	g_bgtgb = "";
	g_bgttype ="01";

	if(strParam!=""){ 
		for(i=1;i<=strParam.ifrm.g_row;i++){
			if(strParam.ifrm.eval("sel_fswrkdiv"+i).value=="02" && strParam.ifrm.eval("hid_flag_del"+i).value!="Y"){
				g_bgttype='02'; //예산
				g_bgtgb="Y";
				g_gubun="Y";
				break;
			}
		}

    if(g_gubun!="Y"){ //예산을 타지 않았을 경우
			for(i=1;i<=strParam.ifrm.g_row;i++){
				if(strParam.ifrm.eval("hid_funddiv"+i).value!=""&& strParam.ifrm.eval("hid_flag_del"+i).value!="Y"){
					g_bgttype='03'; //자금
					g_bgtgb="Y"
					break;
				}
			}
		}
	}

	gcra_confirm.codevalue="Y";
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0900&v_str6="+g_bgttype; 
	//prompt("",gcds_code02.dataid);
	gcds_code02.Reset();

	ln_BgtGubun(g_bgttype);
}


/******************************************************************************
	Description : 회계 예산 구분값
******************************************************************************/
function ln_BgtGubun(p){
	if(p=="01"){
		txt_gubun.value="회계";
	}else if(p=="02"){
    txt_gubun.value="예산";
	}else if(p=="03"){
    txt_gubun.value="자금";
	}else{
    txt_gubun.value="전체";
	}
}
/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>.confirm_popup_s1?v_str1="+txt_empnmk.value; 
	//prompt("",gcds_code01.dataid);
	gcds_code01.Reset();
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
  
	if (txt_empno.value==""){
		alert("결재자를 선택하십시요")
		txt_empnmk.focus();
		return;
	}
	
 // alert("1"+window.returnValue);
	window.returnValue = txt_empno.value + ";" + gcra_confirm.codevalue +";"+hid_cdremark.value+";"+hid_gbcd.value+";"+g_bgtgb;
 //	alert("2"+window.returnValue);
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

/******************************************************************************
	Description : 결재자 찾기
******************************************************************************/
function ln_Popup(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//if(event.keyCode!=113) return;

	arrParam[0]="0900";//결재자

	strURL =  "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno.value =arrResult[0];
		txt_empnmk.value = arrResult[1];
		hid_cdremark.value =  arrResult[2];
		hid_gbcd.value= arrResult[3];

		//alert("hid_cdremark"+hid_cdremark.value);
	}else{
    txt_empno.value="";
		txt_empnmk.value="";
		hid_cdremark.value ="";
		hid_gbcd.value="";	
	}
	ln_BgtGubun(hid_gbcd.value);

}

function ln_Onblur(){
	if (txt_empnmk.value=="") txt_empno.value="";
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
		if (row>=1){
			txt_empno.value = gcds_code01.namevalue(row,"EMPNO");
			txt_empnmk.value = gcds_code01.namevalue(row,"EMPNMK");
		}else{
      txt_empno.value="";
			txt_empnmk.value="";
			ln_Popup();
		}
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
		if (row>=1){
			txt_empno.value =  gcds_code02.namevalue(1,"CDCODE");
			txt_empnmk.value = gcds_code02.namevalue(1,"CDNAM");
			hid_cdremark.value =gcds_code02.namevalue(1,"CDREMARK");
		  hid_gbcd.value= gcds_code02.namevalue(1,"GBCD");
		}else{
      txt_empno.value="";
			txt_empnmk.value="";
			hid_cdremark.value ="";
		  hid_gbcd.value= "";
		}
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

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:310px">
	<tr>
		<td  width="310" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_b_save.gif"  style="cursor:hand" onclick="ln_Save()">
		</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:310px;border:1 solid #708090">
	<tr>
	  <td class="tab13" width="25px" bgcolor="#eeeeee" >
		  <input type="text" class="txt41"  id="txt_gubun" style="position:relative;top:1px;left:3px;width:25px;background-color:#eeeeee;border:0 " readOnly></td>
		<td class="tab19" width="50px;" bgcolor="#eeeeee" align=center>결재자</td>
		<td class="tab13" width="60px">
		  <input type="text" class="txt11" id="txt_empno"  style="position:relative;left:1px;width:55px;background-color:#d7d7d7" readOnly></td>
		<td class="tab13" width="35px">
			<img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;" onclick="ln_Popup()"></td>
		<td class="tab13" width="110px"><nobr>
			<input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="position:relative;left:1px;width:100px;" onblur="ln_Onblur()" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;님께 
	    <input type="hidden" class="txt11" id="hid_cdremark"  readOnly> 
			<input type="hidden" class="txt11" id="hid_gbcd"  readOnly> 
			</nobr></td>
	</tr>
	<tr>
		<td width="100px" colspan=5>
		<comment id="__NSID__"><object  id=gcra_confirm classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:60; width:200">
			<param name=Cols	  value="1">
			<param name=Format	value="Y^결재 바랍니다.,B^결재요청을 보류합니다.">
		</object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>

</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 