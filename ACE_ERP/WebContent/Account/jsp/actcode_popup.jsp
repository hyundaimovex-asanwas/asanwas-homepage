<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 계정코드(공통)	
+ 프로그램 ID	:  A010001.html
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
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>계정코드조회</title>

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
var parentGubun="";
var gs_strGubun =""; //전표유무
var gs_strBanjae =""; //전표유무
var gs_stryeasan="";
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;
	
	if(strParam.length==0){

	}else if(strParam.length==1){
		gs_strGubun = strParam[0];
		ln_Query();
	}else if(strParam.length==2) {
    	gs_strGubun = strParam[0];
		if(strParam[1]!="B"&&strParam[1]!="43"&&strParam[1]!="44"){
			txt_atkornam.value=strParam[1];
		}else if(strParam[1]=="43"||strParam[1]=="44"){	
			txt_atcode.value=strParam[1];
		}else{
			gs_stryeasan=strParam[1];
		}
    	ln_Query();
    }else if(strParam.length==3) {
    	gs_strGubun = strParam[0];
		txt_atkornam.value=strParam[1];
		gs_strBanjae =strParam[2];
    	ln_Query();
	}
	//계정구분
	gcds_comcode01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0033";
	gcds_comcode01.Reset();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?v_str1="+txt_atcode.value+"&v_str2="+txt_atkornam.value
	                                                                      +"&v_str3="+gclx_atdiv.Bindcolval+"&v_str4="+gs_strGubun
																		  +"&v_str5="+gs_strBanjae+"&v_str6="+gs_stryeasan; 
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
		window.returnValue = gcds_code01.namevalue(row,"ATCODE")  + ";" 
	                       + gcds_code01.namevalue(row,"ATKORNAM")+ ";" 
					 	   + gcds_code01.namevalue(row,"ATDECR")  + ";"
						   + gcds_code01.namevalue(row,"ATUPCODE")+ ";"
						   + gcds_code01.namevalue(row,"FSREFCD") + ";"
						   + gcds_code01.namevalue(row,"ATDIVNM");
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
<script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">
	gcds_comcode01.insertrow(1);
	gcds_comcode01.namevalue(1,"ATCODE") = "";
	gcds_comcode01.namevalue(1,"ATKORNAM") = "전체";
	gcds_comcode01.index=0;
</script>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">계정과목명</td>
		<td width="110px"><input type="text" class="txt11" id="txt_atkornam" style="position:relative;left:3px;width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="30"></td>
		<td class="tab16" width="60px;" bgcolor="#eeeeee" align="center">계정코드</td>
		<td width="60px"><input type="text" class="txt11" id="txt_atcode" style="position:relative;left:3px;width:50px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="7"></td>
		<td class="tab16" width="40px;" bgcolor="#eeeeee" align="center">구분</td>
		<td>
			<comment id="__NSID__"><object  id=gclx_atdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:3px;top:1px;font-size:12px;width:60px;">
						<param name=ComboDataID     value="gcds_comcode01">
						<param name=SearchColumn	value=CDNAM>
						<param name=Sort			value=false>
						<param name=ListExprFormat	value="CDNAM^0^65">
						<param name=BindColumn		value=CDCODE>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="계정코드를 검색합니다" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=ATCODE,		 Name=코드,   	  width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=ATKORNAM,	 Name=계정과목명, width=269,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=ATDIVNM,	 Name=구분,       width=50,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=ATDECRNM,	 Name=대차구분,   width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:478;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 