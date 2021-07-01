<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  OMS
+ 프로그램 ID	: TR00202.HTML
+ 기 능 정 의	: 반입주문등록
+ 변 경 이 력	: 정미선
+ 서 블 릿 명	: TR00202.HTML
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
    <Script language="javascript" src="<%=dirPath%>/Transfer/common/include/order.js"></script>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>

<!-- /******************************************************************************
	Description : DataSet 선언
******************************************************************************/ --> 
<%=HDConstant.COMMENT_START%><OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_dump classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT><%=HDConstant.COMMENT_END%> 

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT><%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT><%=HDConstant.COMMENT_END%>  

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name='SyncLoad'              value='true'>  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
	<param name=UseFilter             value="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_samp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc14 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc15 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc16 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_0etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_1etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_2etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_3etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDs_4etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcDsrpt1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>
 
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_project classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad     value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_uplaodtemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad     value="true">  
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문상세-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gcTr03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문차량정보-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gcTr04" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문차량정보-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gcTr05" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터 임시-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gcTr06" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터 임시-->
</OBJECT><%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
var	lb_boolean1 =  false ; 
var PopWinValue = null ; 
var strURL = null ; 
var ls_start = false  ;  

var ls_insert = true ;
var ls_Carinsert =  true ; 
var lf_function  = null ; 
var pack_no =  0 ; 
var saveing = false ; 
var grow = 0;

function ln_RegData00(){

  ln_RegData()
}


	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			window.status="완료";

		}


</SCRIPT>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc2) ; 
	DLVL_TYPE.index = 0; 
</script> 

<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc3) ; 
	CARGO_TYPE.Index = 0 ; 
</script>

<script language=JavaScript for=CARGO_TYPE event=OnSelChange()>
	var ls_type = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);

	if( ls_type =="0002")	{
		LD_CAR.index = LD_CAR.IndexOfColumn("MINORCD", "0001");
		DLVL_TYPE.index = 1;
		LD_CAR.Enable = false;
		LDCARGONM.value = "";
		LDCARGONM.disabled = true;
		tab_car.style.display = "none";
		ln_DispGrid(strim(ls_type));

		var ls_dlvl = DLVL_TYPE.ValueOfIndex("MINORCD", DLVL_TYPE.index);
		if (ls_dlvl=="0001") tr_att_file.style.display = "none";
		else {
			ft_fname.innerText = "첨부약도";
			tr_att_file.style.display = "";
		}

	} else	if( ls_type =="0003" ||  ls_type == "0004" )	{
		LD_CAR.index = LD_CAR.IndexOfColumn("MINORCD", "0001");
		cargoType.style.display= ""; 
		LD_CAR.Enable = true;
		LDCARGONM.disabled = false;
		tab_car.style.display = "";
		ln_DispGrid(strim(ls_type));

		var ls_dlvl = DLVL_TYPE.ValueOfIndex("MINORCD", DLVL_TYPE.index);
		if (ls_dlvl=="0001") ft_fname.innerText = "등록증첨부";
		else if (ls_dlvl=="") ft_fname.innerText = "등록증첨부";
		else ft_fname.innerText = "등록증&약도첨부";

		tr_att_file.style.display = "";

	} else {
		cargoType.style.display= "none"; 
		LD_CAR.Enable = true;
		LDCARGONM.disabled = false;
		tab_car.style.display = "";
		ln_DispGrid(strim(ls_type));

		var ls_dlvl = DLVL_TYPE.ValueOfIndex("MINORCD", DLVL_TYPE.index);
		if (ls_dlvl=="0001") tr_att_file.style.display = "none";
		else if (ls_dlvl=="") tr_att_file.style.display = "none";
		else {
			ft_fname.innerText = "첨부약도";
			tr_att_file.style.display = "";
		}
	}
</script> 

<script language=JavaScript for=LINE_PART event=OnSelChange()>
	if( LINE_PART.index != 0 && DLVL_TYPE.index == 0 ) locationSetting() ;   
	if( LINE_PART.index != 0 && DLVL_TYPE.index != 0 ) locationSetting2() ;   

	gcDs_etc10.Filter();
</script>

<script language=JavaScript for=gcDs_etc10 event=onFilter(row)>
	if (gcDs_etc10.NameValue(row,"LINE_PART") == LINE_PART.BindColVal) return true;
	else return false;
</script>

<script language=JavaScript for=gcDs_etc10 event=OnRowsetChanged()>
	if (gcDs_etc10.namevalue(1,"TR_PROJECT")!=""){
		AddChoiceProjct(gcDs_etc10) ; 
		PROJECT.Index = 0 ; 
	} else {
		gcDs_etc10.UndoAll();
	}
</script>

<script language=JavaScript for=DLVL_TYPE event=OnSelChange()>
	if(DLVL_TYPE.index !=2) TX1.value = "입고일자";
	else if(DLVL_TYPE.index == 2) TX1.value = "상차일자"; 

	if( DLVL_TYPE.index != 0 ) locationSetting2();
</script>

<script language=JavaScript for=gcDs_etc6 event=OnLoadCompleted(rowcnt)>
	ARTC_UNIT.Index = 0;
</script> 

<script language=JavaScript for=gcDs_etc7 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc7);
</script>

<script language=JavaScript for=gcDs_etc8 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc8) ;  
	DTL_LD_CAR.index = 0;
</script>
<script language=JavaScript for=gcDs_etc9 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc9) ;  
	DTL_OFF_CAR.index = 0; 
</script>
<script language=JavaScript for=gcDs_etc10 event=OnLoadCompleted(rowcnt)>
	AddChoiceProjct(gcDs_etc10) ; 
	PROJECT.index = 0; 
</script>
<script language=JavaScript for=gcDs_etc11 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc11) ;  
	LD_CAR.index = 0; 
</script>
<script language=JavaScript for=gcDs_etc12 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc12) ;  
	OFF_CAR.index = 0; 
</script>
<script language=JavaScript for=CUST_CD event=OnKillFocus()>  
	CheckCustCd() ; //거래처 코드 
</script>

<script language=JavaScript for=gcTr03 event=OnSuccess()> 
	show_detail('2');	
</script>

<script language=JavaScript for=gcTr05 event=OnSuccess()> 
	if (confirm("입력이 완료되었습니다.\n\n주문을 계속 입력하시겠습니까 ?")) {
		gcDs4.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s2?NOH=Y&gstr1=" + gs_ordno ; 
		gcDs4.Reset();
	} else 	window.location.href="<%=dirPath%>/Transfer/jsp/tr00201.jsp";
</script>
<script language=JavaScript for=gcDs1 event=OnLoadCompleted(rowcnt)>
	if(ls_start == true ) { first_setting() ;  }
	else{ Match_master() ; } 
</script>
<script language=JavaScript for=gcds_data event=OnLoadCompleted(row)>
	if (gcds_data.namevalue(row,"PARM2")=="Y") alert(gcds_data.namevalue(row,"PARM3")+"의 값에 문제가 있습니다.");
	else ExceltoDataSet();
</script> 

<script language=JavaScript for=gcds_data event=OnLoadError()>
	alert("첨부하시려는 주문상세 물품정보에 문제가 있습니다.");
</script> 

<script language=JavaScript for=gcds_dump event=OnLoadCompleted(rowcnt)>
	PutUnitCode() ; 
</script> 

<script language=JavaScript for= LD_CAR event=OnSearchFail()>
	alert("상차지를 다시 선택하십시오 ") ; 
	LD_CAR.index = 0 ; 
</script>

<script language=JavaScript for= OFF_CAR event=OnSearchFail()>
	alert("하차지를 다시 선택하십시오 ") ; 
	OFF_CAR.index = 0 ; 
</script>

<script language=JavaScript for= DTL_LD_CAR event=OnSearchFail()>
	alert("상차지를 다시 선택하십시오 ") ; 
	DTL_LD_CAR.index = 0 ; 
</script>

<script language=JavaScript for= DTL_LD_CAR event=OnKillFocus()>
	if(DTL_LD_CAR.index != 0){
		var rtnVal = DTL_LD_CAR.ShowSearchCol();
	}
</script>

<script language=JavaScript for= DTL_OFF_CAR event=OnSearchFail()>
	alert("하차지를 다시 선택하십시오 ") ; 
   DTL_OFF_CAR.index = 0 ; 
</script>

<script language=JavaScript for= OFF_CAR event=OnKillFocus()>
	if(OFF_CAR.index != 0)
	{var rtnVal = OFF_CAR.ShowSearchCol(); }  
</script>

<script language=JavaScript for= LD_CAR event=OnKillFocus()>
	if(LD_CAR.index != 0)
	{var rtnVal = LD_CAR.ShowSearchCol(); }  
</script>

<script language=JavaScript for= DTL_OFF_CAR event=OnKillFocus()>
	if(DTL_OFF_CAR.index != 0)
	{var rtnVal = DTL_OFF_CAR.ShowSearchCol(); }  
</script>
<script language=JavaScript for=ARTC_CNT event=OnKillFocus()> 
	getPrice();
</script>

<script language=JavaScript for=UNIT_PRICE event=OnKillFocus()> 
	getPrice();
</script>
<script language=JavaScript for=gcTr02 event=OnSuccess()>

	if (gcDs4.countrow==1){
		gcds_chk.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLdCarGoods_4?gstr1="+gs_ordno+"&gstr2="+gcDs4.countrow;
		gcds_chk.Reset();
	}

	gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_sd1?NOH=Y&gstr1=" +gs_ordno;
	gcDs2.Reset();
</script>

<script language=JavaScript for= PUNIT_CNT event=OnKillFocus()>
	calPKGCnt();
</script>

<script language=JavaScript for= PUNIT_WGHT event=OnKillFocus()>
	calPKGCnt();
</script>

<script language=JavaScript for= PKG_LNGTH event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for= PKG_HEIGHT event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for= PKG_WIDTH event=OnKillFocus()>
	get_cbm();
</script>

<script language=JavaScript for=gcDs2 event=OnRowPosChanged(row)>
	if (gcDs2.countrow<1) return;

	if(saveing == false ) ls_insert = false;
</script> 

<script language=JavaScript for=gcDs2 event=OnColumnChanged(row,colid)>
	if (colid == "ARTC_CNT" || colid == "UNIT_PRICE" ) {
		gcDs2.NameValue(row,"PRICE") = gcDs2.NameValue(row,"ARTC_CNT") * gcDs2.NameValue(row,"UNIT_PRICE");
	}

	if (colid == "PKG_LNGTH" || colid == "PKG_HEIGHT" || colid == "PKG_WIDTH" ) {
		gcDs2.NameValue(row,"PKG_CBM") = gcDs2.NameValue(row,"PKG_LNGTH") * gcDs2.NameValue(row,"PKG_HEIGHT") * gcDs2.NameValue(row,"PKG_WIDTH") / 1000000;
	}

	if (colid == "ARTC_CNT" || colid == "PUNIT_CNT") {
		if (gcDs2.NameValue(row,"ARTC_CNT")=="0") gcDs2.NameValue(row,"PKG_CNT") = 0;
		else if (gcDs2.NameValue(row,"PUNIT_CNT")=="0") gcDs2.NameValue(row,"PKG_CNT") = 0;
		else gcDs2.NameValue(row,"PKG_CNT") = gcDs2.NameValue(row,"ARTC_CNT") / gcDs2.NameValue(row,"PUNIT_CNT");
	}

	if (colid == "PKG_CNT" || colid == "PKG_CBM") {
		gcDs2.NameValue(row,"PKG_CBM_T") = gcDs2.NameValue(row,"PKG_CNT") * gcDs2.NameValue(row,"PKG_CBM");
	}

	if (colid == "PUNIT_WGHT" || colid == "PKG_CBM") {
		gcDs2.NameValue(row,"PUNIT_WGHT_T") = gcDs2.NameValue(row,"PUNIT_WGHT") * gcDs2.NameValue(row,"PKG_CNT");
	}
</script>

<script language=JavaScript for=gcDs4 event=OnRowPosChanged(row)>
	if(gcDs4.CountRow> 0 && saveing == false ){ 
		carLdCargoLoad() ;
		ls_Carinsert = false ; 
	}
</script>

<script language=javascript for=gcDs4 event=OnColumnChanged(row,colid)>
	if (colid=="LD_CARGO"){
		if (gcDs4.namevalue(row,colid)=="ZZZZZ") alert("상차지 정보에 대해 담당자에게 연락하시기 바랍니다.");
	} if (colid=="OFF_CARGO"){
		if (gcDs4.namevalue(row,colid)=="ZZZZZ") alert("하차지 정보에 대해 담당자에게 연락하시기 바랍니다.");
	}
</script>

<script language=JavaScript for=gcDs3 event=OnColumnPosChanged(row,colid)> 
	CalLoadCarCargo(row,colid) ; 
</script>
<script language=JavaScript for=gcGR3 event=OnExit(row,colid,olddata)> 
	CalLoadCarCargo(row,colid) ; 
</script>
<script language=JavaScript for=gcGR3 event=OnClick(row,colid)>
	if (row<1) return;
	CalLoadCarCargo(row,colid) ; 
	CheckTrueSameAs(row,colid);
</script>

<script language="javascript" for=gcGR3 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if (bCheck=="1"){
		for (var i=1; i<=gcDs3.countrow; i++) {
			gcDs3.namevalue(i,"CHECK") = "";
			CheckTrueSameAs(i,"CHECK");
		}
	} else {
		for (var i=1; i<=gcDs3.countrow; i++) {
			gcDs3.namevalue(i,"CHECK") = "T";
			CheckTrueSameAs(i,"CHECK");
		}
	}
</script>

<script language=JavaScript for=gcGR3 event=OnUserColor(row,eventid)> 
	 return gcGR3ColorChange(row,eventid); 
</script>
<script language=JavaScript for=OpenFile event=OnClick()>
	FILENAME.value = OpenFile.value;
	var tmaifiles = OpenFile.FileInfo("size");
	
	if (tmaifiles >= 1048577){
			alert("첨부파일은 1M Byte(1048576 Byte)이하만 가능합니다.\n\n현재 선택한 파일의 크기는 "+tmaifiles+" Byte입니다");
			FILENAME.value = "" ; 
		}
	else
	{ 
	}
</script>
<script language=JavaScript for=gcDsrpt1 event=OnLoadCompleted(rowcnt)>
	var goods_cnt =  null ; 
	for (i=1;i<=gcDs2.CountRow; i++){
		if( i == 1)	goods_cnt = gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT");
		else goods_cnt = goods_cnt + ',' +  gcDs2.NameValue(i,"ARTC_NM") + ':' + gcDs2.NameValue(i,"ARTC_CNT");
	}

	gcDsrpt1.NameValue(1,"GOODS")  = goods_cnt ; 
	gcRpt01.Preview(); 
</script>

<script language=JavaScript for=DLVL_TYPE event=OnCloseUp()>
	if(DLVL_TYPE.index !=2){
		TX1.value = "입고일자";
		ETD_DT.text = "";
		ETD_DT1.text = "";
	}
	if(DLVL_TYPE.index == 2){
		TX1.value = "상차일자"; 
		ETD_DT.text = "";
		ETD_DT1.text = "";
	}
</script>
<script language=JavaScript for=ETD_DT event=OnKillFocus()> 
	var va1 = strim(ETD_DT.text);
	if (va1.length<1) return;
	else EdtDateCheck() ; 
</script>

<script language=JavaScript for=PROJECT event=onkeydown(kcode,scode)>
if (kcode==13){
	gcds_project.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e1?NOH=Y&gstr1=" + PROJECT.Text  ; 
	gcds_project.Reset() ; 

	if (gcds_project.countrow>1) call_project(PROJECT.Text);
}
</script>

<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value) != "") {
		txt_file.value = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		gcDs1.namevalue(1,"ATT_FILE") = tfile; 
		gcDs1.namevalue(1,"ATT_FILENM") = gn_FileType(tfile);
	}
</script>

<script language=javascript for=gcGR1 event=onpopup(row,colid,data)>
	var result ="";

	strURL = "hs_code.jsp";
	PopupOpenDialog(850,490) ;	

	if(PopWinValue != null ){
		gcDs2.namevalue(gcDs2.rowposition,"HSCODE") = PopWinValue[0]; 
		gcDs2.namevalue(gcDs2.rowposition,"HSCODENM") = PopWinValue[1]; 
	}
</script>

<script language="javascript" for=gcGR1 event=OnRButtonDown(Row,Colid,xpos,ypos)>
	var ls_type = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
	if (ls_type=="0003"||ls_type=="0004") return;

	if (Row<2) return;
	
	gcGR1.MenuData="상위물품과 동일포장^1^1^1,상위물품과 동일포장 취소^1^2^1";
	grow = Row;
	gcGR1.TrackPopupMenu(xpos, ypos);
 </script>

<script language="javascript"  for=gcGR1 event=OnCommand(code,str)>
	if (code=="1"){
		if (gcDs2.namevalue(grow-1,"MIX_OTHERS")=="T"){
			gcDs2.namevalue(grow,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow,"SAMEAS") = gcDs2.namevalue(grow-1,"SAMEAS");
			gcDs2.namevalue(grow,"PUNIT_CNT") = 0;
			gcDs2.namevalue(grow,"PUNIT_WGHT") = 0;
			gcDs2.namevalue(grow,"PKG_LNGTH") = 0;
			gcDs2.namevalue(grow,"PKG_WIDTH") = 0;
			gcDs2.namevalue(grow,"PKG_HEIGHT") = 0;
			gcDs2.namevalue(grow,"PKG_CBM") = 0;
		} else {
			gcDs2.namevalue(grow-1,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow-1,"SAMEAS") = gcDs2.namevalue(grow-1,"ORDER_SEQ");
			gcDs2.namevalue(grow,"MIX_OTHERS") = "T";
			gcDs2.namevalue(grow,"SAMEAS") = gcDs2.namevalue(grow-1,"ORDER_SEQ");
			gcDs2.namevalue(grow,"PUNIT_CNT") = 0;
			gcDs2.namevalue(grow,"PUNIT_WGHT") = 0;
			gcDs2.namevalue(grow,"PKG_LNGTH") = 0;
			gcDs2.namevalue(grow,"PKG_WIDTH") = 0;
			gcDs2.namevalue(grow,"PKG_HEIGHT") = 0;
			gcDs2.namevalue(grow,"PKG_CBM") = 0;
		}
	} else {
		if (gcDs2.namevalue(grow,"MIX_OTHERS") == "") return;

		gcDs2.namevalue(grow,"MIX_OTHERS") = "";
		gcDs2.namevalue(grow,"SAMEAS") = "";

		var t2 = gcDs2.namevalue(grow-2,"MIX_OTHERS");
		var v2 = gcDs2.namevalue(grow-2,"SAMEAS");
		var v1 = gcDs2.namevalue(grow-1,"SAMEAS");

		if (t2=="T" && v2==v1){
		} else {
			gcDs2.namevalue(grow-1,"MIX_OTHERS") = "";
			gcDs2.namevalue(grow-1,"SAMEAS") = "";
		}
	}
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<BODY onLoad="Start_101('<%=dirPath%>');">

<div id=all style="display:block">
	<table width="866" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px"  > 
		<tr> 
			<td width="865" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">
				<input id="order_no" name="order_no" type="text" class="txt11" style='width:230;position:relative;left:0px;top:-3px:' style='display:none'>
				<img id=btn_cancel src="<%=dirPath%>/Common/img/btn/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">
				<img id=btn_regdata src="<%=dirPath%>/Common/img/btn/btn_reg.gif" style="cursor:hand" onclick="ln_RegData00()"> 
				<img src="<%=dirPath%>/Common/img/btn/btn_rtn.gif" id=img_rtn style="cursor:hand;display:none" onclick="ln_HistBack2()"> 
				<img src="<%=dirPath%>/Common/img/btn/btn_stssave.gif" id=img_sts style="cursor:hand;display:none" onclick="ln_StsSave()"> 
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<div id=step1 style=display:block>
					<table cellpadding=0 cellspacing=0 border=0 style="width:100%">
						<tr>
							<td>
								<table cellpadding="0" cellspacing="0" border="0" style="width:874px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
									<tr> 
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100><font color="#ff0000">*</font>&nbsp;<B>Project</B></td>
										<td class="tab11_left"> 
											<%=HDConstant.COMMENT_START%><OBJECT id=LINE_PART  style='position:relative;left:8px;top:1px;width:170px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="1">
												<param name=ComboDataID			value="gcDs_etc1">  
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^0^170">
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT><%=HDConstant.COMMENT_END%> 
										</td> 
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100><font color="#ff0000">*</font>&nbsp;물류비 부담</td>
										<td class="tab13_left"> 
											<%=HDConstant.COMMENT_START%><OBJECT id=PROJECT  style='position:relative;left:8px;top:2px;width:320px;height:300' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="2">
												<param name=ComboDataID			value="gcDs_etc10">  
												<param name=SearchColumn		value="USE_PROJNM">
												<param name=ListExprFormat	value="USE_PROJNM^0^250">								
												<param name=BindColumn			value="TR_PROJECT">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2"> 
											</OBJECT><%=HDConstant.COMMENT_END%> 
											<img src="<%=dirPath%>/Common/img/btn_find.gif" id=btn_call_project style="position:relative;left:10px;top:0px;cursor:hand" onclick="call_project(''); " tabindex="3">											
										</td> 
									</tr>
									<tr>
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;적재구분</td>
										<td class="tab11_left">
											<%=HDConstant.COMMENT_START%><OBJECT id=CARGO_TYPE  style='position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=170 height=100 tabindex="4"  >
												<param name=ComboDataID			value=gcDs_etc3>  
												<param name=SearchColumn		value=MINORNM>
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value=True>
												<param name=ListExprFormat	value="MINORNM^1^100">								
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value=0>
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value=2>
											</OBJECT><%=HDConstant.COMMENT_END%> 
										</td>
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width=100><font color="#ff0000">*</font>&nbsp;납품구분</td>
										<td class="tab22"> 
											<%=HDConstant.COMMENT_START%><OBJECT id=DLVL_TYPE  style='position:relative;left:8px;top:1px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=170 height=100  tabindex="5">
												<param name=ComboDataID			value=gcDs_etc2>  
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^100"> 
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT><%=HDConstant.COMMENT_END%> 
										</td> 
									</tr>
									<tr >
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;반입일자</td>
										<td class="tab21">
											<%=HDConstant.COMMENT_START%><OBJECT id=ETD_DT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="6"
												style="position:relative;left:8px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
													<param name=Alignment			value="0">
													<param name=Border	      value="false">
													<param name=Format	      value="YYYY/MM/DD">
													<param name=PromptChar	  value="_">
											</OBJECT><%=HDConstant.COMMENT_END%>
											<img id=btn_Edtdt src="<%=dirPath%>/Common/img/btn_calendar.gif" style="position:relative;left:8px;top:1px;cursor:hand" onclick="__GetCallCalendar2('ETD_DT', 'Text','ETD_DT1','Text' );" tabindex="7">
											&nbsp;&nbsp;(
											<%=HDConstant.COMMENT_START%><OBJECT id=ETD_DT1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="8"
											style="position:relative; left:0px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;">
												<param name=Alignment			value="0">
												<param name=Border	      value="false">
												<param name=Format	      value="YYYY/MM/DD">
												<param name=PromptChar	  value="_">
											</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;:&nbsp;<input id="TX1" name="TX1" type="text" class="txt11_none1" style='width:55;position:relative;left:-4px;top:1px' value="입고일자" readonly> ) 
										</td>
										<td colspan=2 class="tab13_left">&nbsp;</td>
									</tr>
									<tr style="display:none">
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">상차지</td>
										<td class="tab13_left" colspan=3>
											<%=HDConstant.COMMENT_START%><OBJECT id=LD_CAR  style='position:relative;left:8px;top:3px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="9">
												<param name=ComboDataID			value=gcDs_etc11>  
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^100"> 
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT><%=HDConstant.COMMENT_END%>
											<input type="text" class="txt11" id=LDCARGONM style="position:relative;left:10px;top:-3px;width:600px;" tabindex="10">
										</td>
									</tr>
									<tr style="display:none">
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">하차지</td>
										<td class="tab13_left" colspan=3>
											<%=HDConstant.COMMENT_START%><OBJECT id=OFF_CAR  style='position:relative;left:8px;top:3px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100 tabindex="11" >
												<param name=ComboDataID			value=gcDs_etc12>  
												<param name=SearchColumn		value="MINORNM">
												<param name=SortColumn			value="MINORCD"> 
												<param name=Sort						value="True">
												<param name=ListExprFormat	value="MINORNM^1^100"> 
												<param name=BindColumn			value="MINORCD">
												<param name=Index						value="0">
												<param name=InheritColor		value="true"> 
												<param name=ComboStyle			value="2">
											</OBJECT><%=HDConstant.COMMENT_END%>
											<input type="text" class="txt11" id=OFFCARGONM style="position:relative;left:10px;top:-3px;width:600px;" tabindex="12">
										</td> 
									</tr>
									<tr>
										<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;투입목적/공정</td>
										<td class="tab13_left" colspan=3><input type="text" class="txt11" id=txt_obj_remk style="position:relative;left:8px;width:500px;"></td> 
									</tr>
									<tr>
										<td colspan=4>
											<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
												<tr>
													<td class="tab12_left" style="width:30px;text-align:center" bgcolor="#eeeeee">수<br>하<br>인</td>
													<td>
														<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
															<tr>
																<td class="tab11_left" style="height:25px;width:69px;text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;업체명</td>
																<td class="tab11_left" style="width:300px;"><input type="text" class="txt11" id=txt_recipient style="position:relative;left:8px;width:200px;"></td>
																<td class="tab11_left" style="width:80px;text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;담당자</td>
																<td class="tab11_left" style="width:140px;"><input type="text" class="txt11" id=txt_recp_own style="position:relative;left:8px;width:100px;"></td>
																<td class="tab11_left" style="width:80px;text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;전화번호</td>
																<td class="tab13_left" ><input type="text" class="txt11" id=txt_recp_tel style="position:relative;left:8px;width:100px;"></td>
															</tr>
															<tr>
																<td class="tab12_left" style="height:25px;text-align:center" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;주소</td>
																<td colspan=5><input type="text" class="txt11" id=txt_recp_add style="position:relative;left:8px;width:400px;"></td>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id=tr_att_file style="display:none">
										<td style="height:25px;text-align:center;border:0 solid #777777;border-top-width:1px;border-right-width:1px" bgcolor="#eeeeee"><font id=ft_fname>첨부약도</font></td> 
										<td colspan=3 style="border:0 solid #777777;border-top-width:1px;" >
											<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
											<%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
												style="position:relative;left:8px;top:0px;width:100; height:20;" tabindex="14">
													<param name="Text"		value="파일첨부하기">
													<param name="Enable"  value="true">
											</OBJECT><%=HDConstant.COMMENT_END%>
											<img src="<%=dirPath%>/Common/img/btn/com_b_filedown.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="ln_FileDown()" tabindex="15">
										</td>
									</tr>
									<tr id=tr_att_info style="display:none">
										<td class="tab12_left" style="height:25px;width:100px;text-align:center;border:0 solid #777777;border-top-width:1px;border-right-width:1px;" bgcolor="#eeeeee"><font color="#ff0000">*</font>&nbsp;공장담당자정보</td>
										<td colspan=3 style="border:0 solid #777777;border-top-width:1px;">
											&nbsp;성명/직위 :<input type="text" id=FAC_PERSON class="txt11" style="width:100px;">
											&nbsp;&nbsp;전화번호/핸드폰 :<input type="text" id=FAC_PRSTEL class="txt11" style="width:100px;">
										</td>
									</tr>
									<tr> 
										<td style="height:25px;text-align:center;border:0 solid #777777;border-top-width:1px;border-right-width:1px" bgcolor="#eeeeee">비고</td> 
										<td colspan=3 style="border:0 solid #777777;border-top-width:1px;"><textarea name="REMARK" id="REMARK" style="position:relative;left:8px;width:700;height:40;border:0;font-size:9pt;overflow:auto;ime-mode:active" tabindex="13"></textarea></td>
									</tr>
								</table>
							</td> 
						</tr> 
						<tr><td colspan=2 height=20px>&nbsp;</td></tr>
						<tr>
							<td>
								<table border=0 cellpadding=0 cellspacing=0 id=tab_car>
									<tr>
										<td align=right>
											<img src="<%=dirPath%>/Common/img/btn/com_btn_add.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="CarDetail_Insert()" id=btn_CarInsert2 alt="차량정보를 추가합니다.">
											<img src="<%=dirPath%>/Common/img//btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="CarDetail_Delete()" id=btn_CarDel2 alt="선택하신 차량정보를 삭제합니다.">
										</td>
									</tr>
									<tr>
										<td>
											<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR0 style="width:872;height:122px;border:1 solid #777777;display:block" viewastext>
												<PARAM NAME="DataID"			VALUE="gcDs4">
												<PARAM NAME="TitleHeight" VALUE="23">
												<PARAM NAME="RowHeight"		VALUE="20">
												<PARAM NAME="BorderStyle" VALUE="0">
												<PARAM NAME="Fillarea"		VALUE="true">
												<PARAM NAME="Editable"		VALUE="true">
												<param name="AllShowEdit" VALUE="true">
												<PARAM NAME="Format"			VALUE="   
													<C> Name='순번'			ID={CURROW}		HeadAlign=Center BgColor=#eeeeee Width=40  align=center</C>  
													<C> Name='* 차량'			ID=CARTYPENO	HeadAlign=Center HeadBgColor=#eeeeee HeadColor='#ff0000' Width=120  align=center	EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME'</C>  
													<C> Name='* 대표품목' ID=CTN_STDRD	HeadAlign=Center HeadBgColor=#eeeeee HeadColor='#ff0000' Width=120  align=left</C>  
													<C> Name='* 상차지'		ID=LD_CARGO		HeadAlign=Center HeadBgColor=#eeeeee HeadColor='#ff0000' Width=90		align=center	EditStyle=Lookup Data='gcDs_etc15:MINORCD:MINORNM'</C>  
													<C> Name='* 하차지'		ID=OFF_CARGO	HeadAlign=Center HeadBgColor=#eeeeee HeadColor='#ff0000' Width=90		align=center	EditStyle=Lookup Data='gcDs_etc16:MINORCD:MINORNM'</C>  
													<C> Name='상차지상세정보'	ID=LD_CARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left</C>  
													<C> Name='하차지상세정보'	ID=OFF_CARGONM		HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left</C>  
												">
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>
									<tr><td colspan=2 height=20px>&nbsp;</td></tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table cellpadding=0 cellspacing=0 border=0 style="width:100%">
									<tr>
										<td valign="bottom">
											<table height="30" border="0" cellpadding="0" cellspacing="0" style="position:relative;top:-3px;left:0;width:798px;" background="../img/under_bar5.gif"> 
												<tr>
													<td align=right>&nbsp;(세관제출 반출입신고서(수출입신고서) 별도작성요청<input type="checkbox" id=pl_cl name=pl_cl class="chk1" value="N" style='position:relative;left:0px;top:2px' onclick="pl_ci_add();" tabindex="16">)</td>
												</tr>
											</table>
										</td>
									</tr>
								</table> 
							</td>
						</tr>
						<tr>
							<td align=left>
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
									<tr> 
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center" rowspan=3>신청업체</td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center"><font color="#ff0000">*</font>&nbsp;사업자명</td>
										<td class="tab13_left" align='left' colspan=3 >
											<%=HDConstant.COMMENT_START%><OBJECT id=CUST_CD  class="txt11_right" style='position:relative;left:8px;top:2px;height:15;width:90;display:none' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="17"> 
												<param name=Alignment		value=1>  
												<param name=Numeric			value="false"> 
												<param name=border			value=false> 
												<param name=SelectAll		value=true>
											</OBJECT><%=HDConstant.COMMENT_END%>
											<input id="CUST_CDNM" name="CUST_CDNM" type="text" class="txt11" style='position:relative;left:8px;top:-2px;width:230;' onkeydown="if(event.keyCode == '13') nameCheck_cust('CUST_CDNM');" onkeyup="if (same.checked) SHIPPER_NM.value = this.value;" tabindex="18"> 
											<img src="<%=dirPath%>/Common/img/btn_find.gif" id=btn_vender style="position:relative;left:8px;top:2px;cursor:hand" onclick="if (LINE_PART.Enable==true) call_vender('CUST_CD','Text');" tabindex="19">
											<%=HDConstant.COMMENT_START%><OBJECT id=CUST_ID  class="txt11_right" style='position:relative;left:12px;top:2px;height:15;width:90;' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F onkeyup="if (same.checked) SHIPPER_ID.text = this.text;" tabindex="20" > 
												<param name=Alignment		value=1>
												<param name=Format			value="000-00-00000"> 
												<param name=PromptChar	value="">
												<param name=border			value=false> 
												<param name=SelectAll		value=true>
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;담당자명</td>
										<td class="tab13_left" colspan=3><input id="CUST_PRSN" name="CUST_PRSN" type="text" class="txt11" style='width:100;position:relative;left:8px;top:1px;ime-mode:active' onkeyup="if (same.checked) SHIPPERPS.value = this.value;" tabindex="21"></td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;전화번호</td>
										<td class="tab11_left" style="width:300px;"><input id="CUST_TELNO" name="CUST_TELNO" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' onkeyup="if (same.checked) SHIPPERHPTEL.value = this.value;" tabindex="22"></td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100px;text-align:center">핸드폰 번호</td>
										<td class="tab13_left"><input id="CUST_HPNO" name="CUST_HPNO" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' onkeyup="if (same.checked) SHIPPERHP.value = this.value;" tabindex="23">
										</td>
									</tr>
									<tr> 
										<td class="tab12_left" bgcolor="#eeeeee" style="width:100;text-align:center" rowspan=3>&nbsp;실화주<BR>&nbsp;(위와 동일<input type="checkbox" id=same name=same class="chk1" value="C" style='position:relative;left:0px;top:2px' onclick="Shipper_Same();" tabindex="24">)</td>
										<td class="tab11_left" bgcolor="#eeeeee" style="width:100;text-align:center"><font color="#ff0000">*</font>&nbsp;사업자명</td>
										<td class="tab13_left" colspan=3 >
											<%=HDConstant.COMMENT_START%><OBJECT id=SHIPPER  class="txt11_right" style='width:90;position:relative;left:8px;top:2px;height:15;display:none' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="25"> 
												<param name=Alignment		value=1>
												<param name=Numeric			value="false"> 
												<param name=border			value=false> 
											</OBJECT><%=HDConstant.COMMENT_END%>
											<input id="SHIPPER_NM" name="SHIPPER_NM" type="text" class="txt11" style='width:230;position:relative;left:8px;top:-2px' onkeydown="if(event.keyCode == '13'){nameCheck_cust('SHIPPER_NM');}" tabindex="26"> 
											<img id=btn_vender src="<%=dirPath%>/Common/img/btn_find.gif" style="position:relative;left:8px;top:2px;cursor:hand" onclick="if (LINE_PART.Enable==true) call_vender('SHIPPER','Text');" tabindex="27"> 
											<%=HDConstant.COMMENT_START%><OBJECT id=SHIPPER_ID  class="txt11_right" style='width:90;position:relative;left:12px;top:2px;height:15;' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="28"> 
												<param name=Alignment		value=1>
												<param name=Numeric			value="false"> 
												<param name=Format			value="000-00-00000"> 
												<param name=PromptChar	value="">
												<param name=Format			value=""> 
												<param name=border			value=false> 
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>
									<tr>
										<td class="tab11_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;담당자명</td>
										<td class="tab13_left" align='left'  colspan=3><input id="SHIPPERPS" name="SHIPPERPS" type="text" class="txt11" style='width:100;position:relative;left:8px;top:1px;ime-mode:active' tabindex="29"></td>
									</tr>
									<tr>
										<td class="tab12_left" bgcolor="#eeeeee" style="text-align:center"><font color="#ff0000">*</font>&nbsp;전화번호</td>
										<td class="tab12_left"><input id="SHIPPERTEL" name="SHIPPERTEL" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px' tabindex="30"></td>
										<td class="tab12_left" bgcolor="#eeeeee" style="width:100;text-align:center">핸드폰 번호</td>
										<td><input id="SHIPPERHP" name="SHIPPERHP" type="text" class="txt11" style='width:120;position:relative;left:8px;top:1px'tabindex="31" ></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr><td height=20px></td></tr> 
						<tr>
							<td style="width:100%">
								<div id=pl_ci_add_div style="display:none">
									<table cellpadding=0 cellspacing=0 border=0 style="position:relative;top:0px;">	
										<tr>
											<td height=30px align=left width=70px><img src="<%=dirPath%>/Common/img/head_4.gif" style="position:relative;left:0px;top:0px;"></td> 
											<td valign="bottom">
												<table height="30" border="0" cellpadding="0" cellspacing="0" style="position:relative;top:-3px;width:800px;left:0" background="../img/under_bar5.gif"> 
													<tr>
														<td align=right></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan=2>
												<table  cellpadding="0" cellspacing="0" border="0" style="width:100%;font-size:9pt;background-color:#ffffff;border:1 solid #708090"  style="position:relative;left:0px;top:0px;"> 
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee">&nbsp;송하인 
														(&nbsp;<input id='PL_SHIPPER'  name="PL_SHIPPER" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="32">
																<img src="../img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="33" id=btn_calshipper onclick="Call_SHIPPER();">&nbsp;)
														</td>
														<td class=tab13_left bgcolor="#eeeeee">&nbsp;수하인(&nbsp;<input id='PL_CSTM'  name="PL_CSTM" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="34">
																<img src="<%=dirPath%>/Common/img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="35" id=btn_calcsi onclick="Call_PLCST();" >&nbsp;)
														</td> 
													</tr>  
													<tr>
														<td class=tab11_left width=423px > 
															<input id="PL_SHPPRNM" name="PL_SHPPRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHIPADDR" name="PL_SHIPADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHPADDR2" name="PL_SHPADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHPADDR3" name="PL_SHPADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_SHIPTEL" name="PL_SHIPTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
														</td>
														<td  class=tab13_left> 
															<input id="PL_CSTMNM" name="PL_CSTMNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR" name="PL_CSTADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR2" name="PL_CSTADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTADDR3" name="PL_CSTADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSTTEL" name="PL_CSTTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
													</tr>
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee">&nbsp;통지처 (&nbsp;<input id="PL_BRKR"  name="PL_BRKR" type="text"   size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="36">
																<img src="../img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="37" id=btn_calbrkr onclick ="Call_BRKR();">&nbsp; )
														</td>
														<td class=tab13_left bgcolor="#eeeeee" style="width:100">&nbsp;대표물품</td>
													</tr>
													<tr>
														<td class=tab11_left>  
															<input id="PL_BRKRNM" name="PL_BRKRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR" name="PL_BRKADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR2" name="PL_BRKADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKADDR3" name="PL_BRKADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_BRKTEL" name="PL_BRKTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
														<td class=tab13_left><textarea id="RPST_GOODS" name="RPST_GOODS" rows=10 cols=30 style='border:1;width:440;position:relative;left:0px;top:0px;height:80;font-size:9pt;overflow:auto' tabindex="38"></textarea></td>
													</tr> 
													<tr> 
														<td class=tab11_left bgcolor="#eeeeee"  >&nbsp;위탁자 
														(&nbsp;<input id='PL_CSN'  name="PL_CSN" type="text"  size=16 maxlength=50  value="" style="position:relative;left:0px;top:0px;" class=txt11 tabindex="39">
																<img src="../img/btn_find.gif" style="position:relative;left:0px;top:3px;cursor:hand" tabindex="40" id=btn_calcs onclick="Call_CS();">&nbsp;)
														</td>
														<td class=tab13_left bgcolor="#eeeeee">&nbsp;</td> 
													</tr>
													<tr>
														<td class=tab12_left>
															<input id="PL_CSNNM" name="PL_CSNNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR" name="PL_CSNADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR2" name="PL_CSNADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNADDR3" name="PL_CSNADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
															<input id="PL_CSNTEL" name="PL_CSNTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr><td height=20px></td></tr> 
									</table>
								</div>
							</td>
						</tr>
					</table>
					<table cellpadding=0 cellspacing=0 border=0 style="width:100%">
						<tr><td align=center colspan=2><img src="<%=dirPath%>/Common/img/btn/btn_prdetail.gif" onclick="Master_Save();" style='cursor:hand' alt="물품 상세정보 입력 화면으로 이동합니다."></td></tr>
						<tr><td height=20px></td></tr> 
					</table> 
				</div>
			</td>
		</tr>
		
<!-- ***************************************************************************************************** -->
<!-- 				Detail                                                                           -->
<!-- ***************************************************************************************************** -->
		<tr>
			<td colspan=2>
				<div id=step2 style=display:none>
					<table cellpadding=0 cellspacing=0 border=0>
						<tr>
							<td valign="bottom">
								<table height="30" border="0" cellpadding="1" cellspacing="0" style="position:relative;top:-3px;width:799px;left:0" background="../img/under_bar5.gif"> 
									<tr>
										<td align=right> 
											<img src="<%=dirPath%>/Common/img/btn/b_write.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="New_Insert();" alt="물품정보를 작성합니다.">
											<img src="<%=dirPath%>/Common/img/btn/b_save.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="Detail_Save();" alt="입력하신 물품정보를 저장합니다."> 
											<img src="<%=dirPath%>/Common/img//btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="Detail_Delete()" alt="선택하신 물품정보를 삭제합니다."> 
											<img src="<%=dirPath%>/Common/img/btn/com_b_fileupload.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ExcelLoad();" alt="엑셀파일을 업로드 합니다.">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr> 
							<td colspan=2> 
								<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:200px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;display:none" >
									<tr>
										<td id=tddetail2 align=left colspan=2>
											<table cellpadding="0" cellspacing="0" border="0" style=" width:100%;height:20px;font-size:9pt;background-color:#ffffff;border:0 solid #708090"> 
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>HSCODE</td>
													<td class="tab11_left" colspan=3>
														<input id="HSCODE" name="HSCODE" type="text" class="txt11" style='width:65;position:relative;left:0px;top:0px' tabindex="40" >
														<img src="<%=dirPath%>/Common/img/btn_find.gif" style="position:relative;left:2px;top:3px;"  onclick="call_hscode();" tabindex="41" >
														<input id="HSCODENM" name="HSCODENM" type="text" class="txt11" style='width:185;position:relative;left:0px;top:0px' tabindex="42">
													</td> 
													<td class="tab11_left" bgcolor="#A7BDD8"   colspan=6>
														&nbsp;단위포장별(이전에 입력한 품목과 동일한 포장일 경우 체크 <input type="checkbox" id=MIX_OTHERS name=MIX_OTHERS class="chk1" value="C" style='position:relative;left:-1px;top:2px' onclick="enable_packinfo();" tabindex="54">)
													</td> 
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee">품명</td>
													<td class="tab11_left"  colspan=3  align=left  id=kor_name>
													&nbsp;<input id="ARTC_NM" name="ARTC_NM" type="text" class="txt11" style='width:125;position:relative;left:0px;top:0px;border:1 solid #a9c9b9' tabindex="38">
													  <input id="ARTC_CD" name="ARTC_CD" type="text" class="txt11" style='width:0;position:relative;left:0px;top:0px;border:1 solid #930122' tabindex="36">
													</td>   
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>수량</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PUNIT_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="55"> 
														<param name=Alignment				value=2>
														<param name=Numeric					value=true>
														<param name=IsComma					value=true>
														<param name=MaxLength				value=10>
														<param name=MaxDecimalPlace	value=2>
														<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%> 
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='50px' colspan=1>중량</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PUNIT_WGHT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="57"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=1>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%> 
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>영문품명</td>
													<td id=eng_name colspan=3 class="tab11_left" >&nbsp;<input id="ARTC_ENM" name="ARTC_ENM" type="text" class="txt11" style='width:125;position:relative;left:0px;top:0px' tabindex="39"></td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' colspan=1>길이(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_LNGTH  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="58"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" colspan=1>높이(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_HEIGHT  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="60"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" colspan=1>폭(cm)</td>
													<td class="tab11_left">&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_WIDTH  class="txt11_right" style='width:60;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="59"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>규 격</td>
													<td class="tab11_left" colspan=3>&nbsp;<input id="STN_SZNM" name="STN_SZNM" type="text" class="txt11" style='width:275;position:relative;left:0px;top:0px' tabindex="48" ></td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' colspan=1>용적</td>
													<td class="tab11_left" colspan=2 >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_CBM  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F Height=24 width=120 tabindex="61"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=0>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>  
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>총수량</td>
													<td class="tab11_left" colspan=2>&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="61"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%> 
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>수량</td>
													<td class="tab11_left" >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=ARTC_CNT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="50"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>단위</td>
													<td class="tab11_left" > &nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=ARTC_UNIT  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="51">
															<param name=ComboDataID			value=gcDs_etc6>  
															<param name=SearchColumn		value=MINORNM>
															<param name=SortColumn			value="MINORCD"> 
															<param name=Sort						value=True>
															<param name=ListExprFormat	value="MINORNM^1^100"> 
															<param name=BindColumn			value="MINORCD">
															<param name=Index						value=0>
															<param name=InheritColor		value="true"> 
															<param name=ComboStyle			value=2>
														</OBJECT><%=HDConstant.COMMENT_END%>
													</td>											
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' colspan=1>총용적</td>
													<td class="tab11_left"  colspan=2 >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=TOTAL_PKG_CBM  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="62"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>총무게</td>
													<td class="tab11_left" colspan=2 >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PKG_WGHT  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="63"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>
													</td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>단가</td>
													<td class="tab11_left" >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=UNIT_PRICE  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%>
													</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>금액</td>
													<td class="tab11_left" >&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=PRICE  class="txt11_right" style='width:90;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="53"> 
															<param name=Alignment				value=2>
															<param name=Numeric					value=true>
															<param name=IsComma					value=true>
															<param name=MaxLength				value=10>
															<param name=MaxDecimalPlace	value=2>
															<param name=border					value=false>
														</OBJECT><%=HDConstant.COMMENT_END%> 
													</td>  
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>상차지</td>
													<td class="tab11_left"   align=left colspan=5>
														&nbsp;<%=HDConstant.COMMENT_START%><OBJECT id=DTL_LD_CAR  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="43">
															<param name=ComboDataID			value=gcDs_etc8>  
															<param name=SearchColumn		value="MINORNM">
															<param name=SortColumn			value="MINORCD"> 
															<param name=Sort						value="True">
															<param name=ListExprFormat	value="MINORNM^1^100"> 
															<param name=BindColumn			value="MINORCD">
															<param name=Index						value="0">
															<param name=InheritColor		value="true"> 
															<param name=ComboStyle			value="2">
														</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp; FIXED&nbsp;<input type="checkbox" id=fixed name=fixed class="chk1" value="C" style='position:relative;left:-1px;top:2px' tabindex="44" > 
													</td>  
												</tr>  
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px' rowspan=3>비고</td>
													<td class="tab11_left" colspan=3 rowspan=3>&nbsp;</td>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>추가정보</td>
													<td class="tab11_left" align=left colspan=5>&nbsp;<input id="DTL_LD_CAR_NM" name="DTL_LD_CAR_NM" type="text" class="txt11" style='width:325;position:relative;left:0px;top:0px' tabindex="47"></td>
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>하차지</td>
													<td class="tab11_left" align=left colspan=5>&nbsp;
														<%=HDConstant.COMMENT_START%><OBJECT id=DTL_OFF_CAR  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="45">
															<param name=ComboDataID			value=gcDs_etc9>  
															<param name=SearchColumn		value="MINORNM">
															<param name=SortColumn			value="MINORCD"> 
															<param name=Sort						value="True">
															<param name=ListExprFormat	value="MINORNM^1^100"> 
															<param name=BindColumn			value="MINORCD">
															<param name=Index						value="0">
															<param name=InheritColor		value="true"> 
															<param name=ComboStyle			value="2">
														</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp; FIXED&nbsp;<input type="checkbox" id=fixed1 name=fixed1 class="chk1" value="C" style='position:relative;left:-1px;top:2px' tabindex="46" > 
													</td> 
												</tr>
												<tr>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='100px'>추가정보</td>
													<td class="tab11_left"   align=left colspan=5>&nbsp;<input id="DTL_OFF_CAR_NM" name="DTL_OFF_CAR_NM" type="text" class="txt11" style='width:325;position:relative;left:0px;top:0px' tabindex="47"></td>
												</tr>
												<tr id=cargoType style=display:none>
													<td class="tab11_left" style="text-align:center" bgcolor="#eeeeee" width='80px'>등록증</td>
													<td class="tab12_left" colspan=7>&nbsp;
														<input type="textarea" id="FILENAME" name="FILENAME"  class="txt11" style='width:475;position:relative;left:0px;top:0px'>
														<%=HDConstant.COMMENT_START%><OBJECT id=OpenFile classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
															style="position:relative;left:0px;top:5px;width=0; height=0;display:none">
																<param name="Text"		value='FileOpen'> 
														</OBJECT><%=HDConstant.COMMENT_END%> 
														&nbsp;<img id=openfile1 src="<%=dirPath%>/Common/img/btn_find.gif" style="display:none"   onclick="OpenFile();" style="position:relative;left:0px;top:5px "> 
														&nbsp;
														<img id=down_img src="<%=dirPath%>/Common/img/down_icon.gif" style=display:none style="position:relative;left:0px;top:5px "  onclick="DownLoadFile(1);">
													</td> 
												</tr>  
											</table>
										</td>
									</tr>
								</table>
								<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
									<tr>
										<td colspan=2>
											<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:870;height:401px;border:1 solid #777777;display:block" viewastext>
												<PARAM NAME="DataID"			VALUE="gcDs2">
												<PARAM NAME="TitleHeight" VALUE="22">
												<PARAM NAME="RowHeight"		VALUE="20">
												<PARAM NAME="BorderStyle" VALUE="0">
												<PARAM NAME="ColSizing"		VALUE="true">
												<PARAM NAME="Fillarea"		VALUE="true">
												<PARAM NAME="Editable"		VALUE="true">
												<param name="AllShowEdit" VALUE="true">
												<PARAM NAME="ViewSummary"	VALUE="1">
												<PARAM NAME="Format"			VALUE="
													<F> Name='No.'			ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none</F>   
													<F> Name='상차지'		ID=LDCARGO  	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center,	 editstyle=LookUp Data='gcDs_etc8:MINORCD:MINORNM'</F>
													<F> Name='하차지'		ID=OFFCARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center,	 editstyle=LookUp Data='gcDs_etc9:MINORCD:MINORNM'</F>
													<F> Name='영문명'		ID=ENG_ARTCNM	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=left, show=false</F>
													<F> Name='HS code'	ID=HSCODE  		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center, editStyle=Popup, show=false</F>
													<F> Name='HS Name'	ID=HSCODENM 	HeadAlign=Center HeadBgColor=#eeeeee Width=137  align=left, show=false </F> 
													<F> Name='품명'			ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=left, sumText='합계'</F>
													<C> Name='규격'			ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left</C>
													<C> Name='단위'			ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left,	 editstyle=LookUp Data='gcDs_etc6:MINORCD:MINORNM'</C>
													<C> Name='수량'			ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right, sumText=@sum</C> 
													<C> Name='단가(원)'	ID=UNIT_PRICE HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>
													<C> Name='금액(원)'	ID=PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> 
													<C> Name='화폐'			ID=CUR_CODE		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center</C>
													<C> Name='단가(외화)'	ID=FR_UNTRPRCE	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>
													<C> Name='금액(외화)'	ID=FR_PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> 
													<G> Name='단위포장' HeadBgColor=#eeeeee
														<C> Name='수량'	ID=PUNIT_CNT  	HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0, sumText=@sum</C>   
														<C> Name='중량(KG)'	ID=PUNIT_WGHT  	HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right, dec=0, sumText=@sum</C>
														<C> Name='길이(CM)'	ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='폭(CM)'		ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='높이(CM)'	ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> 
														<C> Name='용적(CBM)'ID=PKG_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=right, dec=3</C> 
													</G>
													<C> Name='총수량'					ID=PKG_CNT	 			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=2, sumText=@sum</C>   
													<C> Name='총용적(CBM)'		ID=PKG_CBM_T 			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=3, sumText=@sum</C>   
													<C> Name='총중량(KG)'			ID=PUNIT_WGHT_T		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right,	dec=1, sumText=@sum</C>   
													<C> Name='상차지추가정보' ID=LDCARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C>   
													<C> Name='하차지추가정보' ID=OFFCARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C>   
													<C> Name='동일포장'				ID=MIX_OTHERS  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, show=false </C>   
													<C> Name='동일포장;No'		ID=SAMEAS  				HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center</C> 
												">
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								</table> 
							</td>
						</tr> 
						<tr><td height=10px align=right colspan=2>&nbsp;</td></tr> 
						<tr>
							<td align=center colspan=2 class=tab_11>
								<img src="<%=dirPath%>/Common/img/btn/btn_order.gif" onclick="show_detail(1);" style='cursor:hand;position:relative;left:0px;top:0px' alt="주문정보 화면으로 이동합니다.">
								<img src="<%=dirPath%>/Common/img/btn/btn_cardetail.gif" onclick="lf_car_input();"  id=disp_carbutton style='cursor:hand;position:relative;left:0px;top:0px' alt="차량 및 배정정보를 선택하는 화면으로 이동합니다."> 
								<img src="<%=dirPath%>/Common/img/btn/btn_autcargood.gif" onclick="lf_confirm();"  id=disp_confirm style='cursor:hand;position:relative;left:0px;top:0px' alt="입력하신 물품을 위탁배정 작업을 진행합니다."> 
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan=2>
				<div id=step3 style="display:none"> 
					<table border=0 cellpadding=0 cellspacing=0>
<!-- ***************************************************************************************************** -->
<!-- 				차량정보                                                                               -->
<!-- ***************************************************************************************************** -->
						<tr>
							<td colspan=2>
								<div id=Car_disp style="display:block">
									<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
										<tr>
											<td height=30px align=left><img src="<%=dirPath%>/Common/img/head_6.gif" style="position:relative;left:0px;top:2px;"></td>
											<td valign="bottom">
												<table height="30" border="0" cellpadding="1" cellspacing="0" style="position:relative;top:0px;width:790px;left:0" background="../img/under_bar5.gif">
													<tr>
														<td align=left>&nbsp;<font style="position:relative;top:2px;">차량정보는 적재구분(일반)일 경우만 입력합니다.</font></td>
														<td align=right>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan=2 style="height:130px"> 
												<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR2 style="width:872;height:122px;border:1 solid #777777;display:block" viewastext>
													<PARAM NAME="DataID"			VALUE="gcDs4">
													<PARAM NAME="TitleHeight" VALUE="23">
													<PARAM NAME="RowHeight"		VALUE="20">
													<PARAM NAME="BorderStyle" VALUE="0">
													<PARAM NAME="Fillarea"		VALUE="true">
													<PARAM NAME="Editable"		VALUE="false">
													<param name="AllShowEdit" VALUE="true">
													<PARAM NAME="Format"			VALUE="   
														<C> Name='순번'			ID={CURROW}		HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center</C>  
														<C> Name='차량'			ID=CARTYPENO	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=center	EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME'</C>  
														<C> Name='대표품목' ID=CTN_STDRD	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left</C>  
														<C> Name='상차지'		ID=LD_CARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center	EditStyle=Lookup Data='gcDs_etc15:MINORCD:MINORNM'</C>  
														<C> Name='하차지'		ID=OFF_CARGO	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center	EditStyle=Lookup Data='gcDs_etc16:MINORCD:MINORNM'</C>  
														<C> Name='상차지상세정보'	ID=LD_CARGONM			HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left</C>  
														<C> Name='하차지상세정보'	ID=OFF_CARGONM		HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left</C>  
													">
												</OBJECT><%=HDConstant.COMMENT_END%>

												<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:150px;font-size:9pt;display:none" >
													<tr>
														<td width=500>
															<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR2_old style="width:500;height:122px;border:1 solid #777777;display:block" viewastext>
																<PARAM NAME="DataID"			VALUE="gcDs4">
																<PARAM NAME="TitleHeight" VALUE="23">
																<PARAM NAME="RowHeight"		VALUE="20">
																<PARAM NAME="BorderStyle" VALUE="0">
																<PARAM NAME="Fillarea"		VALUE="true">
																<PARAM NAME="Editable"		VALUE="false">
																<param name="AllShowEdit" VALUE="true">
																<PARAM NAME="Format"			VALUE="   
																	<C> Name='적재차량종류' ID=CARTYPENO		HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=center EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME', show=true</C>  
																	<C> Name='대수'					ID='CAR_CNT'		HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=right</C>  
																	<C> Name='대표품목'			ID='CTN_STDRD'	HeadAlign=Center HeadBgColor=#eeeeee Width=130  align=left</C>
																	<C> Name='특이사항'			ID='REMARK'			HeadAlign=Center HeadBgColor=#eeeeee Width=150  align=left</C>  
																">
															</OBJECT><%=HDConstant.COMMENT_END%>
														</td>
														<td>
															<table cellpadding="0" cellspacing="0" border="0" style=" width:370;height:125px;font-size:9pt;"  >
																<tr>
																	<td class=tab18 style="height:30px;width:80px;text-align:center" bgcolor="#eeeeee">차량종류</td>
																	<td class=tab18 colspan=3>&nbsp;
																		<%=HDConstant.COMMENT_START%><OBJECT id=CAR_TYPE  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  tabindex="64">
																			<param name=ComboDataID			value="gcDs_etc5">
																			<param name=SearchColumn		value="CAR_NAME">
																			<param name=SortColumn			value="CAR_TYPE"> 
																			<param name=Sort						value="True">
																			<param name=ListExprFormat	value="CAR_TYPE^2^32,CAR_NAME^0^100"> 
																			<param name=BindColumn			value="CAR_TYPE">
																			<param name=Index						value="0">
																			<param name=InheritColor		value="true"> 
																			<param name=ComboStyle			value="2">
																		</OBJECT><%=HDConstant.COMMENT_END%><img src="../img/btn_find.gif" style="position:relative;left:2px;top:0px;" onclick="CallCarType();">
																	</td>
																	<td class=tab18 bgcolor="#eeeeee" style=display:none>대수</td>
																	<td class=tab18 style=display:none>&nbsp;<input id="CAR_CNT" name="CAR_CNT" type="text" class="txt11" style='width:40;position:relative;left:0px;top:1px' value=1></td>
																</tr>
																<tr style='display:none'>
																	<td class=tab11_left style="height:30px;text-align:center" bgcolor="#eeeeee">반입일자</td>
																	<td class=tab11_left colspan=1 align=left>&nbsp;
																		<%=HDConstant.COMMENT_START%><OBJECT id=CAR_EDT_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																			style="position:relative; left:0px;top:2px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" tabindex="67" >
																				<param name=Alignment			value="0">
																				<param name=Border	      value="false">
																				<param name=Format	      value="YYYY/MM/DD">
																				<param name=PromptChar	  value="_">
																		</OBJECT><%=HDConstant.COMMENT_END%><img src="../img/btn_calendar.gif" style="position:relative;left:0px;top:1px;"onclick="__GetCallCalendar2('CAR_EDT_DATE', 'Text','LOAD_DATE', 'Text');" tabindex="68"> 
																	</td>
																	<td class=tab11_left style="text-align:center" bgcolor="#eeeeee">납품일자</td>
																	<td class=tab11_left colspan=1 align=left>&nbsp;
																		<%=HDConstant.COMMENT_START%><OBJECT id=LOAD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
																			style="position:relative; left:0px;top:2px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;"  tabindex="65">
																				<param name=Alignment			value="0">
																				<param name=Border	      value="false">
																				<param name=Format	      value="YYYY/MM/DD">
																				<param name=PromptChar	  value="_">
																		</OBJECT><%=HDConstant.COMMENT_END%>
																	</td>
																</tr>
																<tr>
																	<td class=tab11_left style="height:30px;text-align:center" bgcolor="#eeeeee">대표품목</td>
																	<td class=tab11_left style="align:left" colspan=3>&nbsp;<input id="CTN_STDRD" name="CTN_STDRD" type="text" class="txt11" style='width:180;position:relative;left:0px;top:1px' tabindex="69"></td>
																</tr>
																<tr>
																	<td class=tab11_left style="height:30px;text-align:center" bgcolor="#eeeeee">비고</td>
																	<td class=tab11_left style="align:left" colspan=3>&nbsp;<input id="CAR_REMARK" name="CAR_REMARK" type="text" class="txt11" style='width:257;position:relative;left:0px;top:1px' tabindex="70"></td> 
																</tr>
																<tr>
																	<td class=tab11_left style="height:30px;text-align:center" bgcolor="#eeeeee">약도</td>
																	<td class=tab11_left colspan=3>&nbsp;<input id="LCT_URL" name="LCT_URL" type="text" class="txt11" style='width:232;position:relative;left:0px;top:-2px' tabindex="71" >&nbsp;<img src="../img/btn/kctc_s_find.jpg" style="position:relative;left:0px;top:4px;" tabindex="72"></td>
																</tr> 
															</table> 
														</td>
													</tr>
												</table> 
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<table cellpadding=0 cellspacing=0 border=0>
									<tr>
										<td>(선택하신 차량에 적재할 물품들을 선택한 후 수량을 입력해주십시오)</td>
										<td align=right>
											<font style="position:relative;left:0px;top:-5px;">단위포장 :  Pallet,Buddle,Box,EA(개당) ...</font>
											<img src="<%=dirPath%>/Common/img/btn/b_save.gif" style="position:relative;left:0px;top:0px;cursor:hand" onclick="CarGoods_SAVE();" alt="입력하신 배정정보를 저장합니다.">
										</td>
									</tr>		
									<tr>
										<td colspan=2>
											<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR3 style="width:870;height:304px;border:1 solid #777777;display:block" viewastext>
												<PARAM NAME="DataID"					VALUE="gcDs3">
												<PARAM NAME="TitleHeight"			VALUE="22">
												<PARAM NAME="RowHeight"				VALUE="20">
												<PARAM NAME="BorderStyle"			VALUE="0">
												<PARAM NAME="Fillarea"				VALUE="true">
												<PARAM NAME="Editable"				VALUE="true">
												<PARAM NAME="AllShowEdit"			VALUE="true">
												<PARAM NAME="EdgeLLineColor"	VALUE="Blue">
												<PARAM NAME="ViewSummary"			VALUE="1">  
												<PARAM NAME="Format"					VALUE="
													<C> Name=''			ID=CHECK			HeadAlign=Center HeadBgColor=#eeeeee Width=20 CheckBoxText='Stsnm'	Pointer=Hand EditStyle=CheckBox HeadCheck=false		HeadCheckShow=true align=center HeadVAlign=TOP, edit=none</C>   
													<C> Name='No.'	ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30  align=right edit=none bgcolor=@acolor</C>   
													<C> Name='품명'	ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=117 align=left  edit=none bgcolor=@acolor sumtext='합계'</C>   
													<C> Name='단위'	ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left  edit=none show=false bgcolor=@acolor</C> 
													<G> Name='수량' HeadBgColor=#eeeeee 
														<C> Name='물품수량'	ID=ARTC_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none show=false bgcolor=@acolor</C>
														<C> Name='적재수량'	ID=LD_ARTC_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=RealNumeric BGCOLOR=#CCCCFF bgcolor=@acolor1</C>
														<C> Name='잔여수량'	ID=EXT_ARTC_CNT HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none bgcolor=@acolor Color=@acolor3</C> 
													</G>
													<G> Name='포장수량' HeadBgColor=#eeeeee 
														<C> Name='포장수량'	ID=PKG_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none show=false bgcolor=@acolor</C> 
														<C> Name='적재수량'	ID=LD_PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=RealNumeric bgcolor=@acolor1</C> 
														<C> Name='잔여수량'	ID=EXT_PKG_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none  bgcolor=@acolor Color=@acolor2</C> 
													</G>
													<C> Name='총중량(KG)'		ID=LD_PKG_WGHT	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right bgcolor=@acolor sumtext=@sum</C> 
													<C> Name='총용적(CBM)'	ID=LD_PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right bgcolor=@acolor sumtext=@sum</C> 
													<G> Name='단위포장' HeadBgColor=#eeeeee 
														<C> Name='길이(CM)'	ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right show=TRUE bgcolor=@acolor</C> 
														<C> Name='폭(CM)'		ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right show=TRUE bgcolor=@acolor</C> 
														<C> Name='높이(CM)'	ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right show=TRUE bgcolor=@acolor</C> 
														<C> Name='HSCODE'		ID=HSCODE  			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left show=false bgcolor=@acolor</C> 
													</G>  
												">
											</OBJECT><%=HDConstant.COMMENT_END%>
										</td>
									</tr>	
								</table>
							</td>
						</tr>
						<tr><td height=5px>&nbsp;</td></tr>
						<tr>
							<td align=center colspan=2 class=tab_11>
								<img src="<%=dirPath%>/Common/img/btn/btn_prdetail2.gif" onclick="lf_car_back();" style='cursor:hand;position:relative;left:0px;top:0px' alt="물품 상세정보 입력 화면으로 이동합니다.">&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr><td style="height:10px"></td></tr>
					</table>
				</div>
			</td>
		</tr>
		<tr style="display:none">
			<td>
				<%=HDConstant.COMMENT_START%><OBJECT id=gclx_samp classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
					<param name=ComboDataID			value="gcDs_samp">  
					<param name=SearchColumn		value="MINORNM">
					<param name=SortColumn			value="MINORCD"> 
					<param name=Sort						value="True">
					<param name=ListExprFormat	value="MINORNM^1^100"> 
					<param name=BindColumn			value="MINORCD">
					<param name=Index						value="0">
					<param name=InheritColor		value="true"> 
					<param name=ComboStyle			value="2">
				</OBJECT><%=HDConstant.COMMENT_END%>
			</td>
		</tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="<%=dirPath%>/Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcbn01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcDs1>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=ETD_DT           Ctrl=ETD_DT					Param=Text</C> 
		<C>Col=ETD_DT1          Ctrl=ETD_DT1				Param=Text</C> 
		<C>Col=LINE_PART        Ctrl=LINE_PART			Param=BindColVal</C> 
		<C>Col=PROJECT          Ctrl=PROJECT				Param=BindColVal</C>  
		<C>Col=CUST_CD          Ctrl=CUST_CD        Param=Text</C>
		<C>Col=CUST_PRSN        Ctrl=CUST_PRSN      Param=value</C> 
		<C>Col=CUST_TELNO       Ctrl=CUST_TELNO     Param=value</C> 
		<C>Col=CUST_HPNO        Ctrl=CUST_HPNO      Param=value</C> 
		<C>Col=SHIPPERHP        Ctrl=SHIPPERHP      Param=value</C>  
		<C>Col=CARGO_TYPE       Ctrl=CARGO_TYPE     Param=BindColVal</C> 
		<C>Col=DLVL_TYPE        Ctrl=DLVL_TYPE      Param=BindColVal</C> 
		<C>Col=DIV_IO						Ctrl=DIV_IO         Param=BindColVal</C>  
		<C>Col=DLVL_DATE        Ctrl=DLVL_DATE      Param=Text</C> 
		<C>Col=SHIPPER          Ctrl=SHIPPER        Param=Text</C>
		<C>Col=SHIPPERPS        Ctrl=SHIPPERPS      Param=value</C> 
		<C>Col=SHIPPERTEL       Ctrl=SHIPPERTEL     Param=value</C> 
		<C>Col=FEE_IN           Ctrl=FEE_IN					Param=BindColVal</C> 
		<C>Col=FEE_OUT          Ctrl=FEE_OUT				Param=BindColVal</C> 
		<C>Col=GORDER_NO        Ctrl=GORDER_NO      Param=value</C> 
		<C>Col=RQST_NO          Ctrl=RQST_NO        Param=value</C> 
		<C>Col=PL_TYPE          Ctrl=PL_TYPE        Param=value</C> 
		<C>Col=PL_SHIPPER       Ctrl=PL_SHIPPER     Param=value</C> 
		<C>Col=PL_SHPPRNM       Ctrl=PL_SHPPRNM     Param=value</C> 
		<C>Col=PL_SHIPADDR      Ctrl=PL_SHIPADDR    Param=value</C> 
		<C>Col=PL_SHIPTEL       Ctrl=PL_SHIPTEL     Param=value</C> 
		<C>Col=PL_CSTM          Ctrl=PL_CSTM        Param=value</C> 
		<C>Col=PL_CSTMNM        Ctrl=PL_CSTMNM      Param=value</C> 
		<C>Col=PL_CSTADDR       Ctrl=PL_CSTADDR     Param=value</C> 
		<C>Col=PL_CSTTEL				Ctrl=PL_CSTTEL      Param=value</C> 
		<C>Col=PL_BRKR          Ctrl=PL_BRKR        Param=value</C> 
		<C>Col=PL_BRKRNM        Ctrl=PL_BRKRNM      Param=value</C>
		<C>Col=PL_BRKADDR       Ctrl=PL_BRKADDR     Param=value</C> 
		<C>Col=PL_BRKTEL        Ctrl=PL_BRKTEL      Param=value</C> 
		<C>Col=RPST_GOODS       Ctrl=RPST_GOODS     Param=value</C> 
		<C>Col=TOTAL_CNT        Ctrl=TOTAL_CNT      Param=value</C> 
		<C>Col=TOTAL_UNIT       Ctrl=TOTAL_UNIT     Param=value</C> 
		<C>Col=TOTAL_WGHT       Ctrl=TOTAL_WGHT     Param=value</C> 
		<C>Col=TOTAL_CBM        Ctrl=TOTAL_CBM      Param=value</C> 
		<C>Col=CANCLE_DATE      Ctrl=CANCLE_DATE    Param=Text</C> 
		<C>Col=REMARK           Ctrl=REMARK					Param=value</C> 
		<C>Col=PRICETYPE        Ctrl=PRICETYPE      Param=value</C> 
		<C>Col=SETTLETYPE       Ctrl=SETTLETYPE     Param=value</C> 
		<C>Col=LC_NO            Ctrl=LC_NO					Param=value</C> 
		<C>Col=LC_DATE          Ctrl=LC_DATE				Param=value</C> 
		<C>Col=LC_BANK          Ctrl=LC_BANK				Param=value</C> 
		<C>Col=EXPRT_NO         Ctrl=EXPRT_NO				Param=value</C> 
		<C>Col=EXPRT_DATE       Ctrl=EXPRT_DATE     Param=value</C> 
		<C>Col=LDCARGONM        Ctrl=LDCARGONM			Param=value</C> 
		<C>Col=OFFCARGONM       Ctrl=OFFCARGONM			Param=value</C> 
		<C>Col=CONSIGNEE        Ctrl=CONSIGNEE			Param=value</C> 
		<C>Col=LDCARGO          Ctrl=LD_CAR					Param=BindColVal</C>
		<C>Col=OFFCARGO         Ctrl=OFF_CAR				Param=BindColVal</C>
		<C>Col=PL_SHPADDR2      Ctrl=PL_SHPADDR2    Param=value</C> 
		<C>Col=PL_SHPADDR3			Ctrl=PL_SHPADDR3    Param=value</C> 
		<C>Col=PL_CSTADDR2			Ctrl=PL_CSTADDR2    Param=value</C> 
		<C>Col=PL_CSTADDR3			Ctrl=PL_CSTADDR3    Param=value</C> 
		<C>Col=PL_BRKADDR2			Ctrl=PL_BRKADDR2    Param=value</C> 
		<C>Col=PL_BRKADDR3			Ctrl=PL_BRKADDR3    Param=value</C>
		<C>Col=PL_CSN           Ctrl=PL_CSN         Param=value</C>
		<C>Col=PL_CSNNM         Ctrl=PL_CSNNM       Param=value</C>
		<C>Col=PL_CSNTEL        Ctrl=PL_CSNTEL      Param=value</C>
		<C>Col=PL_CSNADDR       Ctrl=PL_CSNADDR     Param=value</C>
		<C>Col=PL_CSNADDR2      Ctrl=PL_CSNADDR2    Param=value</C>
		<C>Col=PL_CSNADDR3      Ctrl=PL_CSNADDR3    Param=value</C>
		<C>Col=FAC_PERSON				Ctrl=FAC_PERSON			Param=value</C>
		<C>Col=FAC_PRSTEL	      Ctrl=FAC_PRSTEL			Param=value</C>
		<C>Col=RECIPIENT	      Ctrl=txt_recipient	Param=value</C>
		<C>Col=RECP_OWN					Ctrl=txt_recp_own		Param=value</C>
		<C>Col=RECP_TEL					Ctrl=txt_recp_tel		Param=value</C>
		<C>Col=RECP_ADD					Ctrl=txt_recp_add		Param=value</C>
		<C>Col=OBJ_REMK					Ctrl=txt_obj_remk		Param=value</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcRpt01 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"	value="gcDsrpt1">
	<param name="DetailDataID"	value="gcDsrpt1">		
	<param name="PaperSize"			value="A4">		
	<param name="LandScape"     value="false"> 
	<param name="Format"				value="
		<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=516 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='CARGO MARK' ,left=3 ,top=219 ,right=2000 ,bottom=381 ,face='Times New Roman' ,size=35 ,bold=true ,underline=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=1731 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=194 ,top=44 ,right=1856 ,bottom=456 ,border=true</X>
			<C>id='Project', left=222, top=75, right=1831, bottom=416, face='Arial', size=21, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=753, top=1444, right=1778, bottom=1691, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
			<T>id='출   경   일  : ' ,left=200 ,top=637 ,right=741 ,bottom=741 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='발주업체명   : ' ,left=197 ,top=912 ,right=738 ,bottom=1016 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='품         명  : ' ,left=197 ,top=1187 ,right=738 ,bottom=1291 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='수         량  : ' ,left=197 ,top=1325 ,right=738 ,bottom=1428 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='비         고  : ' ,left=197 ,top=1462 ,right=738 ,bottom=1566 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CONSIGNEE', left=753, top=784, right=1428, bottom=887, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ETD_DT', left=753, top=637, right=1428, bottom=741, align='left' ,mask='XXXX-XX-XX', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='수   하   인  : ' ,left=197 ,top=784 ,right=738 ,bottom=887 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='SHIPPER_NM', left=753, top=912, right=1428, bottom=1016, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='공급업체명   : ' ,left=197 ,top=1050 ,right=738 ,bottom=1153 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CUST_NM', left=753, top=1050, right=1428, bottom=1153, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORDER_NO', left=753, top=491, right=1428, bottom=594, align='left', face='Arial', size=15, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='주 문 번 호  : ' ,left=200 ,top=491 ,right=741 ,bottom=594 ,align='left' ,face='새굴림' ,size=17 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='GOODS', left=753, top=1203, right=1775, bottom=1428, align='left', face='Arial', size=13, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true, Dec=0</C>
		</B>
		<B>id=Footer ,left=0 ,top=2395 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='Image' ,left=666 ,top=22 ,right=1244 ,bottom=269</I>
		</B>
	">
</OBJECT><%=HDConstant.COMMENT_END%>

</BODY>
</HTML>

