<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 공통코드 상세	
+ 프로그램 ID	:  Commdtil_popup_ifrm.html
+ 기 능 정 의	:  관리항목별  팝업창
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2005.12.07
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

<title>관리항목</title>

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
var g_gbcd="";
var g_cmtype="";
var g_gubun="";
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam=window.dialogArguments;
  	g_cmtype=strParam[0];
	txt_cdcodenm.value=strParam[1];

	if(g_cmtype=="0003"){ //예산부서
		g_gbcd = strParam[2];
	}else if(g_cmtype=="0030"){//원가코드
    	g_gbcd = strParam[2];

  	}else if(g_cmtype=="0997"||g_cmtype=="0023"||g_cmtype=="0022"){//선급비용  2010.03.19 jys : 전표등록과 조회시 다르게 조회함. 계좌번호 0023 추가 (2016.06.10)
		g_gubun = strParam[2];
	
	    //alert("g_gubun::"+g_gubun);
	}else{
		g_gbcd="";
	}
	ln_Query();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  if(g_cmtype =="0030"||g_cmtype =="0001"){ //원가코드 또는 사원번호
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_cost_s1?v_str1="+g_cmtype
	                                                                                 +"&v_str2="
																					 +"&v_str3="+txt_cdcodenm.value
																					 +"&v_str4=C"
																					 +"&v_str5="
																					 +"&v_str6=";  
  
     //prompt("",gcds_code01.DataID);
	  gcds_code01.Reset();
 	}else{

		if(g_gubun=="A"){
			gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s3f?v_str1="+g_cmtype
																					+"&v_str2="+txt_cdcodenm.value
																					+"&v_str3=&v_str4="+g_gbcd; 
			//prompt("A",gcds_code01.DataID);
			gcds_code01.Reset();

		}else{
			gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s2f?v_str1="+g_cmtype
																					+"&v_str2="+txt_cdcodenm.value
																					+"&v_str3=&v_str4="+g_gbcd; 
			//prompt("B",gcds_code01.DataID);
			gcds_code01.Reset();
		}
	}
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
		var row = gcds_code01.rowposition;
		
		if(row<1){
			alert("행이 선택되지 않았습니다.");
			return false;
		}
		
		window.returnValue = gcds_code01.namevalue(row,"CDCODE")+";" 
		                   + gcds_code01.namevalue(row,"CDNAM")+";" 
						   + gcds_code01.namevalue(row,"GBCD")+ ";" 
	                   	   + gcds_code01.namevalue(row,"CDREMARK");
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

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:382px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee">관리항목</td>
		<td width="255px"><input type="text" class="txt11" id="txt_cdcodenm" style="position:relative;left:4px;width:240px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:380;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=CDCODE,		Name=코드,	width=65,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=CDNAM,		Name=명칭,	width=295,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:382;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
