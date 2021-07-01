<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - 시스템명 	     : 출납 등록 관리
 - 프로그램ID 	 : PMS/SI060I
 - J  S  P		     : si060i.jsp
 - 서 블 릿		 : Si060I
 - 작 성 자		 : 정영식
 - 작 성 일		 : 2013-01-29
 - 기능정의		 : 
 - [ 수정일자 ][수정자] 내용
 - [2013-01-29][정영식] 신규  - 관리자용  접수번호 및 계산서번호 등 모든 수정 가능함.
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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
    var gstrAuthgr="";

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid 헤드색 
		fnInit();	
		fnAuthority();
	}
	
    <%//초기작업 %>
    function fnInit() {

	    v_job ="I";
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset();  //입력구분 
        
        ds_ingb_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd.Reset();  //입력구분 

    
	    ds_tax_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	    ds_tax_knd.Reset();  //과세구분[매입]
	    
	    ds_tax_div.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	    ds_tax_div.Reset();   //귀속구분[매입]
	    
	    ds_gubun.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2200"; 
	    ds_gubun.Reset();   //발행구분
	    
        ds_inout_gb.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI002&s_item1=Y";
        ds_inout_gb.Reset();	//출납구분
        
		ds_card_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1134";
	    ds_card_knd.Reset();   //카드종류
	    
	    ds_non_pay.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1011";
	    ds_non_pay.Reset();   //미불구분
	    
	    
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        vt_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        v_chk_cost.checked = true;
        v_chk_ingb.checked = true;

        //임시
        //vt_fr_inout_dt.Text = "20121201";
       // vt_to_inout_dt.Text = "20121231";
        
        v_empnmk.value=gusrnm;
        v_empno.value=gusrid;
        
        return;
            
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
             
    }
    
    
 <%   
 /******************************************************************************
 권한
******************************************************************************/
%>
	function fnAuthority(){
		gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2="+gusrid+"&v_str3=si060i&v_str4=Y";
		gcds_empno_chk.Reset();
		
		if(gcds_empno_chk.countrow>0){
			gstrAuthgr=gcds_empno_chk.namevalue(gcds_empno_chk.rowposition,"AUTHGR");
		}else{
			gstrAuthgr="";
		}
		//alert("gstrAuthgr::::"+gstrAuthgr);
	}
	    
    
    
    <%//메인 조회  %>
    function fnSelect() {
		if (ds_default.IsUpdated ) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";
		    
	        var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	        
	         if(v_cost_cd_0.value==""){
	       		alert("원가는 필수항목입니다.");
	       		return false;
	        }
	
	        if(fr_date.length!=8) {
	            alert("출발일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        
	        if(to_date.length!=8) {
	            alert("출발일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                         + ",v_cost_cd=" + v_cost_cd_0.value
	                         + ",v_ingb_cd=" + lc_ingb_cd_0.bindcolval
	                         + ",v_fr_inout_dt =" + fr_date
	                         + ",v_to_inout_dt =" + to_date
	                         + ",v_empno =" + v_empno.value
	                         + ",v_inout_gb =1" ;  // 1:출금 
	                        
	                 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	            //prompt('',param);
	        tr_post(tr1);
		}
    }    

	<%//저장 %>
	function fnApply(){
	
	    //세션값 체크하여 NULL이면 저장 안되게 함. 
	
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
               // prompt('',ds_default.text );
                + ",v_userid =" + gusrid;
            
        		tr_post(tr1);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
	<%//입력값 체크 %>
	function ln_Chk() {
	
	   //return true;
	   //alert("gusrid:::"+gusrid+"::::");
	   
	   if(gusrid==""){
	   	alert("다시 로그인 해주세여");
	   	return false;
	   }
	
	   //작성자 체크 : 수정은 본인만 가능함. 

		for(i=1;i<=ds_default.countrow;i++) {
		   //필수항목 체크 
		   
		   if(ds_default.RowStatus(i)==1||ds_default.RowStatus(i)==2||ds_default.RowStatus(i)==3) { //insert delete update
		   
		       /*
		       alert("RowStatus::"+ds_default.RowStatus(i));
		       alert("SUPAMT OrgNameValue::"+ds_default.OrgNameValue(i, "SUPAMT")+"::::NameValue:::"+ds_default.NameValue(i,"SUPAMT"));
		       alert(" VATAMT OrgNameValue::"+ds_default.OrgNameValue(i, "VATAMT")+"::::NameValue:::"+ds_default.NameValue(i,"VATAMT"));
		       alert("SUMAMT OrgNameValue::"+ds_default.OrgNameValue(i, "SUMAMT")+"::::NameValue:::"+ds_default.NameValue(i,"SUMAMT"));
		       alert("XSUPAMTOrgNameValue::"+ds_default.OrgNameValue(i, "XSUPAMT")+"::::NameValue:::"+ds_default.NameValue(i,"XSUPAMT"));
		       */
		                 
		                 
		       /*관리자 모드 막음 
		                  
		       if(ds_default.RowStatus(i)==2 ||ds_default.RowStatus(i)==3){ //삭제  수정시 작성자와 비교
		           
		           //alert("EMPNO::"+ds_default.namevalue(i,"I_EMPNO")+"::gusrid::"+gusrid);
		       		if(ds_default.namevalue(i,"I_EMPNO")!=gusrid){
		       			alert("수정 및 삭제 권한이 존재하지 않습니다.");
		       			alert("EMPNO::"+ds_default.namevalue(i,"I_EMPNO")+"::id::"+gusrid);
		       			return false;
		       		}
		       }
		       
		       //계산서 작성시 수정불가
		       if(ds_default.namevalue(i,"TAXNBR")!=""){
		       		alert("계산서가 작성 되었습니다. 수정할 수 없습니다.");
		       		return false;
		       }
		       
		       //전표 작성시 수정불가 
		       if(ds_default.namevalue(i,"FSDAT")!=""){
		       		alert("전표가 작성되었습니다. 수정할 수 없습니다.");
		       		return false;
		       }
		       
		       **/
		    
			   //원가 
			   if(ds_default.namevalue(i,"COST_CD")=="") {
			   		alert("원가코드를 입력해 주십시오");
			   		return false;
			   }
			    //원가명
			   if(ds_default.namevalue(i,"COST_NM")=="") {
			   		alert("원가명을  입력해 주십시오");
			   		return false;
			   }
			    //입력구분 
			   if(ds_default.namevalue(i,"INGB_CD")=="") {
			   		alert("입력구분을  입력해 주십시오");
			   		return false;
			   }
			    //출납일자
			   if(ds_default.namevalue(i,"INOUT_DT")=="") {
			   		alert("출납일자를  입력해 주십시오");
			   		return false;
			   }
			   			   
			   if(ds_default.namevalue(i,"INOUT_DT").length!=8) {
			   		alert("출납일자를  확인해 주십시오");
			   		return false;
			   }
			   
			    //계정과목코드
			   if(ds_default.namevalue(i,"ATCODE")=="") {
			   		alert("계정코드를  입력해 주십시오");
			   		return false;
			   }
			    //계정과목명
			   if(ds_default.namevalue(i,"ATKORNAM")=="") {
			   		alert("계정명을  입력해 주십시오");
			   		return false;
			   }
			   
			   /*********************************************
			    //2012.06.20 JYS 공종은 임시로 필수항목에서 제외 
			    //공종코드
			   if(ds_default.namevalue(i,"BID_SITE_KIND")=="") {
			   		alert("공종코드를  입력해 주십시오");
			   		return false;
			   }
			    //공종명
			   if(ds_default.namevalue(i,"BID_SITE_KIND_NM")=="") {
			   		alert("공종명을  입력해 주십시오");
			   		return false;
			   }
			   ************************************************/
			   
			   //과세구분 --필수항목이 아님.
			  
			   if(ds_default.namevalue(i,"SUPAMT")=="") {
			   		alert("공급가를 입력해 주십시요. ");
			   		return false;
			   }
			      
			   if(ds_default.namevalue(i,"SUMAMT")=="") {
			   		alert("합계를 입력해 주십시요. ");
			   		return false;
			   }
			    
			   //공급가+부가세 = 합계  
			   if(Number(ds_default.namevalue(i,"SUMAMT"))!=Number(ds_default.namevalue(i,"SUPAMT"))+Number(ds_default.namevalue(i,"VATAMT"))) {
			   		alert("공급가+부가세=합계가 맞지 안습니다. ");
			   		return false;
			   } 
			    
			   //영세||면세 일경우 부가세 =0 
			   //alert("i::"+i+"::TAX_KND::"+ds_default.namevalue(i,"TAX_KND")+"::"); 
			   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="2"||ds_default.namevalue(i,"TAX_KND")=="3") {
			   		if(ds_default.namevalue(i,"VATAMT")!="0") {
			   			alert("부가세는 0 원입니다. ");
			   			return false;
			   		}
			   }else{
			   		if(ds_default.namevalue(i,"VATAMT")=="0") {
			   			alert("부가세을 입력해 주십시요. ");
			   			return false;
			   		}
			   }
			    
			   //과세구분이 없는데 부가세가 존재하는 경우 안됨 
			   if(ds_default.namevalue(i,"TAX_KND")==""){
			    	if(ds_default.namevalue(i,"VATAMT")!="0") {
			    		alert("과세구분없이 부가세만 존재합니다. ");
			   			return false;
			    	}
			    	
			    	if(ds_default.namevalue(i,"XSUPAMT")!="0") {
			    		alert("과세구분없이 매입공급가만 존재합니다. ");
			   			return false;
			    	}
			   }else{
			   		if(ds_default.namevalue(i,"XSUPAMT")=="0") {
			    		alert("매입공급가를 입력해 주십시요. ");
			   			return false;
			    	}
			   }
			   
			   //매입공급가가 존재하고 부가세가 존재할 경우 동일하면 안됨 .2012.10.11 jys 추가 
			   if(ds_default.namevalue(i,"XSUPAMT")!="0"&& ds_default.namevalue(i,"VATAMT")!="0"){
			   		 if(ds_default.namevalue(i,"XSUPAMT")==ds_default.namevalue(i,"VATAMT")){
			   		     alert("매입공급가와 부가세액이 동일합니다. 확인바랍니다.");
			   		     return false;
			   		 }
			   }
			   
			    //거래처명 
			   if(ds_default.namevalue(i,"VEND_NM")=="") {
			   		alert("거래처명을 입력해 주십시요. ");
			   		return false;
			   }
			    
			    //적요
			   if(ds_default.namevalue(i,"REMARK")=="") {
			   		alert("적요를 입력해 주십시요. ");
			   		return false;
			   }
			    
			    //과세구분존재할 경우 
			       //과세일경우 부가세 입력 
			   	if(ds_default.namevalue(i,"TAX_KND")!="") {
			   	
			   	  //거래처코드
				   if(ds_default.namevalue(i,"VEND_CD")=="") {
				   		alert("거래처코드를 입력해 주십시요. ");
				   		return false;
				   }
			   		//귀속구분 
			   	   if(ds_default.namevalue(i,"TAX_DIV")=="") {
				   		alert("귀속구분을 입력해 주십시요. ");
				   		return false;
				   }
				   
				   //발행구분
			   	    if(ds_default.namevalue(i,"GUBUN")=="") {
				   		alert("발행구분을 입력해 주십시요. ");
				   		return false;
				   }
			   	}else{ //과세구분이 없을 경우 거래처코드 /귀속구분/전자발행 필요없음.
			   	
			   	   //과세구분없을 경우도 거래처 코드 체크 안함. 
			   	   /**
			   	   //거래처코드
				   if(ds_default.namevalue(i,"VEND_CD")!="") {
				   		alert("거래처코드를 삭제해 주십시요.");
				   		return false;
				   }
				   **/
			   		//귀속구분 
			   	   if(ds_default.namevalue(i,"TAX_DIV")!="") {
				   		alert("귀속구분을 삭제해 주십시요.");
				   		return false;
				   }
				   //발행구분
			   	    if(ds_default.namevalue(i,"GUBUN")!="") {
				   		alert("발행구분을 삭제해 주십시요.");
				   		return false;
				   }
			   	}
				    
				//출납구분
			   if(ds_default.namevalue(i,"INOUT_GB")=="") {
			   		alert("출납구분을  입력해 주십시요. ");
			   		return false;
			   }
			   
			   if(ds_default.namevalue(i,"INOUT_GB")!="1") {
			   		alert("출금만 입력 가능합니다. ");
			   		return false;
			   }
			   
			   
			   if(ds_default.namevalue(i,"INGB_CD")=="1") {  //법인카드
			   	   if(ds_default.namevalue(i,"CARD_NUM")=="") {
				   		alert("카드번호를  입력해 주십시요. ");
				   		return false;
				   }
				   
				   //과세구분이 없거나 신용카드만 가능 
				   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="8"){
				   }else{
				   		alert("법인카드의 과세구분은 공백 또는 신용카드만 가능합니다.");
				   		return false;
				   }
				   
				   //과세구분이 신용카드이면 수기발행만 가능 
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				    	if(ds_default.namevalue(i,"GUBUN")!="2") {
				   		    alert("과세구분이 [신용카드] 일경우 발행구분은 [수기발행]만 가능합니다. ");
				   			return false;
				  		}
				   }
				   
			   }else if (ds_default.namevalue(i,"INGB_CD")=="2") { //개인명법인카드
			       if(ds_default.namevalue(i,"CARD_NUM")=="") {
				   		alert("카드번호를  입력해 주십시요. ");
				   		return false;
				   }
				    if(ds_default.namevalue(i,"CARD_KND")=="") {
				   		alert("카드종류를 입력해 주십시요. ");
				   		return false;
				   }
				   if(ds_default.namevalue(i,"OWNER")=="") {
				   		alert("카드 소유자 사번을  입력해 주십시요. ");
				   		return false;
				   }
				    if(ds_default.namevalue(i,"OWNER_NM")=="") {
				   		alert("카드 소유자명을  입력해 주십시요. ");
				   		return false;
				   }
				   
				    //과세구분이 없거나 신용카드만 가능 
				   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="8"){
				   
				   }else{
				   		alert("개인명 법인카드의 과세구분은 공백 또는 신용카드만 가능합니다.");
				   		return false;
				   }
				   
				    //과세구분이 신용카드이면 수기발행만 가능 
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				    	if(ds_default.namevalue(i,"GUBUN")!="2") {
				   		    alert("과세구분이 [신용카드] 일경우 발행구분은 [수기발행]만 가능합니다. ");
				   			return false;
				  		}
				   }
				   
				   
			   }else if (ds_default.namevalue(i,"INGB_CD")=="3" || ds_default.namevalue(i,"INGB_CD")=="4" ) { //전도금 또는 미불 
			   		//카드 존재하면 안됨 .
			   	 	if(ds_default.namevalue(i,"CARD_NUM")!="") {
				   		alert("입력구분이 전도금은  카드번호가 존재하지 않습니다.");
				   		return false;
				   }
				   
				    //과세구분이 신용카드이면 안됨  
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				   		alert("전도금은 과세구분이 신용카드는 불가입니다 .");
				   		return false;
				   }  
			   }	
			   
			   //alert("i:::"+i+":NONPAY:"+ds_default.namevalue(i,"NONPAY"));
			   if(ds_default.namevalue(i,"INGB_CD")=="4"){    //미불 
				   if(ds_default.namevalue(i,"NONPAY")==""){
				   		alert("입력구분 미불은 미불구분이 필수항목입니다.");
				   		return false;
				   }  
			   }
			   
			   //외상매입금의 경우 미불구분 필수 
			   if(ds_default.namevalue(i,"ATCODE")=="2100120"){
			   		 if(ds_default.namevalue(i,"NONPAY")==""){
				   		alert("입력구분 미불은 미불구분이 필수항목입니다.");
				   		return false;
				   }  
			   }
			   			   
			  			   
			   //계정과목이에 따른 자산 번호 체크 
			   if (ds_default.namevalue(i,"ATCODE")=="1220100"||ds_default.namevalue(i,"ATCODE")=="1220200"||
			       ds_default.namevalue(i,"ATCODE")=="1220300"||ds_default.namevalue(i,"ATCODE")=="1220400"||
			       ds_default.namevalue(i,"ATCODE")=="1220600"||ds_default.namevalue(i,"ATCODE")=="1220700"||
			       ds_default.namevalue(i,"ATCODE")=="1222100"
			   ){
			   	   if(ds_default.namevalue(i,"H_ASTNBR")==""){
			   	   		alert("자산번호를 입력해 주십시요.");
			   	   		return false;
			   	   }
			   }else{
			   		 if(ds_default.namevalue(i,"H_ASTNBR")!=""){
			   	   		alert("자산번호를 입력할 수 없습니다.");
			   	   		return false;
			   	   }
			   }	   
			   
			}//RowStatus
		} //for		
		return true;
	}

    
      <%//팝-체크 %>
    function fnSelPopChk() {
         return true;
    	 if(ds_default.CountRow==0){
            alert("신규 버튼으로 새 행을 추가하시기 바랍니다.");
            return false;
        }
        return true;
    }
    
    
    <%//원가 팝- 조회%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath );
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
    
    <%//작성자 팝- 조회%>
    function fnSelEmpPopup(dirPath){
    
        //권한 체크         
        if(gstrAuthgr=="A" ||gstrAuthgr=="B"){
        
        
        }else{
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
    
    
     <%//작성자 팝- 조회%>
    function fnSelEmpPopup02(dirPath){
    
        //권한 체크         
        if(gstrAuthgr=="A" ||gstrAuthgr=="B"){
        
        
        }else{
        	alert("권한이 존재하지 않습니다.");
        	return false;
        }
        
    	var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiEmpPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_empno02.value = arrParam[0];	//
            v_empnmk02.value = arrParam[1];	//
        } else {
			fnSelEmpCleanup02();
        }               
    }
    
    
    <%//원가 팝- 입력%>
    function fnSelCostPop(dirPath) {
        if(!fnSelPopChk()) return;
            
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm.value = arrParam[1];	//
            v_cost_cd.value = arrParam[0];	//
        } else {
			fnSelCostCleanup();
        }               
        
        //alert("v_cost_nm.value::"+v_cost_nm.value);
    }

	<%//계정코드%>
    function fnSelAccPopup(dirPath) {
        if(!fnSelPopChk()) return;
          
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnSiAccPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_atkornam.value = arrParam[1]; //NM
            v_atcode.value = arrParam[0];	//cd
            
	   		if(lc_ingb_cd.bindcolval =="3"){ //전도금
	   			if(v_atcode.value=="2100110"){ //외상매입금
	   				lc_non_pay.Enable=true;
	   			}else{
	   				lc_non_pay.Enable=false;
	   				lc_non_pay.bindcolval ="";
	   			}
	   		}else if(lc_ingb_cd.bindcolval =="4"){ //미불
	   		    lc_non_pay.Enable=true;
	   		}else{ //미불외...
	   			lc_non_pay.Enable=false;
	   			lc_non_pay.bindcolval ="";
	   		}
        } else {
			fnSelAccCleanup();
        }               
    }
    

	<%//공종 팝- 조회%>
    function fnSelKindPopup(dirPath) {
        if(!fnSelPopChk()) return;
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var p_costcd = v_cost_cd.value;  
        

        if(p_costcd==""){
        	alert("원가를 선택하십시요.");
        	return false;
        }

        arrResult = fnSiBidSitePop(dirPath,p_costcd);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_dcstr_sid.value = arrParam[0];
            v_bid_site_kind.value = arrParam[1];
            v_bid_site_kind_nm.value = arrParam[2];
            
        } else {
		    fnSelKindCleanup();
        }               
    }

	<%//거래처 팝- 입력%>
    function fnSelVendPopup(dirPath) {
        if(!fnSelPopChk()) return;
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCustPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_vend_cd.value  = arrParam[0];
			v_vend_nm.value = arrParam[1]; 
        } else {
			fnSelVendCleanup();
        }               
    }
    

	<%// 카드 팝업  %>
    function fnSelCardPopup(dirPath) {
        
        if(!fnSelPopChk()) return;
        var arrParam  = new Array();
        var arrResult   = new Array();      
        
        if(lc_ingb_cd.bindcolval =="1"){ //법인카드 
        	arrResult = fnSiCardPop1(dirPath);
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            vt_card_num.text= arrParam[0];	
	            lc_card_knd.bindcolval= arrParam[1];	
	        } else {
	             fnSelCardCleanup();
	        }               
        }else if (lc_ingb_cd.bindcolval =="2"){//개인명  법인카드 
        	arrResult = fnSiCardPop2(dirPath);
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            vt_card_num.text= arrParam[0];	
	            lc_card_knd.bindcolval= arrParam[2];	
	            v_owner.value= arrParam[4];	
	            v_owner_nm.value= arrParam[5];	
	        } else {
	             fnSelCardCleanup();
	        }               
        }else if (lc_ingb_cd.bindcolval =="3"){//전도금 
        	alert("전도금은 카드 선택할 수 없습니다.");
        }          
    }
    
    <%//자산번호%>
    function fnSelAstnbrPopup(dirPath) {
        if(!fnSelPopChk()) return;
        var arrParam    = new Array();
        var arrResult   = new Array();
        var p_costcd = v_cost_nm.value;  
        arrResult = fnSiAstnbrPop(dirPath,p_costcd );
        
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_h_astnbr.value= arrParam[0];	
            v_astnm.value= arrParam[1];	
        } else {
             fnSelAstnbrCleanup();
        }               
    }
   
    function fnSelCostCleanup_0(){
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
    } 
    
    function fnSelCostCleanup(){
        v_cost_nm.value = "";
        v_cost_cd.value  = "";
    }
    
    function fnSelAccCleanup(){
        v_atkornam.value = "";
        v_atcode.value  = "";
    }
    
    function fnSelKindCleanup(){
        v_dcstr_sid.value = "";
        v_bid_site_kind.value = "";
        v_bid_site_kind_nm.value  = "";
    }
    
    function fnSelVendCleanup(){
        v_vend_cd.value = "";
        v_vend_nm.value  = "";
    }
    
    function fnSelCardCleanup(){
         vt_card_num.text= "";
         lc_card_knd.bindcolval= "";
         v_owner.value= "";
         v_owner_nm.value= "";
    }
    
    function fnSelAstnbrCleanup(){
         v_h_astnbr.value= "";
         v_astnm.value="";
    }
    
    function fnSelEmpCleanup(){
    	 v_empno.value = "";
         v_empnmk.value = "";
    }
    
    function fnSelEmpCleanup02(){
    	 v_empno02.value = "";
         v_empnmk02.value = "";
    }
    
    
    
	<%// 마스터 신규 %>
	function fnAddRowDsDefault(){
		v_job="N";
		var str_cost_nm=v_cost_nm.value;
		var str_cost_cd =v_cost_cd.value;
		
		var str_ingb_cd=lc_ingb_cd.bindcolval;
		
		ds_default.addrow();	
		fnAddSetting();
		//alert("v_chk_cost.checked::"+v_chk_cost.checked);
		if(v_chk_cost.checked==true){
			v_cost_nm.value = str_cost_nm;
			v_cost_cd.value = str_cost_cd;
		}
		
		if(v_chk_ingb.checked==true){
			lc_ingb_cd.bindcolval = str_ingb_cd;
		}
		
	}
	
	<%//신규 추가시 설정 %>
	function fnAddSetting(){
		lc_inout_gb.bindcolval ="1";
		vt_inout_dt.text = "<%=DateUtil.getCurrentDate(8)%>";
        
	}

	<%// 마스터 삭제 %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("수정중인 작업이 있어 삭제할 수 없습니다.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//합계금액 자동계산 %>	
	<script language=JavaScript for=ds_default  event=onColumnChanged(row,colid)>
	
		if(colid=="SUPAMT"||colid=="VATAMT"){
			ds_default.namevalue(row,"SUMAMT") = ds_default.namevalue(row,"SUPAMT") + ds_default.namevalue(row,"VATAMT") ;
		}
	</script>
	
    <%//과세구분 선택시 처리  %>	
   <script language=JavaScript for= lc_tax_knd event=OnSelChange()>

	 	//alert("bindcolval"+lc_tax_knd.bindcolval);
	 	if (lc_tax_knd.bindcolval==""){
	 		//귀속구분, 발행구분 값 없음 .
	 		v_vend_nm.readOnly = false;
	 		v_vend_nm.value="";
	 		v_vend_cd.value = "";
	 		lc_tax_div.bindcolval="";
	 		lc_gubun.bindcolval="";
	 	}else{
	 	    v_vend_nm.readOnly = true;
	 	    v_vend_cd.value = "";
	 	    v_vend_nm.value="";
	 	}
	</script>
 
    <%//입력구분 선택시 처리  %>
    <script language=JavaScript for= lc_ingb_cd event=OnSelChange()>
   
    	if(ds_default.RowStatus(ds_default.rowposition)=="1"||ds_default.RowStatus(ds_default.rowposition)=="2"||ds_default.RowStatus(ds_default.rowposition)=="3"){
    
	    	if( lc_ingb_cd.bindcolval=="1"){  //법인카드 소유자 삭제 
	    		v_owner_nm.value="";
				v_owner.value="";
	    	}else if ( lc_ingb_cd.bindcolval=="3"){ //전도금 카드 정보 모두삭제 
        		vt_card_num.text="";
				lc_card_knd.bindcolval="";
				v_owner_nm.value="";
				v_owner.value="";
	    	}
	    	
	    	if(lc_ingb_cd.bindcolval =="4" ){ //미불 
	   			lc_non_pay.Enable=true;
	   		}else if(lc_ingb_cd.bindcolval =="3"){ //전도금
	   			if(v_atcode.value=="2100110"){ //외상매입금
	   				lc_non_pay.Enable=true;
	   			}else{
	   				lc_non_pay.Enable=false;
	   				lc_non_pay.bindcolval ="";
	   			}
	   		}else{ //미불외...
	   			lc_non_pay.Enable=false;
	   			lc_non_pay.bindcolval ="";;
	   		}
	    }
	 </script>
	    
	 <%//공급가 입력시 부가세 자동 설정  %>   
     <script language=JavaScript for=vt_supamt  event=onKillFocus()>
     
     	if(lc_tax_knd.bindcolval=="1"||lc_tax_knd.bindcolval=="4"||lc_tax_knd.bindcolval=="7"||lc_tax_knd.bindcolval=="8"){
     		if(vt_supamt.text!=0){
     			//vt_vatamt.text = vt_supamt.text*0.1;
     			//vt_sumamt.text = Number(vt_supamt.text)+Number(vt_vatamt.text);
     		}
     	}
     	
     	//저장시점에서 공급가와 매입공급가가 틀릴 경우 msg로 알려줌. 
     	//매입공급가가 0 또는 공백일 경우만 공급가 금액 가져옴. 
     	if(vt_xsupamt.text ==0 ||vt_xsupamt.text ==""){
     		vt_xsupamt.text = Number(vt_supamt.text);
     	}
     	     
     </script>
     
      <%//공급가 입력시 부가세 자동 설정  %>   
     <script language=JavaScript for=vt_vatamt  event=onKillFocus()>
     
     	if(lc_tax_knd.bindcolval=="1"||lc_tax_knd.bindcolval=="4"||lc_tax_knd.bindcolval=="7"||lc_tax_knd.bindcolval=="8"){
       		//vt_sumamt.text = Number(vt_supamt.text)+Number(vt_vatamt.text);
     	}
     
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
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        //window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
        msgTxt.innerHTML ="데이타 조회중입니다..잠시만 기다려 주십시오.";
      
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        //window.status="조회가 완료 되었습니다.";
        msgTxt.innerHTML ="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
		}
	</script>
	
	<script language=javascript for="ds_tax_knd" event="OnLoadCompleted(row)">
      	ds_tax_knd.insertrow(1);
		ds_tax_knd.namevalue(1,"CDCODE") = "";
		ds_tax_knd.namevalue(1,"CDNAM") = "";
	</script>
	
	<script language=javascript for="ds_tax_div" event="OnLoadCompleted(row)">
      	ds_tax_div.insertrow(1);
		ds_tax_div.namevalue(1,"CDCODE") = "";
		ds_tax_div.namevalue(1,"CDNAM") = "";
	</script>
	
	<script language=javascript for="ds_gubun" event="OnLoadCompleted(row)">
      	ds_gubun.insertrow(1);
		ds_gubun.namevalue(1,"CDCODE") = "";
		ds_gubun.namevalue(1,"CDNAM") = "";
	</script>
	
	<script language=javascript for="ds_card_knd" event="OnLoadCompleted(row)">
      	ds_card_knd.insertrow(1);
		ds_card_knd.namevalue(1,"CDCODE") = "";
		ds_card_knd.namevalue(1,"CDNAM") = "";
	</script>
	
	
	<script language=javascript for="ds_non_pay" event="OnLoadCompleted(row)">
      	for(var i =1 ;i<=row ;i++){
      		if(ds_non_pay.namevalue(i,"CDCODE")=="02"||ds_non_pay.namevalue(i,"CDCODE")=="03"||ds_non_pay.namevalue(i,"CDCODE")=="05"){
      		}else{
      			ds_non_pay.DeleteRow(i);
      		}
      	}
      	
      	ds_non_pay.insertrow(1);
		ds_non_pay.namevalue(1,"CDCODE") = "";
		ds_non_pay.namevalue(1,"CDNAM") = "";
	</script>
	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--조회-->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입력구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ingb_cd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입력구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_tax_knd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 과세구분 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_tax_div classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--귀속구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gubun classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--발행구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_inout_gb classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--출납구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_card_knd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--카드종류-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_non_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--미불-->
    <param name="SyncLoad"  value="True">
</object>

<object id=gcds_empno_chk classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--권한체크 -->
    <param name="SyncLoad"  value="True">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" >
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
                                    <td align="center" class="text" width="70">원가</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                        <input type="text" name='v_cost_nm_0' id="v_cost_nm_0" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_cost_cd_0' id='v_cost_cd_0'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif"  align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="값 지우기">
                                    </td>
                                    <td align="center" class="text" width="70">입력구분</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=lc_ingb_cd_0 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150  width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_ingb_cd_0>
                                            <param name=BindColumn       value="detail">
                                            <param name=BindColVal         value="detail">
                                            <param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat   value="detail_nm^0^100">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">출납일자</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="YYYY-MM-DD">
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
			                                <param name=Format      value="YYYY-MM-DD">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>   
			                        <td align="center" class="text" width="70">작성자</td>
                                   <td bgcolor='#ffffff' >&nbsp;
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelEmpPopup('<%=dirPath%>');" alt="조회창 팝">
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
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='233px' border='1'>
                                <param name="DataID"                  value="ds_default">
                                <param name="ColSizing"              value="true">
                                <param name="Editable"                value="false">
                                <param name="BorderStyle"          value="0">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                 value="
                                     <C> name='입력구분'	   ID='INGB_CD'    	         width=90 	align=CENTER	 editstyle=lookup Data='ds_ingb_cd:detail:detail_nm'</C>
                                     <C> name='일자'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 mask='XXXX/XX/XX'   sumtext='총'   sumtextalign='center'</C>
                                     <C> name='계정'            ID='ATKORNAM'       	     width=140 	align=left 		     sumtext='@cnt' sumtextalign='center'</C>
									 <C> name='공종' 		   ID='CSTR_NM'               width=60 	    align=left       	 sumtext='건'</C>
									 <C> name='공급가' 		   ID='SUPAMT'    	         width=80 	align=right    	 sumtext='@sum'  </C>
                                     <C> name='부가세'  	   ID='VATAMT'                   width=60 	align=right 		 sumtext='@sum'  </C>
                                     <C> name='계'    	       ID='SUMAMT'   	              width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='매입공급가'   ID='XSUPAMT'   	          width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='적요'   	       ID='REMARK'   	              width=120 	align=left   	     </C>
                                     <C> name='거래처'    	   ID='VEND_NM'      	          width=120 	align=left  	    </C>
                                     <C> name='거래처코드'   ID='VEND_CD'      	          width=120 	align=left  	    </C>
                                     <C> name='과세구분'      ID='TAX_KND'	              width=60 	align=left  	     editstyle=lookup Data='ds_tax_knd:CDCODE:CDNAM'</C>
                                     <C> name='귀속구분'	   ID='TAX_DIV'    	              width=80 	align=left 	         editstyle=lookup Data='ds_tax_div:CDCODE:CDNAM'</C>
                                     <C> name='출납'	           ID='INOUT_GB'    	          width=80 	align=left 	         editstyle=lookup Data='ds_inout_gb:detail:detail_nm'</C>
                                     <C> name='소유자'	       ID='OWNER_NM'              width=60 	align=center 	 </C>
                                     <C> name='카드번호'	   ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX'</C>
                                     <C> name='자산번호'	   ID='H_ASTNBR'    	          width=80 	align=center 	 </C>
                                     <C> name='원가코드'	   ID='COST_CD'    	          width=80 	align=center 	 </C>
                                     <C> name='원가명'	       ID='COST_NM'    	          width=80 	align=left 	         </C>
                                     <C> name='계산서번호'  ID='TAXNBR'       	          width=80 	align=center 	 mask='XXXXXXX-XXXX'</C>
                                     <C> name='접수일자'      ID='FSDAT'       	          width=60 	align=center 	</C>
                                     <C> name='접수번호'      ID='FSNBR'       	          width=60 	align=center 	</C>
                                     <C> name='작성자'         ID='U_EMPNO'       	      width=60 	align=center 	</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
        	<td>
        		<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
        			<tr height="21px">
        				<td width="80px"  class="boardt02">
        					<input type="checkbox"  name='v_chk_cost'   id='v_chk_cost'  style="width:20px;" >원가
        				</td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_cost_nm' id="v_cost_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_cost_cd' id='v_cost_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick=" fnSelCostPop('<%=dirPath%>');" alt="조회창 팝">
						</td>
	
						<td width="80px" class="boardt02">
							<input type="checkbox"  name='v_chk_ingb'   id='v_chk_ingb'  style="width:20px;" >입력구분
						</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_ingb_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID    value=ds_ingb_cd>
								<param name=BindColumn      value="detail">
								<param name=BindColVal        value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">출납일자</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=vt_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly     value="false">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object><%=HDConstant.COMMENT_END%>  
						</td>
					</tr>	
					<tr>	
						<td width="70px" class="boardt02">계정과목 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_atkornam' id="v_atkornam" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelAccPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_atcode' id='v_atcode'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelAccPopup('<%=dirPath%>');" alt="조회창 팝">
						</td>
						
						<td width="70px" class="boardt02">공종 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_bid_site_kind_nm' id="v_bid_site_kind_nm" style="width:250px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelKindPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_bid_site_kind' id='v_bid_site_kind'>
                            <input type="hidden"  name='v_dcstr_sid' id='v_dcstr_sid'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindPopup('<%=dirPath%>');" alt="조회창 팝">
						</td>
        			</tr>
        			
        			<tr>	
        				 <td width="70px" class="boardt02">과세구분 </td>
        					<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_knd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_knd>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">귀속구분 </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_div classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_div>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">발행구분 </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_gubun classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gubun>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">출납구분 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_inout_gb classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_inout_gb>
								<param name=BindColumn       value="detail">
								<param name=BindColVal         value="detail">
								<param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat   value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        				<tr>	
						<td width="70px" class="boardt02">공급가 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_supamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text            value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">부가세 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_vatamt   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">합계 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_sumamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
						<td width="70px" class="boardt02">매입공급가 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsupamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
        			</tr>
        			<tr>	
						<td width="70px" class="boardt02">거래처 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_vend_nm' id="v_vend_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelVendPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_vend_cd' id='v_vend_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelVendPopup('<%=dirPath%>');" alt="조회창 팝">
						</td>
						
						<td width="70px" class="boardt02">적요 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark' id="v_remark" style="width:250px;" class='input02' >
						</td>
        			</tr>
        			<tr>	
        			   <td width="70px" class="boardt02">카드번호 </td>
        				<td bgcolor='#ffffff'  colspan =3 >&nbsp;
                            <%=HDConstant.COMMENT_START%>
                            <object id=vt_card_num classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:120px; height:17px;">
                                <param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="0000-0000-0000-0000">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly        value="true">
                                <param name=SelectAll          value="true">
                                <param name=SelectAllOnClick        value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object><%=HDConstant.COMMENT_END%>  &nbsp;
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCardPopup('<%=dirPath%>');" alt="조회창 팝">				
						</td>
						
						<td width="70px" class="boardt02">카드종류</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_card_knd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_card_knd>
								<param name=Enable               value="false">
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">소유자 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_owner_nm' id="v_owner_nm" style="width:100px;" class='input01'  readOnly="readonly">
                            <input type="hidden"  name='v_owner' id='v_owner'>
						</td>
					</tr>
        			<tr>
        				<td width="70px" class="boardt02">자산번호 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_h_astnbr' id="v_h_astnbr" style="width:100px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelAstnbrPopup('<%=dirPath%>');" readOnly="readonly">
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelAstnbrPopup('<%=dirPath%>');" alt="조회창 팝">
						</td>
        		        <td width="70px" class="boardt02">자산명 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_astnm' id="v_astnm" style="width:130px;" class='input01'   readOnly="readonly">
						</td>
						<td width="70px" class="boardt02">미불구분</td>
        				<td bgcolor='#ffffff'  colspan=3>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_non_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_non_pay>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        			<tr>
        				<td width="70px" class="boardt02">접수번호</td>
        				<td bgcolor='#ffffff' colspan=3 >&nbsp;
						    <%=HDConstant.COMMENT_START%>
							<object  id=gcem_fdcode02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:18px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text			   value="A">
												<param name=Alignment     value=0>
												<param name=Border         value=true>
												<param name=Format          value="##">
												<param name=UpperFlag    value="1">
												<param name=PromptChar  value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor   value=false>
							 </object>
							 &nbsp;
							<object  id=gcem_fsdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:80px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text			   value="">
												<param name=Alignment     value=0>
												<param name=Border         value=true>
												<param name=Format          value="#####/##/##">
												<param name=PromptChar    value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
							 </object>
							 &nbsp;
							 <object  id=gcem_fsnbr02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text				qkzoqvalue="">
												<param name=Alignment       value=0>
												<param name=Border           value=true>
												<param name=Format            value="######">
												<param name=PromptChar    value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
							 </object> 
							 <%=HDConstant.COMMENT_END%>
						    
						</td>
        		  
						<td width="70px" class="boardt02">작성자</td>
        				<td bgcolor='#ffffff'  colspan=3>&nbsp;
     	        			<input type="text"  name='v_empnmk02' id="v_empnmk02" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup02('<%=dirPath%>');" readOnly="readonly">
	                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelEmpPopup02('<%=dirPath%>');" alt="조회창 팝">
	                        <input type="text"  name='v_empno02'   id='v_empno02'  style="width:70px;" class='input01'  readOnly="readonly">
        				
						</td>
        			</tr>
        			<tr>
        				<td width="70px" class="boardt02">계산서번호</td>
        				<td bgcolor='#ffffff' colspan=7>&nbsp;
        				   <%=HDConstant.COMMENT_START%> 
						   <object  id=gcem_taxnbr02  classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="position:relative;left:0px;top:1px;width:85px;height:20px;"   >
								<param name=Text            value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Format	      value="#######-####">
								<param name=MaxLength  value=10>
								<param name=PromptChar value="_">
								<param name=BackColor    value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Enable		   value=true>
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        			<tr>
        			    <td bgcolor='#ffffff'  colspan = 8>
        			     <font size="2" color="blue"> 예 ) 접수번호 02 A20130101 000001,     계산서번호 A2013010001</font>
        			    </td>
        			</tr>
        		</table>
        	</td>	
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
    </table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=COST_CD                Ctrl=v_cost_cd          Param=Value </C>
					<C>Col=COST_NM                Ctrl=v_cost_nm         Param=Value </C>
					<C>Col=INGB_CD                  Ctrl=lc_ingb_cd         Param=BindColVal </C>
					<C>Col=INOUT_DT                 Ctrl=vt_inout_dt         Param=Text </C>
					<C>Col=ATCODE                    Ctrl=v_atcode           Param=Value </C>
					<C>Col=ATKORNAM               Ctrl=v_atkornam        Param=Value </C>
					<C>Col=BID_SITE_KIND          Ctrl=v_bid_site_kind  Param=Value </C>
					<C>Col=CSTR_NM                 Ctrl=v_bid_site_kind_nm  Param=Value </C>
					<C>Col=DCSTR_SID               Ctrl=v_dcstr_sid      Param=Value </C>
					<C>Col=SUPAMT                    Ctrl=vt_supamt         Param=Text </C>
					<C>Col=VATAMT                     Ctrl=vt_vatamt           Param=Text </C>
					<C>Col=SUMAMT                    Ctrl=vt_sumamt        Param=Text </C>
					<C>Col=REMARK                    Ctrl=v_remark            Param=Value </C>
					<C>Col=TAX_KND                   Ctrl=lc_tax_knd         Param=BindColVal </C>
					<C>Col=VEND_CD                  Ctrl=v_vend_cd         Param=Value </C>
					<C>Col=VEND_NM                 Ctrl=v_vend_nm         Param=Value </C>
					<C>Col=TAX_DIV                   Ctrl=lc_tax_div            Param=BindColVal </C>
					<C>Col=GUBUN                    Ctrl=lc_gubun            Param=BindColVal </C>
					<C>Col=INOUT_GB               Ctrl=lc_inout_gb         Param=BindColVal </C>
					<C>Col=OWNER                   Ctrl=v_owner              Param=Value </C>
					<C>Col=OWNER_NM            Ctrl=v_owner_nm        Param=Value </C>
					<C>Col=CARD_KND              Ctrl=lc_card_knd        Param=BindColVal </C>
					<C>Col=CARD_NUM             Ctrl=vt_card_num        Param=Text </C>
					<C>Col=H_ASTNBR              Ctrl=v_h_astnbr          Param=Value </C>
					<C>Col=ASTNM                    Ctrl=v_astnm              Param=Value </C>
					<C>Col=XSUPAMT                Ctrl=vt_xsupamt         Param=Text </C>
					<C>Col=NONPAY                  Ctrl=lc_non_pay         Param=BindColVal </C>
					<C>Col=TAXNBR                  Ctrl=gcem_taxnbr02   Param=Text </C>
					<C>Col=FDCODE                  Ctrl=gcem_fdcode02  Param=Text </C>
					<C>Col=FSDAT                     Ctrl=gcem_fsdat02      Param=Text </C>
					<C>Col=FSNBR                     Ctrl=gcem_fsnbr02     Param=Text </C>
					<C>Col=U_EMPNO                Ctrl=v_empno02         Param=Value </C>
					<C>Col=EMP_NM                  Ctrl=v_empnmk02         Param=Value </C>
					
					
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		