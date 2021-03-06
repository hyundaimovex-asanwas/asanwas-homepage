<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  반출주문조회
+ 프로그램 ID	: TR00104.HTML
+ 기 능 정 의	: 반출배정관리
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

	var gs_userid = gusrid;
	
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

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

	gcem_eff_date.text='20060301';
	gcem_exp_date.text=gs_date;

	
 //구분[검색]
	gcds_class_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0021"; 
	gcds_class_fr.Reset();

	//구간코드 상차지[검색]
	gcds_section_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; 
	gcds_section_fr.Reset();

	//구간코드 하차지[검색]
	gcds_section2_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; 
	gcds_section2_fr.Reset();

 //적재구분
	gcds_logis_type_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0024"; 
	gcds_logis_type_fr.Reset();

	//차량정보
	gcds_logis_unit_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_cartype";
	gcds_logis_unit_fr.Reset();

	//프로젝트[검색]
	gcds_line_part.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_line_part.Reset();

	//구분
	gcds_class.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0021"; 
	gcds_class.Reset();

	//구간코드 상차지
	gcds_section.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; 
	gcds_section.Reset();

	//구간코드 하차지
	gcds_section2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007"; 
	gcds_section2.Reset();

	//물품코드(화물)
	gcds_artc_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00508_popup_s1?v_str1="; 
	gcds_artc_cd.Reset();

	//적재구분
	gcds_logis_type.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0024"; 
	gcds_logis_type.Reset();

	//화폐
	gcds_currency.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0022"; 
	gcds_currency.Reset();

	//차량운행종류
	gcds_car_class.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0024"; 
	gcds_car_class.Reset();

	//차량정보
	gcds_logis_unit.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>com_cartype";
	gcds_logis_unit.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  var str1 = gclx_class_fr.BindColVal;             //구분
	var str2 = txt_section_fr.value;                 //상차지
	var str3 = txt_section2_fr.value;                //하차지
	var str4 = gclx_logis_type_fr.BindColVal;        //적재구분
	var str5 = gclx_logis_unit_fr.BindColVal;				 //차량종류

 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00508_s1?"
									 + "v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5;
	gcds_data.Reset();

	//ln_Enable(t);
	ln_Format(1);
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.AddRow();
	//ln_Enable(t);

	ln_Format(1);

	gcem_eff_date.text=gs_date.substring(0,4)+'0101';
	gcem_exp_date.text=gs_date.substring(0,4)+'1231';

}

/******************************************************************************
	Description : 저장
******************************************************************************/
/*function ln_Save(){
	if (gcds_data.IsUpdated) {
		if (confirm("해당 입력정보를 저장하겠습니까 ?")) {
			for (var i=1; i<=gcds_data.countrow; i++){
				if (gcds_data.sysStatus(i)!=0) {
					if (gcds_data.sysStatus(i)==1) gcds_data.namevalue(i,"CREATE_USR") = gusrid;
					gcds_data.namevalue(i,"UPDATE_USR") = gusrid;
				}
			}

 	    gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00508_t3";
			gctr_data.post();
		}
	}
}
*/
function ln_Save(){
	if (gcds_data.IsUpdated){
				//if(ln_Chk()){
		//prompt('',gcds_data.Text) ;
				if (confirm("저장하시겠습니까?")){	
					//prompt('',gcds_data.Text) ; 
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00508_t1?";
					gctr_data.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid;		
					gctr_data.post();
	
		//	}
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
	Description : 물품코드 찾기
******************************************************************************/
function ln_Popup(){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Transfer/html/TR00508_popup.html";
	strPos = "dialogWidth:395px;dialogHeight:389px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		//gcds_data.NameValue(gcds_data.Rowposition,"MINORCD")  = arrParam[0];

		gcem_artc_cd.text = arrParam[0];
//alert(arrParam[0]);
		txt_artc_cd.value = arrParam[1];
//alert(arrParam[1]);
		
//} else {
//		gcem_artc_cd.text = "";
//		txt_artc_cd.value ="";
	
	}
}
/******************************************************************************
	Description : 페이지 사용유무
******************************************************************************/
function ln_Format(e){
	if (gcds_data.sysStatus(e)=="1") {	//등록
		txt_chargecode.disabled	= false;
	
	} else {
		
		txt_chargecode.disabled	= true;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 프로젝트 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_line_part classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 구분 [검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_class_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 구간코드 상차지[검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_section_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 구간코드 하차지 [검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_section2_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 적재구분 [검색]-->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_logis_type_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>


<!-- 차량 정보 [검색] -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_logis_unit_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>


<!-- 구분 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_class classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 구간코드 상차지 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_section classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 구간코드 하차지 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_section2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 물품코드(화물) -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_artc_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 적재구분 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_logis_type classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 화폐단위 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_currency classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 차량운행종류 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_car_class classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- 차량 정보 -->
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_logis_unit classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00508_t1">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00508_t1(I:USER=gcds_data)">
</OBJECT><%=HDConstant.COMMENT_END%>  
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
	ft_cnt.innerText = "조회건수 : 총 ( " + row + " ) 건";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onRowPoschanged(row)">
	if (gcds_data.sysStatus(row)=="1") txt_chargecode.readOnly = false;
	else txt_chargecode.readOnly = true;
</script>

 <script language=JavaScript for=gcem_rqst_price event=onKeyUp(kcode,scode)>
		//alert("Key : " + kcode);
</script> 

	<script language=JavaScript for=gcem_unit_price event=OnKillFocus()> 
	//alert("adad") ; 
		var ls_amt = gcem_unit_price.Text ; 
		var ls_amtt = 0 ; 
	
		//alert(ls_amt*1 + ls_amt*10/100) ; 
		gcem_rqst_price.Text= ls_amt*1 + ls_amt*10/100  ;
		ls_amtt =  gcem_rqst_price.Text ; 
		gcem_rqst_price2.Text = ls_amtt*1 + ls_amtt*10/100 ;
		
		//gcem_rqst_price2.Text = gcem_rqst_price.Text ;

	</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- 프로젝트 -->
<script language="javascript" for="gcds_line_part" event="onloadCompleted(row,colid)">
	gcds_line_part.InsertRow(1);
	gcds_line_part.NameValue(1,"MINORCD")="";
	gcds_line_part.NameValue(1,"MINORNM")="전체";
	gclx_line_part.index=0;
</script>

<!-- 구분 -->
<script language="javascript" for="gcds_class_fr" event="onloadCompleted(row,colid)">
	gcds_class_fr.InsertRow(1);
	gcds_class_fr.NameValue(1,"MINORCD")="";
	gcds_class_fr.NameValue(1,"MINORNM")="전체";
	gclx_class_fr.index=0;
</script>

<!-- 구간코드 상차지 -->
<script language="javascript" for="gcds_section_fr" event="onloadCompleted(row,colid)">
	gcds_section_fr.InsertRow(1);
	gcds_section_fr.NameValue(1,"MINORCD")="";
	gcds_section_fr.NameValue(1,"MINORNM")="전체";
	//gclx_section_fr.index=0;
</script>

<!-- 구간코드 하차지 -->
<script language="javascript" for="gcds_section2_fr" event="onloadCompleted(row,colid)">
	gcds_section2_fr.InsertRow(1);
	gcds_section2_fr.NameValue(1,"MINORCD")="";
	gcds_section2_fr.NameValue(1,"MINORNM")="전체";
	//gclx_section2_fr.index=0;
</script>

<!-- 적재구분 [검색] -->
<script language="javascript" for="gcds_logis_type_fr" event="onloadCompleted(row,colid)">
	gcds_logis_type_fr.InsertRow(1);
	gcds_logis_type_fr.NameValue(1,"MINORCD")="";
	gcds_logis_type_fr.NameValue(1,"MINORNM")="전체";
	gclx_logis_type_fr.index=0;
</script>

<!-- 차량 정보 -->
<script language="javascript" for="gcds_logis_unit_fr" event="onloadCompleted(row,colid)">
	gcds_logis_unit_fr.InsertRow(1);
	gcds_logis_unit_fr.NameValue(1,"CAR_TYPE")="";
	gcds_logis_unit_fr.NameValue(1,"CAR_NAME")="전체";
	gclx_logis_unit_fr.index=0;
</script>


<!-- 구분 -->
<script language="javascript" for="gcds_class" event="onloadCompleted(row,colid)">
	gcds_class.InsertRow(1);
	gcds_class.NameValue(1,"MINORCD")="";
	gcds_class.NameValue(1,"MINORNM")="전체";
	gclx_class.index=0;
</script>

<!-- 구간코드 상차지 -->
<script language="javascript" for="gcds_section" event="onloadCompleted(row,colid)">
	gcds_section.InsertRow(1);
	gcds_section.NameValue(1,"MINORCD")="";
	gcds_section.NameValue(1,"MINORNM")="전체";
	gclx_section.index=0;
</script>

<!-- 구간코드 하차지 -->
<script language="javascript" for="gcds_section2" event="onloadCompleted(row,colid)">
	gcds_section2.InsertRow(1);
	gcds_section2.NameValue(1,"MINORCD")="";
	gcds_section2.NameValue(1,"MINORNM")="전체";
	gclx_section2.index=0;
</script>

<!-- 적재구분 -->
<script language="javascript" for="gcds_logis_type" event="onloadCompleted(row,colid)">
	gcds_logis_type.InsertRow(1);
	gcds_logis_type.NameValue(1,"MINORCD")="";
	gcds_logis_type.NameValue(1,"MINORNM")="전체";
	gclx_logis_type.index=0;
</script>

<!-- 화폐단위 -->
<script language="javascript" for="gcds_currency" event="onloadCompleted(row,colid)">
	gcds_currency.InsertRow(1);
	gcds_currency.NameValue(1,"MINORCD")="";
	gcds_currency.NameValue(1,"MINORNM")="전체";
	gclx_currency.index=0;
</script>

<!-- 차량운행종류 -->
<script language="javascript" for="gcds_car_class" event="onloadCompleted(row,colid)">
	gcds_car_class.InsertRow(1);
	gcds_car_class.NameValue(1,"MINORCD")="";
	gcds_car_class.NameValue(1,"MINORNM")="전체";
	gclx_car_class.index=0;
</script>

<!-- 차량 정보 -->
<script language="javascript" for="gcds_logis_unit" event="onloadCompleted(row,colid)">
	gcds_logis_unit.InsertRow(1);
	gcds_logis_unit.NameValue(1,"CAR_TYPE")="";
	gcds_logis_unit.NameValue(1,"CAR_NAME")="전체";
	gclx_logis_unit.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data.reset();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
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
    <td ><img src="../img/TR00508_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif">
			<img src="../../common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="../../common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="../../common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    <img src="../../common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign=top colspan=2>
      <table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
				<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">구분</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_class_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_class_fr">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^114">
								<param name=BindColumn			value=MINORCD>
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 

					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">상차지</td>
					 <td class="tab21"> 
						 <input type="text" class="txt11" id="txt_section_fr" style="width:130px;height:18px;IME-MODE: active"
					onkeydown="if(event.keyCode==13) ln_Query();">
								<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gclx_section_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_section_fr">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORCD^0^50,MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%> -->
						
						</td>

					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">하차지</td>
					<td class="tab21">
						<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gclx_section2_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_section2_fr">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORCD^0^50,MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%> -->
									 <input type="text" class="txt11" id="txt_section2_fr" style="width:100px;height:18px;IME-MODE: active"
					onkeydown="if(event.keyCode==13) ln_Query();"></td> 
				</tr>
			 	<tr> 
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">적재구분</td>
					<td class="tab21" style="width:200px;">&nbsp;
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_logis_type_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_logis_type_fr">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
						</td> 

	
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">차량종류</td>
					<td class="tab21"> 
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_logis_unit_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=130 style="position:relative;top:1px;left:8px;" class="txtbox">
										<param name=ComboDataID			value="gcds_logis_unit_fr">
										<param name=SearchColumn		value="car_name">
										<param name=BindColumn      value="car_type">
										<param name=Index			      value="0">
										<param name=ListExprFormat	value="car_name^0^120">
										<param name=Index						value="0">
									</OBJECT><%=HDConstant.COMMENT_END%>
						 </td>
					<td class="tab21" align=center bgcolor="#eeeeee" style="width:100px;height:25px;">&nbsp;</td>
					<td class="tab21">&nbsp;</td>
				</tr>  
			</table>
		</td>
	</tr>
  <tr> 
    <td colspan="2"> 

      <table width="867" style="position:relative;left:0px;width:866px;top:3px;border:0" cellpadding="1" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:503px; height:404px; border:1 solid #708090" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="sortview"		VALUE="left">
							<Param Name="Editable"    VALUE="false"> 
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='운송코드'			  ID=CHARGECODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left</C>
								<G> Name='적용구분'       HeadAlign=Center, HeadBgColor=#B9D4DC
								<C> Name='시작일자'	   	  ID=EFF_DATE  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center, Mask='XXXX/XX/XX'</C> 
								<C> Name='종료일자'		    ID=EXP_DATE		    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center, Mask='XXXX/XX/XX'</C>
								</G>
								<C> Name='프로젝트'	      ID='LINE_PART' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left, Editstyle='lookup', Data='gcds_line_part:minorcd:minornm'</C>
								<C> Name='구분'			      ID='CLASS'  			HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center
								Editstyle='lookup' Data='gcds_class:minorcd:minornm' </C> 
								<C> Name='상차지'	        ID='SECTION'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left
								Editstyle='lookup' Data='gcds_section:minorcd:minornm'</C> 
								<C> Name='하차지'	        ID='SECTION2'			HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left
								Editstyle='lookup' Data='gcds_section2:minorcd:minornm'</C>
								<C> Name='물품코드(화물)'	ID='ARTC_CD'  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left
								Editstyle='lookup' Data='gcds_artc_cd:minorcd:minornm' Show=False</C>
								<C> Name='적재구분'			  ID='LOGIS_TYPE'   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center, Editstyle='lookup', Data='gcds_logis_type:minorcd:minornm'</C>
								<C> Name='차량종류'			  ID='LOGIS_UNIT'   HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center, Editstyle='lookup', Data='gcds_logis_unit:car_type:car_name'</C>
								<C> Name='단가'	          ID='UNIT_PRICE'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right</C>
								<C> Name='청구단가'			  ID='RQST_PRICE'   HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right</C>
								<C> Name='청구단가_VAT'	  ID='RQST_PRICE2'  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=right</C>
								<C> Name='청구퍼센트'			ID='RQST_PRCNT'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right</C>
								<C> Name='화폐단위'		    ID='CURRENCY' 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left,
								Editstyle='lookup', Data='gcds_currency:minorcd:minornm'</C>
								<C> Name='차량운행종류'	  ID='CAR_CLASS'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center, Editstyle='lookup', Data='gcds_car_class:minorcd:minornm'</C>
								<C> Name='취소기준1'			ID='CANCLE1'      HeadAlign=Center HeadBgColor=#B9D4DC Width=85		align=right</C>
								<C> Name='취소기준2'			ID='CANCLE2'      HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right</C>
																
							">
            </OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:505px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:370px; border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<tr>
								<td class="tab21" style="width:90px;height:25px;" bgcolor="#eeeeee">&nbsp;운송코드</td>
								<td class="tab21" colspan="3"><input type="text" class="txt11" id="txt_chargecode" style="width:100px;height:20px;"></td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;적용일자</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_eff_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:4px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_eff_date', 'Text');"> ~ 
								<%=HDConstant.COMMENT_START%><OBJECT id=gcem_exp_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:6px;top:3px;height:20;width:70" >
											<param name=Alignment			value=1>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;<img src="../img/btn_calendar.gif" style="position:relative; left:6px;top:1px;cursor:hand" onclick="__GetCallCalendar('gcem_exp_date', 'Text');">
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;프로젝트</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_line_part classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
											<param name=ComboDataID			value="gcds_line_part">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^160">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;구분</td>
								<td class="tab21" colspan="3">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_class classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_class">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^114">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;상차지</td>
								<td class="tab21" colspan="3">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_section classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_section">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gclx_section classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;left:8px;" class="txtbox">
										<param name=CBData			   value="1^사용,2^미사용">
										<param name=CBDataColumns	 value="code,name">
										<param name=SearchColumn	 value="name">
										<param name=ListExprFormat value="name">								
										<param name=BindColumn		 value="code">
										<param name=Index			     value="0">
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							 </tr>
							<tr> 
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;하차지</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_section2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_section2">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<!--<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;물품코드</td>
								<td class="tab21" colspan="3" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_artc_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:84px;height:20px;position:relative;left:8px;top:2px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Numeric       value=false>
														<param name=Format        value="######">
														<param name=PromptChar    value="">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=Enable	      value="false">
									</OBJECT><%=HDConstant.COMMENT_END%>
									<img src="../img/btn_find.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_Popup();" > 
									<input id="txt_artc_cd" type="text" class="txt11"  style= "width:100px;height:20px;top:-2px" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
								</td>
							</tr>-->
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;적재구분</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_logis_type classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_logis_type">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;차량종류</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_logis_unit classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;top:2px;left:8px;" class="txtbox">
										<param name=ComboDataID			value="gcds_logis_unit">
										<param name=SearchColumn		value="car_name">
										<param name=BindColumn      value="car_type">
										<param name=Index			      value="0">
										<param name=ListExprFormat	value="car_name^0^120">
										<param name=Index						value="0">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;단가</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_unit_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
										<param name=Alignment			value=2>
										<param name=MaxDecimalPlace		value=5>
										<param name=Enable				value=true>
										<param name=Numeric				value="true">

									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;청구단가</td>
								<td class="tab21" >
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80">
										<param name=Alignment					value=2>
										<param name=MaxDecimalPlace		value=5>
										<param name=Enable							value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;청구단가(VAT포함)</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_price2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							 </tr>
							<tr> 
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;청구단위퍼센트</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_rqst_prcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:2px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=0>
                     <param name=Enable							value=true>
										 <param name=Format             value="###">
										 <param name=PromptChar         value="">
                  </OBJECT><%=HDConstant.COMMENT_END%>&nbsp; %
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;화폐단위</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_currency classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_currency">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;차량운행종류</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gclx_car_class classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_car_class">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^94">
											<param name=BindColumn			value=MINORCD>
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
							</tr>
							<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;취소기준1</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_cancle1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
						
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;취소기준2</td>
								<td class="tab21">
									 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_cancle2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%> 
								</td>
							</tr> 
							<tr>
							<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;취소기준3</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_cancle3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;취소기준4</td>
								<td class="tab21">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_cancle4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
								</tr>
								<tr>
								<td class="tab21" style="height:25px;" bgcolor="#eeeeee">&nbsp;취소기준5</td>
								<td class="tab21" colspan="3">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_cancle5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative;left:8px;top:0px;height:20;width:80" >
										 <param name=Alignment					value=2>
                     <param name=MaxDecimalPlace		value=5>
                     <param name=Enable							value=true>
                  </OBJECT><%=HDConstant.COMMENT_END%>
								</td>
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
		<C>Col=CHARGECODE   Ctrl=txt_chargecode    Param=Value</C>
		<C>Col=EFF_DATE     Ctrl=gcem_eff_date     Param=Text</C>
		<C>Col=EXP_DATE     Ctrl=gcem_exp_date     Param=Text</C>
		<C>Col=LINE_PART    Ctrl=gclx_line_part    Param=BindColVal</C>
		<C>Col=CLASS        Ctrl=gclx_class        Param=BindColVal</C>
		<C>Col=SECTION      Ctrl=gclx_section      Param=BindColVal</C>
		<C>Col=SECTION2     Ctrl=gclx_section2     Param=BindColVal</C>
		<C>Col=ARTC_CD      Ctrl=gcem_artc_cd      Param=Text</C>
		<C>Col=A_CD         Ctrl=txt_artc_cd       Param=Value</C>
		<C>Col=LOGIS_TYPE   Ctrl=gclx_logis_type   Param=BindColVal</C>
		<C>Col=LOGIS_UNIT   Ctrl=gclx_logis_unit   Param=BindColVal</C>

		<C>Col=UNIT_PRICE   Ctrl=gcem_unit_price   Param=Text</C>
		<C>Col=RQST_PRICE   Ctrl=gcem_rqst_price   Param=Text</C>
		<C>Col=RQST_PRICE2  Ctrl=gcem_rqst_price2  Param=Text</C>
		<C>Col=RQST_PRCNT   Ctrl=gcem_rqst_prcnt   Param=Text</C>
		<C>Col=CURRENCY     Ctrl=gclx_currency     Param=BindColVal</C>

		<C>Col=CAR_CLASS    Ctrl=gclx_car_class    Param=BindColVal</C>
		<C>Col=CANCLE1      Ctrl=gcem_cancle1      Param=Text</C>
		<C>Col=CANCLE2      Ctrl=gcem_cancle2      Param=Text</C>
		<C>Col=CANCLE3      Ctrl=gcem_cancle3      Param=Text</C>
		<C>Col=CANCLE4      Ctrl=gcem_cancle4      Param=Text</C>
		<C>Col=CANCLE5      Ctrl=gcem_cancle5      Param=Text</C>
		
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

