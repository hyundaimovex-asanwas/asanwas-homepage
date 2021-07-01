<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	물류관리 - 공지사항관리
+ 프로그램 ID	: TR00602.HTML
+ 기 능 정 의	: 조회,저장,삭제
+ 변 경 이 력	: 정미선
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

		get_cookdata();
		
		//임시
		gusrid ="6070001";

		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
			

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			ln_Start();
			window.status="완료";

		}
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

	txt_filenm.value = "";
	
	ln_Query();
	
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_s01?v_str1=1&v_str2=";
	alert();
	gcds_data.Reset();
	
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	if (gcds_data.sysStatus(gcds_data.countrow)=="1") {
		alert("기 입력하신 내용을 저장하신 후 신규 건을 작성해 주십시오.");
		return;
	}

	gcds_data.AddRow();
	gcds_data.Namevalue(gcds_data.rowposition,"MAIFLAG") = "F";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

	if (!gcds_data.IsUpdated) return;

	if (gcds_data.countrow > 0) {

		var tmaidesc = txt_text.value;
		var tmaisubj = txt_subject.value;
		var cdesc = tmaidesc.replace(/\s/g,"");
		var csubj = tmaisubj.replace(/\s/g,"");
		var curdate = gn_Replace(gcurdate,'-');
		var tfile = txt_filenm.value;
		var tmaifiles = gcip_file.FileInfo("size");
		var tmaifname = ln_Divide(txt_filenm.value, "\\");
		var tdaecod = gusrid;

		if (tfile == '' || tfile == null)	tfile = "";
		if (tmaifiles == '' || tmaifiles == null)	tmaifiles = 0;

		if (csubj == '' || csubj == null){
			alert('제목을 입력하시오');
			txt_subject.focus();
			return;
		}

		if (cdesc == '' || cdesc == null){
			alert('내용을 입력하시오');
			txt_text.focus();
			return;
		}
		
		if (tmaifiles >= 1048577){
			alert("첨부파일은 1M Byte(1048576 Byte)이하만 가능합니다.\n\n현재 선택한 파일의 크기는 "+tmaifiles+" Byte입니다");
			return;
		}

		for (var j=1; j<=gcds_data.countrow; j++){
			if (gcds_data.sysStatus(j)=="1"){
				gcds_data.NameValue(j,"MAIGBN") = "1";	        //입력구분
				gcds_data.NameValue(j,"MAIYMD") = curdate;			//입력일자
				gcds_data.NameValue(j,"MAISEQ") = 0;		        //순번

				gcds_data.NameValue(j,"MAITIME") = "0";							//입력시간
				gcds_data.NameValue(j,"MAISMAN") = gusrid;					//입력자
				gcds_data.NameValue(j,"MAISUBJ") = tmaisubj;				//제목
				gcds_data.NameValue(j,"MAIDESC") = tmaidesc;			  //내용 
				gcds_data.NameValue(j,"MAIFILES") = Number(tmaifiles);		//첨부파일 SIZE
				gcds_data.NameValue(j,"MAIFNAME") = tmaifname;				    //첨부파일이름

				if (tfile != null || tfile != "")	gcds_data.NameValue(j,"MAIFILE") = tfile;				    //첨부파일

			} else if (gcds_data.sysStatus(j)=="3"){
				gcds_data.NameValue(j,"MAISUBJ") = tmaisubj;				//제목
				gcds_data.NameValue(j,"MAIDESC") = tmaidesc;			  //내용 
				gcds_data.NameValue(j,"MAIFILES") = Number(tmaifiles);		//첨부파일 SIZE
				gcds_data.NameValue(j,"MAIFNAME") = tmaifname;				    //첨부파일이름
				if (tfile != null || tfile != "")	gcds_data.NameValue(j,"MAIFILE") = tfile;				    //첨부파일
			}
		}
	} 



	if (confirm("해당 입력정보를 저장하겠습니까 ?")) {
	
		if (tfile == null || tfile == "")	{
			gctr_nfile.Parameters = "v_str1=" + "1" + ",v_str2=" + curdate;

			gctr_nfile.Post();		  //첨부파일이 없는 경우
		} else {
			gctr_tfile.Parameters = "v_str1=" + "1" + ",v_str2=" + curdate;
			gctr_tfile.Post();		  //첨부파일이 존재하는 경우
		}
	}

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	var row = gcds_data.rowposition;
	if (gcds_data.sysStatus(row)=="1") gcds_data.undo(row)
	else gcds_data.deleterow(row);
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
	Description :
******************************************************************************/
function ln_Divide(str, delim){

	var strArr = str.split(delim);
	var rtn = "";
	var a = strArr.length;

	if(a>0) rtn=strArr[a-1];

	strArr = null;
	return rtn;
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_nfile classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_t01">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00602_t01(I:DATA=gcds_data)">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_tfile classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_t02">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00602_t02(I:DATA=gcds_data)">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";

	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";

</script>

<script language="javascript" for="gcds_data" event="CanRowPosChange(row)">
	if (gcds_data.sysStatus(row)=="1" || gcds_data.sysStatus(row)=="3" ) {

	} else return true;

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcip_file event=OnClick()>
	txt_filenm.value = gcip_file.value;

</script>
<script language="javascript"  for=gcgd_disp event=OnClick(Row,Colid)>
	 
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_nfile" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data.reset();
</script>

<script language="javascript" for="gctr_tfile" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data.reset();
</script>


<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="877" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif">
			<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    	<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
			&nbsp;
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign="top" colspan=2>
			<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp
				style="position:relative;left:0px;width:875px; height:119px; border:1 solid #708090;">
			    <PARAM NAME="DataID"			VALUE="gcds_data">
				  <PARAM NAME="BorderStyle" VALUE="0">
				  <PARAM NAME="Editable"		VALUE="1">
					<PARAM NAME="IndWidth"		VALUE='17'>
					<PARAM NAME="Fillarea"		VALUE="true">
				  <PARAM NAME="Format"			VALUE="  
						<C> Name='No',  ID={CURROW},  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center</C> 
						<C> Name='첨부'  ID=						HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center value={decode(MAIFILES,0,'','Y')}, cursor=hand, edit=none</C> 
						<C> Name='고정'		ID=MAIFLAG	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center cursor=hand, editstyle=checkbox</C> 
						<C> Name='제 목'  ID=MAISUBJ  HeadAlign=Center HeadBgColor=#B9D4DC Width=457 align=left, edit=none</C> 
						<C> Name='작성일' ID=MAIYMD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, mask='XXXX/XX/XX', edit=none</C> 
						<C> Name='작성자' ID=REGNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=133 align=center, edit=none</C> 
					">
			</OBJECT><%=HDConstant.COMMENT_END%>
		</td>
	</tr>
	<tr><td height=3></td></tr>
	<tr>
		<td colspan=2>
      <table width="877" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" style="width:100%;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
              <tr> 
	              <td class="tab11" style="width:90;height:30px" bgcolor="#eeeeee">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                <td colspan="3" class="tab21"><input type="text" class="txt11" id=txt_subject style="width:750px;IME-MODE: active" maxlength="100"></td>			
              		</tr>
					<tr> 
                			<td class="tab11" style="height:30px;" bgcolor="#eeeeee">첨부파일</td>
                			<td colspan="3" class="tab21">
                  			<input type="text" class="txt11" id=txt_filenm readonly style="width:685px">
								  <%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
						        style="position:relative;left:9px;width:80; height:20;" align="absmiddle">
								      <param name="Text"          value='찾아보기'>
		                  			<param name="Enable"        value="true">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
              		</tr>
              		<tr style="height:300px"> 
                <td class="tab11" style="height:30px;" bgcolor="#eeeeee">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
                <td colspan="3" class="tab21"><TEXTAREA id=txt_text class="txt11" style="width:775px; height:290px;border:0;overflow:auto;IME-MODE: active"></TEXTAREA>
				</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=MAISUBJ    	Ctrl=txt_subject	Param=Value</C>
		<C>Col=MAIDESC		Ctrl=txt_text			Param=Value</C>
		<C>Col=MAIFNAME   Ctrl=txt_filenm		Param=Value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>


</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
