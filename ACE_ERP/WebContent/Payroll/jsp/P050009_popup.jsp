<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: P050009_POPUP.HTML
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 
+ 서 블 릿 명	: P050009_s4
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>  
<title>사원조회</title>

<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
//get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	if(window.dialogArguments[0]=="H050009"||window.dialogArguments[0]=="EMPNO"){
	   parentGubun ="";
	}else if(window.dialogArguments[0] != undefined && window.dialogArguments[0] != "H030003" && window.dialogArguments[0] != "H050005"&& window.dialogArguments[0] != "H050008" ) { 
	   parentGubun="P040001";
	}else if(window.dialogArguments[0] == "H030003") {
		parentGubun="H030003";
	}else if(window.dialogArguments[0] == "H050008") {
		parentGubun="H050008";
	}else if(window.dialogArguments[0] == "H050005") {
		parentGubun="H050005";
	}else if(window.dialogArguments[0] == "P050009") {
		parentGubun="P050009";
		}
	//alert("window.dialogArguments[0]::"+window.dialogArguments[0]);
	//alert("parentGubun::"+parentGubun);
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(e){
// alert("parentGubun::"+parentGubun+":::");

	if(parentGubun=="") {	
		gcds_data.DataID = "/services/servlet/Person.h030003_s2?"
										 + "v_str1=" + txt_nm.value;
	}	else if(parentGubun == "P050009"){ //급여보험등록
			gcds_data.DataID = "/services/servlet/Payroll.P050009_s4?"  //급여보험등록
											 + "v_str1=" + txt_nm.value; 
												//	prompt(this,gcds_data.DataID);
	}else if(parentGubun=="P040001") {	//추계퇴직급조회
		gcds_data.DataID = "/services/servlet/Payroll.p040001_pop_s1?"
									   + "v_str1=" + txt_nm.value;
  } else if(parentGubun == "H030003") {	//증명서발행결재
		gcds_data.DataID = "/services/servlet/Person.h030003_s2?"
										 + "v_str1=" + txt_nm.value
										 + "&v_str2=" + "T";
  } else if(parentGubun == "H050008") {	//야근특근 대상자.
	  if(window.dialogArguments[1]==""||window.dialogArguments[1]==undefined ){
			gcds_data.DataID = "/services/servlet/Person.h030003_s5?"  //야근특근 전체용
											 + "v_str1=" + txt_nm.value;
		}else{
			gcds_data.DataID = "/services/servlet/Person.h030003_s6?"  //야근특근 부서 관리자용
											 + "v_str1="+txt_nm.value
											 + "&v_str2="
											 + "&v_str3="+window.dialogArguments[1];//사번
		}
	}else if(parentGubun == "H050005"){ //근태
		if(window.dialogArguments[1]==""||window.dialogArguments[1]==undefined ){
			gcds_data.DataID = "/services/servlet/Person.h030003_s7?"  //근태 전체용
											 + "v_str1=" + txt_nm.value;
		}else{
			gcds_data.DataID = "/services/servlet/Person.h030003_s8?"  //근태 부서 관리자용
											 + "v_str1="+txt_nm.value
											 + "&v_str2="
											 + "&v_str3="+window.dialogArguments[1];//사번
		}
	}
	gcds_data.Reset();
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
******************************************************************************/
function ln_Close(e){
// alert("e::"+gcds_data.namevalue(row,"EMPNO")+";"+ gcds_data.namevalue(row,"EMPNMK") ); 
										
	if (e=="A") {
		var row = gcds_data.rowposition;
		if(parentGubun=="") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM") + ";"
												 + gcds_data.namevalue(row,"DEPTCD") + ";"
												 + gcds_data.namevalue(row,"PAYGRD") + ";"
												 + gcds_data.namevalue(row,"MEMO");
												 + "v_str1=" + txt_nm.value;
		}	else if(parentGubun=="P040001") { //추계퇴직급조회
			window.returnValue = gcds_data.namevalue(row,"EMPNO")   + ";" + gcds_data.namevalue(row,"EMPNMK")  + ";"
												 + gcds_data.namevalue(row,"DEPTCD")  + ";" + gcds_data.namevalue(row,"DEPTNM")  + ";"
												 + gcds_data.namevalue(row,"PAYSEQ")  + ";" + gcds_data.namevalue(row,"PAYSEQNM")+ ";" 
												 + gcds_data.namevalue(row,"STRTDT")  + ";" + gcds_data.namevalue(row,"ENDDT")   + ";"
												 + gcds_data.namevalue(row,"GRSTRTDT")+ ";" + gcds_data.namevalue(row,"RESINO")  + ";"
												 + gcds_data.namevalue(row,"DUYEAR")  + ";" + gcds_data.namevalue(row,"PAYGRD")  + ";"
												 + gcds_data.namevalue(row,"PAYGNM")  + ";"
												 + gcds_data.namevalue(row,"PAYDIV")  + ";";
		} else if (parentGubun=="H030003") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM");
												 + "v_str1=" + txt_nm.value;
		} else if (parentGubun=="P050009") {
	//	 alert("e::"+gcds_data.namevalue(row,"EMPNO")+";"+ gcds_data.namevalue(row,"EMPNMK") ); 
			window.returnValue = gcds_data.namevalue(row,"EMPNO") + ";" 
												 + gcds_data.namevalue(row,"EMPNMK");
		}if(parentGubun=="H050008"||parentGubun=="H050005") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM") + ";"
												 + gcds_data.namevalue(row,"DEPTCD") + ";"
												 + gcds_data.namevalue(row,"PAYGRD") + ";"
												 + gcds_data.namevalue(row,"MEMO");
												 + "v_str1=" + txt_nm.value;
		}
		window.close();
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("조회된 데이타가 없습니다.");
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">성명</td>
		<td width="110px"><input type="text" class="txt11" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="성명을 검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:358;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=EMPNO,		Name=사번,		width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=EMPNMK,		Name=성명,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=DEPTNM,		Name=소속명,	width=106,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=PAYGNM,		Name=직위명,	width=86,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:360;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	