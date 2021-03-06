<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	복지카드조회
+ 프로그램 ID	: P050011.HTML
+ 기 능 정 의	: 조회,출력
+ 변 경 이 력	: 
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>복지카드조회</title>
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
//get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2);
var gs_userid = gusrid;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


  gcem_settdt.text = gs_date;
	ln_SetHeader();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
		var date = fn_trim(gcem_settdt.text);
		var nmk  = fn_trim(gcem_empno.text);
		var head1 = fn_trim(txt_head.value);
		var div1  = fn_trim(txt_div.value);
		var dept1 = fn_trim(txt_dept.value);

		gcds_data.UseChangeInfo = "true"; 
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>P050011_s1?"
																															+"v_str1="+date
																															+"&v_str2="+nmk
																															+"&v_str3="+head1
																															+"&v_str4="+div1
																															+"&v_str5="+dept1;

		gcds_data.Reset();

}
/******************************************************************************
	Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel(){
var szPath = "C:\\Test\\Test.xls";
	if (gcds_data.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_disp.GridToExcel('복지카드내역','',1);
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 사원조회 
******************************************************************************/
function ln_FindEmp(){

	var arrSend	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrSend[0]="H050005";
	strURL = "./H030003_popup.jsp";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
			txt_empnmk.value = arrParam[0]; //성명
			gcem_empno.text = arrParam[1];  //사번
	} else {
		txt_empnmk.value = "";
		gcem_empno.text = "";
	}
}
/******************************************************************************
	Description : 소속조회 
******************************************************************************/
function ln_Finddiv(e1,e2){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Hcdept_popup2.jsp";
	arrParam[0]=eval(e1).text;
	arrParam[1]=eval(e2).value;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e1).text  = arrParam[0];
		eval(e2).value = arrParam[1];
	} else {
		eval(e1).text  = ""
		eval(e2).value = ""
	}
}


/******************************************************************************
	Description : 선조회조건
******************************************************************************/
function ln_Before(){

}

/******************************************************************************
	Description : 헤더생성
******************************************************************************/
function ln_SetHeader(){

}


</script>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="UseChangeInfo"    value="true">
	<PARAM NAME="SubsumExpr"		VALUE="total,2:HEADNM,1:DIVNM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_enddata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
	<!-- <param name="Parameters"	value="v_str1=gs_userid"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_data.realcount(0,CountRow) + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
		 
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("요청하신 작업이 성공적으로 수행되지 못했습니다.");

	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/P050011_head.jpg"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr> 
    <td colspan=2>
			<table width="876" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=center>
						<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;border:0 solid #708090;border-top-width:1px;border-left-width:1px'>
							<tr>
								<td class="tab11" width="80px" bgcolor="#eeeeee">결제년월</td>
								<td width="0" width="212px" class="tab21" align=LEFT onkeydown="if(event.keyCode==13) ln_Query();"><nobr>&nbsp;
									<comment id="__NSID__">
									<object  id=gcem_settdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
									 <param name=Text					value="">
									 <param name=Alignment     value=0>
									 <param name=Border        value=true>
									 <param name=Format        value="YYYY/MM">
									 <param name=PromptChar    value="_">
									 <param name=BackColor     value="#CCCCCC">
									 <param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_settdt', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
										&nbsp;</td>
										<td class="tab11" width="80px" bgcolor="#eeeeee">성명</td>
										<td class="tab21"  colspan="3" ><nobr>
										<comment id="__NSID__">
										<object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:10px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
											<param name=Text          value="">
											<param name=Alignment	    value=0>
											<param name=Border	      value=True>
											<param name=Format	      value="0000000">
											<param name=PromptChar	  value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
											<param name=ReadOnly      value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:3px;top:2px;" onclick="ln_FindEmp()" >
										<input id="txt_empnmk" type="text" class="txt21" style="position:relative;left:5px;top:-3px;width:70px;"  ReadOnly> 
									</nobr>
							</tr>
							<tr>
								<td class="tab11" style="" bgcolor="#eeeeee">본부</td>
								<td class="tab21" ><nobr>
									<comment id="__NSID__"><object  id=gcem_head classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:10px;top:3px">
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:3px;top:2px;" onclick="ln_Finddiv(gcem_head,txt_head)" > <nobr>
										<input type="hidden" width="0" id="txt_head" name="txt_head">
									<!-- <comment id="__NSID__"><object  id=gcem_headcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="####">
										<param name=PromptChar	value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script> -->
								</td> 
								<td class="tab11" style="" bgcolor="#eeeeee">부서</td>
								<td class="tab21" ><nobr>
									<comment id="__NSID__"><object  id=gcem_div classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:10px;top:3px">
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:3px;top:2px;" onclick="ln_Finddiv(gcem_div,txt_div)" >
										<input type="hidden" width="0" id="txt_div" name="txt_div">
								</td>
								<td class="tab11" width="80px" style=" bgcolor="#eeeeee">팀</td>
								<td class="tab21" width="212px" ><nobr>
									<comment id="__NSID__"><object  id=gcem_dept classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:80px;height:20px;position:relative;left:10px;top:3px">
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;
									 <img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:3px;top:2px;" onclick="ln_Finddiv(gcem_dept,txt_dept)" > 
										<input type="hidden" width="0" id="txt_dept" name="txt_dept">
									</td>
								</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>  
  </tr>
  <tr> 
    <td colspan="2" align=center valign=center> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=center>
						<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;top:2px;">
							<tr> 
								<td style="width:876" align=center>
									<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
										style="width:876px;height:437px;border:1 solid #777777;z-index:2;">
										<PARAM NAME="DataID"				VALUE="gcds_data">
			              <PARAM NAME="Editable"			VALUE="True">
						        <PARAM NAME="BorderStyle"		VALUE="0">
										<PARAM NAME="Indwidth"			VALUE="0">
										<param name="Fillarea"			VALUE="true">
										<PARAM NAME="SortView"			VALUE="left">
										<PARAM NAME="ColSizing"			VALUE="true">
									  <PARAM NAME="Format"				VALUE="  
									  <FC> Name='CurLevel'			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,		           bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true Value={CurLevel}  show=false</FC>
										<FC> Name='본부'				ID=HEADNM		HeadAlign=Center HeadBgColor=#B9D4DC width=80 align=left,    bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true, suppress=2  Value={Decode(CurLevel,2,'본부계',9999,'총계',0,HEADNM)}</FC>
										<FC> Name='부서'				ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=left,   bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true , suppress=1 Value={Decode(CurLevel,1,'소계',0,DIVNM)}</FC> 
										<FC> Name='팀'					ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true </FC>
										<FC> Name='성명'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left,		 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true </FC>
										<C> Name='승인일자'			ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,  bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, edit=none,  Mask=XXXX-XX-XX, sort=true </C>
										<C> Name='사용액'				ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=Right,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true </C>
										<C> Name='가맹점'				ID=MEMBER		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left,   bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true </C>
										<C> Name='구분'		      ID=TAXGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left,		 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,EditStyle=Combo Data='N:과세,Y:비과세' sort=true </C>
										<C> Name='매출확정일자'	ID=SALEDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, Mask=XXXX-XX-XX, sort=true </C>
										<C> Name='결제일자'			ID=SETTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, Mask=XXXX-XX-XX, sort=true </C>
										<C> Name='일련번호(false)' ID=SEQID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true, show=false </C>
										<C Name='일련번호'			ID= SEQID1		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true, Value={String(SEQID)} </C>										
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<fieldset style="width:876px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
									</fieldset>
                </td>
       					<td style="padding-left:3px;">

								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
		</td>
	</tr>
</table>



<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>