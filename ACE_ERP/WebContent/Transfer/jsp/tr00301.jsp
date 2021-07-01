<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:  출입계획관리 - 출입계획검색		
+ 프로그램 ID	:  TR00301.html
+ 기 능 정 의	:  출입계획관리를 조회 하는 화면이다
+ 작   성  자 :  이민정
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

	
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
	var gs_userid = gusrid;
	
	var gs_hisdat = gs_date;
    //var gs_date = '<%=firstday%>';
	//var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);			//트리초기화 호출 [반드시 들어가야 함]

			ln_Start();//선조회

			window.status="완료";

		}
		
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  
	ln_Before();

}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {

	gcem_acc_date_fr.text = gs_date2 + "01";	  //출경일자 from
	gcem_acc_date_to.text = gs_date;						//출경일자 to 

	//프로젝트[검색]
	gcds_project_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_project_cd.Reset();
	
	//물류비 부담[검색]
	gcds_project.DataID = "<%=dirPath%>/servlet/Account.commdtil_s1?v_str1=0030";  
	gcds_project.Reset();

	//출경목적지[검색]
	gcds_sreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_sreach_ciq.Reset();

	//입경목적지[검색]
	gcds_rreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_rreach_ciq.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_project_cd.BindColVal;           //프로젝트
	var str2 = gclx_project.BindColVal;              //물류비 부담
	var str3 = gcem_acc_date_fr.text;                //출경일자 from
	var str4 = gcem_acc_date_to.text;                //출경일자 to
	var str5 = gcem_rtrn_date_fr.text;				 //입경일자 from
	var str6 = gcem_rtrn_date_to.text;				 //입경일자 to
	var str7 = gclx_sreach_ciq.BindColVal;			 //출경목적지
	var str8 = gclx_rreach_ciq.BindColVal;			 //입경목적지
	var str9 = gcem_accessno.text;					 //출입번호
	var str10 = gcem_create_usr.text;				 //입력자
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7+"&v_str8="+str8
										+ "&v_str9="+str9+"&v_str10="+str10;
									 
	gcds_code01.Reset(); 
	
}

/******************************************************************************
	Description : 등록
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
function ln_Delete() {
	
}

/******************************************************************************
	Description : 출력
	parameter   : 
******************************************************************************/
function ln_Print(){
		
}

/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
******************************************************************************/
function ln_Enable(p) {
	
}

/******************************************************************************
	Description : 사원번호 찾기
******************************************************************************/
function ln_Popup(){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Person/html/H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_create_usr.text = arrParam[1];
		txt_create_usr.value = arrParam[0];
} else {
		gcem_create_usr.text = "";
		txt_create_usr.value ="";
		
	}
}

/******************************************************************************
	Description : 출입계획 생성
******************************************************************************/
function ln_Create(){

	if (gcds_code01.countrow<1) return;

	var row = gcds_code01.rowposition;

	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s3"
									  + "?v_str1="+gcds_code01.namevalue(row,"ACCESSNO");
	gcds_chk.Reset(); 

	if (gcds_chk.namevalue(1,"CNT")>0) {
		if (confirm("이미 생성된 자료가 있습니다.\n\n자료를 재 생성하시겠습니까?")){
			gcds_cre.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s2?v_str1=" + gcds_code01.namevalue(row,"ACCESSNO");
			gcds_cre.Reset();
		}
	} else{
		if (confirm("자료를 생성하시겠습니까?")){
			gcds_cre.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s2?v_str1=" + gcds_code01.namevalue(row,"ACCESSNO");
			gcds_cre.Reset();
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 프로젝트 -->
<OBJECT id=gcds_project_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 물류비 부담 -->
<OBJECT id="gcds_project" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 출경목적지 -->
<OBJECT id="gcds_sreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 입력목적지 -->
<OBJECT id="gcds_rreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 출입계획 수정여부 -->
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 출입계획 생성 -->
<OBJECT id="gcds_cre" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-- 프로젝트 -->
<script language="javascript" for="gcds_project_cd" event="onloadCompleted(row,colid)">
	gcds_project_cd.InsertRow(1);
	gcds_project_cd.NameValue(1,"MINORCD")="";
	gcds_project_cd.NameValue(1,"MINORNM")="전체";
	gclx_project_cd.index=0;
</script>

<!-- 물류비 부담 -->
<script language="javascript" for="gcds_project" event="onloadCompleted(row,colid)">
	gcds_project.InsertRow(1);
	gcds_project.NameValue(1,"CDCODE")="";
	gcds_project.NameValue(1,"CDNAM")="전체";
	gclx_project.index=0;
</script>

<!-- 출경목적지 -->
<script language="javascript" for="gcds_sreach_ciq" event="onloadCompleted(row,colid)">
	gcds_sreach_ciq.InsertRow(1);
	gcds_sreach_ciq.NameValue(1,"MINORCD")="";
	gcds_sreach_ciq.NameValue(1,"MINORNM")="전체";
	gclx_sreach_ciq.index=0;
</script>

<!-- 입경목적지 -->
<script language="javascript" for="gcds_rreach_ciq" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";   
	document.all.LowerFrame.style.visibility="hidden";      //마지막으로 로딩되는것은 hidden으로
	gcds_rreach_ciq.InsertRow(1);
	gcds_rreach_ciq.NameValue(1,"MINORCD")="";
	gcds_rreach_ciq.NameValue(1,"MINORNM")="전체";
	gclx_rreach_ciq.index=0;
</script> 

<script language="javascript" for="gcds_cre" event="onloadCompleted(row,colid)">
	alert("출입계획자료가 정상적으로 생성되었습니다.");
</script> 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	var sUrl = "../../Transfer/html/TR00302.html"+
						 "?gstr="+gcds_code01.NameValue(row,"ACCESSNO") + 
						 "&" + gcds_code01.NameValue(row,"S_DATE").substring(0,20) +
						 "&" + gcds_code01.NameValue(row,"R_DATE").substring(0,20); 
	window.location.href = sUrl;

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

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
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../../Common/img/btn/com_b_create_trs.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Create()">
			<img src="../../../Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
				 <td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >프로젝트</td>
					<td class="tab21" >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_project_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project_cd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >물류비 부담</td>
						<td class="tab21" >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_project classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn			value=CDNAM>
								<param name=Sort							value=false>
								<param name=ListExprFormat			value="CDNAM^0^180">
								<param name=BindColumn				value=CDCODE>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">출경일자</td> 
					 <td  class="tab21" width="180px;" > 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_acc_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:5px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;~&nbsp;
           				<%=HDConstant.COMMENT_START%>
           				<OBJECT id=gcem_acc_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">입경일자</td> 
				  	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt;" width="180px;" > 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_rtrn_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:5px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;
			
           				<%=HDConstant.COMMENT_START%>
           				<OBJECT id=gcem_rtrn_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						</td> 
					<tr>
						 <td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" align=center >출경목적지</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; ">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_sreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_sreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" align=center >입경목적지</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; ">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_rreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_rreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat		value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" align=center >출입번호</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_accessno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:78px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							</td>
							<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" align=center >입력자</td>
						 	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:굴림;font-size:9pt; " >

					 		<%=HDConstant.COMMENT_START%>
					 		<OBJECT id=gcem_create_usr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:52px;height:20px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						 <img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="입력자를 검색합니다" style="cursor:hand;position:relative;left:6px;top:0px" align=center onclick="ln_Popup();">
							<input id="txt_create_usr" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:70px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
						</td> 
				</tr>
			</table>
		</td>
	</tr>  
							
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:3px;width:280px;border:0 solid #708090;">
		<tr> 			
			<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code01">
						<PARAM NAME="IndWidth"		VALUE ='0'> 
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		VALUE="left">
						<param name="ColSizing"   value="true"> 
						<Param Name="Editable"     value="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F>	Name='생성;여부'	ID='FLAG', width=30 	   	HeadBgColor=#B9D4DC HeadCheckShow=true align=center bgcolor=@acolor </F>
						<F> Name='SEQ'	     	    ID=SEQ 		  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center  Edit=true  
						Value={ToString(CurRow)}</F>
						<C> Name='출입번호'	      ID=ACCESSNO		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	  Edit=none  </C> 
						<C> Name='프로젝트'		    ID=P_CD         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	  Edit=none  
						</C> 
						<G> Name='출경정보'												HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='일시'					  ID=S_DATE 		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center  Edit=none 
						</C> 
						<C> Name='경로'					  ID=A_COURSE		      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	    </C> 
						<C> Name='목적'						ID=PURPOSE    	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=186	align=left    Edit=none  </C>
						<C> Name='목적지'					ID=S_CIQ 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center  Edit=none  </C> 
						<C> Name='인원'						ID=SPERSON_CNT    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right   Edit=none  </C> 
						<C> Name='차량'						ID=SCAR_CNT    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right   Edit=none  </C> 
						<C> Name='비고'						ID=REMARK   HeadAlign=Center HeadBgColor=#B9D4DC Width=173	align=left   Edit=none  </C> 
						</G>
						<G> Name='입경정보' HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='일시'						ID=R_DATE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center   Edit=none </C> 
						<C> Name='경로'						ID=R_COURSE	    		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	    </C> 
						<C> Name='목적'						ID=PP_POSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=186	align=left    Edit=none  </C>
						<C> Name='목적지'					ID=G_CIQ 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center    Edit=none  </C> 
						<C> Name='인원'						ID=RPERSON_CNT     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right    Edit=none  </C> 
						<C> Name='차량'						ID=RCAR_CNT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right    Edit=none  </C> 
						<C> Name='비고'						ID=REMARK 		HeadAlign=Center HeadBgColor=#B9D4DC Width=173	align=left    Edit=none  </C>
						</G>
						<C> Name='입력자'					ID=C_USR       HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left    Edit=none  </C> 
						<C> Name='입력일시'				ID=C_DT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=center    Edit=none
					    </C>
						<C> Name='수정자'					ID=U_UST 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left     Edit=none  </C> 
						<C> Name='수정일시'				ID=U_DT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center    Edit=none  </C>
						">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

