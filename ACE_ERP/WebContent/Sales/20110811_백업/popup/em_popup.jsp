<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%	String dirPath = request.getContextPath(); %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 인사관리 - 개인정보
+ 프로그램ID : em_popup.jsp
+ 기능정의 : 인사 기본정보화면의 생성버튼을 이용하여 신규추가를 하는 팝업창
+ 작 성 자 : 양 태 식 
+ 작성일자 : 2007.10.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em010_S1,Em010_S2
----------------------------------------------------------------------------------*/
%>
<head>
<title>[근로자 정보]</title>
<jsp:include page="/Sales/common/include/head.jsp"/>

<script language="javascript">

	/* 페이지로딩 */
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!
			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
			//fnInit(); //초기화 함수
		}

var parentGubun="";
get_cookdata();
var opener = window.dialogArguments;
/*----------------------------------------------------------------------------
 Description : 페이지 로딩
----------------------------------------------------------------------------*/

function ln_Start(){
	ln_before();

}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_Query(){

  if(fn_trim(txt_custnm.value)==""){
		alert("성명은 조회 필수 항목입니다.");
		return;
	}

	gcds_data.DataID = "<%=dirPath%>/servlet/sales.em.EmPopup_S?"
											+"v_str1="+ txt_custnm.value
											+"&v_str2="+ txt_custid.value
											+"&v_str3="+ txt_nationcd.value;
	gcds_data.Reset();

}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_before(){

	//국적  SY005
	gcds_cm020.DataID="<%=dirPath%>/servlet/sales.em.Em010_Cm020?v_str1=SY005";
	gcds_cm020.Reset();

}
/*----------------------------------------------------------------------------
 Description : 팝업
----------------------------------------------------------------------------*/
function ln_Nation(){

		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "../popup/em_nation.jsp";
		strPos = "dialogWidth:380px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
      // gcds_data00.addrow();
			arrParam = arrResult.split(";");
			txt_nationcd.value=arrParam[0];
			txt_nationnm.value=arrParam[1]
		}
}

/*----------------------------------------------------------------------------
 Description : 창닫기
----------------------------------------------------------------------------*/
function ln_Close(e) {
 if (e=="A") {
  var row = gcds_data.rowposition;
  window.returnValue =  gcds_data.namevalue(row,"CUST_NM") + ";"+ gcds_data.namevalue(row,"CUST_SID");
  window.close();
 } else {
  window.close();
 }
}
/*----------------------------------------------------------------------------
 Description : 창닫기
----------------------------------------------------------------------------*/
function ln_select() {

 if (gcds_data.countrow>=1) {
  var row = gcds_data.rowposition;
   window.returnValue =  gcds_data.namevalue(row,"CUST_NM")
									+ ";"+ gcds_data.namevalue(row,"CUST_SID")
									+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
									+ ";"+ gcds_data.namevalue(row,"SEX")
									+ ";"+ gcds_data.namevalue(row,"PASS_NO")
									+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
									+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
									+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
									+ ";"+ gcds_data.namevalue(row,"TEL_NO")
									+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
									+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
									+ ";"+ gcds_data.namevalue(row,"USTS")
									+ ";"+ gcds_data.namevalue(row,"ENG_NM");
  window.close();
 } else {
  window.close();
 }
}
</script>
<!-----------------------------------------------------------------------------
  DataSet Components(DS) 선언 시작
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- 민족 -->
<comment id="__NSID__"><OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" value="+COM_SNAME">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
     D A T A S E T   C O M P O N E N T' S
  M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.CHK="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.CHK="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
	alert("검색된 데이터가 없습니다.");
	}
</script>

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>

	if (gcds_data.countrow>=1) {
		 var row = gcds_data.rowposition;
		 window.returnValue =  gcds_data.namevalue(row,"CUST_NM") 
										+ ";"+ gcds_data.namevalue(row,"CUST_SID")
										+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
										+ ";"+ gcds_data.namevalue(row,"SEX")
										+ ";"+ gcds_data.namevalue(row,"PASS_NO")
										+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
										+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
										+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
										+ ";"+ gcds_data.namevalue(row,"TEL_NO")
										+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
										+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
										+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
										+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
										+ ";"+ gcds_data.namevalue(row,"USTS")
										+ ";"+ gcds_data.namevalue(row,"ENG_NM");
		window.close();
 }
</script>


<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table cellpadding="0" cellspacing="0" border="0" width="620" height="390">
	<tr height="5"><td>&nbsp;</td></tr>
	<tr height="25">
		<td><b>&nbsp;[근로자 정보]</b></td>
			<td align="right">
			<img src="<%=dirPath%>/Sales/images/p_find.gif"    	style="cursor:hand" onclick="ln_Query()">
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"   	style="cursor:hand" onclick="ln_Close()">
			<img src="<%=dirPath%>/Sales/images/p_select.gif"   	style="cursor:hand" onclick="ln_select()">&nbsp;
		</td>
	</tr>
	<tr height="25">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:610px;height:25px;font-size:12px;" bgcolor="#708090">
				<tr>
          <td align="center" bgcolor="#eeeeee" width="50px">성명</td>
					<td  bgcolor="#FFFFFF" width="150px;"><input type="text" id="txt_custnm" name="txt_custnm" style="position:relative;left:5px;width:100px;" onkeydown="if(event.keyCode==13)ln_Query();">
					</td>
					<td align="center" bgcolor="#eeeeee">사업자ID</td>
					<td  bgcolor="#FFFFFF"><input type="text" id="txt_custid" name="txt_custid" style="position:relative;left:5px;width:70px;" maxlength="10"></td>
					<td align="center" bgcolor="#eeeeee" width="50px">국가</td>
					<td  bgcolor="#FFFFFF">
						<input type="text"   id="txt_nationnm" name="txt_nationnm" style="position:relative;width:120px;top:-2px;left:7px;">
						<input type="hidden" id="txt_nationcd" name="txt_nationcd" >
						<img src="<%=dirPath%>/Sales/images/help.gif"	style="position:relative;top:2px;cursor:hand"  onclick="ln_Nation()">
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td colspan="2" valign="top"><br>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:610px;height:260px;" bgcolor="#708090">
				<tr >
					<td valign="top" bgcolor="#FFFFFF" width="610px" >
							<comment id="__NSID__">
							<OBJECT id=gcgd_disp  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="position:relative;left:0px;width:612px;height:240px;font-size:12px;">
							<param name=DataID					value=gcds_data>
							<param Name=BorderStyle			value=0> 
							<param name=indwidth				value=0>
							<param name=Editable				value=false>
							<param name=fillarea				value=true>
							<param name=colsizing				value=true>
							<param name=UsingOneClick		value=true>
							<param name=TitleHeight			value=30>
							<param name=format					value='
							<F> Name=NO				ID={CurRow}	HeadAlign=Center HeadBgColor=#B9D4DC Width=26,	align=right </F> 
							<FC>ID=CUST_NM					,	Name="한글성명	",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center </FC>
							<FC>ID=CUST_SID				,	Name="고객SID		",  width=55,	 HeadBgColor=#B9D4DC,	HeadAlign=center </FC>
							<FC>ID=BIRTHDAY				,	Name="생년월일	",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center,Mask="XXXX/XX/XX" </FC>
							<FC>ID=SEX					,		Name="성별			",  width=35,	 HeadBgColor=#B9D4DC,	HeadAlign=center ,align=center ,Value={IF(SEX="M","남","여")}</FC>
							<C>ID=PASS_NO					,	Name="여권번호	",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							<C>ID=PASS_EXPIRE_DATE,	Name="여권;만기일", width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center,Mask="XXXX/XX/XX" </C>
							<C>ID=N_CARD_NO				,	Name="방북증번호",  width=100,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							<C>ID=COUNTRY_CD			,	Name="국가;코드	",  width=35,	 HeadBgColor=#B9D4DC,	HeadAlign=center ,align=center</C>
							<C>ID=TEL_NO					,	Name="자택전화	",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							<C>ID=MOBILE_NO				,	Name="핸드폰		",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							<C>ID=ZIP_CD					,	Name="우편번호	",  width=50,	 HeadBgColor=#B9D4DC,	HeadAlign=center Mask="XXX-XXX"</C>
							<C>ID=ADDRESS1				,	Name="주소1			",  width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							<C>ID=ADDRESS2				,	Name="주소2			",  width=170,	 HeadBgColor=#B9D4DC,	HeadAlign=center </C>
							'>
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="width:612;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
							</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
<!-- </body>
</html> -->
