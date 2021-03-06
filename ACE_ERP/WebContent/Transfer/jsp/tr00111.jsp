<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반출 P/L 및 C/I 관리
+ 프로그램 ID	:	TR00111.HTML
+ 기 능 정 의	:	반출 P/L 및 C/I 관리
+ 변 경 이 력	:	정미선
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

		//alert( "ls_type::=" + ls_type );
		if( gs_parm[0]  == "update"){ // MODE 체크
			PL_NO.value = gs_parm[1];
			//alert( " gs_parm[1]::=" +  gs_parm[1] );
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

			var selVal = gs_parm[1].split("/");   alert( "selVal =" + selVal  );

			for( k=0;k<selVal.length-1; k++){
				AddPlDetail(selVal[k]);
			}

			var selPos = gs_parm[2].split("/");   alert( "selPos =" + selPos  );

      //alert("selPos[0]::"+selPos[0]);

			LINE_PART.index = LINE_PART.IndexOfColumn("MINORCD", selPos[0]);
			START_DATE.text = selPos[1]; //반출일자

			var ls_project = LINE_PART.bindcolval;
			
			if(ls_project == '0001') {
				//START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0001");
				//alert("test");
				//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			} else if(ls_project == '0002') {
			//	START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0007");
			//	REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0005");
			} else {
			//	START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0001");
			//	REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			}

			gcDs1.NameValue(gcDs1.RowPosition ,"PACKING_UNIT")	= "0059"; 
			PACKING_UNIT.value =  "기타(GT)";

      //PL 상단 설정
			ln_GetSum();
			getSum();

      PACKING_UNIT2.value =  "기타(GT)";
			PACKING_CBM.text="";

			gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO") = selVal[0];
			ln_Mst_Setting();
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function AddPlDetail(order_no) { 
		gcDs_etc0.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsMakePl2?NOH=Y&gstr0=O&gstr1="+order_no ; 
		gcDs_etc0.Reset() ; 

		if(gcDs_etc0.CountRow > 0 ) {
			RPR_GOODS.value = gcDs_etc0.NameValue(i,"ARTC_NM");

			for( var i = 1 ; i<=gcDs_etc0.CountRow ; i++ ) {
				gsCnt = gsCnt*1 + 1*1 ; 
				gcDs2.AddRow();
				gcDs2.NameValue(gsCnt,"PL_SEQNO")			= gsCnt ; 
				gcDs2.NameValue(gsCnt,"CAR_NO")				= gcDs_etc0.NameValue(i,"CAR_NO") ;  //차량번호
				gcDs2.NameValue(gsCnt,"CNTN_NO")			= "" ;                               //컨테이너번호
				gcDs2.NameValue(gsCnt,"CNTN_SDSZ")		= "" ;                               //컨테이너규격
				gcDs2.NameValue(gsCnt,"CNTN_SLNO")		= "" ;                               //컨테이너봉인번호
				gcDs2.NameValue(gsCnt,"GOODS_CD")			= gcDs_etc0.NameValue(i,"ARTC_CD") ; //물품코드 
				gcDs2.NameValue(gsCnt,"GOODS_NM")			= gcDs_etc0.NameValue(i,"ARTC_NM") ; //품명
				gcDs2.NameValue(gsCnt,"GOODS_ENM")		= "" ;                               //품명영문명
				gcDs2.NameValue(gsCnt,"PACKING_NO")		= "" ;                               //포장번호
				gcDs2.NameValue(gsCnt,"PACKING_CNT")	= gcDs_etc0.NameValue(i,"PUNIT_CNT") ; //포장수
				gcDs2.NameValue(gsCnt,"STDRD_SZ")			= gcDs_etc0.NameValue(i,"STN_SZNM") ;  //규격
				gcDs2.NameValue(gsCnt,"HS_CODE")			= gcDs_etc0.NameValue(i,"HSCODE") ;    //HSCODE
				gcDs2.NameValue(gsCnt,"GOODS_CNT")		= gcDs_etc0.NameValue(i,"ARTC_CNT") ;  //수량
				gcDs2.NameValue(gsCnt,"CNT_UNIT")			= gcDs_etc0.NameValue(i,"ARTC_UNIT") ;  //수량단위
				gcDs2.NameValue(gsCnt,"UNIT_PRICE")		= gcDs_etc0.NameValue(i,"UNIT_PRICE") ; //단가
				gcDs2.NameValue(gsCnt,"PRICE")				= gcDs_etc0.NameValue(i,"PRICE1") ;     //금액
				gcDs2.NameValue(gsCnt,"PKC_CNT")			= gcDs_etc0.NameValue(i,"PUNIT_CNT1") ; 
				gcDs2.NameValue(gsCnt,"PKG_WEIGHT")		= gcDs_etc0.NameValue(i,"PUNIT_WEIGHT") ; 
				gcDs2.NameValue(gsCnt,"PKG_LNGTH")		= gcDs_etc0.NameValue(i,"PKG_LNGTH") ; 
				gcDs2.NameValue(gsCnt,"PKG_HEIGHT")		= gcDs_etc0.NameValue(i,"PKG_HEIGHT") ; 
				gcDs2.NameValue(gsCnt,"PKG_WIDTH")		= gcDs_etc0.NameValue(i,"PKG_WIDTH") ; 
				//gcDs2.NameValue(gsCnt,"PKG_CBM")			= gcDs_etc0.NameValue(i,"CBM") ; 
				
				/*2007.11.21 정영식*/
				gcDs2.NameValue(gsCnt,"PKG_CBM")			= gcDs_etc0.NameValue(i,"PKG_LNGTH")*gcDs_etc0.NameValue(i,"PKG_HEIGHT")* gcDs_etc0.NameValue(i,"PKG_WIDTH")/1000000 ; 

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
		//gcem_amt.Text =gcDs2.Sum(gcDs2.ColumnIndex('GOODS_CNT'),0,0)*gcDs2.Sum(gcDs2.ColumnIndex('UNIT_PRICE'),1,1);
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
		Description :총중량 계산 
		2007.11.21 정영식 추가 
	******************************************************************************/ 
  function ln_GetSum_Weight(){
		
		var v_weight = 0;
		var v_cbm = 0;
		for (var i=1; i<=gcDs2.countrow; i++){
			var v_1 = gcDs2.namevalue(i,"GOODS_CNT");
			var v_2 = gcDs2.namevalue(i,"PKC_CNT");
			if (v_1 != null && v_1 != "" && v_2 != null && v_2 != "") {
				var v_3 = v_1/v_2;
				v_weight = v_weight + v_3*gcDs2.namevalue(i,"PKG_WEIGHT");
			}
		}

		T_WEIGHT.Text = v_weight;
	}

	/******************************************************************************
		Description :총CBM 계산 
		2007.11.21 정영식 추가 
	******************************************************************************/ 
  function ln_GetSum_CBM(){
		
		var v_weight = 0;
		var v_cbm = 0;
		for (var i=1; i<=gcDs2.countrow; i++){
			var v_1 = gcDs2.namevalue(i,"GOODS_CNT");
			var v_2 = gcDs2.namevalue(i,"PKC_CNT");
			if (v_1 != null && v_1 != "" && v_2 != null && v_2 != "") {
				var v_3 = v_1/v_2;
				v_cbm = v_cbm + v_3*gcDs2.namevalue(i,"PKG_CBM");
			}
		}

		T_CBM.Text = v_cbm;
	}
  /******************************************************************************
		Description : 사업명에 따라 송하인 수하인 설정
		              2007.11.20 정영식 추가
	******************************************************************************/ 
	function ln_Mst_Setting(){
	  var ls_project = LINE_PART.bindcolval;
		var ls_pl_shpprnm = PL_SHPPRNM.value;
		var ls_pl_brkrnm = PL_BRKRNM.value;
		var ls_pl_cstmnm = PL_CSNNM.value;

		if(ls_project == '0001') {
			
			if(ls_pl_shpprnm == '') {
				PL_SHPPRNM.value='현대아산(주)';
				PL_SHPADD1.value='서울 종로 계동 140-2';
			}

			if(ls_pl_brkrnm == '') {
				PL_CSTMNM.value='현대아산(주)개성사업소';
			}

			if(ls_pl_cstmnm == '') {
				PL_CSNNM.value='현대아산(주)';
				PL_CSNADDR.value='서울 종로 계동 140-2';
			}

			if(START_LCT.BindColVal =='') {
					START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
			}

			if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			}
		} else if(ls_project == '0002') {

			if(ls_pl_shpprnm == '') {
				PL_SHPPRNM.value='현대아산(주)';
				PL_SHPADD1.value='서울 종로 계동 140-2';
			}

			if(ls_pl_brkrnm == '') {
				PL_CSTMNM.value='현대아산(주)금강산지점';
			}

			if(ls_pl_cstmnm == '') {
				PL_CSNNM.value='현대아산(주)';
				PL_CSNADDR.value='서울 종로 계동 140-2';
			}

			if(START_LCT.BindColVal =='') {
					START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
			}

			if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
			}

			//START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
			
		} else {
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0001");
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			PL_CSTMNM.value='현대아산(주)개성사업소';
		}

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

		gcds_print02.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=N" ; 
		gcds_print02.Reset() ; 

    /*
		var ls_project = LINE_PART.bindcolval;
		var ls_pl_shpprnm = PL_SHPPRNM.value;
		var ls_pl_brkrnm = PL_BRKRNM.value;
		var ls_pl_cstmnm = PL_CSNNM.value;
		
		if(ls_project == '0001') {
			
			if(ls_pl_shpprnm == '') {
				PL_SHPPRNM.value='현대아산(주)';
				PL_SHPADD1.value='서울 종로 계동 140-2';
			}

			if(ls_pl_brkrnm == '') {
				PL_CSTMNM.value='현대아산(주)개성사업소';
			}

			if(ls_pl_cstmnm == '') {
				PL_CSNNM.value='현대아산(주)';
				PL_CSNADDR.value='서울 종로 계동 140-2';
			}

			if(START_LCT.BindColVal =='') {
					START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
					//alert(START_LCT.index);
			}

			if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
					//alert(REACH_LCT.index);
			}
		} else if(ls_project == '0002') {

			if(ls_pl_shpprnm == '') {
				PL_SHPPRNM.value='현대아산(주)';
				PL_SHPADD1.value='서울 종로 계동 140-2';
			}

			if(ls_pl_brkrnm == '') {
				PL_CSTMNM.value='현대아산(주)금강산지점';
			}

			if(ls_pl_cstmnm == '') {
				PL_CSNNM.value='현대아산(주)';
				PL_CSNADDR.value='서울 종로 계동 140-2';
			}

			if(START_LCT.BindColVal =='') {
					START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
					//alert(START_LCT.index);
			}

			if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
					//alert(REACH_LCT.index);
			}

			//START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
			
		} else {
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0001");
			//REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			PL_CSTMNM.value='현대아산(주)개성사업소';
		}
		*/
	}

 /******************************************************************************
		Description :
	******************************************************************************/

 
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Search() {
    
		if(ls_type ="update"){
			if(fn_trim(PL_NO.value)==""){
				alert("PL_NO를 입력후 조회하십시요.");
				return;
			}
		}

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlMaster?NOH=Y&gstr0=O&gstr1="+PL_NO.value; 
		//prompt('gcDs1',gcDs1.DataId );
		gcDs1.Reset();

    //2007.11.20 정영식 추가 
		//PL NO 가 없을 경우 DTL 조회 안함.
		if(gcDs1.namevalue(gcDs1.rowposition,"PL_NO")==""||gcDs1.namevalue(gcDs1.rowposition,"PL_NO")==undefined){
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=N&gstr1="+PL_NO.value; 
			//prompt('gcDs2',gcDs2.DataId );
			gcDs2.Reset();
			alert("데이타가 존재하지 않습니다.");
			return;
		}else{
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlDetail?NOH=Y&gstr1="+PL_NO.value; 
			//prompt('gcDs2',gcDs2.DataId );
			gcDs2.Reset();
		}
	
		if(PL_SHPPRNM.value=='') {
			PL_SHPPRNM.value='현대아산(주)';
			PL_SHPADD1.value='서울 종로 계동 140-2';
		}

		if(PL_BRKRNM.value=='') {
			PL_BRKRNM.value='현대아산(주)';
			PL_BRKADD1.value='서울 종로 계동 140-2';
		}

		if(PL_CSNNM.value=='') {
			PL_CSNNM.value='현대아산(주)';
			PL_CSNADDR.value='서울 종로 계동 140-2';
		}

		var ls_project = LINE_PART.bindcolval;
			
			if(ls_project == '0001') {
				
				if(PL_CSTMNM.value==''){
					PL_CSTMNM.value='현대아산(주)개성사업소';
				}
				if(START_LCT.BindColVal =='') {
					//START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
					//alert(START_LCT.index);
				}

				if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
					//alert(START_LCT.index);
				}

			} else if(ls_project == '0002') {

				if(PL_CSTMNM.value==''){
					PL_CSTMNM.value='현대아산(주)금강산사업소';
				}
				if(START_LCT.BindColVal =='') {
					START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
					//alert(START_LCT.index);
				}

				if(REACH_LCT.BindColVal =='') {
					REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
					//alert(START_LCT.index);
				}

			} else {
				//START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
				REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			}

      //2007.11.20 정영식 추가
      //ln_GetSum();
			getSum();
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
			//alert("NOH=Y&gstr1=0002&gstr2=" + ls_yymm);
			gcDs_etc.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetSeqNo?NOH=Y&gstr1=0002&gstr2=" + ls_yymm;  
			gcDs_etc.Reset();   
			if(gcDs_etc.CountRow == 1 ) gs_plno = 'OP' + ls_yymm +  gcDs_etc.NameValue(1,"SEQ_NO"); 	
			gcDs1.NameValue(1,"IN_OUT") = "O" ; 
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
    
    /* 수정하다가 중단함.....
		gcTr02.KeyValue = "trPlMastar(I:USERM=gcDs1,I:USER=gcDs2)";
		//gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlDetail";
		gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trPlDetail_new";
		gcTr02.Parameters = "gstr1="+gs_plno ; ///pl_no
		gcTr02.post(); 
		*/

		ls_type = "update" ; 
		
		alert("반출 P/L 및 C/I정보가 정상적으로 저장되었습니다.");
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
			PL_SHPPRCD.value  = PopWinValue[0] ; 
//alert(PL_SHPPRNM.value);
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
	function callUnit(gbn) {
		strURL = "TR00000_E1.html";
		PopupOpenDialog(400,420) ;		
		if(PopWinValue != null ){
			gcDs1.NameValue(gcDs1.RowPosition ,"PACKING_UNIT")	= PopWinValue[0] ; 

			if(gbn==1){
				PACKING_UNIT.value =  PopWinValue[1] ; 
			}else if(gbn==2){
        PACKING_UNIT2.value =  PopWinValue[1] ; 
			}
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

function ln_SetDataHeader(){

		if (gcds_print.countrow<1){
			var ls_temp = "CUDATE:STRING,GOODS_NM:STRING,STDRD_SZ:STRING,CAR_NO:STRING,GOODS_CNT:DECIMAL,PKG_WEIGHT:DECIMAL,UNIT_PRICE:DECIMAL,PRICE:DECIMAL,CNT_UNIT:STRING,NAM:STRING,CNT_UNITNM:STRING,"
		+"PL_SHPPRNM:STRING,PL_CSTMNM:STRING,PL_SHPADD1:STRING,TRANS_CAR:STRING,ETD_DT:STRING,"
		+"ETD_DT1:STRING,START_LCTNM:STRING,REACH_LCTNM:STRING,UNIT_PRICE_US:DECIMAL";
		gcds_print.SetDataHeader(ls_temp);
		gcds_print01.SetDataHeader(ls_temp);
		gcds_print02.SetDataHeader(ls_temp);
		}
	}


	
/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print01(){
	
	if (gcDs2.countrow<1) return;
		
		gcds_print.ClearData();
		gcds_print01.ClearData();
		gcds_print02.ClearData();

//		ln_SetDataHeader();
			
		var ls_temp = "CUDATE:STRING,GOODS_NM:STRING,STDRD_SZ:STRING,CAR_NO:STRING,GOODS_CNT:DECIMAL,PKG_WEIGHT:DECIMAL,UNIT_PRICE:DECIMAL,PRICE:DECIMAL,CNT_UNIT:STRING,NAM:STRING,CNT_UNITNM:STRING,"
		+"PL_SHPPRNM:STRING,PL_CSTMNM:STRING,PL_SHPADD1:STRING,TRANS_CAR:STRING,ETD_DT:STRING,"
		+"ETD_DT1:STRING,START_LCTNM:STRING,REACH_LCTNM:STRING,UNIT_PRICE_US:DECIMAL";
		gcds_print.SetDataHeader(ls_temp);
		gcds_print01.SetDataHeader(ls_temp);
		gcds_print02.SetDataHeader(ls_temp);

		Search();
		gcds_print.Addrow();
		gcds_print02.Addrow();
	
	if (gcDs2.countrow<4) {

		for (j=1;j<=gcDs2.countrow;j++) {

			gcds_print01.Addrow();
			gcds_print01.namevalue(j,"CAR_NO")=gcDs2.namevalue(j,"CAR_NO");
			gcds_print01.namevalue(j,"GOODS_NM")=gcDs2.namevalue(j,"GOODS_NM");
			gcds_print01.namevalue(j,"STDRD_SZ")=gcDs2.namevalue(j,"STDRD_SZ");
			gcds_print01.namevalue(j,"GOODS_CNT")=gcDs2.namevalue(j,"GOODS_CNT");
			gcds_print01.namevalue(j,"PKG_WEIGHT")=gcDs2.namevalue(j,"PKG_WEIGHT");
			gcds_print01.namevalue(j,"UNIT_PRICE")=gcDs2.namevalue(j,"UNIT_PRICE");
			gcds_print01.namevalue(j,"PRICE")=gcDs2.namevalue(j,"PRICE");
			gcds_print01.namevalue(j,"CNT_UNIT")=gcDs2.namevalue(j,"CNT_UNIT");
			gcds_print01.namevalue(j,"NAM")=gcDs2.namevalue(j,"NAM");
			gcds_print01.namevalue(j,"CNT_UNITNM")=gcDs2.namevalue(j,"CNT_UNITNM");
			//ln_RptFormat();
		}

	}else {

		for (j=1;j<=3;j++) {

			gcds_print01.Addrow();
			gcds_print01.namevalue(j,"CAR_NO")=gcDs2.namevalue(j,"CAR_NO");
			gcds_print01.namevalue(j,"GOODS_NM")=gcDs2.namevalue(j,"GOODS_NM");
			gcds_print01.namevalue(j,"STDRD_SZ")=gcDs2.namevalue(j,"STDRD_SZ");
			gcds_print01.namevalue(j,"GOODS_CNT")=gcDs2.namevalue(j,"GOODS_CNT");
			gcds_print01.namevalue(j,"PKG_WEIGHT")=gcDs2.namevalue(j,"PKG_WEIGHT");
			gcds_print01.namevalue(j,"UNIT_PRICE")=gcDs2.namevalue(j,"UNIT_PRICE");
			gcds_print01.namevalue(j,"PRICE")=gcDs2.namevalue(j,"PRICE");
			gcds_print01.namevalue(j,"CNT_UNIT")=gcDs2.namevalue(j,"CNT_UNIT");
			gcds_print01.namevalue(j,"NAM")=gcDs2.namevalue(j,"NAM");
			gcds_print01.namevalue(j,"CNT_UNITNM")=gcDs2.namevalue(j,"CNT_UNITNM");
	
		}

	}
	
			gcds_print.namevalue(1,"PL_SHPPRNM")=gcDs1.namevalue(gcDs1.rowposition,"PL_SHPPRNM");
			gcds_print.namevalue(1,"PL_CSTMNM")=gcDs1.namevalue(gcDs1.rowposition,"PL_CSTMNM");
			gcds_print.namevalue(1,"TRANS_CAR")=gcDs1.namevalue(gcDs1.rowposition,"TRANS_CAR");
			gcds_print.namevalue(1,"ETD_DT")=gcDs2.namevalue(gcDs2.rowposition,"ETD_DT");
			gcds_print.namevalue(1,"ETD_DT1")=gcDs2.namevalue(gcDs2.rowposition,"ETD_DT");
			gcds_print.namevalue(1,"PL_SHPADD1")=gcDs1.namevalue(gcDs1.rowposition,"PL_SHPADD1");
			gcds_print.namevalue(1,"START_LCTNM")=gcDs1.namevalue(gcDs1.rowposition,"START_LCTNM");
			gcds_print.namevalue(1,"REACH_LCTNM")=gcDs1.namevalue(gcDs1.rowposition,"REACH_LCTNM");

			gcds_print02.UndoAll();
			gcds_print02.ImportData(gcDs2.ExportData(1,gcDs2.countrow,true));

		for (j=1;j<=3;j++) {
		
			gcDs2.DeleteRow(gcDs2.RowPosition);
			
		}

			gcrp_print.DetailDataID="gcds_print02";
			ln_RptFormat();

	}
	/******************************************************************************
		Description :  프린트
	******************************************************************************/
	function ln_RptFormat(){

		var ls_format = "";
		var ls_format1 = "";
		var ls_l1 = ",border=true, penstyle=solid ,penwidth=3 </L>";
		var ls_l2 = ",border=true, penstyle=solid ,penwidth=2 </L>";
		var ls_l2_2 = ",penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>";
		var ls_l3 = " ,underline=false,italic=false,forecolor=#000000 ,backcolor=#FFFFFF</T>";
		var ls_l4 = ", underline=false,italic=false,forecolor=#000000 ,backcolor=#FFFFFF</C>";


		ls_format +="		<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132";
		ls_format +="			<R>id='물자반입신고서.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_print01',SuppressColumns='1:NAM'";
		ls_format +="				<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=914 ,face='굴림' ,size=10 ,backcolor=#DDDDDD ,penwidth=1";
		ls_format +="					<X>left=114 ,top=460 ,right=2681 ,bottom=914 ,backcolor=#FFFFFF,border=true, penstyle=solid ,penwidth=2 </L>	" ;;
		ls_format +="					<T>id='수송수단' ,left=2168 ,top=472 ,right=2414 ,bottom=580 ,face='신명조' ,size=14 ,bold=false 	" + ls_l3;
		ls_format +="					<C>id='TRANS_CAR', left=2423, top=472, right=2675, bottom=580, align='left', face='신명조', size=9, bold=true" + ls_l3;
		ls_format +="					<T>id='신고자명' ,left=633 ,top=472 ,right=914 ,bottom=636 ,face='신명조체' ,size=14 ,bold=false  " + ls_l3;
		ls_format +="					<C>id='PL_SHPPRNM', left=923, top=472, right=1201, bottom=636, face='신명조', size=11, bold=true" + ls_l4;
		ls_format +="					<C>id='PL_SHPPRNM', left=923, top=472, right=1201, bottom=636, face='신명조', size=11, bold=true" + ls_l4;
		ls_format +="					<C>id='', left=328, top=472, right=618, bottom=636, face='굴림', size=10, bold=false " + ls_l4;
		ls_format +="					<T>id='도착지' ,left=990 ,top=642 ,right=1298 ,bottom=706 ,face='신명조' ,size=14 ,bold=false " + ls_l3;
		ls_format +="					<L> left=114 ,top=642 ,right=2681 ,bottom=642 </L>	" ;
		ls_format +="					<L> left=439 ,top=642 ,right=439 ,bottom=773" +ls_l2_2 ;
		ls_format +="					<L> left=987 ,top=642 ,right=987 ,bottom=773"+ls_l2_2 ;
		ls_format +="					<L> left=1304 ,top=642 ,right=1304 ,bottom=773"+ls_l2_2 ; 
		ls_format +="					<L> left=1846 ,top=642 ,right=1846 ,bottom=773"+ls_l2_2 ; 
		ls_format +="					<T>id='번호' ,left=120 ,top=545 ,right=316 ,bottom=618 ,face='신명조체' ,size=14 ,bold=false " +ls_l3;
		ls_format +="					<T>id='반입기간' ,left=1849 ,top=647 ,right=2159 ,bottom=771 ,face='신명조' ,size=14 ,bold=false " +ls_l3;
		ls_format +="					<T>id='(HS)' ,left=237 ,top=832 ,right=428 ,bottom=896 ,face='신명조' ,size=14 ,bold=false " +ls_l3;
		ls_format +="					<T>id='상품번호' ,left=237 ,top=779 ,right=428 ,bottom=844 ,face='신명조' ,size=14 ,bold=false " +ls_l3;
		ls_format +="					<T>id='(US$)' ,left=1392 ,top=829 ,right=1541 ,bottom=894 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='단가' ,left=1392 ,top=782 ,right=1541 ,bottom=844 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='(US$)' ,left=1559 ,top=829 ,right=1708 ,bottom=894 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='금액' ,left=1559 ,top=782 ,right=1708 ,bottom=844 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='세관등록' ,left=120 ,top=478 ,right=316 ,bottom=565 ,face='신명조체' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<L> left=1207 ,top=586 ,right=2681 ,bottom=586 </L>" ;
		ls_format +="					<T>id='주 소' ,left=1213 ,top=472 ,right=1441 ,bottom=583 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='수화인' ,left=990 ,top=712 ,right=1298 ,bottom=768 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='송화인' ,left=123 ,top=715 ,right=434 ,bottom=771 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='물자반입신고서' ,left=117 ,top=290 ,right=2707 ,bottom=422 ,face='신명조' ,size=26 ,bold=true" +ls_l3;
		ls_format +="					<T>id='개성공업지구세관 앞' ,left=108 ,top=243 ,right=653 ,bottom=319 ,align='left' ,face='신명조체' ,size=14 ,bold=true" +ls_l3;
		ls_format +="					<T>id='02-3669-3707' ,left=1453 ,top=592 ,right=2159 ,bottom=639 ,face='굴림' ,size=14 ,bold=true " +ls_l3;
		ls_format +="					<T>id='NO' ,left=123 ,top=779 ,right=231 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='원산지' ,left=2502 ,top=779 ,right=2672 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='복기' ,left=1714 ,top=779 ,right=2065 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='수량' ,left=1201 ,top=779 ,right=1380 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='단위' ,left=1058 ,top=779 ,right=1192 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='품    명' ,left=439 ,top=779 ,right=776 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<C>id='PL_SHPADD1', left=1453, top=472, right=2159, bottom=580, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<C>id='PL_SHPPRNM', left=445, top=715, right=976, bottom=771, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<T>id='규    격' ,left=785 ,top=779 ,right=1046 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<L> left=1553 ,top=776 ,right=1553 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=1389 ,top=776 ,right=1389 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=2074 ,top=776 ,right=2074 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=1714 ,top=776 ,right=1714 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=2203 ,top=776 ,right=2203 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=2499 ,top=776 ,right=2499 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=2329 ,top=776 ,right=2329 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<C>id='ETD_DT', left=2177, top=647, right=2672, bottom=771 ,mask='XXXX년 XX월 XX일 까지', face='신명조', size=13, bold=false" +ls_l4; 
		ls_format +="					<T>id='출발지' ,left=123 ,top=645 ,right=434 ,bottom=709 ,face='신명조' ,size=14 ,bold=false" +ls_l3; 
		ls_format +="					<L> left=322 ,top=460 ,right=322 ,bottom=642"+ls_l2_2 ;
		ls_format +="					<L> left=1207 ,top=460 ,right=1207 ,bottom=642"+ls_l2_2 ;
		ls_format +="					<L> left=917 ,top=460 ,right=917 ,bottom=642"+ls_l2_2 ;
		ls_format +="					<L> left=624 ,top=460 ,right=624 ,bottom=642"+ls_l2_2 ;
		ls_format +="					<L> left=2420 ,top=460 ,right=2420 ,bottom=642"+ls_l2_2 ;
		ls_format +="					<L> left=2165 ,top=460 ,right=2165 ,bottom=773"+ls_l2_2 ;
		ls_format +="					<L> left=1450 ,top=460 ,right=1450 ,bottom=642" +ls_l2_2 ;
		ls_format +="					<L> left=114 ,top=773 ,right=2681 ,bottom=773 </L>";
		ls_format +="					<L> left=234 ,top=773 ,right=234 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<T>id='(KG)' ,left=2335 ,top=829 ,right=2493 ,bottom=894 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='중량' ,left=2335 ,top=782 ,right=2493 ,bottom=844 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<C>id='START_LCTNM', left=445, top=645, right=976, bottom=700, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<C>id='PL_CSTMNM', left=1307, top=715, right=1837, bottom=771, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<L> left=114 ,top=706 ,right=1846 ,bottom=706 </L>" ;
		ls_format +="					<C>id='REACH_LCTNM', left=1307, top=645, right=1837, bottom=706, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<T>id='봉인번호' ,left=2168 ,top=589 ,right=2414 ,bottom=639 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='전화번호' ,left=1213 ,top=589 ,right=1441 ,bottom=636 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<L> left=782 ,top=773 ,right=782 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=1198 ,top=773 ,right=1198 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<L> left=1052 ,top=773 ,right=1052 ,bottom=914"+ls_l2_2 ;
		ls_format +="					<T>id='짝수' ,left=2209 ,top=779 ,right=2323 ,bottom=905 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='포장' ,left=2080 ,top=782 ,right=2194 ,bottom=844 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<T>id='형식' ,left=2080 ,top=829 ,right=2194 ,bottom=894 ,face='신명조' ,size=14 ,bold=false" +ls_l3;
		ls_format +="					<L> left=434 ,top=773 ,right=434 ,bottom=914"+ls_l2_2 ;
		ls_format += " </B>       ";	

		ls_format +="				<B>id=default ,left=0,top=0 ,right=2869 ,bottom=68 ,face='굴림' ,size=10 ,penwidth=1";
		ls_format +="					<C>id='{CURROW}', left=116, top=0, right=228, bottom=62, face='신명조', size=12, bold=true" +ls_l4;
		ls_format +="					<C>id='NAM', left=2500, top=0, right=2672, bottom=62, supplevel=1, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<L> left=113 ,top=0 ,right=113 ,bottom=69"+ls_l2_2 ;
		ls_format +="					<L> left=234 ,top=0 ,right=234 ,bottom=69"+ls_l2_2 ;
		ls_format +="					<C>id='{DECODE(PKG_WEIGHT,0,,PKG_WEIGHT)}', left=2334, top=0, right=2494, bottom=62, align='right', face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<C>id='{DECODE(PRICE,0,,PRICE)}', left=1559, top=0, right=1709, bottom=62, align='right', face='신명조', size=12, bold=true" +ls_l4;
		ls_format +="					<C>id='UNIT_PRICE_US', left=1391, top=0, right=1541, bottom=62, align='right', face='신명조', size=12, bold=true, underline=false,italic=false,forecolor=#000000 ,backcolor=#FFFFFF, dec=3</C>";
		
		ls_format +="					<C>id='{DECODE(GOODS_CNT,0,,GOODS_CNT)}', left=1200, top=0, right=1381, bottom=62, align='right', face='신명조', size=12, bold=true" +ls_l4;
		ls_format +="					<C>id='CNT_UNITNM', left=1059, top=0, right=1191, bottom=62, face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<C>id='STDRD_SZ', left=784, top=0, right=1047, bottom=62, align='left', face='신명조', size=11, bold=true" +ls_l4;
		ls_format +="					<L> left=1053 ,top=0 ,right=1053 ,bottom=69" +ls_l2_2;
		ls_format +="					<L> left=781 ,top=0 ,right=781 ,bottom=69"+ls_l2_2; 
		ls_format +="					<L> left=1197 ,top=0 ,right=1197 ,bottom=69" +ls_l2_2;
		ls_format +="					<L> left=1388 ,top=0 ,right=1388 ,bottom=69" +ls_l2_2; 
		ls_format +="					<L> left=1713 ,top=0 ,right=1713 ,bottom=69" +ls_l2_2;
		ls_format +="					<L> left=1553 ,top=0 ,right=1553 ,bottom=69" +ls_l2_2; 
		ls_format +="					<L> left=2678 ,top=0 ,right=2678 ,bottom=69" +ls_l2_2; 
		ls_format +="					<L> left=2500 ,top=0 ,right=2500 ,bottom=69" +ls_l2_2;
		ls_format +="					<L> left=2328 ,top=0 ,right=2328 ,bottom=69" +ls_l2_2; 
		ls_format +="					<C>id='{DECODE(PKG_CBM,0,,PKG_CBM)}', left=2209, top=0, right=2322, bottom=62, align='right', face='굴림', size=11, bold=true" +ls_l4;
		ls_format +="					<L> left=2203 ,top=0 ,right=2203 ,bottom=69"+ls_l2_2; 
		ls_format +="					<C>id='{DECODE(PKG_WIDTH,0,,PKG_WIDTH)}', left=2081, top=0, right=2194, bottom=62, align='right', face='굴림', size=11, bold=true" +ls_l4;	
		ls_format +="					<L> left=2075 ,top=0 ,right=2075 ,bottom=69"+ls_l4;
		ls_format +="					<C>id='{DECODE(PKG_HEIGHT,0,,PKG_HEIGHT)}', left=1713, top=0, right=2066, bottom=62, align='right', face='신명조', size=12, bold=true" +ls_l4;
		ls_format +="					<L> left=434 ,top=0 ,right=434 ,bottom=69" +ls_l4;
		ls_format +="					<C>id='{DECODE(PKC_CNT,0,,PKC_CNT)}', left=238, top=0, right=428, bottom=62, face='신명조', size=12, bold=true" +ls_l4;
		ls_format +="					<C>id='GOODS_NM', left=438, top=0, right=775, bottom=62, align='left', face='신명조', size=11, bold=true" +ls_l4;
		ls_format += " </B>       ";	

 		ls_format +="				<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format +="					<L> left=113 ,top=300 ,right=2681 ,bottom=300 </L>" ;
		ls_format +="					<L> left=2678 ,top=0 ,right=2678 ,bottom=303" +ls_l2_2;
		ls_format +="					<L> left=113 ,top=0 ,right=113 ,bottom=300"+ls_l2_2; 
		ls_format +="					<L> left=234 ,top=0 ,right=234 ,bottom=300" +ls_l2_2;
		ls_format +="					<L> left=434 ,top=0 ,right=434 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=781 ,top=0 ,right=781 ,bottom=300" +ls_l2_2;
		ls_format +="					<L> left=1053 ,top=0 ,right=1053 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=1197 ,top=0 ,right=1197 ,bottom=300"+ls_l2_2; 
		ls_format +="					<L> left=1388 ,top=0 ,right=1388 ,bottom=300" +ls_l2_2;
		ls_format +="					<L> left=1713 ,top=0 ,right=1713 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=1553 ,top=0 ,right=1553 ,bottom=300" +ls_l2_2;
		ls_format +="					<L> left=2075 ,top=0 ,right=2075 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=2203 ,top=0 ,right=2203 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=2328 ,top=0 ,right=2328 ,bottom=300" +ls_l2_2; 
		ls_format +="					<L> left=2500 ,top=0 ,right=2500 ,bottom=300" +ls_l2_2;
		ls_format += " </B>       ";	
	
		ls_format +="				<B>id=LDFooter ,left=0,top=0 ,right=2869 ,bottom=394 ,face='굴림' ,size=10 ,penwidth=1";
		ls_format +="					<T>id='※ 품명이 많을때에는 별지로 첨부할것' ,left=106 ,top=6 ,right=1147 ,bottom=78 ,align='left' ,face='신명조' ,size=14 ,bold=true"+ls_l3; 
		ls_format +="					<T>id='신고기관(공인,명판)' ,left=109 ,top=116 ,right=681 ,bottom=191 ,align='left' ,face='신명조' ,size=14 ,bold=true" +ls_l3;
		ls_format +="					<T>id='신고날짜:' ,left=109 ,top=200 ,right=388 ,bottom=272 ,align='left' ,face='신명조' ,size=14 ,bold=true" +ls_l3; 
		ls_format +="					<T>id='승    인' ,left=1663 ,top=200 ,right=2234 ,bottom=272 ,face='신명조' ,size=14 ,bold=true" +ls_l3;
		ls_format +="					<T>id='개성공업지구세관' ,left=1663 ,top=116 ,right=2231 ,bottom=191 ,align='left' ,face='신명조' ,size=14 ,bold=true" +ls_l3; 
		ls_format +="					<C>id='ETD_DT1', left=400, top=200, right=897, bottom=272, align='left' ,mask=' XXXX년  XX월  XX일 ', face='신명조', size=13, bold=true, Dec=0" +ls_l4; 
		ls_format += " </B>       ";	
		ls_format += " </R>       ";	
		ls_format += " </A>       ";	

		ls_format1 +="		<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=141";
		ls_format1 +="			<R>id='반입신고서_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcDs2' ";
		ls_format1 +="				<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=141 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format1 +="					<T>id='물자반입신고서 별지' ,left=26 ,top=32 ,right=1767 ,bottom=126 ,align='left' ,face='신명조' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>" ;
		ls_format1 += " </B>       ";	
		ls_format1 +="				<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=120 ,face='Arial' ,size=10 ,penwidth=1";
		ls_format1 +="					<X>left=29 ,top=29 ,right=2757 ,bottom=120 ,border=true ,penstyle=solid ,penwidth=3</X>" ;
		ls_format1 +="					<T>id='차량번호' ,left=41 ,top=32 ,right=211 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=217 ,top=29 ,right=217 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='품  명' ,left=223 ,top=32 ,right=703 ,bottom=114 ,face='굴림' ,size=10 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=712 ,top=29 ,right=712 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='규  격' ,left=715 ,top=32 ,right=1037 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=1043 ,top=29 ,right=1043 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='단위' ,left=1049 ,top=32 ,right=1192 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=1198 ,top=29 ,right=1198 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='수량' ,left=1204 ,top=32 ,right=1310 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=1315 ,top=29 ,right=1315 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='(US$)' ,left=1321 ,top=73 ,right=1509 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<T>id='단가' ,left=1321 ,top=41 ,right=1509 ,bottom=82 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=1518 ,top=29 ,right=1518 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='금액' ,left=1526 ,top=38 ,right=1802 ,bottom=79 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<T>id='(US$)' ,left=1526 ,top=70 ,right=1802 ,bottom=117 ,face='Arial' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=1808 ,top=29 ,right=1808 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='복기' ,left=1813 ,top=32 ,right=2051 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=2057 ,top=29 ,right=2057 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='포장' ,left=2063 ,top=35 ,right=2150 ,bottom=76 ,face='Arial' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=2142 ,top=29 ,right=2142 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='짝수' ,left=2147 ,top=32 ,right=2232 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=2227 ,top=29 ,right=2227 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='비고' ,left=2493 ,top=32 ,right=2745 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=2487 ,top=29 ,right=2487 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='원산지' ,left=2364 ,top=32 ,right=2481 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<T>id='중량' ,left=2232 ,top=32 ,right=2358 ,bottom=114 ,face='굴림' ,size=9 ,bold=false" + ls_l3;
		ls_format1 +="					<L> left=2364 ,top=29 ,right=2364 ,bottom=120" + ls_l2_2;
		ls_format1 +="					<T>id='형식' ,left=2063 ,top=73 ,right=2150 ,bottom=117 ,face='Arial' ,size=9 ,bold=false" + ls_l3;
		ls_format1 += " </B>       ";	

		ls_format1 +="				<B>id=default ,left=0,top=0 ,right=2871 ,bottom=96 ,face='굴림' ,size=10 ,penwidth=1";
		ls_format1 +="					<C>id='CNT_UNITNM', left=1049, top=6, right=1192, bottom=97, face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=1043 ,top=0 ,right=1043 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='STDRD_SZ', left=715, top=6, right=1037, bottom=97, align='left', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=712 ,top=0 ,right=712 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='GOODS_NM', left=223, top=6, right=706, bottom=97, align='left', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=217 ,top=0 ,right=217 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='CAR_NO', left=38, top=6, right=211, bottom=97, align='left', supplevel=1, face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<C>id='{DECODE(GOODS_CNT,0,,GOODS_CNT)}', left=1204, top=6, right=1310, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<C>id='{DECODE(UNIT_PRICE,0,,UNIT_PRICE)}', left=1321, top=6, right=1509, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<C>id='{DECODE(PRICE,0,,PRICE)}', left=1526, top=6, right=1802, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=1808 ,top=0 ,right=1808 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2057 ,top=0 ,right=2057 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2142 ,top=0 ,right=2142 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='', left=2063, top=6, right=2136, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=2227 ,top=0 ,right=2227 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='{DECODE(PKG_WEIGHT,0,,PKG_WEIGHT)}', left=2232, top=6, right=2358, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<C>id='VEND_NM', left=2493, top=3, right=2745, bottom=97, align='left', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=29 ,top=0 ,right=29 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='{DECODE(PKG_LNGTH,0,,PKG_LNGTH)}', left=1813, top=6, right=2051, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<C>id='', left=2147, top=6, right=2221, bottom=97, align='right', face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=1198 ,top=0 ,right=1198 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=1315 ,top=0 ,right=1315 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=1518 ,top=0 ,right=1518 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<C>id='NAM', left=2364, top=6, right=2481, bottom=97, supplevel=1, face='굴림', size=8, bold=false"+ls_l4;
		ls_format1 +="					<L> left=2487 ,top=0 ,right=2487 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2364 ,top=0 ,right=2364 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=32 ,top=97 ,right=2754 ,bottom=97 </L>" ;
		ls_format1 +="					<L> left=2754 ,top=0 ,right=2754 ,bottom=97" + ls_l2_2;
		ls_format1 += " </B>       ";

		ls_format1 +="				<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=331 ,face='굴림' ,size=10 ,penwidth=1";
		ls_format1 +="					<T>id='총    계' ,left=38 ,top=12 ,right=1034 ,bottom=88</T>";
		ls_format1 +="					<L> left=1043 ,top=0 ,right=1043 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=1198 ,top=0 ,right=1198 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=1315 ,top=0 ,right=1315 ,bottom=97" + ls_l2_2;

		ls_format1 +="					<S>id='{SUM(PKG_WEIGHT)}' ,left=1204 ,top=12 ,right=1310 ,bottom=88 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>" ;
		ls_format1 +="					<L> left=1518 ,top=0 ,right=1518 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<S>id='{SUM(PKG_WEIGHT)}' ,left=1526 ,top=12 ,right=1802 ,bottom=88 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>";


		ls_format1 +="					<L> left=1808 ,top=0 ,right=1808 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2057 ,top=0 ,right=2057 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2142 ,top=0 ,right=2142 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2227 ,top=0 ,right=2227 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=2364 ,top=0 ,right=2364 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<S>id='Avg(PKG_WEIGHT)' ,left=2232 ,top=12 ,right=2358 ,bottom=88 ,align='right' ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>" ;
		ls_format1 +="					<L> left=2487 ,top=0 ,right=2487 ,bottom=97" + ls_l2_2;
		ls_format1 +="					<L> left=29 ,top=0 ,right=29 ,bottom=97 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
		ls_format1 +="					<L> left=29 ,top=97 ,right=2751 ,bottom=97 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
		ls_format1 +="					<L> left=32 ,top=0 ,right=2748 ,bottom=0 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
		ls_format1 +="					<L> left=2754 ,top=0 ,right=2754 ,bottom=97" + ls_l2_2;
		
		ls_format1 += " </B>       ";
		ls_format1 += " </R>       ";	
		ls_format1 += " </A>       ";	

		if (gcDs2.countrow<4) {

			gcrp_print01.Format  = ls_format ;
			gcrp_print01.preview();    

		} else {

			gcrp_print01.Format  = ls_format + ls_format1  ;
			gcrp_print01.preview();    

	}
}

	/******************************************************************************
		Description :  프린트
	******************************************************************************/
	function ln_Print(){

		if (gcDs2.countrow<1) return;

		var arrParam	= new Array();
		var sPramRtn = window.showModalDialog("tr00111_popup01.html","","dialogWidth:500px;dialogHeight:200px;scroll:0;help:0;status:0");

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
			ls_format +="					<C>id='T_CBM'				,left=1600  ,top=1330	,right=1855 ,bottom=1400 ,face='굴림' ,size=9 ,bold=false ,backcolor=#FFFFFF, align=center, Dec=3</C>";
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
			ls_format +="					<L>left=163		,top=120  ,right=163 ,bottom=210		" + ls_l2;
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
			ls_format +="					<L>left=163		,top=0  ,right=163 ,bottom=40		" + ls_l2;
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
			ls_format +="					<C>id='CAR_NO'			,left=27		,top=0 ,right=160		,bottom=40 ,face='굴림' ,size=6 ,bold=false ,backcolor=#FFFFFF, align=left	,supplevel=1</C>";
			ls_format +="					<C>id='{DECODE(PKC_CNT,0,'',PKC_CNT)}'			,left=165		,top=0 ,right=240		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center, dec=0</C>";
			ls_format +="					<C>id='GOODS_NM'		,left=250		,top=0 ,right=550		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='STDRD_SZ'		,left=560		,top=0 ,right=860		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
			ls_format +="					<C>id='CNT_UNIT1'		,left=870		,top=0 ,right=940		,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=center</C>";
			ls_format +="					<C>id='{DECODE(GOODS_CNT,0,'',GOODS_CNT)}'		,left=950		,top=0 ,right=1050	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WEIGHT,0,'',PKG_WEIGHT)}'	,left=1060	,top=0 ,right=1170	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WEIGHT,0,'',PKG_WEIGHT)}'	,left=1180	,top=0 ,right=1290	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_LNGTH,0,'',PKG_LNGTH)}'		,left=1300	,top=0 ,right=1390	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_HEIGHT,0,'',PKG_HEIGHT)}'	,left=1400	,top=0 ,right=1490	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_WIDTH,0,'',PKG_WIDTH)}'		,left=1500	,top=0 ,right=1590	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=0</C>";
			ls_format +="					<C>id='{DECODE(PKG_CBM,0,'',PKG_CBM)}'				,left=1600	,top=0 ,right=1700	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=3</C>";
			ls_format +="					<C>id='VEND_NM'			,left=1710	,top=0 ,right=1850	,bottom=40 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=left</C>";
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
			ls_format +="					<S>id='{SUM(PKG_CBM)}'		,left=1600	,top=0 ,right=1700	,bottom=70 ,face='굴림' ,size=7 ,bold=false ,backcolor=#FFFFFF, align=right, dec=3</S>";
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
		var ls_project = LINE_PART.bindcolval;

		if (sPramRtn != null) arrParam = sPramRtn.split(";");
		
		if (arrParam[0]!="A" && arrParam[0]!="B") return;
		
		var surl = "";
		if (arrParam[0]=="A" && ls_project == '0001' ){
			surl = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00111_excel_pl?v_str1=" + PL_NO.value + "&v_str2=" + gn_Replace(gcurdate,"-") + "&v_str3=" +  ls_project  ;
	//		alert("str1=" + PL_NO.value + "&v_str2=" +ls_project );
			window.location.href=surl;
		} else if (arrParam[0]=="A" && ls_project == '0002' ){
			surl = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00111_excel_pl2?v_str1=" + PL_NO.value + "&v_str2=" + gn_Replace(gcurdate,"-") + "&v_str3=" +  ls_project  ;
			alert("str1=" + PL_NO.value + "&v_str2=" +ls_project );
			window.location.href=surl;				
		}else {
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

<OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="fasle">
	 <param name=SubSumExpr	value="1:NAM">
</OBJECT>

<OBJECT id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="fasle">
	 <param name=SubSumExpr	value="1:NAM">
</OBJECT>

<OBJECT id=gcds_print02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
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


<script language="javascript" for="gcds_print01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript for=gcDs_etc20 event=OnLoadCompleted(rowcnt)>
	gcDs_etc20.InsertRow(1) ; 
	gcDs_etc20.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc20.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	LINE_PART.index = 0 ; 
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

<script language=JavaScript for=LINE_PART event=OnSelChange()>
	var ls_project = LINE_PART.bindcolval;

	if( gs_parm[0]  == "make"){ // MODE 체크
			
		if(ls_project == '0001') {
			PL_CSTMNM.value='현대아산(주)개성사업소';	
			START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
			REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
		} else if(ls_project == '0002') {
			
			if(PL_SHPPRNM.value=='') {
				PL_SHPPRNM.value='현대아산(주)';
				PL_SHPADD1.value='서울 종로 연지동 1-7';
			}

			if(PL_BRKRNM.value=='') {
				PL_BRKRNM.value='현대아산(주)';
				PL_BRKADD1.value='서울 종로 연지동 1-7';
			}

			if(PL_CSNNM.value=='') {
				PL_CSTMNM.value='현대아산(주)금강산사업소';
			//PL_CSNADDR.value='서울 종로 계동 140-2';
			}

			START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0145");
			REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0004");
			PL_CSTMNM.value='현대아산(주)금강산사업소';
			//alert("test");
		} else {
			START_LCT.index = START_LCT.IndexOfColumn("MINORCD", "0010");
			REACH_LCT.index = REACH_LCT.IndexOfColumn("MINORCD", "0003");
			PL_CSTMNM.value='현대아산(주)개성사업소';	
		}
}
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

<!--2007.11.20 정영식 추가 -->
<script language=JavaScript for=gcDs2 event=onColumnChanged(row,colid)>
  var dblamt=0; 
	var dblkg=0;
	var dblcbm=0;

	//if (colid == 'T_WEIGHT') {
	//	gcDs1.NameValue(gcDs1.rowposition,"T_WEIGHT")= gcDs2.Sum(27,0,0);
	//}

  //금액관련 start//////////////////////////////////////////////////////////////////
  if(colid=="GOODS_CNT"){ //수량
		for(i=1;i<=gcDs2.countrow;i++){
			 dblamt = dblamt + gcDs2.namevalue(i,"GOODS_CNT")*gcDs2.namevalue(i,"UNIT_PRICE");
		}
		gcem_amt.text = dblamt;
		ln_GetSum_Weight();
		ln_GetSum_CBM();
	}

	if(colid=="UNIT_PRICE"){ //단가
	  for(i=1;i<=gcDs2.countrow;i++){
			dblamt = dblamt + gcDs2.namevalue(i,"GOODS_CNT")*gcDs2.namevalue(i,"UNIT_PRICE");
		}
		gcem_amt.text = dblamt;
	}
	//금액관련 end//////////////////////////////////////////////////////////////////


  //중량관련 start//////////////////////////////////////////////////////////////////
	if(colid=="PKC_CNT"){ //포장수량
		ln_GetSum_Weight();
		ln_GetSum_CBM();
	}

	if(colid=="PKG_WEIGHT"){ //포장중량
	  ln_GetSum_Weight();
	}
 //중량관련 end//////////////////////////////////////////////////////////////////

 
  //CBM관련 start//////////////////////////////////////////////////////////////////
	if(colid=="PKG_LNGTH"){ //포장길이
		gcDs2.namevalue(row,"PKG_CBM")=gcDs2.namevalue(row,"PKG_LNGTH")*gcDs2.namevalue(row,"PKG_WIDTH")*gcDs2.namevalue(row,"PKG_HEIGHT")/1000000
		ln_GetSum_CBM();
	}

	if(colid=="PKG_WIDTH"){ //포장길이
	  gcDs2.namevalue(row,"PKG_CBM")=gcDs2.namevalue(row,"PKG_LNGTH")*gcDs2.namevalue(row,"PKG_WIDTH")*gcDs2.namevalue(row,"PKG_HEIGHT")/1000000
		ln_GetSum_CBM();
	}

	if(colid=="PKG_HEIGHT"){ //포장길이
	  gcDs2.namevalue(row,"PKG_CBM")=gcDs2.namevalue(row,"PKG_LNGTH")*gcDs2.namevalue(row,"PKG_WIDTH")*gcDs2.namevalue(row,"PKG_HEIGHT")/1000000
		ln_GetSum_CBM();
	}

  //CBM관련 end//////////////////////////////////////////////////////////////////
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

<script language=JavaScript for=gcrp_print01 event=OnPreviewDlgClosed()>

gcDs2.UndoAll();


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
			<td><img src="../img/TR00109_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../img/btn/btn_print4.gif" style="cursor:hand" onclick="ln_Print01();"> 
				<img src="../img/com_b_print.gif" style="cursor:hand" onclick="ln_Print();">		
				<img src="../img/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel();"> 
				<img src="../img/btn/b_save.gif" style="cursor:hand" onclick="Save();">
				<img src="../img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
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
						<td class="tab11_top1" bgcolor="#eeeeee" width=120 style="text-align:center">사업명</td>
						<td style="width:300px;border:1 solid #777777;border-right-width:0px;border-left-width:0px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:160px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="1">
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
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
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
							<input id="PL_SHPPRNM" name="PL_SHPPRNM" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' >
							<input id="PL_SHPPRCD" name="PL_SHPPRCD" type="hidden" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD1" name="PL_SHPADD1" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD2" name="PL_SHPADD2" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPADD3" name="PL_SHPADD3" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' ><BR>
							<input id="PL_SHPTEL" name="PL_SHPTEL" type="text" class="txt11_none1" style='width:100%;position:relative;left:0px;top:0px' > 
						</td>
						<td colspan=4 class="tab11_left">
							&nbsp;&nbsp;&nbsp;(송장번호 : 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=DCL_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:6px; width:100px;height:17px;font-family:굴림; font-size:10pt;font-weight:bold;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="############">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> )&nbsp; 
							(송장일자 : 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=DCL_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:2px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:0px;top:3px;cursor:hand" onclick="__GetCallCalendar('DCL_DATE', 'Text');"> )
					</td>
				</tr>
				</tr>
				  <tr> 
					<td class="tab11_left" colspan=4 bgcolor="#eeeeee" >
					 &nbsp;9. 비&nbsp;&nbsp;고
					</td>
				</tr> 
				<tr> <td class="tab11_left" colspan=4 rowspan=3>
				<textarea ID="REMARK" name="REMARK" style='width:510px;height=100px' class=txt11></textarea></td></tr> 
				<tr >
					<td class="tab11_left"  colspan=2  bgcolor="#eeeeee"> 
					&nbsp;2. 수하인 
					<img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallCustomer();"> 
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
					 &nbsp;3. 통지선  
					 <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallBroker();"> 
					</td>
					<td class="tab11_left"  width=360 colspan=4 bgcolor="#eeeeee">
					 &nbsp;위탁자  
					 <img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="CallBroker2();"> 
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
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=START_LCT  style='border:0;position:relative;left:8px;top:0px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=140  >
						<param name=ComboDataID			value=gcDs_etc11>  
						<param name=CBDataColumns		value="MINORCD,MINORNM">
						<param name=SearchColumn		value="MINORNM">
						<param name=SortColumn			value="MINORNM"> 
						<param name=Sort						value=True>
						<param name=ListExprFormat	value="MINORNM^0^120"> 
						<param name=BindColumn			value="MINORCD">
						<param name=Index						value=0>
						<param name=InheritColor		value="true"> 
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td class="tab11_left"> 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=REACH_LCT  style='border:0;position:relative;left:8px;top:0px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=140  >
							<param name=ComboDataID			value=gcDs_etc12>  
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=SortColumn			value="MINORNM"> 
							<param name=Sort						value=True>
							<param name=ListExprFormat	value="MINORNM^0^100"> 
							<param name=BindColumn			value="MINORCD">
							<param name=Index						value=0>
							<param name=InheritColor		value="true"> 
						</OBJECT>
						<%=HDConstant.COMMENT_END%> 
					</td>
					<td class="tab11_left" ><input id="TRANS_CAR" name="TRANS_CAR" type="text" class="txt11_none1" style='width:100px;position:relative;left:8px;top:0px' ></td>
					<td class="tab11_left"    >&nbsp;
					 <%=HDConstant.COMMENT_START%>
					 <OBJECT id=START_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:-1px;top:1px;cursor:hand" onclick="__GetCallCalendar('START_DATE', 'Text');">
					<!--  <%=HDConstant.COMMENT_START%><OBJECT id=START_TIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:30px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="00:00">
								<param name=PromptChar	  value="_">
							</OBJECT><%=HDConstant.COMMENT_END%> -->
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PACKING_CNT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:6px; width:60px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="2">
								<param name=Border	      value="false">
								<param name=Numeric	      value="1">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						<input id="PACKING_UNIT" name="PACKING_UNIT" type="text" class="txt11" style='width:40%;position:relative;left:6px;top:0px'>
						<img src="../img/btn_find.gif" style="position:relative;left:8px;top:3px;cursor:hand" onclick="callUnit(1);"> 
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
					<td class=tab11_left style="height:30px;">
					<input id="txt_danga" name="txt_danga" type="text" class="txt11_none1_right" style='width:100%;position:relative;left:0px;top:0px' ></td>
					<td class=tab11_left>
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_amt  class="txt11_none1_right" style='width:98%;position:relative;left:0px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left>
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PACKING_CBM  class="txt11_none1_right" style='width:60px;position:relative;left:0px;top:4px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						<input id="PACKING_UNIT2" type="text" class="txt11" style='width:40%;position:relative;left:6px;top:0px'><img src="../img/btn_find.gif" style="position:relative;left:8px;top:3px;cursor:hand" onclick="callUnit(2);"> 
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=WEIGHT  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;KGS 
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=T_WEIGHT  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment		value=2>
							<param name=Numeric			value=true>
							<param name=IsComma			value=true>
							<param name=MaxLength		value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border	value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;KGS
					</td>
					<td class=tab11_left> 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=T_CBM  class="txt11_none1_right" style='width:70%;position:relative;left:0px;top:5px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment		value=2>
							<param name=Numeric			value=true>
							<param name=IsComma			value=true>
							<param name=MaxLength		value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border	value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;CBM 
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
						<%=HDConstant.COMMENT_START%>
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:100%;height:238px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
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
								<F> Name='영문품명'	ID=GOODS_ENM		HeadAlign=Center HeadBgColor=#eeeeee Width=110 align=left, edit=none show=false</F>  

								<C> Name='규  격'					ID=STDRD_SZ		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, edit=none</C>
								<C> Name='단위'						ID=CNT_UNIT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left  EditStyle=Lookup Data='gcDs_etc6:MINORCD:MINORNM', edit=none</C>
								<C> Name='수량'						ID=GOODS_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right </C> 
								<C> Name='단가'						ID=UNIT_PRICE	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, dec=0</C>
								<C> Name='UNIT_PRICE_US'	ID=UNIT_PRICE_US  HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, dec=3 show=false</C>
								<C> Name='PRICE_US'				ID=PRICE_US  HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, value={GOODS_CNT*UNIT_PRICE_US}, dec=3 show=false </C>

								<C> Name='금액'						ID=PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=right, value={GOODS_CNT*UNIT_PRICE}</C>
								<G> Name='단위 포장별'    HeadAlign=Center HeadBgColor=#eeeeee 
									<C> Name='수량'					ID=PKC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right, dec=0</C> 
									<C> Name='중량(KG)'			ID=PKG_WEIGHT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, Dec=0  </C> 
									<C> Name='길이(CM)'			ID=PKG_LNGTH  HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0 </C>  
									<C> Name='폭(CM)'				ID=PKG_WIDTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0</C> 
									<C> Name='높이(CM)'			ID=PKG_HEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right, dec=0</C> 
									<C> Name='용적(CBM)'		ID=PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, dec=3, edit=none</C>
								</G>
								<C> Name='총중량(KG)'			ID={GOODS_CNT/PKC_CNT*PKG_WEIGHT}	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=1 edit=none</C> 
								<C> Name='비   고'				ID=VEND_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=217 align=left</C> 
								<C> Name='비   고'				ID=NAM			HeadAlign=Center HeadBgColor=#eeeeee Width=217 align=left Suppress=1 show=false</C> 
							  
							">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
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
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=GOODS_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%> 
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단위&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=CNT_UNIT  style='border:0;position:relative;left:6px;top:1px;width:140px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="51">
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
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단가&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=UNIT_PRICE  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment					value=2>
							<param name=Numeric						value=true>
							<param name=IsComma						value=true>
							<param name=MaxLength					value=10>
							<param name=MaxDecimalPlace		value=2>
							<param name=border						value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;금액&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PRICE  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr><td	colspan=8 class=tab11_left bgcolor="#CCCCFF">&nbsp;<b>단위포장</b></td></tr> 
				<tr>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKC_CNT  class="txt11_right" style='width:90;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120 tabindex="52"> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;단위&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKG_UNIT  style='border:0;position:relative;left:6px;top:1px;width:140px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 tabindex="51">
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
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
						<!--
						<img src="../img/btn_find.gif" style="position:relative;left:2px;top:2px;cursor:hand" onclick="callUnit();"> 
						-->
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;순중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PR_WEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PT_WEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
				</tr>	
				<tr> 
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;길이(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKG_LNGTH  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;높이(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKG_HEIGHT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;폭(cm)&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKG_WIDTH  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;용적&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKG_CBM  class="txt11" style='width:100px;position:relative;left:6px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;CBM
					</td>
				</tr>	
				<tr> 
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;포장수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=PKC_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총중량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=T_WEIGHT1  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총수량&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=T_CNT  class="txt11" style='width:100px;position:relative;left:6px;top:1px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=2>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>  
					</td>
					<td class=tab11_left bgcolor="#eeeeee">&nbsp;총용적&nbsp;</td>
					<td class=tab11_left >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=T_CBM1  class="txt11" style='width:100px;position:relative;left:6px;top:2px;height:15' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=24 width=120> 
							<param name=Alignment				value=2>
							<param name=Numeric					value=true>
							<param name=IsComma					value=true>
							<param name=MaxLength				value=10>
							<param name=MaxDecimalPlace	value=3>
							<param name=border					value=false>
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;CBM
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
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcDs1>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=PL_NO          Ctrl= PL_NO       Param = value </C>
		<C>Col=IN_OUT         Ctrl= IN_OUT      Param = BindColVal </C>
		<C>Col=PL_SHIPPER     Ctrl= PL_SHIPPER  Param = value </C>
		<C>Col=PL_SHPPRNM     Ctrl= PL_SHPPRNM  Param = value </C>
		<C>Col=PL_SHPPRCD     Ctrl= PL_SHPPRCD  Param = value </C>
		<C>Col=PL_SHPADD1     Ctrl= PL_SHPADD1  Param = value </C>
		<C>Col=PL_SHPADD2     Ctrl= PL_SHPADD2  Param = value </C>
		<C>Col=PL_SHPADD3     Ctrl= PL_SHPADD3  Param = value </C>
		<C>Col=PL_SHPTEL      Ctrl= PL_SHPTEL   Param = value </C>
		<C>Col=PL_CSTM        Ctrl= PL_CSTM     Param = value </C>
		<C>Col=PL_CSTMNM      Ctrl= PL_CSTMNM   Param = value </C>
		<C>Col=PL_CSTADD1     Ctrl= PL_CSTADD1  Param = value </C>
		<C>Col=PL_CSTADD2     Ctrl= PL_CSTADD2  Param = value </C>
		<C>Col=PL_CSTADD3     Ctrl= PL_CSTADD3  Param = value </C>
		<C>Col=PL_CSTTEL      Ctrl= PL_CSTTEL   Param = value </C>
		<C>Col=PL_BRKR        Ctrl= PL_BRKR     Param = value </C>
		<C>Col=PL_BRKRNM      Ctrl= PL_BRKRNM   Param = value </C>
		<C>Col=PL_BRKADD1     Ctrl= PL_BRKADD1  Param = value </C>
		<C>Col=PL_BRKADD2     Ctrl= PL_BRKADD2  Param = value </C>
		<C>Col=PL_BRKADD3     Ctrl= PL_BRKADD3  Param = value </C>
		<C>Col=PL_BRKTEL      Ctrl= PL_BRKTEL   Param = value </C>
		<C>Col=PL_NOTICE      Ctrl= PL_NOTICE   Param = value </C>
		<C>Col=PLNOTICENM     Ctrl= PLNOTICENM  Param = value </C>
		<C>Col=START_LCT      Ctrl= START_LCT   Param = BindColVal </C>
		<C>Col=REACH_LCT      Ctrl= REACH_LCT   Param = BindColVal </C>
		<C>Col=TRANS_CAR      Ctrl= TRANS_CAR   Param = value </C>
		<C>Col=START_DT       Ctrl= START_DATE    Param = Text </C>
		<C>Col=START_TIME     Ctrl= START_TIME    Param = Text </C>
		<C>Col=INVOICE_NO     Ctrl= INVOICE_NO  Param = Text </C>
		<C>Col=INVOICE_DT     Ctrl= INVOICE_DT  Param = Text </C>
		<C>Col=REMARK         Ctrl= REMARK      Param = value </C>
		<C>Col=LCNO           Ctrl= LCNO        Param = value </C>
		<C>Col=LCDATE         Ctrl= LCDATE      Param = value </C>
		<C>Col=LCBANK         Ctrl= LCBANK      Param = value </C>
		<C>Col=T_WEIGHT       Ctrl= WEIGHT      Param = Text </C>
		<C>Col=T_WEIGHT       Ctrl= T_WEIGHT    Param = Text </C>
		<C>Col=T_CBM          Ctrl= T_CBM       Param = Text </C>
		<C>Col=GORDER_NO      Ctrl= GORDER_NO   Param = value </C>
		<C>Col=PACKING_CNT    Ctrl= PACKING_CNT Param = Text </C> 
		<C>Col=PACKING_CBM    Ctrl= PACKING_CBM Param = Text </C>
		<C>Col=TELEPHONE      Ctrl= TELEPHONE   Param = value </C>
		<C>Col=RPR_GOODS      Ctrl= RPR_GOODS   Param = value </C>
		<C>Col=CARGO_TYPE     Ctrl= CARGO_TYPE  Param = value </C>
		<C>Col=DNG_TYPE       Ctrl= DNG_TYPE    Param = value </C>
		<C>Col=CAR_TYPE       Ctrl= CAR_TYPE    Param = value </C>
		<C>Col=ORDER_NO       Ctrl= ORDER_NO    Param = value </C>
		<C>Col=DCL_DATE       Ctrl= DCL_DATE    Param = Text </C>
		<C>Col=DCL_NO         Ctrl= DCL_NO      Param = Text </C>
		<C>Col=CURRENCY       Ctrl= CURRENCY    Param = BindColVal </C> 
		<C>Col=PACKING_UNIT   Ctrl= PACKING_UNIT  Param = value </C> 
		<C>Col=LINE_PART      Ctrl= LINE_PART    Param = BindColVal </C>
		<C>Col=PL_CSN				  Ctrl= PL_CSN       Param=value</C>
		<C>Col=PL_CSNNM				Ctrl= PL_CSNNM     Param=value</C>
		<C>Col=PL_CSNTEL			Ctrl= PL_CSNTEL    Param=value</C>
		<C>Col=PL_CSNADDR			Ctrl= PL_CSNADDR   Param=value</C>
		<C>Col=PL_CSNADDR2		Ctrl= PL_CSNADDR2  Param=value</C>
		<C>Col=PL_CSNADDR3		Ctrl= PL_CSNADDR3  Param=value</C>
	'>
	</OBJECT>
	<%=HDConstant.COMMENT_END%>

		<%=HDConstant.COMMENT_START%>
		<OBJECT id=gcbn02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
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
		'>
		</OBJECT>
		<%=HDConstant.COMMENT_END%>


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

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print01  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="MasterDataID"			value="gcds_print">
	<param NAME="DetailDataID"				VALUE="gcds_print02"> 
	<PARAM NAME="PaperSize"						VALUE="A4">	
	<PARAM NAME="LandScape"					  VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag"		VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="100">
	<param name="SuppressColumns"	value="1:NAM;"> 
	<PARAM NAME="Format"							VALUE="

">
</OBJECT>
<%=HDConstant.COMMENT_END%>


</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

