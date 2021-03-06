<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	물류관리 - HS코드관리
+ 프로그램 ID	: TR00504.HTML
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

		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=1&vstr2=9999"; 
		gcds_data1.Reset();
		
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

		var ser = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s02?";
		if (gclx_gbn.bindcolval=="1") ser = ser + "vstr1=1&vstr2=";
		else if (gclx_gbn.bindcolval=="2") ser = ser + "vstr1=2&vstr2=" + gclx_data1.bindColVal; 
		else if (gclx_gbn.bindcolval=="3") ser = ser + "vstr1=2&vstr2=" + gclx_data2.bindColVal; 
		else if (gclx_gbn.bindcolval=="4") ser = ser + "vstr1=2&vstr2=" + gclx_data3.bindColVal; 
	
		gcds_data.DataID = ser;
		gcds_data.Reset();

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.AddRow();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_data.IsUpdated) {
		if (confirm("해당 입력정보를 저장하겠습니까 ?")) {
			for (var i=1; i<=gcds_data.countrow; i++){
				if (gcds_data.sysStatus(i)!=0) {
					gcds_data.namevalue(i,"WRITE_PS") = gusrid;
					gcds_data.namevalue(i,"UPDATE_PS") = gusrid;
				}
				
				if (gcds_data.namevalue(i,"MAJOR_CD")==""){
					gcds_data.undo(i);
				}
			}

 	    gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_t02";
			gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") gcds_data.undo(gcds_data.rowposition)
	else gcds_data.deleterow(gcds_data.rowposition);
	ln_Save();
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
	Description : 엑셀업로드용 헤더 만들기
******************************************************************************/
function ln_SetHeader(){
	var THeader = "MAJOR_CD:STRING(4),MINOR_CD:STRING(10),MINOR_NM:STRING(1024),MINOR_LEN:DECIMAL(2),ETC_CD1:STRING(20),ETC_CD2:STRING(20),ETC_CD3:STRING(20),ETC_NO1:DECIMAL(18.5),ETC_NO2:DECIMAL(18.5),ETC_NO3:DECIMAL(18.5),STS_CD:STRING(1),WRITE_PS:STRING(10),WRITE_DT:STRING(10),UPDATE_PS:STRING(10),UPDATE_DT:STRING(10)";
	gcds_data.SetDataHeader(THeader);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_dump classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="hscode_t02(I:DATA=gcds_data)">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	if (row <1) alert("검색된 데이터가 없습니다.");
	ft_cnt01.innerText = "조회건수 : 총 ( " + row + " ) 건";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_data" event="onRowPoschanged(row)">
	if (gcds_data.sysStatus(row)=="1") {
		txt_major_cd.readOnly = false;
		txt_minor_cd.readOnly = false;
	} else {
		txt_major_cd.readOnly = true;
		txt_minor_cd.readOnly = true;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for="gclx_type" event="onSelChange2()">
	gcds_data.ClearData();
	if (gclx_type.bindColVal=="1") {
		gclx_gbn.style.display = "";
		div_excel.style.display = "none";
	} else {
		gclx_gbn.style.display = "none";
		div_excel.style.display = "";
		ln_SetHeader();
	}
</script>

<script language=javascript for="gclx_gbn" event="onSelChange2()">

	for (var i=1;i<4;i++) eval("gclx_data"+i).style.display = "none";

	switch (gclx_gbn.bindcolval) {
		case "2": gclx_data1.style.display = ""; gclx_data1.index=-1; break;
		case "3": gclx_data1.style.display = ""; gclx_data1.index=-1; gclx_data2.style.display = ""; gclx_data2.index=-1; break;
		case "4": gclx_data1.style.display = ""; gclx_data1.index=-1; gclx_data2.style.display = ""; gclx_data2.index=-1; gclx_data3.style.display = ""; gclx_data3.index=-1; break;
	}

	gcds_data.ClearData();

</script>

<script language=javascript for=gclx_data1 event=onSelchange2()>
	if (gclx_data2.style.display==""){
		gcds_data2.DataID = "/services/servlet/transfer.hscode_s01?vstr1=1&vstr2=" + gclx_data1.bindColVal; 
		gcds_data2.Reset();
	}
</script>

<script language=javascript for=gclx_data2 event=onSelchange2()>
	if (gclx_data3.style.display==""){
		gcds_data3.DataID = "/services/servlet/transfer.hscode_s01?vstr1=1&vstr2=" + gclx_data2.bindColVal; 
		gcds_data3.Reset();
	}
</script>

<script language=JavaScript for=gcip_file event=OnClick()>
	gcds_dump.DataID = gcip_file.value;
	gcds_dump.Reset();

	for (var j=1; j<=gcds_dump.countrow;j++){
		gcds_data.addrow();
		var ls_pos = gcds_data.rowposition;
		for (var i=1; i<9; i++) {
			gcds_data.ColumnValue(ls_pos,i) = gcds_dump.ColumnValue(j,i);
		}
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
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
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="876" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="../../../Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    	<img src="../../../Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan="2"> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:878px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;'>
        <tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">HS 코드 분류</td>
					<td class="tab21">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_type classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;">
							<param name=CBData			   value="1^직접입력,2^엑셀입력">
							<param name=CBDataColumns	 value="code,name">
							<param name=SearchColumn	 value="name">
							<param name=ListExprFormat value="name">								
							<param name=BindColumn		 value="code">
							<param name=Index			     value="0">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_gbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150 style="position:relative;top:2px;left:5px;">
							<param name=CBData			   value="1^부목록,2^류목록,3^4단위목록,4^6(10)단위목록">
							<param name=CBDataColumns	 value="code,name">
							<param name=SearchColumn	 value="name">
							<param name=ListExprFormat value="name">								
							<param name=BindColumn		 value="code">
							<param name=Index			     value="0">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<div id=div_excel style="position:absolute;top:50px;left:210px;width:660px;display:none">
							<input type="text" class="txt11" id=txt_filenm readonly style="width:565px">
							<%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
								style="position:relative;left:10px;width:80; height:20;" align="absmiddle">
									<param name="Text"          value='찾아보기'>
					        <param name="Enable"        value="true">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</div>
					</td>
				</tr>
        		<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="height:30px;">부목록</td>
					<td class="tab21">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_data1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;width:760;display:none">
							<param name=ComboDataID			value="gcds_data1">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="-1">
							<param name=ListExprFormat	value="minor_nm^0^735">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
        <tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="height:30px;">류목록</td>
					<td class="tab21">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_data2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;width:760;display:none">
							<param name=ComboDataID			value="gcds_data2">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="-1">
							<param name=ListExprFormat	value="minor_nm^0^735">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
        <tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="height:30px;">4단위목록</td>
					<td class="tab21">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_data3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;width:760;display:none">
							<param name=ComboDataID			value="gcds_data3">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="-1">
							<param name=ListExprFormat	value="minor_nm^0^735">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
      <table width="867" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:338px; border:1 solid #708090" viewastext>
			              	<PARAM NAME="DataID"			VALUE="gcds_data">
			              	<PARAM NAME="BorderStyle" VALUE="0">
			              	<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
						  	<PARAM NAME="Format"			VALUE=" 
								<C> Name='Major코드'		ID=MAJOR_CD 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left</C>
								<C> Name='Minor코드'		ID=MINOR_CD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=left, mask={decode(MLEN,4,'XXXX',10,'XXXX.XX-XXXX',6,'XXXX.XX','XXX')}</C> 
								<C> Name='코드명(품명)'	ID=MINOR_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=360	align=left,sort=true</C>
								<C> Name='기타문자1'		ID=ETC_CD1	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C>
								<C> Name='기타문자2'		ID=ETC_CD2   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C> 
								<C> Name='기타문자3'		ID=ETC_CD3   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left</C> 
								<C> Name='기타숫자(금액)1'			ID=ETC_NO1    HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=right</C>
								<C> Name='기타숫자(금액)2'			ID=ETC_NO2   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=right</C>
								<C> Name='기타숫자(금액)3'			ID=ETC_NO3    HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=right</C>
								<C> Name='상태코드'			ID=STS_CD   		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center, Editstyle=combo,	data='1:사용,2:미사용'</C>
								<C> Name='작성자'				ID=WRITE_PS   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center</C>
								<C> Name='작성일자'			ID=WRITE_DT   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center</C>
								<C> Name='수정자'				ID=UPDATE_PS   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center</C>
								<C> Name='수정일자'			ID=UPDATE_DT   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center</C>
							">
            			</OBJECT>
            			<%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt01 style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;Major코드</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_major_cd" style="width:100px;height:20px;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;Minor코드</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_minor_cd" style="width:100px;height:20px;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;코드명</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_minor_nm" style="width:250px;height:20px;IME-MODE: active"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타문자1</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_etc_cd1" style="width:200px;height:20px;IME-MODE: active" ></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타문자2</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_etc_cd2" style="width:200px;height:20px;IME-MODE: active" ></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타문자3</td>
								<td class="tab21"><input type="text" class="txt11" id="txt_etc_cd3" style="width:200px;height:20px;IME-MODE: active" ></td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타숫자(금액)1</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_etc_no1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타숫자(금액)2</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_etc_no2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;기타숫자(금액)3</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_etc_no3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
                     <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:30px;" bgcolor="#eeeeee">&nbsp;상태코드</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_sts_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;left:8px;" class="txtbox">
										<param name=CBData			   value="1^사용,2^미사용">
										<param name=CBDataColumns	 value="code,name">
										<param name=SearchColumn	 value="name">
										<param name=ListExprFormat value="name">								
										<param name=BindColumn		 value="code">
										<param name=Index			     value="0">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:59px;" bgcolor="#eeeeee">&nbsp;</td>
								<td class="tab21">&nbsp;</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=major_cd   Ctrl=txt_major_cd    Param=Value</C>
		<C>Col=minor_cd		Ctrl=txt_minor_cd   Param=Value</C>
		<C>Col=minor_nm		Ctrl=txt_minor_nm   Param=Value</C>
		<C>Col=etc_cd1		Ctrl=txt_etc_cd1    Param=Value</C>
		<C>Col=etc_cd2		Ctrl=txt_etc_cd2		Param=Value</C>
		<C>Col=etc_cd3		Ctrl=txt_etc_cd3	  Param=Value</C>
		<C>Col=etc_no1		Ctrl=gcem_etc_no1   Param=Text</C>
		<C>Col=etc_no2		Ctrl=gcem_etc_no2   Param=Text</C>
		<C>Col=etc_no3		Ctrl=gcem_etc_no3   Param=Text</C>
		<C>Col=sts_cd			Ctrl=gclx_sts_cd    Param=BindColVal</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


