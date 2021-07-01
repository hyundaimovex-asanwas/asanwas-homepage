<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반입 P/L 및 C/I 관리
+ 프로그램 ID	:	TR00211.HTML
+ 기 능 정 의	:	반입 P/L 및 C/I 관리
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

<SCRIPT language=JavaScript>
	get_cookdata();

	var ls_type = "insert"  ; 
	var gs_plno = null ;
	var gsCnt = 0  ; 
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			Start();//선조회

			window.status="완료";

		}
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){

		initialize();		

		GetParam();

		ls_type = gs_parm[0]; 

		if( gs_parm[0]  == "update"){ // MODE 체크
			PL_NO.value = gs_parm[1];
			btn_write.style.display = "";
			btn_save.style.display = "";
			btn_delete.style.display = "";
			Search();
			ln_GetSum();
		} else if( ls_type == "insert"){
			gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlMaster?NOH=N";
			gcDs1.Reset();
			gcDs1.AddRow();
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=N";
			gcDs2.Reset();
		}	else if(ls_type =="make") { 
			gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlMaster?NOH=N";
			gcDs1.Reset();
			gcDs1.AddRow();
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=N";
			gcDs2.Reset();

			var selVal = gs_parm[1].split("/"); 
			for( i=0;i<selVal.length-1 ; i++)	AddPlDetail(selVal[i]);

			var selPos = gs_parm[2].split("/"); 
			LINE_PART.index = LINE_PART.IndexOfColumn("MINORCD", selPos[0]);
			START_DATE.text = selPos[1];

			var ls_project = LINE_PART.bindcolval;
			
			if(ls_project == '0001') {
				REACH_LCT.index = START_LCT.IndexOfColumn("MINORCD", "KROJG");
				START_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "KPKSN");
			} else if(ls_project == '0002') {
				REACH_LCT.index = START_LCT.IndexOfColumn("MINORCD", "KRGSG");
				START_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "KPGSG");
			} else {
				START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "KRDRS");
				REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "KPKSN");
			}

			gcDs1.NameValue(gcDs1.RowPosition ,"PACKING_UNIT")	= "0059"; 
			PACKING_UNIT.value =  "기타";

			ln_GetSum();
			getSum();

			gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO") = selVal[0];
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function AddPlDetail(order_no) { 
		gcDs_etc0.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsMakePl2?NOH=Y&gstr0=I&gstr1="+order_no ; 
		gcDs_etc0.Reset() ; 

		if(gcDs_etc0.CountRow > 0 ) {
			RPR_GOODS.value = gcDs_etc0.NameValue(i,"ARTC_NM");

			for( var i = 1 ; i<=gcDs_etc0.CountRow ; i++ ) {
				gsCnt = gsCnt*1 + 1*1 ; 
				gcDs2.AddRow();
				gcDs2.NameValue(gsCnt,"PL_SEQNO")			= gsCnt ; 
				gcDs2.NameValue(gsCnt,"CAR_NO")				= gcDs_etc0.NameValue(i,"CAR_NO") ; 
				gcDs2.NameValue(gsCnt,"CNTN_NO")			= ""  ;
				gcDs2.NameValue(gsCnt,"CNTN_SDSZ")		= ""  ;
				gcDs2.NameValue(gsCnt,"CNTN_SLNO")		= ""  ;
				gcDs2.NameValue(gsCnt,"GOODS_CD")			= gcDs_etc0.NameValue(i,"ARTC_CD") ; 
				gcDs2.NameValue(gsCnt,"GOODS_NM")			= gcDs_etc0.NameValue(i,"ARTC_NM") ; 
				gcDs2.NameValue(gsCnt,"GOODS_ENM")		= "" ; 
				gcDs2.NameValue(gsCnt,"PACKING_NO")		= "" ; 
				gcDs2.NameValue(gsCnt,"PACKING_CNT")	= gcDs_etc0.NameValue(i,"PUNIT_CNT") ; 
				gcDs2.NameValue(gsCnt,"STDRD_SZ")			= gcDs_etc0.NameValue(i,"STN_SZNM") ; 
				gcDs2.NameValue(gsCnt,"HS_CODE")			= gcDs_etc0.NameValue(i,"HSCODE") ; 
				gcDs2.NameValue(gsCnt,"GOODS_CNT")		= gcDs_etc0.NameValue(i,"ARTC_CNT") ; 
				gcDs2.NameValue(gsCnt,"CNT_UNIT")			= gcDs_etc0.NameValue(i,"ARTC_UNIT") ; 
				gcDs2.NameValue(gsCnt,"UNIT_PRICE")		= gcDs_etc0.NameValue(i,"UNIT_PRICE") ; 
				gcDs2.NameValue(gsCnt,"PRICE")				= gcDs_etc0.NameValue(i,"PRICE1") ; 
				gcDs2.NameValue(gsCnt,"PKC_CNT")			= gcDs_etc0.NameValue(i,"PUNIT_CNT1") ; 
				gcDs2.NameValue(gsCnt,"PKG_WEIGHT")		= gcDs_etc0.NameValue(i,"PUNIT_WEIGHT") ; 
				gcDs2.NameValue(gsCnt,"PKG_LNGTH")		= gcDs_etc0.NameValue(i,"PKG_LNGTH") ; 
				gcDs2.NameValue(gsCnt,"PKG_HEIGHT")		= gcDs_etc0.NameValue(i,"PKG_HEIGHT") ; 
				gcDs2.NameValue(gsCnt,"PKG_WIDTH")		= gcDs_etc0.NameValue(i,"PKG_WIDTH") ; 
				gcDs2.NameValue(gsCnt,"PKG_CBM")			= gcDs_etc0.NameValue(i,"CBM") ; 
				gcDs2.NameValue(gsCnt,"PKG_UNIT")			= gcDs_etc0.NameValue(i,"PUNIT_UNIT") ; 
				gcDs2.NameValue(gsCnt,"PR_WEIGHT")		= gcDs_etc0.NameValue(i,"TOTAL_WEIGHT1") ; 
				gcDs2.NameValue(gsCnt,"PT_WEIGHT")		= gcDs_etc0.NameValue(i,"TOTAL_WEIGHT2") ; 
				gcDs2.NameValue(gsCnt,"T_WEIGHT")			= gcDs_etc0.NameValue(i,"TOTAL_WEIGHT2") ; 
				gcDs2.NameValue(gsCnt,"T_CNT")				= gcDs_etc0.NameValue(i,"TOTAL_WEIGHT") ; 
				gcDs2.NameValue(gsCnt,"T_CBM")				= gcDs_etc0.NameValue(i,"TOTAL_CBM") ; 
				gcDs2.NameValue(gsCnt,"ORDER_NO")			= gcDs_etc0.NameValue(i,"ORDER_NO") ; 
				gcDs2.NameValue(gsCnt,"ORDER_SEQ")		= gcDs_etc0.NameValue(i,"ORDER_SEQ") ;  
				gcDs2.NameValue(gsCnt,"CREATE_USR")		= gusrid;
				gcDs2.NameValue(gsCnt,"UPDATE_USR")		= gusrid;
			}
		}
	}

	/******************************************************************************
		Description : 작성
	******************************************************************************/ 
	function New_Insert(){
		if (gcDs2.countrow<1) {
			alert("차량정보가 존재치 않을 경우 물품을 추가하실 수 없습니다.");
			return;
		}

		var vrow = gcDs2.rowposition;
		var vmsg = "차량번호 " + gcDs2.namevalue(vrow,"CAR_NO") + " 에 물품정보를 추가하시겠습니까 ?";
		
		if (!confirm(vmsg)) return;

		gcDs2.InsertRow(vrow+1);
		var row = gcDs2.rowposition;
		gcDs2.NameValue(row,"PL_NO")				= gcDs2.NameValue(vrow,"PL_NO");
		gcDs2.NameValue(row,"PL_SEQNO")			= gcDs2.Max(2,0,0)+1; 
		gcDs2.NameValue(row,"CAR_NO")				= gcDs2.NameValue(vrow,"CAR_NO")
		gcDs2.NameValue(row,"GOODS_CD")			= "9999";
		gcDs2.NameValue(row,"CREATE_USR")		= gusrid;
		gcDs2.NameValue(row,"UPDATE_USR")		= gusrid;
	}

	/******************************************************************************
		Description : 물품 상세 삭제
	******************************************************************************/ 
	function ln_Delete(){
		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
			if (!confirm("선택하신 Packing List Detail 정보를 삭제 하시겠습니까? ")) return;

			gcDs2.deleterow(row);
			gcTr02.KeyValue = "trPlMastar(I:USER=gcDs2)";
			gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlDetail";
			gcTr02.Parameters = "gstr1="+gs_plno ; ///pl_no
			gcTr02.post(); 
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function getSum(){
		WEIGHT.Text = gcDs2.Sum(gcDs2.ColumnIndex('T_WEIGHT'),0,0);
		gcem_amt.Text = gcDs2.Sum(gcDs2.ColumnIndex('PRICE'),0,0);
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_GetSum(){
		var v_weight = 0;
		var v_cbm = 0;
		for (var i=1; i<=gcDs2.countrow; i++){
			var v_1 = gcDs2.namevalue(i,"GOODS_CNT");
			var v_2 = gcDs2.namevalue(i,"PKC_CNT");
			if (v_1 != null && v_1 != "" && v_2 != null && v_2 != "") {
				var v_3 = v_1/v_2;
				v_weight = v_weight + v_3*gcDs2.namevalue(i,"PKG_WEIGHT");
				v_cbm = v_cbm + v_3*gcDs2.namevalue(i,"PKG_CBM");
			}
		}

		gcem_amt.Text = gcDs2.Sum(gcDs2.ColumnIndex('PRICE'),0,0);
		PACKING_CNT.text = gcDs2.Sum(gcDs2.ColumnIndex('PKC_CNT'),0,0);
		PACKING_CBM.text = gcDs2.Sum(gcDs2.ColumnIndex('GOODS_CNT'),0,0);

		T_WEIGHT.Text = v_weight;
		T_CBM.Text = v_cbm;

		TRANS_CAR.value = gcDs2.namevalue(1,"CAR_NO") + " 외";
	}
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function initialize(){
		gcDs_etc6.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //단위 
		gcDs_etc6.Reset();

		gcDs_etc7.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //단위 
		gcDs_etc7.Reset();

		gcDs_etc20.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc20.Reset();

		gcDs_etc11.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //상차지 
		gcDs_etc11.Reset();

		gcDs_etc12.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //하차지 
		gcDs_etc12.Reset(); 
		
		gcDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=N" ; 
		gcDs3.Reset() ; 

	}
 
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Search() {
		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlMaster?NOH=Y&gstr0=I&gstr1=" + PL_NO.value; 
		gcDs1.Reset();

		gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=Y&gstr1=" + PL_NO.value; 
		gcDs2.Reset();
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
		ls_type ="update";
		btn_write.style.display = "";
		btn_save.style.display = "";
		btn_delete.style.display = "";
		Search();
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Save(){

		if( !MasterDataCheck) {return false ; }

		if (!confirm("입력하신 Packing List 정보를 저장하시겠습니까? ")) return;

		if (ls_type =="insert"|| ls_type =="make"){
			
			var ls_yymm =  START_DATE.Text.substring(2,6) ; 
			gcDs_etc.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetSeqNo?NOH=Y&gstr1=0002&gstr2=" + ls_yymm;  //
			gcDs_etc.Reset();   
			if(gcDs_etc.CountRow == 1 ) gs_plno = 'IP' + ls_yymm +  gcDs_etc.NameValue(1,"SEQ_NO")  ; 
			
			gcDs1.NameValue(1,"IN_OUT")  = "I" ; 
		}

		if (gs_plno==null || gs_plno == "") gs_plno = gcDs1.namevalue(1,"PL_NO");

		gcTr01.KeyValue = "trPlMastar(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlMastar";
		gcTr01.Parameters = "gstr1="+gs_plno ; //pl_no 
		gcTr01.post(); 

		gcTr02.KeyValue = "trPlMastar(I:USER=gcDs2)";
		gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlDetail";
		gcTr02.Parameters = "gstr1="+gs_plno ; ///pl_no
		gcTr02.post(); 

		ls_type = "update" ; 
		
		alert("반입 P/L 및 C/I정보가 정상적으로 저장되었습니다.");
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function DetailSave(){
		if (!confirm("입력하신 Packing List Detail 정보를 저장하시겠습니까? ")) return;

		gcTr02.KeyValue = "trPlMastar(I:USER=gcDs2)";
		gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlDetail";
		gcTr02.Parameters = "gstr1="+gs_plno ; ///pl_no
		gcTr02.post(); 
	}

	/******************************************************************************
		Description :  DataCheck : PL 마스터 
	******************************************************************************/
	function MasterDataCheck(){
		if (gcDs1.NameValue(1,"IN_OUT") == null ||  strim(gcDs1.NameValue(1,"IN_OUT")) =="" ){
			alert("반입반출 누락") ; return false ; 
		}
		if (gcDs1.NameValue(1,"PL_SHIPPER") == null ||  strim(gcDs1.NameValue(1,"PL_SHIPPER")) =="" ){
			alert("송하인 코드 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"PL_SHPPRNM") == null ||  strim(gcDs1.NameValue(1,"PL_SHPPRNM")) =="" ){
			alert("송하인명 누락") ; return false ; 
		}
 
		if (  strim(gcDs1.NameValue(1,"PL_SHPADD1") + gcDs1.NameValue(1,"PL_SHPADD2") + gcDs1.NameValue(1,"PL_SHPADD3")).length  == 0  ){
			alert("송하인주소 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"PL_CSTM") == null ||  strim(gcDs1.NameValue(1,"PL_CSTM")) =="" ){
			alert("수하인 코드 누락") ; return false ; 
		} 

		if (gcDs1.NameValue(1,"PL_CSTMNM") == null ||  strim(gcDs1.NameValue(1,"PL_CSTMNM")) =="" ){
			alert("수하인명 누락") ; return false ; 
		}

		if (  strim(gcDs1.NameValue(1,"PL_CSTADD1") + gcDs1.NameValue(1,"PL_CSTADD2") + gcDs1.NameValue(1,"PL_CSTADD3")).length  == 0  ){
			alert("송하인명 누락") ; return false ; 
		}
		
		if (gcDs1.NameValue(1,"PL_BRKR") == null ||  strim(gcDs1.NameValue(1,"PL_BRKR")) =="" ){
			alert("통지선 코드 누락") ; return false ; 
		} 

		if (gcDs1.NameValue(1,"PL_BRKRNM") == null ||  strim(gcDs1.NameValue(1,"PL_BRKRNM")) =="" ){
			alert("통지선명 누락") ; return false ; 
		}

		if (  strim(gcDs1.NameValue(1,"PL_BRKADD1") + gcDs1.NameValue(1,"PL_BRKADD2") + gcDs1.NameValue(1,"PL_BRKADD3")).length  == 0  ){
			alert("송하인명 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"START_LCT") == null ||  strim(gcDs1.NameValue(1,"START_LCT")) =="" ){
			alert("출발지 누락") ; return false ; 
		}
		if (gcDs1.NameValue(1,"REACH_LCT") == null ||  strim(gcDs1.NameValue(1,"REACH_LCT")) =="" ){
			alert("도착지 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"TRANS_CAR") == null ||  strim(gcDs1.NameValue(1,"TRANS_CAR")) =="" ){
			alert("운송차량 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"TRANS_CAR") == null ||  strim(gcDs1.NameValue(1,"TRANS_CAR")) =="" ){
			alert("운송차량 누락") ; return false ; 
		}


		if (gcDs1.NameValue(1,"INVOICE_NO") == null ||  strim(gcDs1.NameValue(1,"INVOICE_NO")) =="" ){
			alert("송장번호 누락") ; return false ; 
		}

		if (gcDs1.NameValue(1,"INVOICE_DT") == null ||  strim(gcDs1.NameValue(1,"INVOICE_DT")) =="" ){
			alert("송장일자 누락") ; return false ; 
		}

		return true ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function CallShipper(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			PL_SHPPRNM.value  = PopWinValue[1] ; 
			PL_SHPTEL.value		= PopWinValue[4] ; 
			PL_SHPADD1.value  = PopWinValue[7] ;
			PL_SHPADD2.value  = PopWinValue[8] ; 
		} 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function CallCustomer(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			PL_CSTMNM.value		= PopWinValue[1] ; 
			PL_CSTTEL.value		= PopWinValue[4] ; 
			PL_CSTADD1.value  = PopWinValue[7] ;
			PL_CSTADD2.value  = PopWinValue[8] ; 
		} 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function CallBroker(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			PL_BRKRNM.value		= PopWinValue[1] ; 
			PL_BRKTEL.value		= PopWinValue[4] ; 
			PL_BRKADD1.value	= PopWinValue[7] ;
			PL_BRKADD2.value	= PopWinValue[8] ; 
		} 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function CallBroker2(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			PL_CSNNM.value		= PopWinValue[1] ; 
			PL_CSNTEL.value		= PopWinValue[4] ; 
			PL_CSNADDR.value	= PopWinValue[7] ;
			PL_CSNADDR2.value	= PopWinValue[8] ; 
		} 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function callUnit() {
		strURL = "TR00000_E1.html";
		PopupOpenDialog(400,420) ;		
		if(PopWinValue != null ){
			gcDs1.NameValue(gcDs1.RowPosition ,"PACKING_UNIT")	= PopWinValue[0] ; 
			PACKING_UNIT.value =  PopWinValue[1] ; 
		}
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "= 선택 =" ;  
	}

	/******************************************************************************
		Description :  프린트
	******************************************************************************/
	function ln_Print(){

		if (gcDs2.countrow<1) return;

		var arrParam	= new Array();
		var sPramRtn = window.showModalDialog("tr00111_popup01.html","","dialogWidth:370px;dialogHeight:180px;scroll:0;help:0;status:0");

		if (sPramRtn != null) arrParam = sPramRtn.split(";");
		
		if (arrParam[0]!="A" && arrParam[0]!="B") return;

		var ls_format = "";
		var ls_l1 = ",border=true, penstyle=solid ,penwidth=3 </L>";
		var ls_l2 = ",border=true, penstyle=solid ,penwidth=2 </L>";

		ls_format +="		<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=132 ,pageskip=true";
		ls_format +="			<R>id='Packing List.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132, MasterDataID='gcDs1'";
		ls_format +="				<B>id=DHeader	,left=0	,top=0 ,right=2000 ,bottom=515 ,face='굴림' ,size=10 ,penwidth=1, backcolor=#FFFFFF";
		ls_format +="					<L>left=25		,top=160  ,right=1855 ,bottom=160		" + ls_l1;
		ls_format +="					<L>left=25		,top=310  ,right=1855 ,bottom=310		" + ls_l1;
		ls_format +="					<L>left=25		,top=630  ,right=1000 ,bottom=630		" + ls_l1;
		ls_format +="					<L>left=25		,top=950  ,right=1000 ,bottom=950		" + ls_l1;
		ls_format +="					<L>left=25		,top=1090 ,right=1000 ,bottom=1090	" + ls_l1;
		ls_format +="					<L>left=25		,top=1230 ,right=1855 ,bottom=1230	" + ls_l1;
		ls_format +="					<L>left=1170	,top=2650 ,right=1855 ,bottom=2650	" + ls_l1;
		ls_format +="					<L>left=1000	,top=160	,right=1000 ,bottom=1230	" + ls_l1;
		ls_format +="					<L>left=500		,top=950	,right=500  ,bottom=1230	" + ls_l1;
		ls_format +="					<L>left=25		,top=2720 ,right=1855 ,bottom=2720	" + ls_l1;

		if (arrParam[0]=="A") ls_format +="					<T>id='PACKING LIST' ,left=25 ,top=20 ,right=1855 ,bottom=120 ,face='굴림' ,size=20 ,bold=true ,backcolor=#FFFFFF</T>";
		else ls_format +="					<T>id='COMMERCIAL INVOICE' ,left=25 ,top=20 ,right=1855 ,bottom=120 ,face='굴림' ,size=20 ,bold=true ,backcolor=#FFFFFF</T>";

		ls_format +="					<T>id='1.송하인/수출자'		,left=30	,top=160	,right=1000 ,bottom=230 ,align=left</T>";

		var row = gcDs1.rowposition;

		var vnm11 = gcDs1.namevalue(row,"PL_SHPPRNM");
		
		ls_format +="					<T>id='" + vnm11 + "' ,left=430 ,top=160	,right=1000 ,bottom=230 ,align=left</T>";
		ls_format +="					<T>id='위탁자'						,left=63	,top=230	,right=1000 ,bottom=310 ,align=left</T>";
		ls_format +="					<T>id='8.송장번호 및 일자'		,left=1010	,top=160	,right=1855 ,bottom=230 ,align=left</T>";
		ls_format +="					<C>id='DCL_NO'		,left=1043	,top=230	,right=1855 ,bottom=310 ,align=left</C>";
		ls_format +="  				<C>id='DCL_DATE'						,left=1043	,top=230	,right=1825 ,bottom=310 ,align=right	,Mask='XXXX.XX.XX'</C>";
		ls_format +="					<T>id='2.수하인'							,left=30	,top=310 ,right=1000 ,bottom=380 ,align=left</T>";

		var vnm21 = gcDs1.namevalue(row,"PL_CSTMNM");
		var vnm22 = gcDs1.namevalue(row,"PL_CSTADD1");
		var vnm23 = gcDs1.namevalue(row,"PL_CSTADD2");
		var vnm24 = gcDs1.namevalue(row,"PL_CSTADD3");
		var vnm25 = gcDs1.namevalue(row,"PL_CSTTEL");

		ls_format +="					<T>id='" + vnm21 + "'			,left=63	,top=400 ,right=1000 ,bottom=470 ,align=left</T>";
		ls_format +="					<T>id='" + vnm22 + " " + vnm23 + " " + vnm24 + "'				,left=63	,top=470 ,right=1000 ,bottom=540 ,align=left</T>";
		ls_format +="					<T>id='" + vnm25 + "'	,left=63	,top=540 ,right=1000 ,bottom=610 ,align=left</T>";

		ls_format +="					<T>id='9.비고'								,left=1010	,top=310 ,right=1855 ,bottom=380 ,align=left</T>";
		ls_format +="					<C>id='REMARK'								,left=1043	,top=400 ,right=1855 ,bottom=1200 ,align=left, multiline=true</C>";
		ls_format +="					<T>id='3.통지선'							,left=30 ,top=630 ,right=1000 ,bottom=700 ,align=left</T>";

		var vnm31 = gcDs1.namevalue(row,"PL_BRKRNM");
		var vnm32 = gcDs1.namevalue(row,"PL_BRKADD1");
		var vnm33 = gcDs1.namevalue(row,"PL_BRKADD2");
		var vnm34 = gcDs1.namevalue(row,"PL_BRKADD3");
		var vnm35 = gcDs1.namevalue(row,"PL_BRKTEL");

		ls_format +="					<T>id='" + vnm31 + "'			,left=63 ,top=720 ,right=1000 ,bottom=790 ,align=left</T>";
		ls_format +="					<T>id='" + vnm32 + " " + vnm33 + " " + vnm34 + "'				,left=63 ,top=790 ,right=1000 ,bottom=860 ,align=left</T>";
		ls_format +="					<T>id='" + vnm35 + "'	,left=63 ,top=860 ,right=1000 ,bottom=930 ,align=left</T>";
		ls_format +="					<T>id='4.출발지'	,left=30  ,top=950	,right=1000 ,bottom=1020 ,align=left</T>";
		ls_format +="					<T>id='" +  START_LCT.ValueOfIndex("MINORNM", START_LCT.index) + "'		,left=230 ,top=1010	,right=1000 ,bottom=1080 ,align=left</T>";
		ls_format +="					<T>id='5.목적지'	,left=510 ,top=950	,right=1000 ,bottom=1020 ,align=left</T>";
		ls_format +="					<T>id='" +  REACH_LCT.ValueOfIndex("MINORNM", REACH_LCT.index) + "'			,left=710 ,top=1010	,right=1000 ,bottom=1080 ,align=left</T>";
		ls_format +="					<T>id='6.운송차량'		,left=30  ,top=1090	,right=1000 ,bottom=1160 ,align=left</T>";
		ls_format +="					<C>id='TRANS_CAR'	,left=230 ,top=1150	,right=1000 ,bottom=1220 ,align=left</C>";
		ls_format +="					<T>id='7.출발일'			,left=510 ,top=1090	,right=1000 ,bottom=1160 ,align=left</T>";
		ls_format +="					<C>id='START_DT'		,left=710 ,top=1150	,right=1000 ,bottom=1220 ,align=left	,Mask='XXXX.XX.XX'</C>";
		ls_format +="					<T>id='10.포장표식 및 포장수량'		,left=30  ,top=1240	,right=1000 ,bottom=1310 ,align=left</T>";
		ls_format +="					<T>id='11.품명'					,left=380   ,top=1240	,right=860  ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
		ls_format +="					<T>id='12.수량/단위'		,left=850   ,top=1240	,right=1100 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";

		if (arrParam[0]=="A") {
			
			ls_format +="					<T>id='13.순중량(KG)'		,left=1100  ,top=1240	,right=1350 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='14.총중량(KG)'		,left=1350  ,top=1240	,right=1600 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='15.용적(CBM)'		,left=1600  ,top=1240	,right=1855 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='" + gcDs1.namevalue(gcDs1.rowposition,"PACKING_CNT") + " " + gcDs1.namevalue(gcDs1.rowposition,"PACKING_UNIT") + "'					,left=30		,top=1330	,right=380 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<C>id='RPR_GOODS'		,left=380   ,top=1330	,right=860  ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<C>id='{DECODE(PACKING_CBM,0,'',PACKING_CBM)}'	,left=850   ,top=1330	,right=1100 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center, Dec=0</C>";
			ls_format +="					<C>id='WEIGHT'			,left=1100  ,top=1330	,right=1350 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center, Dec=0</C>";
			ls_format +="					<C>id='T_WEIGHT'		,left=1350  ,top=1330	,right=1600 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center, Dec=0</C>";
			ls_format +="					<C>id='T_CBM'				,left=1600  ,top=1330	,right=1855 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<T>id='///////////////////////////////////////////////////////////////////////////'			,left=30		,top=1480	,right=1855 ,bottom=1550 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='- 유첨 명세 참조'			,left=700		,top=1580	,right=1855 ,bottom=1650 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='16.연락처'				,left=30		,top=2600	,right=380  ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='02) 3669-3703'		,left=230		,top=2600	,right=1000 ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='17.서  명'				,left=1010	,top=2600	,right=1380  ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="				</B>";
			ls_format +="			</R>";
			ls_format +="		</A>";
			ls_format +="		<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=132";
			ls_format +="			<R>id='Packing List Detail.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132, DetailDataID='gcDs2' ,SuppressColumns='1:CAR_NO'";
			ls_format +="				<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=210 ,face='굴림' ,size=7 ,penwidth=1 , backcolor=#DDDDDD";
			ls_format +="					<T>id='PACKING LIST' ,left=30 ,top=20 ,right=1855 ,bottom=120 ,face='굴림' ,size=13 ,bold=true ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<X>left=25		,top=120 ,right=1855	,bottom=210	,border=true, penstyle=solid ,penwidth=3, backcolor=#DDDDDD </X>";
			ls_format +="					<L>left=155		,top=120  ,right=155 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=245		,top=120  ,right=245 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=555		,top=120  ,right=555 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=865		,top=120  ,right=865 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=945		,top=120  ,right=945 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1055	,top=120  ,right=1055,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1175	,top=120  ,right=1175,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1295	,top=120  ,right=1295,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1395	,top=120  ,right=1395,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1495	,top=120  ,right=1495,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1595	,top=120  ,right=1595,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1705	,top=120  ,right=1705,bottom=210		" + ls_l2;
			ls_format +="					<T>id='차량번호'			,left=30		,top=120 ,right=150		,bottom=210 </T>";
			ls_format +="					<T>id='포장수'				,left=160		,top=120 ,right=240		,bottom=210 </T>";
			ls_format +="					<T>id='품  명(영문명)',left=250		,top=120 ,right=550		,bottom=210 </T>";
			ls_format +="					<T>id='규  격'				,left=560		,top=120 ,right=860		,bottom=210 </T>";
			ls_format +="					<T>id='단위'					,left=870		,top=120 ,right=940		,bottom=210 </T>";
			ls_format +="					<T>id='수량'					,left=950		,top=120 ,right=1050	,bottom=210 </T>";
			ls_format +="					<T>id='순중량'				,left=1060	,top=130 ,right=1170	,bottom=175 </T>";
			ls_format +="					<T>id='(KG)'					,left=1060	,top=165 ,right=1170	,bottom=210 </T>";
			ls_format +="					<T>id='총중량'				,left=1180	,top=130 ,right=1290	,bottom=175 </T>";
			ls_format +="					<T>id='(KG)'					,left=1180	,top=165 ,right=1290	,bottom=210 </T>";
			ls_format +="					<T>id='길이'					,left=1300	,top=130 ,right=1390	,bottom=175 </T>";
			ls_format +="					<T>id='(CM)'					,left=1300	,top=165 ,right=1390	,bottom=210 </T>";
			ls_format +="					<T>id='폭'						,left=1400	,top=130 ,right=1490	,bottom=175 </T>";
			ls_format +="					<T>id='(CM)'					,left=1400	,top=165 ,right=1490	,bottom=210 </T>";
			ls_format +="					<T>id='높이'					,left=1500	,top=130 ,right=1590	,bottom=175 </T>";
			ls_format +="					<T>id='(CM)'					,left=1500	,top=165 ,right=1590	,bottom=210 </T>";
			ls_format +="					<T>id='용적'					,left=1600	,top=130 ,right=1700	,bottom=175 </T>";
			ls_format +="					<T>id='(CBM)'					,left=1600	,top=165 ,right=1700	,bottom=210 </T>";
			ls_format +="					<T>id='비고'					,left=1710	,top=120 ,right=1850	,bottom=210 </T>";
			ls_format +="				</B>";
			ls_format +="				<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=40 ,face='굴림' ,size=7 ,penwidth=1";
			ls_format +="					<L>left=25		,top=0  ,right=25	 ,bottom=40		" + ls_l1;
			ls_format +="					<L>left=155		,top=0  ,right=155 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=245		,top=0  ,right=245 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=555		,top=0  ,right=555 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=865		,top=0  ,right=865 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=945		,top=0  ,right=945 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1055	,top=0  ,right=1055,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1175	,top=0  ,right=1175,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1295	,top=0  ,right=1295,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1395	,top=0  ,right=1395,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1495	,top=0  ,right=1495,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1595	,top=0  ,right=1595,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1705	,top=0  ,right=1705,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1855	,top=0  ,right=1855,bottom=40		" + ls_l1;
			ls_format +="					<C>id='CAR_NO'			,left=30		,top=0 ,right=150		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left	,supplevel=1</C>";
			ls_format +="					<C>id='{DECODE(PKC_CNT,0,'',PKC_CNT)}'			,left=160		,top=0 ,right=240		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center, dec=0</C>";
			ls_format +="					<C>id='GOODS_NM'		,left=250		,top=0 ,right=550		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='STDRD_SZ'		,left=560		,top=0 ,right=860		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='CNT_UNIT1'		,left=870		,top=0 ,right=940		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<C>id='{DECODE(GOODS_CNT,0,'',GOODS_CNT)}'		,left=950		,top=0 ,right=1050	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WEIGHT,0,'',PKG_WEIGHT)}'	,left=1060	,top=0 ,right=1170	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WEIGHT,0,'',PKG_WEIGHT)}'	,left=1180	,top=0 ,right=1290	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_LNGTH,0,'',PKG_LNGTH)}'		,left=1300	,top=0 ,right=1390	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_HEIGHT,0,'',PKG_HEIGHT)}'	,left=1400	,top=0 ,right=1490	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WIDTH,0,'',PKG_WIDTH)}'		,left=1500	,top=0 ,right=1590	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_CBM,0,'',PKG_CBM)}'				,left=1600	,top=0 ,right=1700	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right</C>";
			ls_format +="					<C>id='REMARK'			,left=1710	,top=0 ,right=1850	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<L>left=25	,top=0	,right=1855	,bottom=0		,border=true, penstyle=solid ,penwidth=1	,supplevel=1</L>";
			ls_format +="				</B>";
			ls_format +="				<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=70 ,face='굴림' ,size=7 ,penwidth=1";
			ls_format +="					<L>left=25		,top=0		,right=25		,bottom=70		" + ls_l1;
			ls_format +="					<L>left=1855	,top=0		,right=1855 ,bottom=70		" + ls_l1;
			ls_format +="					<L>left=25		,top=0		,right=1855 ,bottom=0			" + ls_l1;
			ls_format +="					<L>left=25		,top=70		,right=1855 ,bottom=70		" + ls_l1;
			ls_format +="					<L>left=1055	,top=0  ,right=1055,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1175	,top=0  ,right=1175,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1295	,top=0  ,right=1295,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1395	,top=0  ,right=1395,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1495	,top=0  ,right=1495,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1595	,top=0  ,right=1595,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1705	,top=0  ,right=1705,bottom=70		" + ls_l2;
			ls_format +="					<T>id='총    계'					,left=25		,top=0 ,right=1050	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<S>id='{SUM(PKG_WEIGHT)}'	,left=1060	,top=0 ,right=1170	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</S>";
			ls_format +="					<S>id='{SUM(PKG_WEIGHT)}'	,left=1180	,top=0 ,right=1290	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</S>";
			ls_format +="					<S>id='{SUM(PKG_CBM)}'		,left=1600	,top=0 ,right=1700	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right</S>";
			ls_format +="				</B>";
			ls_format +="			</R>";
			ls_format +="		</A>";

			gcrp_print.DetailDataID="gcDs2";

		} else if (arrParam[0]=="B"){
			ls_format +="					<T>id='13.단가'		,left=1150  ,top=1240	,right=1500 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='14.금액'		,left=1500  ,top=1240	,right=1855 ,bottom=1310 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='" + gcDs1.namevalue(gcDs1.rowposition,"PACKING_CNT") + " " + gcDs1.namevalue(gcDs1.rowposition,"PACKING_UNIT") + "'					,left=30		,top=1330	,right=380 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<C>id='RPR_GOODS'		,left=380   ,top=1330	,right=860  ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<C>id='{DECODE(PACKING_CBM,0,'',PACKING_CBM)}'	,left=850   ,top=1330	,right=1100 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center, Dec=0</C>";
			ls_format +="					<T>id='///////////////////////////////////////////////////////////////////////////'			,left=30		,top=1480	,right=1855 ,bottom=1550 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<T>id='- 유첨 명세 참조'			,left=700		,top=1580	,right=1855 ,bottom=1650 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='15.연락처'				,left=30		,top=2600	,right=380  ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='02) 3669-3703'		,left=230		,top=2600	,right=1000 ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<T>id='16.서  명'				,left=1010	,top=2600	,right=1380  ,bottom=2670 ,face='굴림' ,size=10 ,bold=false ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="				</B>";
			ls_format +="			</R>";
			ls_format +="		</A>";
			ls_format +="		<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=132";
			ls_format +="			<R>id='Commercial Invoice Detail.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132, DetailDataID='gcDs3' ,SuppressColumns='1:CAR_NO'";
			ls_format +="				<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=210 ,face='굴림' ,size=7 ,penwidth=1 , backcolor=#DDDDDD";
			ls_format +="					<T>id='COMMERCIAL INVOICE' ,left=30 ,top=20 ,right=1855 ,bottom=120 ,face='굴림' ,size=13 ,bold=true ,backcolor=#FFFFFF, align=left</T>";
			ls_format +="					<X>left=25		,top=120 ,right=1855	,bottom=210	,border=true, penstyle=solid ,penwidth=3, backcolor=#DDDDDD </X>";
			ls_format +="					<L>left=155		,top=120  ,right=155 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=245		,top=120  ,right=245 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=555		,top=120  ,right=555 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=865		,top=120  ,right=865 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=945		,top=120  ,right=945 ,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1055	,top=120  ,right=1055,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1295	,top=120  ,right=1295,bottom=210		" + ls_l2;
			ls_format +="					<L>left=1495	,top=120  ,right=1495,bottom=210		" + ls_l2;
			ls_format +="					<T>id='차량번호'			,left=30		,top=120 ,right=150		,bottom=210 </T>";
			ls_format +="					<T>id='포장수'				,left=160		,top=120 ,right=240		,bottom=210 </T>";
			ls_format +="					<T>id='품  명(영문명)',left=250		,top=120 ,right=550		,bottom=210 </T>";
			ls_format +="					<T>id='규  격'				,left=560		,top=120 ,right=860		,bottom=210 </T>";
			ls_format +="					<T>id='단위'					,left=870		,top=120 ,right=940		,bottom=210 </T>";
			ls_format +="					<T>id='수량'					,left=950		,top=120 ,right=1050	,bottom=210 </T>";
			ls_format +="					<T>id='단가(원)'			,left=1060	,top=120 ,right=1290	,bottom=210 </T>";
			ls_format +="					<T>id='금액(원)'			,left=1300	,top=120 ,right=1490	,bottom=210 </T>";
			ls_format +="					<T>id='비고'					,left=1500	,top=120 ,right=1850	,bottom=210 </T>";
			ls_format +="				</B>";
			ls_format +="				<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=40 ,face='굴림' ,size=7 ,penwidth=1";

			ls_format +="					<L>left=25		,top=0  ,right=25	 ,bottom=40		" + ls_l1;
			ls_format +="					<L>left=155		,top=0  ,right=155 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=245		,top=0  ,right=245 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=555		,top=0  ,right=555 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=865		,top=0  ,right=865 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=945		,top=0  ,right=945 ,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1055	,top=0  ,right=1055,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1295	,top=0  ,right=1295,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1495	,top=0  ,right=1495,bottom=40		" + ls_l2;
			ls_format +="					<L>left=1855	,top=0  ,right=1855,bottom=40		" + ls_l1;

	//		ls_format +="					<L>left=245	,top=0  ,right='{(245)}',bottom=0		" + ls_l1;

			ls_format +="					<C>id='CAR_NO'			,left=30		,top=0 ,right=150		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left	,supplevel=1</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'','',DECODE(PKC_CNT,0,'',PKC_CNT))}'			,left=160		,top=0 ,right=240		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center, dec=0</C>";
			ls_format +="					<C>id='GOODS_NM'		,left=250		,top=0 ,right=550		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'',\'소계\',STDRD_SZ)}'		,left=560		,top=0 ,right=860		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'','',CNT_UNIT1)}'		,left=870		,top=0 ,right=940		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'','',DECODE(GOODS_CNT,0,'',GOODS_CNT))}'		,left=950		,top=0 ,right=1050	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'','',DECODE(UNIT_PRICE,0,'',UNIT_PRICE))}'	,left=1060	,top=0 ,right=1290	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PRICE,0,'',PRICE)}'	,left=1300	,top=0 ,right=1490	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(GOODS_NM,'','',REMARK)}'			,left=1500	,top=0 ,right=1850	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<L>left=25	,top=0	,right=1855	,bottom=0		,border=true, penstyle=solid ,penwidth=1	,supplevel=1</L>";
			ls_format +="				</B>";
			ls_format +="				<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=70 ,face='굴림' ,size=7 ,penwidth=1";
			ls_format +="					<L>left=25		,top=0		,right=25		,bottom=70		" + ls_l1;
			ls_format +="					<L>left=1855	,top=0		,right=1855 ,bottom=70		" + ls_l1;
			ls_format +="					<L>left=25		,top=0		,right=1855 ,bottom=0			" + ls_l1;
			ls_format +="					<L>left=25		,top=70		,right=1855 ,bottom=70		" + ls_l1;
			ls_format +="					<L>left=1055	,top=0  ,right=1055,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1295	,top=0  ,right=1295,bottom=70		" + ls_l2;
			ls_format +="					<L>left=1495	,top=0  ,right=1495,bottom=70		" + ls_l2;
			ls_format +="					<T>id='총    계'					,left=25		,top=0 ,right=1050	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center</T>";
			ls_format +="					<S>id='{SUM(PRICE)}'		,left=1300	,top=0 ,right=1490	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, Dec=0</S>";
			ls_format +="				</B>";
			ls_format +="			</R>";
			ls_format +="		</A>";	
		
			gcDs3.UndoAll();
			gcDs3.ImportData(gcDs2.ExportData(1,gcDs2.countrow,true));

			gcrp_print.DetailDataID="gcDs3";
		}

		gcrp_print.Format = ls_format;

		gcrp_print.preview();         
	}

	/******************************************************************************
		Description :  엑셀
	******************************************************************************/
	function ln_Excel(){
		if (gcDs2.countrow<1) return;

		var arrParam	= new Array();
		var sPramRtn = window.showModalDialog("tr00111_popup01.html","","dialogWidth:370px;dialogHeight:180px;scroll:0;help:0;status:0");

		if (sPramRtn != null) arrParam = sPramRtn.split(";");
		
		if (arrParam[0]!="A" && arrParam[0]!="B") return;
		
		var surl = "";
		if (arrParam[0]=="A"){
			surl = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00111_excel_pl?v_str1=" + PL_NO.value + "&v_str2=" + gn_Replace(gcurdate,"-");
			window.location.href=surl;
		} else {
			surl = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00111_excel_ci?v_str1=" + PL_NO.value + "&v_str2=" + gn_Replace(gcurdate,"-");
			window.location.href=surl;
		}
	}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT> 

<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad		value="true">
	 <param name=SubSumExpr	value="1:CAR_NO">
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc20 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>
<%=HDConstant.COMMENT_END%>

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>

<OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<script language=JavaScript for=gcDs_etc11 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc11) ;  
	START_LCT.index = 0; 
</script>

<script language=JavaScript for=gcDs_etc12 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc12) ;  
	REACH_LCT.index = 0; 
</script>

<script language=JavaScript for=gcDs_etc7 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc7) ;  
	PKG_UNIT.index = 0; 
</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=START_LCT event=OnSearchFail()>
	alert("출발지를 다시 선택하십시오 ") ; 
	START_LCT.index = 0 ; 
</script>

<script language=JavaScript for=REACH_LCT event=OnSearchFail()>
	alert("목적지를 다시 선택하십시오 ") ; 
	REACH_LCT.index = 0 ; 
</script>

<script language=JavaScript for=gcDs2 event=OnRowPosChanged(row)>
	if (gcDs2.sysStatus(row)=="1") {
		gcGR1.columnProp("GOODS_NM","Edit") = "true";
		gcGR1.columnProp("STDRD_SZ","Edit") = "true";
		gcGR1.columnProp("CNT_UNIT","Edit") = "true";
	} else {
		gcGR1.columnProp("GOODS_NM","Edit") = "none";
		gcGR1.columnProp("STDRD_SZ","Edit") = "none";
		gcGR1.columnProp("CNT_UNIT","Edit") = "none";
	}
</script>

<script language="javascript" for=gcGR1 event=OnExit(row,colid,olddata)>
	if (colid=="GOODS_CNT" || colid=="UNIT_PRICE") {
		gcDs2.namevalue(row,"PRICE") = gcDs2.namevalue(row,"GOODS_CNT")*gcDs2.namevalue(row,"UNIT_PRICE");
	} else if (colid=="PKG_LNGTH" || colid=="PKG_WIDTH" || colid=="PKG_HEIGHT"){
		gcDs2.namevalue(row,"PRICE") = gcDs2.namevalue(row,"PKG_LNGTH")*gcDs2.namevalue(row,"PKG_WIDTH")*gcDs2.namevalue(row,"PKG_HEIGHT")/1000000;
	}

	if (colid=="GOODS_CNT" || colid=="PKC_CNT"){
		if (gcDs2.namevalue(row,"PKC_CNT")==""||gcDs2.namevalue(row,"PKC_CNT")=="0") {
		} else gcDs2.namevalue(row,"PACKING_CNT") = gcDs2.namevalue(row,"GOODS_CNT")/gcDs2.namevalue(row,"PKC_CNT");
	}

</script>

<!-- <script language=JavaScript for=START_LCT event=OnKillFocus()>
	if(START_LCT.index != 0)
	{  var rtnVal = START_LCT.ShowSearchCol(); }  
</script>
<script language=JavaScript for=REACH_LCT event=OnKillFocus()>
	if(REACH_LCT.index != 0)
	{  var rtnVal = REACH_LCT.ShowSearchCol(); }  
</script> -->
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
			<td><img src="../img/TR00109_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../../common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print();">
				<img src="../../common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel();"> 
				<img src="../img/btn/b_save.gif" style="cursor:hand" onclick="Save();">
				<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td class="tab11_top1" bgcolor="#eeeeee" width=120 style="text-align:center">PL/No ,C/I No</td> 
						<td style="width:300px;border:1 solid #777777;border-right-width:0px;border-left-width:0px;">
							<input id="PL_NO" name="PL_NO" type="text" class="txt11" style='width:90px;position:relative;left:8px;top:0px' >
						</td>
						<td class="tab11_top1" bgcolor="#eeeeee" width=120 style="text-align:center">Project</td>
						<td style="width:300px;border:1 solid #777777;border-right-width:0px;border-left-width:0px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:160px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="1">
								<param name=ComboDataID			value=gcDs_etc20>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT><%=HDConstant.COMMENT_END%> 
						</td>
						<td style="width:436px;border:1 solid #777777;border-left-width:0px;">&nbsp;</td>
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2>
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;" >
					<tr>
						<td class="tab11_left"  width=40% rowspan=1 colspan=2 bgcolor="#eeeeee">
							&nbsp;1. 송하인/수출자 <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallShipper();">
						</td>
						<td class="tab11_left" colspan=4 bgcolor="#eeeeee">&nbsp;8. 송장번호 및 일자</td>
					<tr>
						<td rowspan=3 colspan=2 class="tab11_left">
							<input id="PL_SHPPRNM" name="PL_SHPPRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD1" name="PL_SHPADD1" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD2" name="PL_SHPADD2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD3" name="PL_SHPADD3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPTEL" name="PL_SHPTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
						</td>
						<td colspan=4 class="tab11_left">
							&nbsp;&nbsp;&nbsp;(송장번호 : <%=HDConstant.COMMENT_START%><OBJECT id=DCL_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:6px; width:100px;height:17px;font-family:굴림; font-size:10pt;font-weight:bold;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="############">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%> )&nbsp; 
							(송장일자 : <%=HDConstant.COMMENT_START%><OBJECT id=DCL_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%><img src="../img/btn_calendar.gif" style="position:relative;left:0px;top:3px;cursor:hand" 
											onclick="__GetCallCalendar('DCL_DATE', 'Text');"> )
					</td>
				</tr>
				</tr>
				  <tr> 
					<td class="tab11_left" colspan=4 bgcolor="#eeeeee" >
					 &nbsp;9. 비&nbsp;&nbsp;고
					</td>
				</tr> 
				<tr> <td class="tab11_left" colspan=4 rowspan=3><textarea ID="REMARK" name="REMARK" style='width:510px;height=100px' class=txt11></textarea></td></tr> 
				<tr >
					<td class="tab11_left"  colspan=2  bgcolor="#eeeeee"> 
					&nbsp;2. 수하인 <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallCustomer();"> 
					</td>
				</tr>
				<tr>
					<td class="tab11_left" colspan=2>
					 <input id="PL_CSTMNM" name="PL_CSTMNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSTADD1" name="PL_CSTADD1" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSTADD2" name="PL_CSTADD2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSTADD3" name="PL_CSTADD3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR> 
					 <input id="PL_CSTTEL" name="PL_CSTTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
					</td>
				</tr>
				<tr>
					<td class="tab11_left"  width=360 colspan=2 bgcolor="#eeeeee">
					 &nbsp;3. 통지선  <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallBroker();"> 
					</td>
					<td class="tab11_left"  width=360 colspan=4 bgcolor="#eeeeee">
					 &nbsp;위탁자  <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallBroker2();"> 
					</td>
				</tr>
				<tr>
					<td class="tab11_left" colspan=2>
					 <input id="PL_BRKRNM" name="PL_BRKRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_BRKADD1" name="PL_BRKADD1" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_BRKADD2" name="PL_BRKADD2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_BRKADD3" name="PL_BRKADD3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_BRKTEL" name="PL_BRKTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
					</td>  
					<td class="tab11_left" colspan=4>
					 <input id="PL_CSNNM" name="PL_CSNNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSNADDR" name="PL_CSNADDR" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSNADDR2" name="PL_CSNADDR2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSNADDR3" name="PL_CSNADDR3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
					 <input id="PL_CSNTEL" name="PL_CSNTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
					</td>
				</tr>
				<tr >
					<td class="tab11_left"  bgcolor="#eeeeee">&nbsp;4. 출발지</td>
					<td class="tab11_left"  bgcolor="#eeeeee">&nbsp;5. 목적지</td>
					<td class="tab11_left"  bgcolor="#eeeeee">&nbsp;6. 운송차량</td>
					<td class="tab11_left"  bgcolor="#eeeeee">&nbsp;7. 출발일</td>
					<td class=tab11_left		style="width:200px;" bgcolor="#eeeeee">&nbsp;10.포장표식및 수량</td>
					<td class=tab11_left		bgcolor="#eeeeee">&nbsp;11. 품명</td>
				</tr>
				<tr >
					<td class="tab11_left" style="height:30px;">
						<%=HDConstant.COMMENT_START%><OBJECT id=START_LCT  style='border:0;position:relative;left:8px;top:0px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=140  >
						<param name=ComboDataID			value=gcDs_etc11>  
						<param name=CBDataColumns		value="MINORCD,MINORNM">
						<param name=SearchColumn		value="MINORNM">
						<param name=SortColumn			value="MINORNM"> 
						<param name=Sort						value=True>
						<param name=ListExprFormat	value="MINORNM^1^100"> 
						<param name=BindColumn			value="MINORCD">
						<param name=Index						value=0>
						<param name=InheritColor		value="true"> 
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td class="tab11_left"> 
						<%=HDConstant.COMMENT_START%><OBJECT id=REACH_LCT  style='border:0;position:relative;left:8px;top:0px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=140  >
							<param name=ComboDataID			value=gcDs_etc12>  
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=SortColumn			value="MINORNM"> 
							<param name=Sort						value=True>
							<param name=ListExprFormat	value="MINORNM^1^100"> 
							<param name=BindColumn			value="MINORCD">
							<param name=Index						value=0>
							<param name=InheritColor		value="true"> 
						</OBJECT><%=HDConstant.COMMENT_END%> 
					</td>
					<td class="tab11_left" ><input id="TRANS_CAR" name="TRANS_CAR" type="text" class="txt11_none1" style='width:100px;position:relative;left:8px;top:0px' ></td>
					<td class="tab11_left"    >&nbsp;
					 <%=HDConstant.COMMENT_START%><OBJECT id=START_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%><img src="../img/btn_calendar.gif" style="position:relative;left:-1px;top:1px;cursor:hand" 
											onclick="__GetCallCalendar('START_DATE', 'Text');">
					<!--  <%=HDConstant.COMMENT_START%><OBJECT id=START_TIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:30px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="00:00">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%> -->
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%><OBJECT id=PACKING_CNT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:6px; width:60px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="2">
								<param name=Border	      value="false">
								<param name=Numeric	      value="1">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<input id="PACKING_UNIT" name="PACKING_UNIT" type="text" class="txt11" style='width:40%;position:relative;left:6px;top:0px'><img src="../img/btn_find.gif" style="position:relative;left:8px;top:3px;cursor:hand" onclick="callUnit();"> 
					</td>
					<td class=tab11_left ><input id="RPR_GOODS" name="RPR_GOODS" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px' ></td>
				</tr>
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단가</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;금액</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;12. 수량/단위</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;13. 순중량(KG)</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;14. 총중량(KG)</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;15. 용적(CBM)</td>
				</tr>
				<tr>
					<td class=tab11_left style="height:30px;"><input id="txt_danga" name="txt_danga" type="text" class="txt11_none1_right" style='width:100%;position:relative;left:0px;top:0px' ></td>
					<td class=tab11_left>
						<%=HDConstant.COMMENT_START%><OBJECT id=gcem_amt  class="txt11_none1_right" style='width:98%;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left>
						<%=HDConstant.COMMENT_START%><OBJECT id=PACKING_CBM  class="txt11_none1_right" style='width:98%;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%><OBJECT id=WEIGHT  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;KGS 
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%><OBJECT id=T_WEIGHT  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment		value=2>
							<param name=Numeric			value=true>
							<param name=IsComma			value=true>
							<param name=MaxLength		value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border	value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;KGS
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%><OBJECT id=T_CBM  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment		value=2>
							<param name=Numeric			value=true>
							<param name=IsComma			value=true>
							<param name=MaxLength		value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border	value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;CBM 
					</td>
				</tr>
			</table> 
		</td>
	</tr> 
	<tr height=20px><td>&nbsp;</td></tr>
	<tr>
		<td colspan=2>
			<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
				<tr>
					<td bgcolor="#CCCCFF" style="height:25px;">&nbsp;&nbsp;<b>Packing Detail List</b></FONT></B>
					</td>
					<td   bgcolor="#CCCCFF" align=right >
						<img src="../img/btn/b_write.gif" id=btn_write style="position:relative;left:0px;top:2px;cursor:hand;display:none" onclick="New_Insert()">
						<img src="../img/btn/b_save.gif" id=btn_save style="position:relative;left:0px;top:2px;cursor:hand;display:none" onclick="DetailSave()"> 
						<img src="../img//btn/b_delete.gif" id=btn_delete style="position:relative;left:0px;top:2px;cursor:hand;display:none" onclick="ln_Delete()">&nbsp;  
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:100%;height:238px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
							<PARAM NAME="DataID"			VALUE="gcDs2">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Editable"		VALUE="true">
							<param name="AllShowEdit" VALUE="true">
							<param name=ColSizing  value="true"> 
							<PARAM NAME="Format"			VALUE="   
								<F>	Name='No.'						ID='SeralNo' 	HeadAlign=Center HeadBgColor=#eeeeee Width=25  Bgcolor='#EFEFEF' Align=Center	Value ={ToString( CurRow)}, edit=none </F> 
								<F> Name='차량번호'				ID=CAR_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center, edit=none</F>
								<F> Name='품  명(영문명)'	ID=GOODS_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=110 align=left, edit=none</F>  
								<C> Name='규  격'					ID=STDRD_SZ		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, edit=none</C>
								<C> Name='단위'						ID=CNT_UNIT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left  EditStyle=Lookup Data='gcDs_etc6:MINORCD:MINORNM', edit=none</C>
								<C> Name='수량'						ID=GOODS_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right </C> 
								<C> Name='단가'						ID=UNIT_PRICE	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, dec=0</C>
								<C> Name='금액'						ID=PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=right, value={GOODS_CNT*UNIT_PRICE}</C>
								<G> Name='단위 포장별' HeadAlign=Center HeadBgColor=#eeeeee 
									<C> Name='수량'					ID=PKC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right, dec=0</C> 
									<C> Name='중량(KG)'			ID=PKG_WEIGHT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, Dec=0  </C> 
									<C> Name='길이(CM)'			ID=PKG_LNGTH  HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0 </C>  
									<C> Name='폭(CM)'				ID=PKG_WIDTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0</C> 
									<C> Name='높이(CM)'			ID=PKG_HEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0</C> 
									<C> Name='용적(CBM)'		ID=PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, dec=3, edit=none</C>
								</G>
								<C> Name='총중량(KG)'			ID={GOODS_CNT/PKC_CNT*PKG_WEIGHT}	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=1 edit=none</C> 
								<C> Name='비   고'				ID=REAMARK			HeadAlign=Center HeadBgColor=#eeeeee Width=217 align=left</C> 
							  
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td	height=10px></td></tr>
	<tr>
		<td colspan=2>
			<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;border-right-width:0px;display:none" >
				<tr>
					<td	colspan=8 class=tab11_left bgcolor="#CCCCFF">&nbsp;<B>Detail</B></td>
				</tr>
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;차량번호&nbsp;</td>
					<td class=tab11_left colspan=3>&nbsp;<input id="CAR_NO" name="CAR_NO" type="text" class="txt11" style='width:120px;position:relative;left:0px;top:0px' readonly> 
					<!--<img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="callUnit();"> -->
					</td>
					<!-- <td class=tab11_left bgcolor="#eeeeee">&nbsp;포장수&nbsp;
					</td>
						<td class=tab11_left >&nbsp;<%=HDConstant.COMMENT_START%><OBJECT id=PACKING_CBM  class="txt11" style='width:100px;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						height=24 width=120> 
						<param name=Alignment		value=2>
						<param name=Numeric			value=true>
						<param name=IsComma			value=true>
						<param name=MaxLength		value=10>
						<param name=MaxDecimalPlace	value=2>
						<param name=border	value=false>
						</OBJECT><%=HDConstant.COMMENT_END%> 
					</td> -->
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;<!--컨테이너-->&nbsp;</td>
					<td class=tab11_left >&nbsp;<input id="CNTN_NO" name="CNTN_NO" type="text" class="txt11" style='width:100px;position:relative;left:0px;top:0px;display:none' ></td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;<!--규격-->&nbsp;</td>
					<td class=tab11_left >&nbsp;<!--<input id="CNTN_SDSZ" name="CNTN_SDSZ" type="text" class="txt11" style='width:80px;position:relative;left:0px;top:0px' > <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="callUnit();">--></td>
				</tr>
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;품명&nbsp;</td>
					<td class=tab11_left colspan=3>&nbsp;<input id="GOODS_CD" name="GOODS_CD" type="text" class="txt11" style='width:30px;position:relative;left:0px;top:0px' readonly><input id="GOODS_NM" name="GOODS_NM" type="text" class="txt11" style='width:90px;position:relative;left:2px;top:0px' readonly><!--  <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="callUnit();"> -->
					
					<!-- <td class=tab11_left bgcolor="#eeeeee">&nbsp;품명(영문명)&nbsp;
					</td> -->
						<!-- <td class=tab11_left >&nbsp; -->(영문명:<input id="GOODS_ENM" name="GOODS_ENM" type="text" class="txt11" style='width:90px;position:relative;left:0px;top:0px' readonly>)
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;규격&nbsp;</td>
					<td class=tab11_left >&nbsp;<input id="STDRD_SZ" name="STDRD_SZ" type="text" class="txt11" style='width:100px;position:relative;left:0px;top:0px' readonly></td>
					<!-- </td> -->
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;포장번호&nbsp;</td>
					<td class=tab11_left >&nbsp;<input id="PACKING_NO" name="PACKING_NO" type="text" class="txt11" style='width:100px;position:relative;left:0px;top:0px' readonly></td> 
				</tr>
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=GOODS_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%> 
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단위&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=CNT_UNIT  style='border:0;position:relative;left:6px;top:1px;width:140px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="51">
							<param name=ComboDataID			value=gcDs_etc6>  
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=SortColumn			value="MINORCD"> 
							<param name=Sort						value=True>
							<param name=ListExprFormat	value="MINORNM^0^140"> 
							<param name=BindColumn			value="MINORCD">
							<param name=Index						value=0>
							<param name=InheritColor		value="true"> 
							<param name=ComboStyle			value=2>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단가&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=UNIT_PRICE  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment					value=2>
							<param name=Numeric						value=true>
							<param name=IsComma						value=true>
							<param name=MaxLength					value=10>
							<param name=MaxDecimalPlace		value=2>
							<param name=border						value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;금액&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PRICE  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr><td	colspan=8 class=tab11_left bgcolor="#CCCCFF">&nbsp;<b>단위포장</b></td></tr> 
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKC_CNT  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단위&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKG_UNIT  style='border:0;position:relative;left:6px;top:1px;width:140px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="51">
							<param name=ComboDataID			value=gcDs_etc7>  
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=SortColumn			value="MINORCD"> 
							<param name=Sort						value=True>
							<param name=ListExprFormat	value="MINORNM^0^140"> 
							<param name=BindColumn			value="MINORCD">
							<param name=Index						value=0>
							<param name=InheritColor		value="true"> 
							<param name=ComboStyle			value=2>
						</OBJECT><%=HDConstant.COMMENT_END%>  
						<!--
						<img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="callUnit();"> 
						-->
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;순중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PR_WEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PT_WEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
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
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;길이(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKG_LNGTH  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;높이(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKG_HEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;폭(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKG_WIDTH  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;용적&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKG_CBM  class="txt11" style='width:100px;position:relative;left:6px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;CBM
					</td>
				</tr>	
				<tr> 
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;포장수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=PKC_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=T_WEIGHT1  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=T_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총용적&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%><OBJECT id=T_CBM1  class="txt11" style='width:100px;position:relative;left:6px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;CBM
					</td>
				</tr>
				<tr>
					<td class=tab12_left bgcolor="#eeeeee">&nbsp;비고&nbsp;</td>
					<td class=tab12_left  colspan=7>&nbsp;<input id="REAMARK" name="REAMARK" type="text" class="txt11" style='width:93%;position:relative;left:0px;top:0px' >&nbsp; 
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td	height=30px></td></tr>
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcbn01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcDs1>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=PL_NO                Ctrl= PL_NO       Param = value </C>
		<C>Col=IN_OUT               Ctrl= IN_OUT      Param = BindColVal </C>
		<C>Col=PL_SHIPPER           Ctrl= PL_SHIPPER  Param = value </C>
		<C>Col=PL_SHPPRNM           Ctrl= PL_SHPPRNM  Param = value </C>
		<C>Col=PL_SHPADD1           Ctrl= PL_SHPADD1  Param = value </C>
		<C>Col=PL_SHPADD2           Ctrl= PL_SHPADD2  Param = value </C>
		<C>Col=PL_SHPADD3           Ctrl= PL_SHPADD3  Param = value </C>
		<C>Col=PL_SHPTEL            Ctrl= PL_SHPTEL   Param = value </C>
		<C>Col=PL_CSTM              Ctrl= PL_CSTM     Param = value </C>
		<C>Col=PL_CSTMNM            Ctrl= PL_CSTMNM   Param = value </C>
		<C>Col=PL_CSTADD1           Ctrl= PL_CSTADD1  Param = value </C>
		<C>Col=PL_CSTADD2           Ctrl= PL_CSTADD2  Param = value </C>
		<C>Col=PL_CSTADD3           Ctrl= PL_CSTADD3  Param = value </C>
		<C>Col=PL_CSTTEL            Ctrl= PL_CSTTEL   Param = value </C>
		<C>Col=PL_BRKR              Ctrl= PL_BRKR     Param = value </C>
		<C>Col=PL_BRKRNM            Ctrl= PL_BRKRNM   Param = value </C>
		<C>Col=PL_BRKADD1           Ctrl= PL_BRKADD1  Param = value </C>
		<C>Col=PL_BRKADD2           Ctrl= PL_BRKADD2  Param = value </C>
		<C>Col=PL_BRKADD3           Ctrl= PL_BRKADD3  Param = value </C>
		<C>Col=PL_BRKTEL            Ctrl= PL_BRKTEL   Param = value </C>
		<C>Col=PL_NOTICE            Ctrl= PL_NOTICE   Param = value </C>
		<C>Col=PLNOTICENM           Ctrl= PLNOTICENM  Param = value </C>
		<C>Col=START_LCT            Ctrl= START_LCT   Param = BindColVal </C>
		<C>Col=REACH_LCT            Ctrl= REACH_LCT   Param = BindColVal </C>
		<C>Col=TRANS_CAR            Ctrl= TRANS_CAR   Param = value </C>
		<C>Col=START_DT             Ctrl= START_DATE    Param = Text </C>
		<C>Col=START_TIME           Ctrl= START_TIME    Param = Text </C>
		<C>Col=INVOICE_NO           Ctrl= INVOICE_NO  Param = Text </C>
		<C>Col=INVOICE_DT           Ctrl= INVOICE_DT  Param = Text </C>
		<C>Col=REMARK               Ctrl= REMARK      Param = value </C>
		<C>Col=LCNO                 Ctrl= LCNO        Param = value </C>
		<C>Col=LCDATE               Ctrl= LCDATE      Param = value </C>
		<C>Col=LCBANK               Ctrl= LCBANK      Param = value </C>
		<C>Col=T_WEIGHT             Ctrl= WEIGHT      Param = Text </C>
		<C>Col=T_WEIGHT             Ctrl= T_WEIGHT    Param = Text </C>
		<C>Col=T_CBM                Ctrl= T_CBM       Param = Text </C>
		<C>Col=GORDER_NO            Ctrl= GORDER_NO   Param = value </C>
		<C>Col=PACKING_CNT          Ctrl= PACKING_CNT Param = value </C> 
		<C>Col=PACKING_CBM          Ctrl= PACKING_CBM Param = Text </C>
		<C>Col=TELEPHONE            Ctrl= TELEPHONE   Param = value </C>
		<C>Col=RPR_GOODS            Ctrl= RPR_GOODS   Param = value </C>
		<C>Col=CARGO_TYPE           Ctrl= CARGO_TYPE  Param = value </C>
		<C>Col=DNG_TYPE             Ctrl= DNG_TYPE    Param = value </C>
		<C>Col=CAR_TYPE             Ctrl= CAR_TYPE    Param = value </C>
		<C>Col=ORDER_NO             Ctrl= ORDER_NO    Param = value </C>
		<C>Col=DCL_DATE             Ctrl= DCL_DATE    Param = Text </C>
		<C>Col=DCL_NO               Ctrl= DCL_NO      Param = Text </C>
		<C>Col=CURRENCY             Ctrl= CURRENCY    Param = BindColVal </C> 
		<C>Col=PACKING_UNIT         Ctrl= PACKING_UNIT  Param = value </C> 
		<C>Col=LINE_PART            Ctrl= LINE_PART    Param = BindColVal </C>
		<C>Col=PL_CSN				Ctrl= PL_CSN       Param=value</C>
		<C>Col=PL_CSNNM				Ctrl= PL_CSNNM     Param=value</C>
		<C>Col=PL_CSNTEL			Ctrl= PL_CSNTEL    Param=value</C>
		<C>Col=PL_CSNADDR			Ctrl= PL_CSNADDR   Param=value</C>
		<C>Col=PL_CSNADDR2			Ctrl= PL_CSNADDR2  Param=value</C>
		<C>Col=PL_CSNADDR3			Ctrl= PL_CSNADDR3  Param=value</C>
		
	'></OBJECT><%=HDConstant.COMMENT_END%>

		<%=HDConstant.COMMENT_START%><OBJECT id=gcbn02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
		<param name=DataID				value=gcDs2>
		<param name=ActiveBind    value=true>
		<param name=BindInfo			value='
		<C>Col=CAR_NO        Ctrl = CAR_NO			Param = value </C> 
		<C>Col=CNTN_NO       Ctrl = CNTN_NO			Param = value </C> 
		<C>Col=CNTN_SDSZ     Ctrl = CNTN_SDSZ		Param =value </C>  
		<C>Col=GOODS_CD      Ctrl = GOODS_CD		Param = value </C> 
		<C>Col=GOODS_NM      Ctrl = GOODS_NM		Param = value </C> 
		<C>Col=GOODS_ENM     Ctrl = GOODS_ENM		Param = value </C> 
		<C>Col=PACKING_NO    Ctrl = PACKING_NO		Param = Text </C> 
		<C>Col=STDRD_SZ      Ctrl = STDRD_SZ		Param = BindColVal </C>  
		<C>Col=GOODS_CNT     Ctrl = GOODS_CNT				Param = Text </C> 
		<C>Col=CNT_UNIT      Ctrl = CNT_UNIT		Param = BindColVal </C> 
		<C>Col=UNIT_PRICE    Ctrl = UNIT_PRICE		Param = Text </C> 
		<C>Col=PRICE         Ctrl = PRICE			Param = Text </C> 
		<C>Col=PKC_CNT       Ctrl = PKC_CNT			Param = Text </C> 
		<C>Col=PKG_WEIGHT    Ctrl = PKG_WEIGHT		Param = Text </C> 
		<C>Col=PKG_LNGTH     Ctrl = PKG_LNGTH		Param = Text </C> 
		<C>Col=PKG_HEIGHT    Ctrl = PKG_HEIGHT		Param = Text </C> 
		<C>Col=PKG_WIDTH     Ctrl = PKG_WIDTH		Param = Text </C> 
		<C>Col=PKG_CBM       Ctrl = PKG_CBM			Param = Text </C> 
		<C>Col=PKG_UNIT      Ctrl = PKG_UNIT		Param = BindColVal </C> 
		<C>Col=PR_WEIGHT     Ctrl = PR_WEIGHT		Param = Text </C> 
		<C>Col=PT_WEIGHT     Ctrl = PT_WEIGHT		Param = Text </C> 
		<C>Col=T_WEIGHT      Ctrl = T_WEIGHT1		Param = Text </C> 
		<C>Col=T_CNT         Ctrl = T_CNT			Param = Text </C> 
		<C>Col=REAMARK       Ctrl = REAMARK			Param = value </C>
		<C>Col=T_CBM         Ctrl = T_CBM1			Param = Text </C>   
		'></OBJECT><%=HDConstant.COMMENT_END%>


<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcDs1">
	<param name="PaperSize"					value="A4">		
	<param name="LandScape"					value="false"> 
	<param name="PrintSetupDlgFlag"	value="true">
	<param name="Format"		value="

	">
</OBJECT>
<%=HDConstant.COMMENT_END%>
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


