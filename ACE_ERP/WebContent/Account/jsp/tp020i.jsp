<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - 시스템명 	 : 가수금관리/보통예금 전표등록
 - 프로그램ID 	 : Account/tp/tp020i.jsp
 - 서 블 릿		 : Account.menu.tp.Tp020I
 - 작 성 자		 : 정영식
 - 작 성 일		 : 2012-06-20
 - 기능정의		 : 출납등록건 중 매입 등록한 건을 대상으로 전표 발행.
 - [ 수정일자 ][수정자] 내용
 - [2012-05-21][정영식] 신규
 - [2015-05-27][심동현] 보통예금 용으로 수정 
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
	   java.util.Calendar date = java.util.Calendar.getInstance();
	   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	   String lastday = m_today.format(date.getTime());//오늘
	   //date.set(java.util.Calendar.HOUR_OF_DAY, -24);//어제
	   String firstday = m_today.format(date.getTime());		   
	         
	   	
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
    var acc_dirpath="<%=dirPath%>/Account/jsp";
    var g_arrParam	= new Array();

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출		
		cfStyleGrid(getObjectFirst("gr_excel"), "comn");  //grid 헤드색
		cfStyleGrid(getObjectFirst("gr_slipdtl"), "comn");  //grid 헤드색 
		
		fnInit();	
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";   
		//계좌번호 [AC021] dstype=5 : detail_nm을 보여주면서 '전체'
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
        codeDs1.Reset();
	    
        vt_fr_inout_dt.Text = "<%=firstday%>";
        vt_to_inout_dt.Text = "<%=lastday%>";
        
        ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //지점 
        
               
       v_empnmk.value=gusrnm;
       v_empno.value=gusrid;       
       lc_fdcode.bindcolval = gfdcode;      
       gcem_fs02.text ="A";
       gcem_fsdat02.text =  "<%=DateUtil.getCurrentDate(8)%>";
       gcem_fsnbr02.text ="000000";      
       gcem_actdat02.text =  "<%=DateUtil.getCurrentDate(8)%>";
    }
    
    
    <%//메인 조회  %>
    function fnSelect() {
		if (ds_excel.IsUpdated ) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";

		    var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	        if(fr_date.length!=8) {
	            alert("거래일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("거래일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	    	if( fr_date.substring(0,6)!= to_date.substring(0,6) ){
	       		alert("조회시 거래년월이 동일해야 합니다. ");
	       		return false;
	        }

		    
			v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
            		+ ",dsType=1"
		            + ",sBgnDate=" + fr_date
		            + ",sEndDate=" + to_date;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",	 
	            "JSP(O:MAIN_DS=ds_excel)",
	            v_param);
	        tr_post(tr1);	<%//Tp010I 조회를 이용%>
	        
	        ds_slipdtl.ClearAll();
	        fnDisplay_Clear();
		}
    }    
    
    
       <%//clear %>
    function fnDisplay_Clear(){
        gcem_fsnum.text="";
    
    	gcem_fsrvalnm01.text ="";
		gcem_fsrvalnm03.text ="";
		gcem_fsrvalnm04.text ="";
		gcem_fsrvalnm05.text ="";
		gcem_fsrvalnm06.text ="";
		gcem_fsrvalnm07.text ="";
		gcem_fsrvalnm08.text ="";
		gcem_fsrvalnm09.text ="";
		
		txt_fsrefval01.value="";
		txt_fsrefval03.value="";
		txt_fsrefval04.value="";
		txt_fsrefval05.value="";
		txt_fsrefval06.value="";
		txt_fsrefval07.value="";
		txt_fsrefval08.value="";
		txt_fsrefval09.value="";
    }
     
        
    
    <%//취소 %>
    function fnCancel_All(){
    	 fnSelect();
    	 fnRepay_Cancel_All();
    }
    
    
    <%//원가 팝- 조회%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
  
  
    function fnSelCostCleanup_0(){
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
    } 
    
     <%//전표생성 버튼%>
    function fnSlipCreate() {
    
          //DataSet Head 설정 
          //gs_rpt_mst.clearAll();

		  //var s_temp = "TITLE:STRING,COST_NM:STRING,USRNAME:STRING,USEDATE:STRING";
		  //gs_rpt_mst.SetDataHeader(s_temp);
		
		  //1전표 MST 생성 
          //2전표 DTL 생성 		  
          //3전표 REF 생성 
          
          //UPDATE -  통장업로드 테이블(SALES.TAC080)에 전표번호 INSERT (TR_SID 정보를 가지고 있어야 함. ) 
          //쿼리에서 조회 하여 일괄 UPDATE 칠까??
          //필수항목 체크 
          
		//if(!fnSlipChk()) return;
		
		//1.회계일자 
		//2.계정1, 계정2 
		//3.거래처 
		//4.지점 
		//5.공급가액, 부가세액 
		//6.반제정산 일경우 정산내역 존재 
		//7.정산내역 금액합과 반제정산 금액 비교 
		//8.전표등록에서 금액이 차변 / 대변 동시에 존재하지 못하게 함. 
		
		// 기본설정 
		//공급가액 -> 계정코드 1
		//공급가액+부가세액 → 계정코드 2
		
		
		//보통예금 정보를 조회해서 행이 있을 때만
		if(ds_excel.countrow>0){
			ds_slipdtl.clearall();
			//그리드 데이터 설정 
			fnCreateSelect();
		}else{
			alert("보통예금 정보를 먼저 조회해주세요.");
		}
    }
    
    
    function fnCreateSelect() {
    
       var fr_date = vt_fr_inout_dt.Text.trim();
	   var to_date = vt_to_inout_dt.Text.trim();
	   var strFsdat = gcem_fs02.text+ gcem_fsdat02.text;
	    
       var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                         + ",v_fdcode=" + lc_fdcode.bindcolval
                         + ",v_fsdat=" + strFsdat
                         + ",v_fr_inout_dt =" + fr_date
                         + ",v_to_inout_dt =" + to_date
                         + ",v_empno =" + v_empno.value	;
                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp020I",
            "JSP(O:DS_SLIPDTL=ds_slipdtl)",
            param);
            //prompt('',param);
        tr_post(tr1);
    }    
    
    <%//전표등록 그리드 데이터 기본셋팅 : ds_slipdtl 로딩 후   %>
    function fnSlipdtl_Display(row){
    	var strPo="";
	    
	    //자동설정하기
		for(var i=1;i<=row;i++){
			ds_slipdtl.namevalue(i,"FSNUM") =ln_Seqno_Format(Number(i),3);
			ds_slipdtl.namevalue(i,"FSSEQ") =ln_Seqno_Format(Number(i),5);
			ds_slipdtl.namevalue(i,"FSREFVAL02") =ds_slipdtl.namevalue(i,"VEND_CD") ;
			ds_slipdtl.namevalue(i,"FSRVALNM02") =ds_slipdtl.namevalue(i,"VEND_NM") ;
			
			//부서 ( 기본으로 작업자 부서 넣기 ) 였으나 불러온 값으로 설정(20150602 by 심동현) 
			//ds_slipdtl.namevalue(i,"FSREFVAL01") = gdeptcd;
			//ds_slipdtl.namevalue(i,"FSRVALNM01") = gdeptnm;

			
			
			
			//본부코드는 어디서 가져올까?
			//(고민거리....쉽게 처리하는 방법이 없나??????) → 저장 시점에서 건설사업본부로 처리함. 
			
			//원가코드 
			strPo="";
			strPo = fnRef_position_find(i,"0030");
			if(ds_slipdtl.namevalue(i,"FSREFCD"+strPo)=="0030"){
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = v_cost_cd_0.value;
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = v_cost_nm_0.value;
			}
			
			////선급부가가치세 자동 설정 
			if (ds_slipdtl.namevalue(i,"ATCODE")=="1112300"){ // 선급부가세 
			    strPo="";
			    strPo = fnRef_position_find(i,"0998");
			    // 전도금 --> 세금계산서,  [개인명]법인카드 -->기타부가세  
				if(ds_default.namevalue(1,"INGB_CD")==1||ds_default.namevalue(1,"INGB_CD")==2){ //법인카드, 개인명 법인카드 ==> 기타부가세
					ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "04";
			        ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "기타부가세";						
				}else if (ds_default.namevalue(1,"INGB_CD")==3||ds_default.namevalue(1,"INGB_CD")==4){
					ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "03";
			        ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "세금계산서";
				}
				
				//계산서 일자 
				strPo="";
			    strPo = fnRef_position_find(i,"0970");
			    
			    //alert("INOUT_DT::"+ds_slipdtl.namevalue(i,"INOUT_DT"));
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"INOUT_DT");
			    ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = ds_slipdtl.namevalue(i,"INOUT_DT");
			}
					 
			//예산부서 LOCK
			//관광구분 LOCK 
			
			//카드종류, 카드번호, 법인카드 거래처 등 
			if (ds_slipdtl.namevalue(i,"ATCODE")=="2100520"){ // 법인카드 
				strPo="";
			    strPo = fnRef_position_find(i,"1134"); //카드종류
			    
			    ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"CARD_KND");
			    
			    if(ds_slipdtl.namevalue(i,"CARD_KND")=="001"){
			    	ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "현대카드";
			    }else if(ds_slipdtl.namevalue(i,"CARD_KND")=="002"){
			    	ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "외환카드";
			    }else if(ds_slipdtl.namevalue(i,"CARD_KND")=="003"){
			    	ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "농협카드";
			    }else if(ds_slipdtl.namevalue(i,"CARD_KND")=="004"){
			    	ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "우리카드";
			    }
			    
		        //이것을 수정하여 처리 하자 ..!!!!!
			    ds_cardcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s7?v_str1=1133&v_str2="+ds_slipdtl.namevalue(i,"CARD_NUM");
			   // prompt('',ds_cardcode2.DataID);
			    ds_cardcode2.Reset();   //지점 
			    
			    strPo="";
			    strPo = fnRef_position_find(i,"1133"); //카드번호
			    ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) =ds_cardcode2.namevalue(ds_cardcode2.rowposition,"CDCODE");
			    ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_cardcode2.namevalue(ds_cardcode2.rowposition,"CDNAM");
			}
			
			//통화명 
			strPo="";
			strPo = fnRef_position_find(i,"1043");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "01";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "WON";
			
			//외화금액 
			strPo="";
			strPo = fnRef_position_find(i,"1045");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "0";
			
			if (ds_slipdtl.namevalue(i,"ATCODE")=="2100525"){ //개인명 법인카드
			
				ds_cardcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_card_s1?v_str1="+ds_slipdtl.namevalue(i,"VEND_CD") ; 
		    	ds_cardcode.Reset();   //지점 
		    	
		    	//alert("ds_cardcode::"+ds_cardcode.countrow);
				
				//개인명은행
				strPo="";
				strPo = fnRef_position_find(i,"2168");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_cardcode.namevalue(ds_cardcode.rowposition,"CAACCBANK");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_cardcode.namevalue(ds_cardcode.rowposition,"BANKNM");
				
				//개인명카드번호
				strPo="";
				strPo = fnRef_position_find(i,"2167");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_cardcode.namevalue(ds_cardcode.rowposition,"CANBR");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_cardcode.namevalue(ds_cardcode.rowposition,"CARDNO");
				
				//카드종류
				strPo="";
				strPo = fnRef_position_find(i,"1134");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_cardcode.namevalue(ds_cardcode.rowposition,"CACARDSPEC");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_cardcode.namevalue(ds_cardcode.rowposition,"CARDKD");
				
				//개인명계좌번호 
				strPo="";
				strPo = fnRef_position_find(i,"2166");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_cardcode.namevalue(ds_cardcode.rowposition,"CABANKNO");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_cardcode.namevalue(ds_cardcode.rowposition,"ACCNO");
			}
			
			//계정이 외상매입금 일경우 
			if (ds_slipdtl.namevalue(i,"ATCODE")=="2100110"){ //외상매입금
				//외상매입금 
				strPo="";
				strPo = fnRef_position_find(i,"1011");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"NONPAY");
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_slipdtl.namevalue(i,"NONPAYNM");
			}
    	}
	}
	
    <%//생성시 기본 데이터 조회  %>
    function fnSave() {
    
        gcds_salestac.clearall();
		fnTacSetDataHeader();
		fnTsiSettting();
       	
       	gcds_slipdtl.clearall();
		fnSlipdtlSetDataHeader();
		fnSlipdtlSettting();
       	
       	gcds_slipmst.clearall();
		fnSlipmstSetDataHeader();   
		fnSlipmstSettting();
    
     	//prompt('gcds_slipdtl',gcds_slipdtl.text);
     	//prompt('gcds_slipmst',gcds_slipmst.text);
    
     	if(fnSave_Chk()){
  			 if (gcds_slipmst.IsUpdated) {
				if (confirm("저장 하시겠습니까?")){	
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp020I_t1"
					tr2.Parameters = "v_str1="+gusrid+",v_str2="+gfdcode;
				    //<param name="KeyValue"    value="Si050I_t1(I:USER1=gcds_slipmst,I:USER2=gcds_slipdtl,I:USER3=gcds_banjaemst,I:USER4=gcds_banjae,I:USER5=gcds_salestac,O:USER9=gcds_slipno )">    
				    //tr2.keyvalue="Si050I_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_salestac,O:USER5=gcds_slipno )"; 
					//prompt('gcds_slipmst',gcds_slipmst.text);
					//prompt('gcds_slipdtl',gcds_slipdtl.text);
					//prompt('gcds_banjaemst',gcds_banjaemst.text);
					//prompt('gcds_banjae',gcds_banjae.text);
					//prompt('gcds_salestac',gcds_salestac.text);
				
					tr2.post();
				}	
			}
		}
    }

       
     <%//head생성%>
	function fnSlipmstSetDataHeader() {
    	 var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
						   + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
						   + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
						   + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		  gcds_slipmst.SetDataHeader(s_temp);
     
    }
    
    <%//head생성%>
	function fnSlipdtlSetDataHeader() {
	 	  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
		  				    + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
							+ "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							+ "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
							+ "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							+ "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							+ "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							+ "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
							+ "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
							+ "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
							+ "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
							+ "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
							+ "TYPE01:STRING,TYPE02:STRING,TYPE03:STRING,TYPE04:STRING,TYPE05:STRING,"
							+ "TYPE06:STRING,TYPE07:STRING,TYPE08:STRING,TYPE09:STRING,"
							+ "ARBALDIV01:STRING,ARBALDIV02:STRING,ARBALDIV03:STRING,ARBALDIV04:STRING,ARBALDIV05:STRING,"
							+ "ARBALDIV06:STRING,ARBALDIV07:STRING,ARBALDIV08:STRING,ARBALDIV09:STRING,"
							+ "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							+ "BANJAEYN:STRING,FSSTAT:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,"
							+ "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING";
			gcds_slipdtl.SetDataHeader(s_temp);
    }
    
    
     <%//전표 저장 후 TAC080 업데이트를 위한 DS head생성%>
	function fnTacSetDataHeader() {
    	 var s_temp = "TR_SID:DECIAML,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
		 gcds_salestac.SetDataHeader(s_temp);
    }
      
        
     <%//전표dtl 데이터 설정%>
    function fnSlipdtlSettting() {
    	    	
    	for (var k=1;k<=ds_slipdtl.countrow;k++){
    		gcds_slipdtl.addrow();
    		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FDCODE" ) = ds_slipdtl.namevalue(k, "FDCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" )    = ds_slipdtl.namevalue(k, "FSDAT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNBR" )   = ds_slipdtl.namevalue(k, "FSNBR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSEQ" )   = ds_slipdtl.namevalue(k, "FSSEQ" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" ) = ds_slipdtl.namevalue(k, "ATCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATDECR" ) = ds_slipdtl.namevalue(k, "ATDECR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "REMARK" ) = ds_slipdtl.namevalue(k, "REMARK" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DEAMT" )   = ds_slipdtl.namevalue(k, "DEAMT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CRAMT" )   = ds_slipdtl.namevalue(k, "CRAMT" );
       		
       		for(var no=1;no<=9;no++){
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFSEQ0"+no ) = ds_slipdtl.namevalue(k, "FSREFSEQ0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )   = ds_slipdtl.namevalue(k, "FSREFCD0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no )  = ds_slipdtl.namevalue(k, "FSREFVAL0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFNM0"+no )   = ds_slipdtl.namevalue(k, "FSREFNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no ) = ds_slipdtl.namevalue(k, "FSRVALNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "TYPE0"+no)           = ds_slipdtl.namevalue(k, "TYPE0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ARBALDIV0"+no)    = ds_slipdtl.namevalue(k, "ARBALDIV0"+no );
       			
       			
       			//2012.10.02 법인카드일경우 법인카드 거래처 적용 
	       		if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" )=="2100520"){
	       			if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )=="0029" ){
	       				gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no );
	       			}
	       		}
       		}
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )   = ds_slipdtl.namevalue(k, "DOCUMCD" );
       		
       		//예산음 모두 미적용으로 함. 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )   ="01";
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRDT" )        ="<%=DateUtil.getCurrentDate(8)%>";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRID" )        = gusrid;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEYN" )    = ds_slipdtl.namevalue(k, "ATDEBTYN" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSTAT" )      = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUVAL" )     = ds_slipdtl.namevalue(k, "DOCUVAL" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" )       = ds_slipdtl.namevalue(k, "FSNUM" );
       		
       		//현장이니까 모두 건설사업본부가 본부가 됨. 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DIVCD" )       ="II00";
       		//예산부서 없음 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BGTDIV" )      = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEREF" )   = ds_slipdtl.namevalue(k, "BANJAEREF" );
       		
       		
       		
       	}
    } 
      
    <%//전표mst 데이터 설정%>
    function fnSlipmstSettting() {
    	var srow = 0;
		gcds_slipmst.addrow();
		
		srow = gcds_slipmst.rowposition; 
		
		//alert("FDCODE"+ds_slipdtl.namevalue(1, "FDCODE" ));
		
		gcds_slipmst.namevalue(srow,"FDCODE")= ds_slipdtl.namevalue(1, "FDCODE" );
		gcds_slipmst.namevalue(srow,"FSDAT") =  ds_slipdtl.namevalue(1, "FSDAT" );
		gcds_slipmst.namevalue(srow,"FSNBR")="000000";
		gcds_slipmst.namevalue(srow,"FSKND")= "D";         //자동전표 - 재무회계   
		gcds_slipmst.namevalue(srow,"FSWRTDAT")= "<%=DateUtil.getCurrentDate(8)%>";
		gcds_slipmst.namevalue(srow,"COCODE")="02";
		gcds_slipmst.namevalue(srow,"DEPTCD")= gdeptcd;
		gcds_slipmst.namevalue(srow,"EMPNO")=gusrid;
		gcds_slipmst.namevalue(srow,"DIVCD")= "";
		gcds_slipmst.namevalue(srow,"FSAMT")= gcds_slipdtl.Sum(9,0,0);   //차변 
		gcds_slipmst.namevalue(srow,"FSVAT")= 0 ;
		gcds_slipmst.namevalue(srow,"DETOT")= gcds_slipdtl.Sum(9,0,0);   //차변 
		gcds_slipmst.namevalue(srow,"CRTOT")= gcds_slipdtl.Sum(10,0,0); //대변 
		gcds_slipmst.namevalue(srow,"REMARK")=  gcds_slipdtl.namevalue(1,"REMARK"); //대변 
		gcds_slipmst.namevalue(srow,"SGNDAT")= "";
		gcds_slipmst.namevalue(srow,"FSSTAT")= "N";
		gcds_slipmst.namevalue(srow,"ACTDAT")= gcem_actdat02.text;
		gcds_slipmst.namevalue(srow,"SSDAT")= "";
		gcds_slipmst.namevalue(srow,"SSNBR")= "";
		gcds_slipmst.namevalue(srow,"WRDT")=  "<%=DateUtil.getCurrentDate(8)%>";
		gcds_slipmst.namevalue(srow,"WRID")= gusrid;
    
    } 
    
     <%//생성시 기본 데이터 조회  %>
    function fnTsiSettting() {
    	for(var t=1;t<=ds_excel.CountRow;t++){
    	
    	    if(ds_excel.namevalue(t,"COL03")!=""){//적요란
    	    	//TR_SID를 생성해준다.
	    		gcds_salestac.addrow();
	    		gcds_salestac.namevalue(gcds_salestac.rowposition,"TR_SID")= ds_excel.namevalue(t,"TR_SID");
	    	}
    	}
   }
    
     <%//필수항목 체크%>
     function fnSave_Chk(){
     
        //return true;     
        var intBanjaeDeamt=0;
        var intBanjaeCramt=0;
     
	    //지점 확인 
		if(gcds_slipmst.namevalue(1,"FDCODE")==""){
			alert("지점을 확인 하십시요");
			return false;
		}
				
		//차변합계 와 대변합계 비교 
		if(gcds_slipmst.namevalue(1,"DETOT")!=gcds_slipmst.namevalue(1,"CRTOT")){
			alert("차변합계와 대변합계 금액을  확인 하십시요");
			return false;
		}
		
		//회계일자 확인
		if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
			alert("회계일자를 확인 하십시요");
			return false;
		}		
		
		
		//출납년월과 회계년월이가 틀린경우 
		if (gcds_slipmst.namevalue(1,"ACTDAT").substring(0,6)!=vt_fr_inout_dt.text.substring(0,6)){
			alert("거래년월과 회계년월이 다릅니다. 확인바랍니다.");
			return false;
		}
	

     	for(var i=1;i<=gcds_slipdtl.countrow;i++){
     	     	
     	    if(gcds_slipdtl.namevalue(i,"ATCODE")==""){
				 gcds_slipdtl.rowposition = i;
				 alert("계정코드를 입력하십시요");
				 return false;
			}
			
			//금액
			if(gcds_slipdtl.namevalue(i,"DEAMT")==0&&gcds_slipdtl.namevalue(i,"CRAMT")==0){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 금액을 입력하십시요");
				return false;
			}
			
			//차변 및 대변 금액 
			if(gcds_slipdtl.namevalue(i,"DEAMT")!=0&&gcds_slipdtl.namevalue(i,"CRAMT")!=0){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+ " 차변금액과 대변금액을 확인 하십시요");
				return false;
			} 
			
			 //거래처 
			if(gcds_slipdtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL02")==""||gcds_slipdtl.namevalue(i,"FSRVALNM02")=="")){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 거래처는 필수항목입니다.");
				return false;
			}
			
				//부서 
			if(gcds_slipdtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL01")==""||gcds_slipdtl.namevalue(i,"FSRVALNM01")=="")){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 부서는 필수항목입니다.");
				return false;
			}
	
			//적요
			if(gcds_slipdtl.namevalue(i,"REMARK")==""){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 적요을 입력하십시요");
				return false;
			}
		
			
	     	if(gcds_slipdtl.namevalue(i,"DOCUMCD")!=""&&gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
	     		alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 증빙값이 존재 하지 않습니다.");
	     		gcds_slipdtl.rowposition = i;
	     		return false;
	     	}
	     	
	  
			for(var k=3;k<=9;k++){
			   
					if(gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)=="")){	
							if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)!="0003"){
							
								 if(gcds_slipdtl.namevalue(i,"TYPE0"+k)!="C"){ //입력아닌경우 
								    ///alert("k::"+k+"::"+gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)+"::::FSREFVAL::"+gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)+"::FSRVALNM::"+gcds_slipdtl.namevalue(i,"FSRVALNM0"+k));
								    //필수항목 체크 
									tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
									alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 관리항목 "+tempnm+"는 필수항목입니다2.");
									gcds_slipdtl.rowposition = i;
									return false;		
								}else{
									if(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)==""){
										tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
										alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 관리항목 "+tempnm+"는 필수항목입니다3.");
										gcds_slipdtl.rowposition = i;
										return false;											
									}
								}
							}
					 }
			}//for k
			
			
			 // 반제 데이터 (-)금액  입력 방지 	
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //반제
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //차변
						if(gcds_slipdtl.namevalue(i,"DEAMT")<0){
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
							gcds_slipdtl.rowposition = i;
							return false;
						}
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //대변
						if(gcds_slipdtl.namevalue(i,"CRAMT")<0){
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
							gcds_slipdtl.rowposition = i;
							return false;
						}
				 }
			}
			
			  //신용카드(공제), 현금영수증(공제)일 경우 선급부가가치세가 기타부가세가 아니면 체크 
			if(gcds_slipdtl.namevalue(i,"DOCUMCD")=="103"||gcds_slipdtl.namevalue(i,"DOCUMCD")=="104" ){ 
				for(var x=3;x<=9;x++){
					if(gcds_slipdtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //선급부가가치세
						if(gcds_slipdtl.namevalue(i,"FSREFVAL0"+x)!="04"){
						    gcds_slipdtl.rowposition = i;
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" 증빙명이 신용카드(공제), 현금영수증(공제)일 경우 선급부가가치세 항목은 기타부가세입니다. ");
							return false;
						}
					}
				}//for x
			}	
			
			
			//반제금액 누적
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //반제
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //차변계정 ( 대변금액 합계 )
				 	intBanjaeCramt+=gcds_slipdtl.namevalue(i,"CRAMT");
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //대변계정 ( 차변계정 합계 )
				 	intBanjaeDeamt+=gcds_slipdtl.namevalue(i,"DEAMT");
				 }
			}
			
			
			
			 //2015.02.25.JYS (오연주 요청) 
			//외상매입금, 미지급금의 일반업체 의 반제 발생인 경우 증빙명 필수 - 계산서 번호 확인
			///////////////////////////////////////////////////////////////////////////////////////////////////////
		   if(gcds_slipdtl.namevalue(i,"ATCODE")=="2100110"&&gcds_slipdtl.namevalue(i,"DEAMT")!=0){
		    	m=0;
				for(k=3;k<=9;k++){
					if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)=="02"){
		        
						if(gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
							gcds_slipdtl.rowposition = i;
							alert("외상매입금 일반업체는 증빙번호가 필수항목니다.확인하십시요");
							return false;
						}
				    }
		    	}
		    }	
	    } //for i
	    return  true;
     }
    
     <%//관리항목 찾기 %>
	function fnRef_Popup(p1,obj,strkeycode){
	
	    var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var strposition="";
		var strpo2="";
		var strpo3="";
		var strPopGubun ="";
		var strPo="";                  // 관리항목위치
		var divcd="";
		var intp=0;                      //관리항목 위치
		
		//var dirpath="../../Account/jsp";
		/////////////////////////////////////////////////////
		// 관리항목 구분자  ( 거래처 제외 ) 
		/////////////////////////////////////////////////////
		intp = Number(p1);
		
		//alert(":::::::::::::::"+eval("txt_type0"+intp).value);
		if(eval("txt_type0"+intp).value=="C") return;
					
		arrParam[0] = eval("txt_fsrefcd"+p1).value;    //관리항목 구분코드  
		arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //관리항목 값 
			
		//ds_slipdtl.namevalue(row,"TYPE"+p)=="C"
		//alert("arrParam[0]::"+arrParam[0]+"::");
		//alert("arrParam[1]::"+arrParam[1]+"::");
			
		//부서 
		if (arrParam[0]=="0002"){
			arrParam[2]="A";
			arrParam[3]="";
			arrParam[4]=lc_fdcode.bindcolval;
	
			//2007.10.08.회계일자 추가(부서 CHGYM 관련)
		    var stractdat = gcem_actdat02.text;
		    arrParam[5]=stractdat.substring(0,6);
		
		    strURL = acc_dirpath+"/hcdept_popup.jsp";
		    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";	   
		}else if (arrParam[0]=="0020"){
			strURL =  acc_dirpath+"/gczm_vender_popup.jsp";
			strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
		}else if (arrParam[0]=="0003"){//예산부서 
			arrParam[2]=hid_bgtdiv.value;
			strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="0030"){ //원가
			arrParam[2]="";
			strURL = acc_dirpath+"/commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="1113"){//카드번호 
			 arrParam[2]="";
		     for(p=3;p<=9;p++){
					if(eval("txt_fsrefcd0"+p).value=="1134"){
						arrParam[2]=eval("txt_fsrefval0"+p).value;
						break;
					}
			 }
			 strURL =  acc_dirpath+"/commdtil_popup_card.jsp";
			 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="1135"){//자산코드번호 
			arrParam[1]= lc_fdcode.bindcolval;   //지점
			arrParam[2]= ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE");         //계정코드
			strURL =  acc_dirpath+"/commdtil_popup_astnbr.jsp";
			strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else{
			 if(arrParam[0]=="0997")arrParam[2]="A";
			 strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
			 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
		}
	
		result = showModalDialog(strURL,arrParam,strPos);	
	
		if(result != null) {
			arrResult = result.split(";");
			eval("txt_fsrefval"+p1).value =arrResult[0];
			eval("gcem_fsrvalnm"+p1).text =arrResult[1];
			
			//alert("01::"+gcem_fsrvalnm01.text);
			//alert("02::"+gcem_fsrvalnm02.text);
			
			if (arrParam[0]=="0002"){
				hid_divcd.value = arrResult[3]; //본부
			}
	    }	
	}
    

	<%//관리항목 KillFocus시 발생  obj - 관리항목의 gcem object명    p - 자리수 0 %>
	function fnonblur(obj, p){
	  // alert("obj::"+obj);
	    var row = ds_slipdtl.rowposition;
	    if(obj=="gcem_fsrvalnm"+p){
			if(ds_slipdtl.namevalue(row,"TYPE"+p)=="C"){
				eval("txt_fsrefval"+p).value =eval("gcem_fsrvalnm"+p).text; 	
				//alert("07::::::::"+eval("txt_fsrefval"+p).value);
			}
			
			if(eval("gcem_fsrvalnm"+p).text==""){
				eval("txt_fsrefval"+p).value=""; 
			}
		}
	}
	    
    <%//관리항목 위치찾기%>
    function fnRef_position_find(p,strValue){
	  var strposition="";
		for(f=3;f<=9;f++){
		    //alert("strValue::"+strValue+"::"+ds_slipdtl.namevalue(p,"FSREFCD0"+f)+"::");
			if (ds_slipdtl.namevalue(p,"FSREFCD0"+f)==strValue){  
					strposition ="0"+f;
					return strposition; 
		    }
		}//for f 
		return strposition; 
	}
     
	<%//작성자 팝- 조회%>
    function fnSelEmpPopup(dirPath){
         //권한 체크 
        //관리자만 사용가능함. 
        if (gusrid!="6070001" && gusrid!="6060002"){
        	alert("권한이 존재하지 않습니다.");
        	return false;
        }
    
    	var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiEmpPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_empno.value = arrParam[0];	//
            v_empnmk.value = arrParam[1];	//
        } else {
			fnSelEmpCleanup();
        }               
    }
    
     function fnSelEmpCleanup(){
    	 v_empno.value = "";
         v_empnmk.value = "";
    }
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<script language=JavaScript for=vt_fr_inout_dt event=OnKillFocus()>
	        if( vt_fr_inout_dt.Modified == true )
	        	vt_to_inout_dt.text = vt_fr_inout_dt.text;
	</script>    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
		
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>


<script language=JavaScript for=tr2  event=OnSuccess()>
	var temp="";
	
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("작업이 성공적으로 완료되었습니다.");
	fnSelect();
</script>


<script language=JavaScript for=tr2 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_excel event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_excel" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
			//gr_excel.ColumnProp('INOUT_DT','BgColor')= "FFCC66";	
		}
	</script>
	
	<script language=javascript for="ds_slipdtl" event="OnLoadCompleted(row)">
	    fnSlipdtl_Display(row);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm01 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('01','gcem_fsrvalnm01',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('03','gcem_fsrvalnm03',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('04','gcem_fsrvalnm04',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('05','gcem_fsrvalnm05',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('06','gcem_fsrvalnm06',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
		if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE")=="2100520"){ //미지급금(법인카드)
			if(gcem_fsrvalnm07.Text.length>=9) {
				alert("법인카드 거래처명을 8자까지 입력가능합니다.");
	      		gcem_fsrvalnm07.Text ="";
				gcem_fsrvalnm07.Focus();
	  		} 
	    }
		
		if (kcode==13||kcode==113)fnRef_Popup('07','gcem_fsrvalnm07',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('08','gcem_fsrvalnm08',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('09','gcem_fsrvalnm09',kcode);
	</script>
	
	
	
	<!-- 부서 / 거래처 / 관리항목 -->
	<script language=JavaScript for=gcem_fsrvalnm01 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm01", '01');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm03", '03');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm04", '04');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm05", '05');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm06", '06');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm07", '07');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm08", '08');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm09", '09');
	</script>
		
	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_excel classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--보통예금-->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--계좌번호 공통코드 -->
    <param name="SyncLoad"  value="False">
</object>



<object id=ds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표상세-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표상세-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표mst-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_cardcode classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--개인법인 카드정보-->
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_cardcode2 classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--법인카드정보-->
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>>       <!--지점-->
    <param name="SyncLoad"  value="True">
</object>

<!--반제history -->
<object id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="+BTSSEQ">
</object>

<!--접수번호 -->
<object id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
     <PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--보통예금 거래정보-->
<object id=gcds_salestac classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"    value="Tp020I_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_salestac,O:USER5=gcds_slipno )"> 
    <param name="Parameters" value="">
</object>


</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <!--<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:pointer" onclick="fnPrint()">-->
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                                <tr>
			                        <td align=left class="text"  width="70">거래일자</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                                                                                                         
			                        </td>   
			                        <td align="center" class="text" width="70">작성자</td>
                                    <td bgcolor='#ffffff' >&nbsp;
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelEmpPopup('<%=dirPath%>');" alt="조회창 팝">
			                            <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  readOnly="readonly">
									</td>
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        
        <tr height='10px'>
            <td><b><font size="2" color="blue">[보통예금 정보]</font></b></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_excel width="845px" height="170px" border="1">
							        <param name="DataID"            value="ds_excel">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="ViewSummary"		value=1>
							        <param name="Format"            value="
											<C> name='계좌번호'    	ID='TR_ACCT_CD' Width=100  align=center  SumText='거래 건수' editstyle=lookup data='codeDs1:detail:detail_nm'</C>
							                <C> name='거래일시'    	ID='COL01'  	Width=100  align=center  show=true SumText='@count'	</C>
							                <C> name='거래구분'  	ID='COL02'    	Width=90  align=center  show=true	</C>
							                <C> name='적요'      	ID='COL03'    	Width=130  align=left  show=true SumText='입금액 계' </C>
							                <C> name='맡기신 금액'  ID='COL04'   	Width=90  SumText={sum(Number(COL04))} align=RIGHT  show=true DEC=0</C>
							                <C> name='남은 금액'  	ID='COL05'  	Width=90  align=RIGHT show=false	DEC=0</C>
							                <C> name='취급점'   	ID='COL06'   	Width=100  align=center show=false	</C>
							                <C> name='TR_SID'    	ID='TR_SID'  	Width=100  align=left  show=false	</C>
							                <C> name='거래처명'    	ID='VEND_NM'  	Width=90  align=left  show=true	</C>
							                <C> name='코드'  		ID='VEND_CD'  	Width=50  align=left  show=true	</C>
							                <C> name='접수일자'		ID='FSDAT'  	Width=66  align=center show=true	</C>
							                <C> name='접수번호'		ID='FSNBR'  	Width=60  align=center show=true	</C>
							        ">
							</object>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
         <tr height='25px'>
            <td>
            	 <table border='0' cellpadding='0' cellspacing='2' width='845px'>
                    <tr>
                        <td><b><font size="2" color="blue">[전표등록]</font></b></td> 
                        <td height='20px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:pointer" onclick="fnSlipCreate()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		    style="cursor:pointer" onclick="fnSave()">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"			style="cursor:pointer" onclick="fnCancel_All()">                        
						   
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='25px'>
	    	<td>
	    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
	    			<tr>
	                   <td align="center" class="text" width="70">지점</td>                                                                     
	                   <td bgcolor='#ffffff'>&nbsp;&nbsp;
							<object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_fdcode>
								<param name=BindColumn       value="FDCODE">
								<param name=BindColVal         value="FDCODE">
								<param name=ListExprFormat   value="FDNAME^0^90">
								<param name=Index                  value="2">
								<param name=Enable               value="true">
							</object>
							
						</td>
	                    <td align="center" class="text" width="70">접수번호</td>
	                    <td bgcolor="#FFFFFF">&nbsp;
	                      	
							<object id=gcem_fs02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=Format        value="#">
							<param name=PromptChar    value="_">
							<param name=UpperFlag     value=1>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:70px;height:20px;position:relative;left:0px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="YYYY/MM/DD">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							-&nbsp;
							<object id=gcem_fsnbr02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:50px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="######">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							   
	                    </td>
	                     <td align="center" class="text" width="70">회계일자</td>                                                                     
	                    <td bgcolor="#FFFFFF" >&nbsp;
	                    	
							<object id=gcem_actdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="position:relative;top:2px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							   
	                    </td>
	    			</tr>
	    			<tr>
	    			 	<td align="center" class="text" width="70">전표부서</td>   
                        <td bgcolor="#FFFFFF"  colspan=5 >&nbsp;
                             <input id="txt_deptcd"   type=text    style= "position:relative;top:0px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find2('txt_MAKER','03');" readOnly>
							 <img SRC="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="전표부서를 검색합니다" style="cursor:pointer;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('01');">
						     <input id="txt_deptnm" type="text"  style= "position:relative;top:0px;left:4px;width:220px; height:20px;background-color:#ccffcc;"class="txtbox"  maxlength="36" onBlur="bytelength(this,this.value,36);" readOnly>			
                             <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCostCleanup_0();" alt="값 지우기">
                         </td>
	    			</tr>
	       		</table>
	       	</td>
	 	</tr>
   
        <tr>
        	<td>
	        	<table cellpadding="0" cellspacing="0" border="0" style="width:845px;height:200px;font-size:9pt;background-color:#ffffff;" > 
					<tr>
						<td colspan =9 style="height:145px;">
							
								<object id=gr_slipdtl classid=<%=HDConstant.CT_GRID_CLSID%> width='843px' height='170px' border='1'>
									<param name="dataid"			        value="ds_slipdtl">
									<param name="indwidth"		        value ='0'>
									<param name="borderstyle"         value="0">
									<param name="fillarea"		        value="true">
									<param name="ViewSummary"	value=1>
									<param name="ColSizing"            value="true">
									<param name="Editable"              value="true">
									<param name="ColSelect"		    value=false>
									<param name="Format"		  	    value=" 
									    <FC>Name='순번'		   ID=FSNUM 	          Width=30	    align=center  edit=none    </FC> 
										<FC>Name='계정코드'  ID=ATCODE 	          Width=51        align=left	    edit=none   </FC> 
										<FC>Name='계정명'	   ID=ATKORNAM	      Width=170	    align=left	    edit=none   SumText='합   계'</FC> 
										<FC>Name='차변금액'  ID=DEAMT 	          Width=95        align=right	edit=none   SumText={sum(Number(DEAMT))}  color =#0000FF  sumcolor =#0000FF  Value={Number(DEAMT)} </FC> 
										<FC>Name='대변금액'  ID=CRAMT 	          Width=95	    align=right    edit=none   SumText={sum(Number(CRAMT))}  color =#FF0000  sumcolor =#FF0000  Value={Number(CRAMT)}</FC> 										
										<C> Name='적요'		   ID=REMARK              Width=205	    align=left	   SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
										<C> Name='증빙명'	   ID=DOCUMCD 	       Width=70	    align=left       edit=none   SumText='차변-대변'  EditStyle=Combo Data='000:,101:세금계산서,102:계산서,103:신용카드(공제),104:현금영수증(공제),201:신용카드(불공),202:간주공급,203:간이영수증'</C> 
										<C> Name='증빙'	       ID=DOCUVAL     	   Width=40    	align=left       edit=none   </C> 
										<C> Name='예산'		   ID=FSWRKDIV 	       Width=40	    align=center edit=none   EditStyle=Combo Data='01:미적용,02:적용'  show =false</C> 
										<C> Name='거래처'	   ID=VEND_NM     	   Width=100 	align=left       edit=none   </C> 
										<C> Name='부서'		   ID=FSRVALNM01 	   Width=100	    align=left       edit=none   </C> 
										<C> Name='관리항목3' ID=FSRVALNM03 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목4' ID=FSRVALNM04 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목5' ID=FSRVALNM05 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목6' ID=FSRVALNM06 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목7' ID=FSRVALNM07 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목8' ID=FSRVALNM08	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='관리항목9' ID=FSRVALNM09 	   Width=100 	align=left	     edit=none   </C>
									">
							</object>		
						</td>
					</tr>
					<tr>
					    <td width="25px"   class="tab32"     align=center  bgcolor="#B9D4DC" style="height:20px;" >순번</td>
					    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
					    	<input type=text    id=txt_fsrefnm01   name=txt_fsrefnm01  value="부서"          size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					        <input type=hidden  id=txt_fsrefcd01   value=''>
							<input type=hidden  id=txt_fsrefseq01 value=''>
							<input type=hidden  id=txt_type01       value=''>
							<input type=hidden  id=txt_arbaldiv01 value=''>
					    </td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
							<input type=text    id=txt_fsrefnm03   name=txt_fsrefnm03  value="관리항목3"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd03   value=''>
							<input type=hidden  id=txt_fsrefseq03 value=''>
							<input type=hidden  id=txt_type03       value=''>
							<input type=hidden  id=txt_arbaldiv03 value=''>					
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm04   name=txt_fsrefnm04  value="관리항목4"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd04   value=''>
							<input type=hidden  id=txt_fsrefseq04 value=''>
							<input type=hidden  id=txt_type04       value=''>
							<input type=hidden  id=txt_arbaldiv04 value=''>
						</td>
						
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm05   name=txt_fsrefnm05  value="관리항목5"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd05   value=''>
							<input type=hidden  id=txt_fsrefseq05 value=''>
							<input type=hidden  id=txt_type05       value=''>
							<input type=hidden  id=txt_arbaldiv05 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text       id=txt_fsrefnm06   name=txt_fsrefnm06  value="관리항목6"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd06   value=''>
							<input type=hidden  id=txt_fsrefseq06 value=''>
							<input type=hidden  id=txt_type06       value=''>
							<input type=hidden  id=txt_arbaldiv06 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text        id=txt_fsrefnm07   name=txt_fsrefnm07  value="관리항목7"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd07   value=''>
							<input type=hidden  id=txt_fsrefseq07 value=''>
							<input type=hidden  id=txt_type07       value=''>
							<input type=hidden  id=txt_arbaldiv07 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text        id=txt_fsrefnm08   name=txt_fsrefnm08  value="관리항목8"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd08   value=''>
							<input type=hidden  id=txt_fsrefseq08 value=''>
							<input type=hidden  id=txt_type08       value=''>
							<input type=hidden  id=txt_arbaldiv08 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm09   name=txt_fsrefnm09  value="관리항목9"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd09   value=''>
							<input type=hidden  id=txt_fsrefseq09 value=''>
							<input type=hidden  id=txt_type09       value=''>
							<input type=hidden  id=txt_arbaldiv09 value=''>
							
							<input type=hidden  id=hid_banjaeref    value=''><!--반제단위-->
							<input type=hidden  id=hid_banjaeyn    value=''><!--반제유무-->
							<input type=hidden  id=hid_atdecr         value=''><!--차대구분-->
							<input type=hidden  id=hid_bgtdiv          value=''><!--예산-->
							<input type=hidden  id=hid_divcd           value=''><!--본부-->
							<!--거래처-->
							<input type=hidden  id=txt_fsrefcd02   value=''>
							<input type=hidden  id=txt_fsrefseq02 value=''>
							<input type=hidden  id=txt_type02       value=''>
							<input type=hidden  id=txt_arbaldiv02 value=''>
						</td>
					</tr>	
					<tr>
					    <td width="24px"   class="tab25"   align=center  style="height:22px;" >
					       
					    	 <object id=gcem_fsnum         classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:18;position:relative;top:3px;">				
								<param name=Text				value="">
								<param name=Border          value=false>
							    <param name=Format          value="000">
								<param name=Enable          value=false>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor   value=false> 
							</object>
					    </td>
					    <td width="104px" class="tab26"     align=center  >
					    	
					   	    <object id=gcem_fsrvalnm01  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval01   value=''>
					    </td>
						<td width="104px" class="tab26"     align=center >
						     
							<object id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval03   value=''>
						</td>
						<td width="104px" class="tab26"     align=center > 
						    
						 	<object id=gcem_fsrvalnm04  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval04   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						     
							<object id=gcem_fsrvalnm05  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval05   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						     
							<object id=gcem_fsrvalnm06  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval06   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						     
							<object id=gcem_fsrvalnm07  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval07   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
			                 
							<object id=gcem_fsrvalnm08  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type=hidden  id=txt_fsrefval08   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center>
						      
							<object id=gcem_fsrvalnm09  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object>
							<input type="hidden"  id=txt_fsrefval09   value=''>
						</td>	
						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="padding-top:4px;">※ 자동 생성된 전표는 [<b>홈>회계>회계관리>전표관리>전표등록</b>]에서 접수번호로 조회할 수 있습니다.</td>
		</tr>		
    </table>
    <object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID        value=ds_slipdtl>
	<param name=BindInfo     value='  
	<C>Col=FDCODE           Ctrl=hid_fdcode   	     Param=value</C>
	<C>Col=FSDAT              Ctrl=hid_fsdat         Param=value</C>
    <C>Col=FSNBR              Ctrl=hid_fsnbr         Param=value</C>
	<C>Col=FSSEQ              Ctrl=hid_fsseq         Param=value</C>
	<C>Col=ATCODE            Ctrl=gcem_atcode02      Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02		 Param=Text</C>
	<C>Col=ATDECR            Ctrl=hid_atdecr	     Param=value</C>
	<C>Col=REMARK            Ctrl=gcem_remark02_1    Param=Text</C>
	<C>Col=CHAAMT            Ctrl=gcem_detot02  	 Param=Text</C>
	<C>Col=DAEAMT            Ctrl=gcem_crtot02       Param=Text</C>
	<C>Col=FSREFSEQ01      Ctrl=txt_fsrefseq01      Param=value</C>
	<C>Col=FSREFSEQ02      Ctrl=txt_fsrefseq02      Param=value</C>
	<C>Col=FSREFSEQ03      Ctrl=txt_fsrefseq03      Param=value</C>
	<C>Col=FSREFSEQ04      Ctrl=txt_fsrefseq04      Param=value</C>
	<C>Col=FSREFSEQ05      Ctrl=txt_fsrefseq05	     Param=value</C>
	<C>Col=FSREFSEQ06      Ctrl=txt_fsrefseq06      Param=value</C>
    <C>Col=FSREFSEQ07      Ctrl=txt_fsrefseq07      Param=value</C>
	<C>Col=FSREFSEQ08      Ctrl=txt_fsrefseq08      Param=value</C>
	<C>Col=FSREFSEQ09      Ctrl=txt_fsrefseq09      Param=value</C>
	<C>Col=FSREFCD01        Ctrl=txt_fsrefcd01		 Param=value</C>
	<C>Col=FSREFCD02        Ctrl=txt_fsrefcd02	   	 Param=value</C>
	<C>Col=FSREFCD03        Ctrl=txt_fsrefcd03     	 Param=value</C>
	<C>Col=FSREFCD04        Ctrl=txt_fsrefcd04	   	 Param=value</C>
	<C>Col=FSREFCD05        Ctrl=txt_fsrefcd05     	 Param=value</C>
	<C>Col=FSREFCD06        Ctrl=txt_fsrefcd06     	 Param=value</C>
	<C>Col=FSREFCD07        Ctrl=txt_fsrefcd07     	 Param=value</C>
	<C>Col=FSREFCD08        Ctrl=txt_fsrefcd08     	 Param=value</C>
	<C>Col=FSREFCD09        Ctrl=txt_fsrefcd09     	 Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_fsrefval01          Param=value</C>
    <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03          Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04          Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05          Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06		     Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	         Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08          Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	         Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01			 Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03			 Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04			 Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05			 Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06			 Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07			 Param=value</C>
    <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08			 Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09			 Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_fsrvalnm01     Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	 Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01              Ctrl=txt_type01				   Param=value</C>
	<C>Col=TYPE02              Ctrl=txt_type02				   Param=value</C>
	<C>Col=TYPE03              Ctrl=txt_type03				   Param=value</C>
    <C>Col=TYPE04              Ctrl=txt_type04				   Param=value</C>
	<C>Col=TYPE05              Ctrl=txt_type05				   Param=value</C>
	<C>Col=TYPE06              Ctrl=txt_type06				   Param=value</C>
	<C>Col=TYPE07              Ctrl=txt_type07				   Param=value</C>
	<C>Col=TYPE08              Ctrl=txt_type08				   Param=value</C>
	<C>Col=TYPE09              Ctrl=txt_type09				   Param=value</C>
	<C>Col=ARBALDIV1       Ctrl=txt_arbaldiv01	  Param=value</C>          
	<C>Col=ARBALDIV2       Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV3       Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV4       Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV5       Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV6       Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV7       Ctrl=txt_arbaldiv07	  Param=value</C>
	<C>Col=ARBALDIV8       Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV9       Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT                 Ctrl=hid_cnt                Param=value</C>
	<C>Col=DOCUMCD       Ctrl=gclx_documcd02 Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT           Ctrl=hid_fsstat             Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM            Ctrl=gcem_fsnum	       Param=Text</C>
	<C>Col=DIVCD              Ctrl=hid_divcd             Param=value</C>
    <C>Col=BGTDIV            Ctrl=hid_bgtdiv            Param=value</C>
	<C>Col=FUNDDIV          Ctrl=hid_funddiv           Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF          Ctrl=hid_lastref            Param=value</C>
	<C>Col=BANJAEMOD     Ctrl=hid_banjaemod    Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype      Param=value</C>
	'>
</object>



</body>
</html>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		