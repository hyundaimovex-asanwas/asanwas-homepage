<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - 시스템명 	     : 개인명 법인카드 대금지급 전표등록
 - 프로그램ID 	 : a070030.jsp
 - J  S  P		 : a070030.jsp
 - 서 블 릿		 : a070030_s1 , a070030_s2  
 - 작 성 자		 : 정영식
 - 작 성 일		 : 2015-06-04
 - 기능정의		 : 개인명법인카드 대금지급 등록건을 대상으로 전표 발행.
 - 
 - 
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>

<%@ page import="Account.common.*" %>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>


<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
  
    <jsp:include page="/Account/common/include/head.jsp"/>
	<title>협력업체대금지급전표등록</title>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
    var g_sgb ="";  //조회 구분  1 상단 지급정보조회 , 2 하단 전표조회
    var acc_dirpath=".";
    var g_arrParam	= new Array();
    
    var curdate  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
    var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid 헤드색 
		cfStyleGrid(getObjectFirst("gr_slipdtl"), "comn");  //grid 헤드색 
		fnInit();	
	}
	
    <%//초기작업 %>
    function fnInit() {
       
        //지점코드[검색]
		gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
		gcds_fdcode.Reset();
		
		ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //지점 
		
		gclx_fdcode.bindcolval="02";
		lc_fdcode.bindcolval="02";
		
	    lc_fdcode.bindcolval = gfdcode;      
	    gcem_fs02.text ="A";
	    gcem_fsdat02.text =  curdate;
	    gcem_fsnbr02.text ="000000";      
	    gcem_actdat02.text = curdate;
	    
	    txt_atcodenm_fr.value ="미지급금(개인명법인카드)";
	    txt_atcode_fr.value ="2100525";
	    
	    gcem_actdat_fr.text = curdate ;
	    gcem_actdat_to.text = curdate ;
    }
    
<%
 //****************************************************************************
// 전월구하기
//****************************************************************************
%>
function fnGetbyymm(v_yyyymm) {

	var ls_yy = v_yyyymm.substring(0,4);
	var ls_mon = v_yyyymm.substring(4,6);
	var ls_bef_yyyymm="";
	var mm=0;
	
	if (ls_mon == "01") {
		ls_bef_yyyymm = parseInt(ls_yy,10)-1;
		ls_bef_yyyymm = ls_bef_yyyymm+"12";
	}else {
        mm =  parseInt(ls_mon,10)-1;
        if(mm<10){
        	ls_bef_yyyymm = ls_yy+"0"+mm;
        }else{
            ls_bef_yyyymm = ls_yy+mm;
        }
	}
	return(ls_bef_yyyymm);
}	
    
    
    <%//메인 조회  %>
     function fnSelect(strParam) {
    	 
    	 g_sgb="1";
    
         //조회 조건확인 
         ds_default.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070030_s1"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+txt_atcode_fr.value         
										 + "&v_str3="+gcem_actdat_fr.text       
										 + "&v_str4="+gcem_actdat_to.text
										 + "&v_str5="+gcrd_gubun.codevalue;       
		 // prompt('', ds_default.DataID);				
		 ds_default.Reset();
		
		 
		 if(strParam!="C"){
		 	gcem_fsnbr02.text ="000000";  
		 }
		 
         ds_slipdtl.ClearAll();
         fnDisplay_Clear();
         
         //2013.12.19 jys add
         fnRepay_Cancel_All();
         //fnCreateSelect();
    }    
     
     
     <%//메인 조회  %>
     function fnSlipSelect() { 
    	 
    	 g_sgb="2";
    	 
    	 var fsdat = gcem_fs02.text+gcem_fsdat02.text;
     
    	 ds_slipdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070030_s7f?v_str1="+lc_fdcode.bindcolval
																				+"&v_str2="+fsdat
																				+"&v_str3="+gcem_fsnbr02.text
																				+"&v_str4="
																				+"&v_str5=";		
		//prompt("ds_slipdtl::",ds_slipdtl.DataID);																									 
		ds_slipdtl.Reset(); 
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
    	
    	if (ds_slipdtl.namevalue(1,"FSNBR")!="000000"){
			alert("이미 발행된 전표입니다. 취소 할 수 없습니다.");
			return;
    	}	
    	
    	if(confirm("취소 하시겠습니까?")){    
    		fnSelect('');
    		fnRepay_Cancel_All();
    	}
    }
    
    
     <%//반제 전체 취소   %>
    function fnRepay_Cancel_All(){    
	    	gcds_banjae.clearAll();
			gcds_banjaemst.clearAll();
    }

    
     <%//전표생성%>
    function fnSlipCreate() {
    
        //DataSet Head 설정 
        //gs_rpt_mst.clearAll();

		//var s_temp = "TITLE:STRING,COST_NM:STRING,USRNAME:STRING,USEDATE:STRING";
		//gs_rpt_mst.SetDataHeader(s_temp);
		
		//전표 MST 생성   
        //전표 DTL 생성 		
        //전표 REF 생성 
          
        //UPDATE -  출납테이블에 전표번호 INSERT ( 출납정보는 출납 SID 정보를 가지고 있어야 함. ) 
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
		//공급가액+부가세액  계정코드 2
		    
		ds_slipdtl.clearall();
		gcds_banjae.clearall(); //반제 내역 초기화 
		
		//그리드 데이터 설정 
		fnCreateSelect();
	
    }
    
   <%//전표생성할 데이터 조회 %>
    function fnCreateSelect() {
    	
    	g_sgb="1";
    	
        var strfsdat = gcem_fs02.text +gcem_fsdat02.text;
        var strAtcode ="2100525";
        
        ds_slipdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070030_s2"
		  					       + "?v_str1="+gclx_fdcode.BindColVal     
								   + "&v_str2="+strAtcode
								   + "&v_str3="+strfsdat
								   + "&v_str4="+gcem_actdat_fr.text 
								   + "&v_str5="+gcem_actdat_to.text; 						                 
		//prompt('',ds_slipdtl.DataID  );
		ds_slipdtl.Reset();  
    }    
    
    <%//전표등록 그리드 데이터 기본셋팅   %>
    function fnSlipdtl_Display(row){
    	var strPo="";
	    
	    //자동설정하기
		for(var i=1;i<=row;i++){
			ds_slipdtl.namevalue(i,"FSNUM") =ln_Seqno_Format(Number(i),3);
			ds_slipdtl.namevalue(i,"FSSEQ") =ln_Seqno_Format(Number(i),5);
			ds_slipdtl.namevalue(i,"FSREFVAL02") =ds_slipdtl.namevalue(i,"VEND_CD") ;  
			ds_slipdtl.namevalue(i,"FSRVALNM02") =ds_slipdtl.namevalue(i,"VEND_NM") ;  
			
			//부서 ( 공통 ) 
			ds_slipdtl.namevalue(i,"FSREFVAL01") = "Y000";
			ds_slipdtl.namevalue(i,"FSRVALNM01") = "공통";
					 	
			//관리항목 
			//외상매입금일 경우 
			if (ds_slipdtl.namevalue(i,"ATCODE")=="2100110"){ 
				//관리항목 - 외상매입금 
				strPo="";
				strPo = fnRef_position_find(i,"1011");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "02";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "일반업체";
			}else if (ds_slipdtl.namevalue(i,"ATCODE")=="2100510") {
				//관리항목 - 미지급금 
				strPo="";
				strPo = fnRef_position_find(i,"1013");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "008";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "일반업체";
			}else if(ds_slipdtl.namevalue(i,"ATCODE")=="1110150"){ //보통예금
			
			    strPo="";
				strPo = fnRef_position_find(i,"0022");  //은행
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "A00003";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "외환은행 계동지점";
			
			    strPo="";
				strPo = fnRef_position_find(i,"0023");  //계좌번호
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0401";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "201-890003-23004";
			}else if(ds_slipdtl.namevalue(i,"ATCODE")=="2100120"){  //외상매입금(지급어음)
			
			    strPo="";
				strPo = fnRef_position_find(i,"0967");  //어음번호
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "-";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = " -";
			
				strPo="";
				strPo = fnRef_position_find(i,"0022");  //은행
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "A00003";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "외환은행 계동지점";
				
				strPo="";
				strPo = fnRef_position_find(i,"0968");  //발행일자 = 지급일자
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"PAYDAT") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_slipdtl.namevalue(i,"PAYDAT") ;  
				
				strPo="";
				strPo = fnRef_position_find(i,"0969");  //만기일자
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"FULDAT") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo)= ds_slipdtl.namevalue(i,"FULDAT") ;  
			
			}else if(ds_slipdtl.namevalue(i,"ATCODE")=="2100525"){  //미지급금(개인명법인카드)
				
			    strPo="";
				strPo = fnRef_position_find(i,"2168");  //개인명은행
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) =ds_slipdtl.namevalue(i,"CAACCBANK") ; 
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_slipdtl.namevalue(i,"BANKNM") ; 
			
				strPo="";
				strPo = fnRef_position_find(i,"2167");  //개인명카드번호
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) =ds_slipdtl.namevalue(i,"CANBR") ; 
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_slipdtl.namevalue(i,"CARDNO") ; 
				
				strPo="";
				strPo = fnRef_position_find(i,"1134");  //카드종류
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo)=ds_slipdtl.namevalue(i,"CACARDSPEC") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo)=ds_slipdtl.namevalue(i,"CARDKD") ;  
				
				strPo="";
				strPo = fnRef_position_find(i,"2166");  //개인명계좌번호
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo)=ds_slipdtl.namevalue(i,"CABANKNO") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo)=ds_slipdtl.namevalue(i,"ACCNO") ;  	
			}
			
			//통화명 
			strPo="";
			strPo = fnRef_position_find(i,"1043");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo)  = "01";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "WON";
			
			//외화금액 
			strPo="";
			strPo = fnRef_position_find(i,"1045");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "0";
    	}
	}
    
    <%//엑셀 다운을 위한 숨김 그리드   %>
    function fnSlipdtl_Vend(row){
    	
    	var strBankPo="";
    	var strAccnoPo="";
    	
    	gcds_excel.clearAll();
    	fnExcelDataHeader();
    	
    	strBankPo="";
    	strBankPo = fnRef_position_find(i,"2168");  //개인명은행
    	strAccnoPo="";
    	strAccnoPo = fnRef_position_find(i,"2166");  //개인명계좌번호
    	
	    //자동설정하기
		for(var i=1;i<=row-1;i++){
			gcds_excel.Addrow();
			gcds_excel.namevalue(i,"VENDCD") = ds_slipdtl.namevalue(i,"FSREFVAL02");
			gcds_excel.namevalue(i,"VENDNM") = ds_slipdtl.namevalue(i,"FSRVALNM02");
			gcds_excel.namevalue(i,"BANKCD") = ds_slipdtl.namevalue(i,"FSREFVAL"+strBankPo);
			gcds_excel.namevalue(i,"BANKNM") = ds_slipdtl.namevalue(i,"FSRVALNM"+strBankPo);
			gcds_excel.namevalue(i,"ACCNO")  = ds_slipdtl.namevalue(i,"FSRVALNM"+strAccnoPo);
			gcds_excel.namevalue(i,"RECAMT") = ds_slipdtl.namevalue(i,"DEAMT");	
		}
	}
	
	
    <%//생성시 기본 데이터 조회  %>
    function fnSave() {
    	
    	if (ds_slipdtl.namevalue(1,"FSNBR")!="000000"){
			alert("이미 발행된 전표입니다. 저장 할 수 없습니다.");
			return;
    	}	
       	
       	gcds_slipdtl.clearall();
		fnSlipdtlSetDataHeader();
		fnSlipdtlSettting();
       	
       	gcds_slipmst.clearall();
		fnSlipmstSetDataHeader();   
		fnSlipmstSettting();
    
     	if(fnSave_Chk()){
  			 if (gcds_slipmst.IsUpdated) {					
				 if(confirm("전표를 저장하시겠습니까?")){
					//gctr_code01.KeyValue = "Account.a070021_t1(I:USER=gcds_code01)";
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070030_t1?";
					tr2.Parameters="v_str1="+gusrid+",v_str2="+gfdcode;
					//prompt('gcds_slipmst',gcds_slipmst.text);
					//prompt('gcds_slipdtl',gcds_slipdtl.text);
					//prompt('gcds_banjae',gcds_banjae.text);
					//prompt('gcds_banjaemst',gcds_banjaemst.text);
					//prompt('gcds_slipno',gcds_slipno.text);
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
	
	
	  <%//Excel용 head생성%>
		function fnExcelDataHeader() {
	    	 var s_temp = "VENDCD:STRING,VENDNM:STRING,BANKCD:STRING,BANKNM:STRING,ACCNO:STRING,"
					    + "RECAMT:DECIAML";	
			  gcds_excel.SetDataHeader(s_temp);
	    }
	    
     <%//전표dtl 데이터 설정%>
    function fnSlipdtlSettting() {
    	    	
    	for (var k=1;k<=ds_slipdtl.countrow;k++){
    		gcds_slipdtl.addrow();
    		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FDCODE" ) = ds_slipdtl.namevalue(k, "FDCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" )  = ds_slipdtl.namevalue(k, "FSDAT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNBR" )  = ds_slipdtl.namevalue(k, "FSNBR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSEQ" )  = ds_slipdtl.namevalue(k, "FSSEQ" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" ) = ds_slipdtl.namevalue(k, "ATCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATDECR" ) = ds_slipdtl.namevalue(k, "ATDECR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "REMARK" ) = ds_slipdtl.namevalue(k, "REMARK" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DEAMT" )  = ds_slipdtl.namevalue(k, "DEAMT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CRAMT" )  = ds_slipdtl.namevalue(k, "CRAMT" );
       		
       		for(var no=1;no<=9;no++){
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFSEQ0"+no ) = ds_slipdtl.namevalue(k, "FSREFSEQ0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )  = ds_slipdtl.namevalue(k, "FSREFCD0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = ds_slipdtl.namevalue(k, "FSREFVAL0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFNM0"+no )  = ds_slipdtl.namevalue(k, "FSREFNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no ) = ds_slipdtl.namevalue(k, "FSRVALNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "TYPE0"+no)      = ds_slipdtl.namevalue(k, "TYPE0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ARBALDIV0"+no)  = ds_slipdtl.namevalue(k, "ARBALDIV0"+no );
       			
       			
       			//2012.10.02 법인카드일경우 법인카드 거래처 적용 
       			/**법인카드 없음 ) 
	       		if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" )=="2100520"){
	       			if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )=="0029" ){
	       				gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no );
	       			}
	       		}
	       		**/
       		}
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )   = ds_slipdtl.namevalue(k, "DOCUMCD" );
       		
       		//예산음 모두 미적용으로 함. 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )   ="01";
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRDT" )       = curdate;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRID" )       = gusrid;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEYN" )   = ds_slipdtl.namevalue(k, "ATDEBTYN" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSTAT" )     = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUVAL" )    = ds_slipdtl.namevalue(k, "DOCUVAL" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" )      = ds_slipdtl.namevalue(k, "FSNUM" );
       		
       		//공통으로 처리함 (오연주 ) 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DIVCD" )      ="Y000";
       		//예산부서 없음 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BGTDIV" )     = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEREF" )  = ds_slipdtl.namevalue(k, "BANJAEREF" );
       		
       	}
    } 
      
    <%//전표mst 데이터 설정%>
    function fnSlipmstSettting() {
    	var srow = 0;
		gcds_slipmst.addrow();
		
		srow = gcds_slipmst.rowposition; 	
		//alert("FDCODE"+ds_slipdtl.namevalue(1, "FDCODE" ));
		gcds_slipmst.namevalue(srow,"FDCODE")= ds_slipdtl.namevalue(1, "FDCODE" );
		gcds_slipmst.namevalue(srow,"FSDAT") = ds_slipdtl.namevalue(1, "FSDAT" );
		gcds_slipmst.namevalue(srow,"FSNBR")="000000";
		gcds_slipmst.namevalue(srow,"FSKND")= "D";            //자동 - 대금지급   
		gcds_slipmst.namevalue(srow,"FSWRTDAT")=curdate;
		gcds_slipmst.namevalue(srow,"COCODE")="02";
		gcds_slipmst.namevalue(srow,"DEPTCD")= gdeptcd;
		gcds_slipmst.namevalue(srow,"EMPNO")= gusrid;
		gcds_slipmst.namevalue(srow,"DIVCD")= "";
		gcds_slipmst.namevalue(srow,"FSAMT")= gcds_slipdtl.Sum(9,0,0);   //차변 
		gcds_slipmst.namevalue(srow,"FSVAT")= 0 ;
		gcds_slipmst.namevalue(srow,"DETOT")= gcds_slipdtl.Sum(9,0,0);   //차변 
		gcds_slipmst.namevalue(srow,"CRTOT")= gcds_slipdtl.Sum(10,0,0); //대변 
		gcds_slipmst.namevalue(srow,"REMARK")=gcds_slipdtl.namevalue(1,"REMARK"); //대변 
		gcds_slipmst.namevalue(srow,"SGNDAT")= "";
		gcds_slipmst.namevalue(srow,"FSSTAT")= "N";
		gcds_slipmst.namevalue(srow,"ACTDAT")= gcem_actdat02.text;
		gcds_slipmst.namevalue(srow,"SSDAT")= "";
		gcds_slipmst.namevalue(srow,"SSNBR")= "";
		gcds_slipmst.namevalue(srow,"WRDT")= curdate;
		gcds_slipmst.namevalue(srow,"WRID")= gusrid;
    
    } 
    
    
     <%//필수항목 체크%>
     function fnSave_Chk(){
     
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
		
		//접수일자
		if(gcds_slipmst.namevalue(1,"FSDAT")==""){
			alert("접수일자를 확인 하십시요");
			return false;
		}		
		
		//회계일자 확인
		if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
			alert("회계일자를 확인 하십시요");
			return false;
		}		
		
		/**
		//출납년월과 회계년월이가 틀린경우 
		if (gcds_slipmst.namevalue(1,"ACTDAT").substring(0,6)!=vt_fr_inout_dt.text.substring(0,6)){
			alert("출납년월과 회계년월이 다릅니다. 확인바랍니다.");
			return false;
		}
		**/
	

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
			 /*
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
			*/
			
			
			//반제금액 누적
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //반제
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //차변계정 ( 대변금액 합계 )
				 	intBanjaeCramt+=gcds_slipdtl.namevalue(i,"CRAMT");
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //대변계정 ( 차변계정 합계 )
				 	intBanjaeDeamt+=gcds_slipdtl.namevalue(i,"DEAMT");
				 }
			}
	    } //for i
	    
	    
	    //alert("gcds_banjae.Sum(13,0,0):::"+gcds_banjae.Sum(13,0,0)+"::intBanjaeDeamt::"+intBanjaeDeamt);

        if (gcds_banjae.CountRow>0){
		    //반제금액 합계  체크  ( 반제내역 합계 Vs 전표등록의 반제 정산 금액 합계 )
		    if ( gcds_banjae.Sum(13,0,0)!=intBanjaeDeamt){
		    	alert( "반제 차변 금액이 틀립니다.");
		    	return false;
		    }
		    
		    if ( gcds_banjae.Sum(14,0,0)!=intBanjaeCramt){
		    	alert( "반제 대변 금액이 틀립니다.");
		    	return false;
		    }
		 }else{
		 	if ( intBanjaeDeamt !=0){
		    	alert( "반제 차변 금액이 틀립니다2.");
		    	return false;
		    }
		    
		     if (intBanjaeCramt !=0){
		    	alert( "반제 대변 금액이 틀립니다2.");
		    	return false;
		    }
		 }
	    	
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
		var intp=0;                    //관리항목 위치
		
		
		/////////////////////////////////////////////////////
		// 관리항목 구분자  ( 거래처 제외 ) 
		/////////////////////////////////////////////////////
		intp = Number(p1);
	
		if(eval("txt_type0"+intp).value=="C") return;
					
		arrParam[0] = eval("txt_fsrefcd"+p1).value;    //관리항목 구분코드  
		arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //관리항목 값 
		
			
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
     
    <%//반제 팝업%>
    function fnRepay(){
   
		var row = ds_slipdtl.rowposition;
		var result="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var strseq="000";
		var strbanjaeref ="";
		var strbanjaerefval ="";
		var strbanjaerefnm = "";
		
		//반제 계정체크 
		if (ds_slipdtl.namevalue (row,"ATDEBTYN")!="Y"){
			alert("반제계정이 아닙니다.");
			return false;
		}
		
		//차변계정인데 차변에 금액 존재하면 반제 안됨 
		if(ds_slipdtl.namevalue (row,"ATDECR")=="1"&&ds_slipdtl.namevalue (row,"DEAMT")!=0){
			alert("반제 발생건입니다.");
			return false;
		}
		
		//대변계정인데 대변에 금액이 존재하면 반제 안됨 
		if(ds_slipdtl.namevalue (row,"ATDECR")=="2"&&ds_slipdtl.namevalue (row,"CRAMT")!=0){
			alert("반제 발생건입니다.");
			return false;
		}
			
		//기존 반제 데이터가 존재하면 
	    for(var m=1;m<=gcds_banjae.countrow;m++){
	    	if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(m,"BTSSEQ")){
	    		alert("반제 데이터가 존재합니다.");
	    		return false;
	    	}
	    }
	       
		//반제단위 관리항목값을 저장함.
		_out2:
		for(k=1;k<=9;k++){
		    //alert("row:::"+row+"::FSREFCD0:::"+ds_slipdtl.namevalue(row,"FSREFCD0"+k)+"::BANJAEREF::"+ds_slipdtl.namevalue(row,"BANJAEREF"));
			if(ds_slipdtl.namevalue(row,"FSREFCD0"+k)==ds_slipdtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = ds_slipdtl.namevalue(row,"BANJAEREF");
				 //alert("strbanjaeref::"+strbanjaeref);
				 strbanjaerefval = ds_slipdtl.namevalue(row,"FSREFVAL0"+k)
				 strbanjaerefnm = ds_slipdtl.namevalue(row,"FSRVALNM0"+k)
				 //alert("strbanjaerefval:;"+strbanjaerefval);
				 //alert("strbanjaerefnm:;"+strbanjaerefnm);
				 break _out2;
			}
		}//k	
		
	    g_arrParam[0]=ds_slipdtl.namevalue(row,"ATCODE");    //계정코드
		g_arrParam[1]=ds_slipdtl.namevalue(row,"ATKORNAM");  //계정명
		g_arrParam[2]=ds_slipdtl.namevalue(row,"VEND_CD");   //거래처코드
		g_arrParam[3]=ds_slipdtl.namevalue(row,"VEND_NM");   //거래처명
		g_arrParam[4]=ds_slipdtl.namevalue(row,"FDCODE");	 //반제전표 FDCODE   FSDAT
		g_arrParam[5]=ds_slipdtl.namevalue(row,"FSDAT");	 //반제전표 FSDAT
		g_arrParam[6]=ds_slipdtl.namevalue(row,"FSNBR");	 //반제전표 FSNBR          
		g_arrParam[7]=ds_slipdtl.namevalue(row,"FSSEQ");     //전표행번호 seq
		g_arrParam[8]=strbanjaeref;                          //반제단위 관리항목 
		g_arrParam[9]=strbanjaerefval;                       //반제단위값
		g_arrParam[10]=strbanjaerefnm;                       //반제단위값 명칭
	
	   
	    //alert("strbanjaerefval::"+strbanjaerefval);
		strURL = acc_dirpath+"/repay_popup_A.jsp";
		strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,window,strPos);
		
		if (result != null) {
			arrResult = result.split(";");
			if(arrResult[0]!=0){         //차변이 0이 아닐 경우 대변 금액
				ds_slipdtl.namevalue(row,"CRAMT")=arrResult[0];
			}else if(arrResult[1]!=0){   //대변이 0이 아닐 경우 차변 금액
				ds_slipdtl.namevalue(row,"DEAMT")=arrResult[1];
			}
		}
	}
	
    <%//반제취소%>
	function fnRepay_Cancel(){
	   //prompt('mst',gcds_banjaemst.text);
	   //prompt('rel',gcds_banjae.text);
	   var crow = ds_slipdtl.rowposition;
	   
	    //반제 계정체크 
		if (ds_slipdtl.namevalue (crow,"ATDEBTYN")!="Y"){
			alert("반제계정이 아닙니다.");
			return false;
		}else{
			if(ds_slipdtl.namevalue (crow,"ATDECR")=="1" && ds_slipdtl.namevalue (crow,"DEAMT")!=0){       //차변계정 발생 
				 alert("반제취소 항목이 아닙니다.1");
				 return false;
			}else if(ds_slipdtl.namevalue (crow,"ATDECR")=="2" && ds_slipdtl.namevalue (crow,"CRAMT")!=0){ //대변계정 발생 
			     alert("반제취소 항목이 아닙니다.2");
			     return false;
			}
		}
		
		//var banjae_cnt=0;
	    //반제상세 삭제 
		for(var m=1;m<=gcds_banjae.countrow;m++){
		   // alert(":m:"+m+":FSSEQ:"+ds_slipdtl.namevalue(crow,"FSSEQ") +":BTSSEQ:"+gcds_banjae.namevalue(m,"BTSSEQ"))
			if(ds_slipdtl.namevalue(crow,"FSSEQ") == gcds_banjae.namevalue(m,"BTSSEQ")){
				gcds_banjae.RowMark(m)=1;
				//banjae_cnt+=1;
			}else{
				gcds_banjae.RowMark(m)=0;
			}
		}
		gcds_banjae.DeleteMarked();
		
		/*
		if(banjae_cnt==0){
			return false;
		}else{
			gcds_banjae.DeleteMarked();
		}
		*/
		
		//반제MST 삭제 
		for(var n=1;n<=gcds_banjaemst.countrow;n++){
			if(ds_slipdtl.namevalue(crow,"FSSEQ") == gcds_banjaemst.namevalue(n,"SEQ")){
			   // alert("n::"+n);
			    gcds_banjaemst.RowMark(n)=1;
			}else{
			    gcds_banjaemst.RowMark(n)=0;
			}
		}
		
		gcds_banjaemst.DeleteMarked();
		//gcds_banjae.clearAll();
		//gcds_banjaemst.clearAll();
		ds_slipdtl.namevalue(crow,"DEAMT")=0;
		ds_slipdtl.namevalue(crow,"CRAMT")=0; 
	}
	
	<%//계정과목 찾기%>
	function ln_Blur(obj){
		if(event.keyCode!=113&&event.keyCode!=13) return;    //F2 또는 Enter 
		if (obj=="txt_atcodenm_fr"||obj=="txt_atcodecd_fr"){
			ln_Popup(obj);
		}
	}
	
	<%//계정과목 찾기%>
	function ln_Popup(obj){ 
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		arrParam[1]=eval(obj).value;
		arrParam[2]="ATDEBTYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_atcode_fr.value = arrParam[0];
			txt_atcodenm_fr.value = arrParam[1];
		}
	}
	
	<%//개인명법인카드지급정보 엑셀 다운받기%>
	function fnExcel2(){
	    var strTitle ="개인명법인카드지급정보";
	    gr_default.GridToExcel(strTitle,"",1);
	}
	
	
	
	<%//엑셀 다운받기%>
	function fnExcel(){
		
		if (ds_slipdtl.namevalue(1,"FSNBR")=="000000"||ds_slipdtl.namevalue(1,"FSNBR")==undefined){
			alert("전표가 등록되지 않았습니다. 등록 후 엑셀 다운로드 가능합니다.");
			return ;
		}
		gcgd_excel.GridToExcel("개인명법인카드 대금지급", "개인명법인카드 대금지급.xls", 9); 
	}
	
	
	
	<%//행삭제 %>
	function fnRowDelete(){
		var chkgubun="";
		//전표가 생성되었으면 삭제 안되게 함.
		if (ds_slipdtl.namevalue(1,"FSNBR")!="000000"){
			alert("이미 발행된 전표입니다. 행삭제 할 수 없습니다.");
			return ;
		}else{
			//반제데이터 있는지 확인
			for(m=1;m<=gcds_banjae.countrow;m++){
				if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(m,"BTSSEQ")){
					chkgubun="1";
				}
			}

	        //반제가 존재함.
	        if(chkgubun=="1"){
				alert("해당 계정은 반제적용 되었습니다. 반제취소 후 행삭제하십시요.");
				return;
	        }
		}
		
		if(confirm("행삭제하시겠습니까?")){    		
		 	ds_slipdtl.deleterow(ds_slipdtl.rowposition);
		 	ln_Fsnum_Reset(ds_slipdtl.rowposition);
		}
	}
	
	<%//행번호 재설정 %>
	function ln_Fsnum_Reset(ipo){
		for(k=ipo;k<=ds_slipdtl.countrow;k++){
			ds_slipdtl.namevalue(k,"FSNUM") = ln_Seqno_Format(Number(k),3);
		}
	}

	
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language=JavaScript for=tr2  event=OnSuccess()>
	var temp="";
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");																	
	alert("전표 생성이 성공적으로 완료되었습니다.");
	fnSelect('C'); //create
</script>

<script language=JavaScript for=tr2 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>
 
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
	    
	    //alert("row::"+row);
        window.status="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    //if(row==0){
		     //   alert("<%=HDConstant.S_MSG_NO_DATA%>");
			//}
			//gr_default.ColumnProp('INOUT_DT','BgColor')= "FFCC66";	
		}
	</script>
	
	<script language=javascript for="ds_slipdtl" event="OnLoadCompleted(row)">
	
		if (g_sgb=="1"){
			fnSlipdtl_Display(row);
		} else if (g_sgb=="2"){
			fnSlipdtl_Vend(row);
		}
		
		g_sgb="";
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
<%=HDConstant.COMMENT_START%>

<object  id=gcds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--조회-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표상세 -->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표상세 저장용-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--전표mst-->
    <param name="SyncLoad"  value="false">
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
	<param name=SortExpr   value="+BTSSEQ">
</object>

<!--접수번호 -->
<object id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
     <PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
    <param name="KeyValue"    value="a070030_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,O:USER5=gcds_slipno )"> 
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <!--<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onclick="fnPrint()">-->
                            <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onclick="fnExcel2()">&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect('')">
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
                                    <td align="center" class="text" width="70">지점</td>                                                                     
                                    <td bgcolor="#FFFFFF" width="250" >&nbsp;
                                      <object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											 style="position:relative;left:6px;top:1px;font-size:12px;width:100px;">
												<param name=ComboDataID		  value="gcds_fdcode">
												<param name=CBDataColumns	  value="FDCODE, FDNAME">
												<param name=SearchColumn	  value=FDNAME>
												<param name=ListExprFormat	  value="FDNAME^0^120">
												<param name=BindColumn		  value="FDCODE">
									  </object>
                                    </td>
                                    <td align="center" class="text" width="70">계정과목</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                        <%=HDConstant.COMMENT_START%>
			                         		<input id="txt_atcodenm_fr"  type="text" class="txtbox"  style= "width:260px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('txt_atcodenm_fr')">
											<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('txt_atcodenm_fr');">
											<input id="txt_atcode_fr"    type="text" class="txtbox"  style= "width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('txt_atcode_fr')" >
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">회계일자</td>
			                        <td align=left bgcolor="#ffffff"  >&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                           <OBJECT id=gcem_actdat_fr  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
										<param name=Alignment		  value=0>
										<param name=Border	          value=true>
										<param name=Format	          value="YYYY/MM/DD">
										<param name=PromptChar	      value="_">
										</OBJECT>      
										 <%=HDConstant.COMMENT_END%>     
			                            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;left:1px;top:2px;width:20px;cursor:hand;">                                                                       
			                            ~&nbsp;&nbsp;
			                            <OBJECT id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
										<param name=Alignment		  value=0>
										<param name=Border	          value=true>
										<param name=Format	          value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										</OBJECT>
			                            <%=HDConstant.COMMENT_END%>        
			                            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
			                        </td>   
			                        
			                        <td align="center" class="text" width="70">잠금구분</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
											<param name=Cols	    value="3">
											<param name=Format  	value="^전체,F^정상,T^잠금">
										</object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td><b><font size="2" color="blue">[개인명법인카드지급정보]</font></b></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='175px' border='1'>
                                <param name="DataID"           value="ds_default">
                                <param name="ColSizing"        value="true">
                                <param name="Editable"         value="false">
                                <param name="BorderStyle"      value="0">
                                <param name="fillarea"		   value="true">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"           value="
                                     <C>Id=Count name='CurLevel' width=80 Align=Right  Value={CurLevel}     show =false     </C>
                                     <C> name='잠김'	        ID='FSLOCK'    	     width=30 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   sumtext='총' </C>
                                     <C> name='계정코드'      ID='ATCODE'       	 width=60 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   show = false   </C>
                                     <C> name='계정명'		ID='ATKORNAM' 		 width=130 	align=left    BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   sumtext='@cnt' sumtextalign='center'     </C>
									 <C> name='거래처' 	    ID='VENDCD'          width=60 	align=left    BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   sumtext='건'     sumtextalign='center'  </C>
									 <C> name='거래처명' 	    ID='VEND_NM'    	 width=90 	align=left    BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   </C>
                                     <C> name='관리항목' 	    ID='FSREFVAL'    	 width=120 	align=left    BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')}   </C>
                                     <C> name='적요'         ID='REMARK'      	 width=170 	align=left    BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                                     <C> name='지급금액'  	ID='CRAMT'           width=80 	align=right   BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	sumtext='@sum'  </C>                                     
                                     <C> name='지점'	        ID='FDCODE'    	     width=30 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                                     <C> name='전표일자'      ID='SSDAT'    	     width=70 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                                     <C> name='전표번호'      ID='SSNBR'    	     width=60 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                                     <C> name='순번'         ID='FSNUM'    	     width=30 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                                     <C> name='작성자'       ID='EMPNMK'    	     width=60 	align=center  BgColor={IF(FSLOCK='T','#FFCC66','#FFFFFF')} 	</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
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
                            
                            <img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:hand" onclick="fnSlipCreate()">&nbsp;&nbsp;
                            <img src="<%=dirPath%>/Sales/images/refer.gif"		    style="cursor:hand" onclick="fnSlipSelect()">&nbsp;&nbsp;
                            <img src="<%=dirPath%>/Sales/images/excel.gif"		    style="cursor:hand" onclick="fnExcel()">&nbsp;&nbsp;
                            <img src="<%=dirPath%>/Sales/images/save.gif"		    style="cursor:hand" onclick="fnSave()">&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/minus.gif"		    style="cursor:hand" onclick="fnRowDelete()">&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	  	    style="cursor:hand" onclick="fnCancel_All()">   
							                    
						   
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
	                   <td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_fdcode>
								<param name=BindColumn      value="FDCODE">
								<param name=BindColVal      value="FDCODE">
								<param name=ListExprFormat  value="FDNAME^0^90">
								<param name=Index           value="2">
								<param name=Enable          value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
	                    <td align="center" class="text" width="70">접수번호</td>
	                    <td bgcolor="#FFFFFF">&nbsp;
	                      	<%=HDConstant.COMMENT_START%>
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
							<%=HDConstant.COMMENT_END%>   
	                    </td>
	                     <td align="center" class="text" width="70">회계일자</td>                                                                     
	                    <td bgcolor="#FFFFFF" >&nbsp;
	                    	<%=HDConstant.COMMENT_START%>
							<object id=gcem_actdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="position:relative;top:2px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							<%=HDConstant.COMMENT_END%>   
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
							<%=HDConstant.COMMENT_START%>
								<object id=gr_slipdtl classid=<%=HDConstant.CT_GRID_CLSID%> width='843px' height='175px' border='1'>
									<param name="dataid"			    value="ds_slipdtl">
									<param name="indwidth"		        value ="0">
									<param name="borderstyle"           value="0">
									<param name="fillarea"		        value="true">
									<param name="ViewSummary"	        value=1>
									<param name="ColSizing"             value="true">
									<param name="Editable"              value="true">
									<param name="ColSelect"		        value="true">
									<param name="Format"		  	    value=" 
									    <FC>Name='순번'	   ID=FSNUM 	       Width=30	    align=center   edit=none    </FC> 
										<FC>Name='계정코드'  ID=ATCODE 	       Width=51     align=left	   edit=none    </FC> 
										<FC>Name='계정명'	   ID=ATKORNAM	       Width=125	align=left	   edit=none   SumText='합   계'</FC> 
										<FC>Name='차변금액'  ID=DEAMT 	       Width=95     align=right	   edit= none  SumText={sum(Number(DEAMT))}  color =#0000FF  sumcolor =#0000FF  </FC> 
										<FC>Name='대변금액'  ID=CRAMT	           Width=95	    align=right    SumText={sum(Number(CRAMT))}  color =#FF0000  sumcolor =#FF0000  </FC> 										
										<C> Name='적요'	   ID=REMARK           Width=250	align=left	   edit=none   SumText={sum(DEAMT)-sum(CRAMT)} SumTextAlign=right </C> 
										<C> Name='증빙명'	   ID=DOCUMCD 	       Width=70	    align=left     edit=none   SumText='차변-대변'  EditStyle=Combo Data='000:,101:세금계산서,102:계산서,103:신용카드(공제),104:현금영수증(공제),201:신용카드(불공),202:간주공급,203:간이영수증' show=false</C> 
										<C> Name='증빙'	   ID=DOCUVAL     	   Width=40    	align=left     edit=none   show = false</C> 
										<C> Name='예산'	   ID=FSWRKDIV 	       Width=40	    align=center   edit=none   EditStyle=Combo Data='01:미적용,02:적용'  show =false</C> 
										<C> Name='거래처'	   ID=FSRVALNM02  	   Width=140 	align=left     edit=none   </C> 
										<C> Name='부서'	   ID=FSRVALNM01 	   Width=50	    align=left     edit=none   </C> 
										<C> Name='관리항목3' ID=FSRVALNM03 	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목4' ID=FSRVALNM04 	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목5' ID=FSRVALNM05 	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목6' ID=FSRVALNM06 	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목7' ID=FSRVALNM07 	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목8' ID=FSRVALNM08	   Width=100 	align=left	   edit=none   </C> 
										<C> Name='관리항목9' ID=FSRVALNM09 	   Width=100 	align=left	   edit=none   </C>
									">
							</object><%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
					<tr>
					    <td width="25px"   class="tab32"     align=center  bgcolor="#B9D4DC" style="height:20px;" >순번</td>
					    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
					    	<input type=text    id=txt_fsrefnm01    name=txt_fsrefnm01  value="부서"          size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					        <input type=hidden  id=txt_fsrefcd01    value=''>
							<input type=hidden  id=txt_fsrefseq01   value=''>
							<input type=hidden  id=txt_type01       value=''>
							<input type=hidden  id=txt_arbaldiv01   value=''>
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
							<input type=hidden  id=txt_fsrefseq04  value=''>
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
					       <%=HDConstant.COMMENT_START%>
					    	 <object id=gcem_fsnum         classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:18;position:relative;top:3px;">				
								<param name=Text				value="">
								<param name=Border          value=false>
							    <param name=Format          value="000">
								<param name=Enable          value=false>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor   value=false> 
							</object><%=HDConstant.COMMENT_END%>
					    </td>
					    <td width="104px" class="tab26"     align=center  >
					    	<%=HDConstant.COMMENT_START%>
					   	    <object id=gcem_fsrvalnm01  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval01   value=''>
					    </td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval03   value=''>
						</td>
						<td width="104px" class="tab26"     align=center > 
						    <%=HDConstant.COMMENT_START%>
						 	<object id=gcem_fsrvalnm04  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval04   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm05  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval05   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm06  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval06   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm07  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval07   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
			               <%=HDConstant.COMMENT_START%>  
							<object id=gcem_fsrvalnm08  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval08   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center>
						    <%=HDConstant.COMMENT_START%>  
							<object id=gcem_fsrvalnm09  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type="hidden"  id=txt_fsrefval09   value=''>
						</td>	
						
					</tr>
				</table>
			</td>
		</tr>
        <tr height='10px'>
        	<td>
        	 <table border='0' cellpadding='0' cellspacing='2' width='845px'>
                    <tr>
                        <td><b><font size="2" color="blue">[반제내역]</font></b></td>
                        <td height='20px' align='right'>
                            <img src="../../Common/img/btn/com_btn_repay.gif"		     style="cursor:hand"   onClick="fnRepay()"  >	
                            <img src="../../Common/img/btn/com_btn_repay_cancel.gif"	 style="cursor:hand;"  onClick="fnRepay_Cancel()"  >
						</td>
                    </tr>
                </table>
             </td>
        </tr>
        <tr>
            <td>
           		 <%=HDConstant.COMMENT_START%>  
            	 <object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_banjaerel style="WIDTH:843px;HEIGHT:175px;border:1 solid #777777;display:block;">
							<param name="dataid"			  value="gcds_banjae">
							<param name="borderstyle"   value="0">
							<param name="indwidth"        value="0">
							<param name="fillarea"		  value="true">
							<param name="colsizing"      value="true">
							<param name="ViewSummary"	value=1>
							<param name="format"			  value="  
							<C>  Name='전표순번'   ID=BTSSEQ            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=center 	SumBgColor=#C3D0DB  </C>	
							<C>  Name='전표일자'   ID=SSDAT            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=center 	SumBgColor=#C3D0DB  </C>	
							<C>  Name='번호'      ID=SSNBR           	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	    align=center 	SumBgColor=#C3D0DB  </C>		
							<C>  Name='순'       ID=FSNUM           	              HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center 	SumBgColor=#C3D0DB  SumText= '합계' </C>			  					
							<C>  Name='차변'		ID=BJDEAMT          	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=right        color =#0000FF   SumBgColor=#C3D0DB  sumcolor =#0000FF SumText={sum(Number(BJDEAMT))} </C>
							<C>  Name='대변'     ID=BJCRAMT                        HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=right	    color =#FF0000   SumBgColor=#C3D0DB  sumcolor =#FF0000 SumText={sum(Number(BJCRAMT))} </C>		
							<C>  Name='적요'     ID=REMARK            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=333	    align=left   	    SumBgColor=#C3D0DB  </C>						
								">
					</object>
				<%=HDConstant.COMMENT_END%>	
            </td>
        </tr>
        
        <tr>
            <td>
           		 <%=HDConstant.COMMENT_START%>  
            	 <object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_excel style="WIDTH:843px;HEIGHT:100px;border:1 solid #777777;display:none;">
							<param name="dataid"		value="gcds_excel">
							<param name="borderstyle"   value="0">
							<param name="indwidth"      value="0">
							<param name="fillarea"		value="true">
							<param name="colsizing"     value="true">
							<param name="ViewSummary"	value=1>
							<param name="format"		value="  
							<C>  Name='순서'       ID=CURROW        HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center 	SumBgColor=#C3D0DB   Value={CurRow}</C>	
							<C>  Name='거래처코드'   ID=VENDCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=center 	SumBgColor=#C3D0DB  </C>	
							<C>  Name='거래처명'    ID=VENDNM        HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=center 	SumBgColor=#C3D0DB  </C>		
							<C>  Name='은행코드'    ID=BANKCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=center 	SumBgColor=#C3D0DB  SumText= '합계' </C>			  					
							<C>  Name='은행명'	  ID=BANKNM        HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left      SumBgColor=#C3D0DB  </C>
							<C>  Name='계좌번호'    ID=ACCNO         HeadAlign=Center HeadBgColor=#B9D4DC Width=150	    align=left      SumBgColor=#C3D0DB  </C>		
							<C>  Name='금액'       ID=RECAMT        HeadAlign=Center HeadBgColor=#B9D4DC Width=120	    align=right  	SumBgColor=#C3D0DB  color =#0000FF sumcolor =#0000FF SumText={sum(Number(RECAMT))}</C>						
								">
					</object>
				<%=HDConstant.COMMENT_END%>	
            </td>
        </tr>
        
        
    </table>
     <%=HDConstant.COMMENT_START%>  
    <object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID        value=ds_slipdtl>
	<param name=BindInfo     value='  
	<C>Col=FDCODE         Ctrl=hid_fdcode   	   Param=value</C>
	<C>Col=FSDAT          Ctrl=hid_fsdat           Param=value</C>
    <C>Col=FSNBR          Ctrl=hid_fsnbr           Param=value</C>
	<C>Col=FSSEQ          Ctrl=hid_fsseq           Param=value</C>
	<C>Col=ATCODE         Ctrl=gcem_atcode02       Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02	   Param=Text</C>
	<C>Col=ATDECR         Ctrl=hid_atdecr	       Param=value</C>
	<C>Col=REMARK         Ctrl=gcem_remark02_1     Param=Text</C>
	<C>Col=FSREFSEQ01     Ctrl=txt_fsrefseq01      Param=value</C>
	<C>Col=FSREFSEQ02     Ctrl=txt_fsrefseq02      Param=value</C>
	<C>Col=FSREFSEQ03     Ctrl=txt_fsrefseq03      Param=value</C>
	<C>Col=FSREFSEQ04     Ctrl=txt_fsrefseq04      Param=value</C>
	<C>Col=FSREFSEQ05     Ctrl=txt_fsrefseq05	   Param=value</C>
	<C>Col=FSREFSEQ06     Ctrl=txt_fsrefseq06      Param=value</C>
    <C>Col=FSREFSEQ07     Ctrl=txt_fsrefseq07      Param=value</C>
	<C>Col=FSREFSEQ08     Ctrl=txt_fsrefseq08      Param=value</C>
	<C>Col=FSREFSEQ09     Ctrl=txt_fsrefseq09      Param=value</C>
	<C>Col=FSREFCD01      Ctrl=txt_fsrefcd01	   Param=value</C>
	<C>Col=FSREFCD02      Ctrl=txt_fsrefcd02	   Param=value</C>
	<C>Col=FSREFCD03      Ctrl=txt_fsrefcd03       Param=value</C>
	<C>Col=FSREFCD04      Ctrl=txt_fsrefcd04	   Param=value</C>
	<C>Col=FSREFCD05      Ctrl=txt_fsrefcd05       Param=value</C>
	<C>Col=FSREFCD06      Ctrl=txt_fsrefcd06       Param=value</C>
	<C>Col=FSREFCD07      Ctrl=txt_fsrefcd07       Param=value</C>
	<C>Col=FSREFCD08      Ctrl=txt_fsrefcd08       Param=value</C>
	<C>Col=FSREFCD09      Ctrl=txt_fsrefcd09       Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_fsrefval01      Param=value</C>
    <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03      Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04      Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05      Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06	   Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	   Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08      Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	   Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01	   Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03	   Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04	   Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05	   Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06	   Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07	   Param=value</C>
    <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08	   Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09	   Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_fsrvalnm01     Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	   Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01         Ctrl=txt_type01		   Param=value</C>
	<C>Col=TYPE02         Ctrl=txt_type02		   Param=value</C>
	<C>Col=TYPE03         Ctrl=txt_type03		   Param=value</C>
    <C>Col=TYPE04         Ctrl=txt_type04		   Param=value</C>
	<C>Col=TYPE05         Ctrl=txt_type05		   Param=value</C>
	<C>Col=TYPE06         Ctrl=txt_type06		   Param=value</C>
	<C>Col=TYPE07         Ctrl=txt_type07		   Param=value</C>
	<C>Col=TYPE08         Ctrl=txt_type08		   Param=value</C>
	<C>Col=TYPE09         Ctrl=txt_type09		   Param=value</C>
	<C>Col=ARBALDIV1      Ctrl=txt_arbaldiv01	   Param=value</C>          
	<C>Col=ARBALDIV2      Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV3      Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV4      Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV5      Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV6      Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV7      Ctrl=txt_arbaldiv07	   Param=value</C>
	<C>Col=ARBALDIV8      Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV9      Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT            Ctrl=hid_cnt             Param=value</C>
	<C>Col=DOCUMCD        Ctrl=gclx_documcd02      Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT         Ctrl=hid_fsstat          Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM          Ctrl=gcem_fsnum	       Param=Text</C>
	<C>Col=DIVCD          Ctrl=hid_divcd           Param=value</C>
    <C>Col=BGTDIV         Ctrl=hid_bgtdiv          Param=value</C>
	<C>Col=FUNDDIV        Ctrl=hid_funddiv         Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF        Ctrl=hid_lastref         Param=value</C>
	<C>Col=BANJAEMOD      Ctrl=hid_banjaemod       Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype       Param=value</C>
	'>
</object>

<%=HDConstant.COMMENT_END%>

</body>
</html>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		