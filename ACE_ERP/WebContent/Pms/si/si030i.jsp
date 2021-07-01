<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - 시스템명 	     : 출납 매입등록
 - 프로그램ID 	 : PMS/SI030I
 - J  S  P		     : si030i.jsp
 - 서 블 릿		 : Si010I
 - 작 성 자		 : 정영식
 - 작 성 일		 : 2012-06-07
 - 기능정의		 : 출납등록건 중 매입 대상건에 한하여 조회 가능함.
 - [ 수정일자 ][수정자] 내용
 - [2012-05-21][정영식] 신규
 -----------------------------------------------------------------------------
 - [ 수정일자 ][수정자] 내용
 - [2013-01-15][정영식] 간이과세업자의 경우 과세구분이 면세를 제외하고는 매입등록 불가  
 - [ 수정일자 ][수정자] 내용
 - [2014-04-14][정영식] 원가코드 추가 

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

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid 헤드색
		cfStyleGrid(getObjectFirst("gr_default2"), "comn");  //grid 헤드색 
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {

	    v_job ="I";
	    
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset(); //입력구분 
        
        ds_ingb_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd.Reset();  //입력구분 
    
        ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //지점 
	    
	    ds_cocode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2210"; 
	    ds_cocode.Reset();  //사업소 
    
	    ds_tax_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	    ds_tax_knd.Reset();  //과세구분[매입]
	    
	    ds_tax_div.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	    ds_tax_div.Reset();   //귀속구분[매입]
	    
	    ds_gubun.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2200"; 
	    ds_gubun.Reset();   //발행구분
	    
	    
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //vt_fr_inout_dt.Text = "20120401";
        //vt_to_inout_dt.Text = "20120430";
        
        v_empnmk.value=gusrnm;
        v_empno.value=gusrid;

        return;
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
             
       		lc_fdcode.bindcolval = gfdcode;
      	    lc_cocode.bindcolval = gcocode;             
    }
    
    <%//메인 조회  %>
    function fnSelect() {
    

		if (ds_default.IsUpdated ) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";    
		    
		    if(v_cost_nm_0.value==""||v_cost_cd_0.value==""){
		      	alert("원가를 입력하십시요.");
		      	return false;
		    }
		    
		    
	        var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	
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
	                         + ",v_empno =" + v_empno.value;
	                 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           // prompt('',param);
	       tr_post(tr1);
		}
    }    

	<%//저장 %>
	function fnApply(){
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I2",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_MST=ds_taxmst,I:DS_DTL=ds_taxdtl,O:DS_NBR=ds_taxnbr)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                
                //prompt('',ds_default.text );
                //prompt('',ds_taxmst.text );
                //prompt('',ds_taxdtl.text );
        		tr_post(tr2);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}

	<%//입력값 체크 %>
	function ln_Chk() {

		for(i=1;i<=ds_taxmst.countrow;i++) {
		   //필수항목 체크 
		   
		   if(ds_taxmst.RowStatus(i)==1||ds_taxmst.RowStatus(i)==2||ds_taxmst.RowStatus(i)==3) {
		    
			   // 계산서번호 
			   if(ds_taxmst.namevalue(i,"TAXNBR")!="") {
			   		alert("계산서 번호가 존재 합니다.  신규 입력 불가 입니다.");
			   		return false;
			   }
			   
			   
			   if(ds_taxmst.namevalue(i,"COST_CD")=="") {
			   		alert("원가를  입력해 주십시오");
			   		return false;
			   }
			   
			    //지점
			   if(ds_taxmst.namevalue(i,"FDCODE")=="") {
			   		alert("지점을  입력해 주십시오");
			   		return false;
			   }
			    //사업소 
			   if(ds_taxmst.namevalue(i,"COCODE")=="") {
			   		alert("사업소를  입력해 주십시오");
			   		return false;
			   }
			   
			    //계산서일자
			   if(ds_taxmst.namevalue(i,"TAXDAT")=="") {
				   alert("계산서일자를  입력해 주십시오");
			   	   return false;	
			   }
			    
			   if(ds_taxmst.namevalue(i,"TAXDAT").trim().length!=8){
				   alert("계산서일자를  길이를 확인해 주십시오");
			   	   return false;
			   }
			    
			    //거래처
			   if(ds_taxmst.namevalue(i,"VEND_CD")=="") {
			   		alert("거래처를  입력해 주십시오");
			   		return false;
			   }
			   
			    //계정과목명
			   if(ds_taxmst.namevalue(i,"ATCODE")=="") {
			   		alert("계정명을  입력해 주십시오");
			   		return false;
			   }
			    //부서코드
			   if(ds_taxmst.namevalue(i,"DEPTCD")=="") {
			   		alert("부서코드를  입력해 주십시오");
			   		return false;
			   }
			   
			    //담당자
			   if(ds_taxmst.namevalue(i,"EMPNO")=="") {
			   		alert("담장자를  입력해 주십시오");
			   		return false;
			   }
			   
			    //계산서구분
			   if(ds_taxmst.namevalue(i,"TAXIODIV")=="") {
			   		alert("계산서구분을  입력해 주십시요. ");
			   		return false;
			   }
			      
			   //귀속구분
			   if(ds_taxmst.namevalue(i,"TAXDIV")=="") {
			   		alert("귀속구분을  입력해 주십시요. ");
			   		return false;
			   }
			   
			   //계산서종류
			   if(ds_taxmst.namevalue(i,"TAXKND")=="") {
			   		alert("계산서종류를  입력해 주십시요. ");
			   		return false;
			   }
			   
			    //적요
			   if(ds_taxmst.namevalue(i,"REMARK")=="") {
			   		alert("적요를  입력해 주십시요. ");
			   		return false;
			   }
			   
			   //공급가+부가세 = 합계  
			   if(Number(ds_taxmst.namevalue(i,"TAXTOT"))!=Number(ds_taxmst.namevalue(i,"TAXVATAMT"))+Number(ds_taxmst.namevalue(i,"TAXSUM"))) {
			   		alert("공급가+부가세=합계가 맞지 안습니다. ");
			   		return false;
			   } 
			   
			   //영세||면세 일경우 부가세 =0 		    
			   if(ds_taxmst.namevalue(i,"TAXKND")==""||ds_taxmst.namevalue(i,"TAXKND")=="2"||ds_taxmst.namevalue(i,"TAXKND")=="3") {
			   		if(ds_taxmst.namevalue(i,"TAXVATAMT")!="0") {
			   			alert("부가세는 0 원입니다. ");
			   			return false;
			   		}
			   }else{
			   		if(ds_taxmst.namevalue(i,"TAXVATAMT")=="0") {
			   			alert("부가세을 입력해 주십시요. ");
			   			return false;
			   		}
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
			   
			   
			   //2013.01.15. JYS 간이과세업자 체크 
			   //간이과세업자 
			   
			   if(ds_default.namevalue(i,"COCOMYN")=="T") {
			   		if(ds_default.namevalue(i,"TAX_KND")!="3") {  //면세가 아닌경우는 입력 불가 
			   			alert("간이과세자입니다. 거래처를 확인하십시요.");
			   			return false;
			   		}
			   }
			   	   
			   //2015.01.21
			    //이예빈
			    //간이과세자일 경우 부가세액 0원  ( 꼭 체크 )
			    if(ds_default.namevalue(i,"COCOMYN")=="T" ){   
			    	if(ds_taxmst.namevalue(i,"TAXVATAMT")!=0){
			    		alert("간이과세 업체입니다. 부가세액을 확인 하십시요.");
			    		return false;
			    	}
			    }
			   
			   
			   
			   //2014.06.30 JYS 면세업자 체크 
			    if(ds_default.namevalue(i,"COCOMYN")=="M") {
			    	//alert("TAXKND::"+ds_default.namevalue(i,"TAX_KND"));
			   		if(ds_default.namevalue(i,"TAX_KND")!="3") {  //면세가 아닌경우는 입력 불가 
			   			alert("면세업체는 과세구분이 [면세]만 가능합니다. 거래처를 확인하십시요.");
			   			return false;
			   		}
			   }
			   
			   
			   if(ds_taxmst.namevalue(i,"INGB_CD")=="1") {  //법인카드
			   	   if(ds_taxmst.namevalue(i,"CARD_NUM")=="") {
				   		alert("카드번호를  입력해 주십시요. ");
				   		return false;
				   }
			   }else if (ds_taxmst.namevalue(i,"INGB_CD")=="2") { //개인명법인카드
			       if(ds_taxmst.namevalue(i,"CARD_NUM")=="") {
				   		alert("카드번호를  입력해 주십시요. ");
				   		return false;
				   }
				    if(ds_taxmst.namevalue(i,"CARD_KND")=="") {
				   		alert("카드종류를 입력해 주십시요. ");
				   		return false;
				   }
			   }else if (ds_taxmst.namevalue(i,"INGB_CD")=="3") { //전도금 
			   		//카드 존재하면 안됨 .
			   		
			   		//alert("i::"+i+"::INGB_CD::"+ds_taxmst.namevalue(i,"INGB_CD")+":TAXCDNBR:"+ds_taxmst.namevalue(i,"TAXCDNBR"))+"::";
			   		
			   	 	if(ds_taxmst.namevalue(i,"TAXCDNBR")!="" && ds_taxmst.namevalue(i,"TAXCDNBR")!=" ") {
				   		alert("입력구분이 전도금은  카드번호가 존재하지 않습니다.");
				   		return false;
				   }

			   }	
	
			  			   
			   //계정과목이에 따른 자산 번호 체크 
			   if (ds_taxmst.namevalue(i,"ATCODE")=="1220100"||ds_taxmst.namevalue(i,"ATCODE")=="1220200"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1220300"||ds_taxmst.namevalue(i,"ATCODE")=="1220400"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1220600"||ds_taxmst.namevalue(i,"ATCODE")=="1220700"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1222100"
			   ){
			   	   if(ds_taxmst.namevalue(i,"H_ASTNBR")==""){
			   	   		alert("자산번호를 입력해 주십시요.");
			   	   		return false;
			   	   }
			   }	   
			   
			}//RowStatus
		} //for		
		
		
		//품목입력 체크 
		if ( ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPDTNAM")==""){
			alert("품목을 입력해 주십시요.");
			return false;
		} 
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
	
	<%//입력구분, 년월, 거래처, 과세구분, 귀속구분, 발행구분 체크가 동일한 건만 체크 가능함 %>
	function fnCustnmDateChk(crow) {
	
	    for (var i=1; i<=ds_default.countrow;i++){
	    
	        //alert(ds_default.namevalue(i,"CHK")+"::i:::"+i+":::"+ds_default.namevalue(crow,"INGB_CD")+":::::"+ds_default.namevalue(i,"INGB_CD"));	
	    	if(ds_default.namevalue(i,"CHK")=="T"){
	    		if(ds_default.namevalue(crow,"INGB_CD")!=ds_default.namevalue(i,"INGB_CD")){
	    		    alert("입력구분이 다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"INOUT_DT")!=ds_default.namevalue(i,"INOUT_DT")){
	    		    alert("일자가 다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"VEND_CD")!=ds_default.namevalue(i,"VEND_CD")){
	    		    alert("거래처가 다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"TAX_KND")!=ds_default.namevalue(i,"TAX_KND")){
	    		    alert("과세구분이 다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"TAX_DIV")!=ds_default.namevalue(i,"TAX_DIV")){
	    		    alert("귀속구분이  다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"GUBUN")!=ds_default.namevalue(i,"GUBUN")){
	    		    alert("발행구분이  다릅니다.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    	}
	    }
	    return true;
   	}
   	
   	
   	<%//금액누계 처리   %>
	function fnAmtSum() {	
	  var i_xsupamt=0;
	  var i_vatamt=0; 
	  var i_ChkCnt=0;
	
       for(var i =1; i<=ds_default.countrow;i++){
       		if(ds_default.namevalue(i,"CHK")=="T"){
       			i_xsupamt+= Number(ds_default.namevalue(i,"XSUPAMT"));
	    		i_vatamt+=Number(ds_default.namevalue(i,"VATAMT"));
	    		i_ChkCnt+=1;
       		}
       }
       
        vt_xsupamt.text = i_xsupamt;
	    vt_vatamt.text = i_vatamt;
        vt_xsumamt.text = Number(vt_xsupamt.text)+Number(vt_vatamt.text);
        ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSUM")=vt_xsupamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXVATAMT")=vt_vatamt.text;
        
        //체크가 없을 경우 입력화면 clear
        //alert("i_ChkCnt::"+i_ChkCnt);
        if(i_ChkCnt==0){
        	ds_taxmst.ClearData();
        	ds_taxdtl.ClearData();
        }
	}
		
	<%//매입MST  %>
	function fnTaxmst_Add(crow) {	
	
	    ds_taxmst.clearall();	
		fnSetHeader();
		ds_taxmst.addrow();
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXNBR")=ds_default.namevalue(crow,"TAXNBR");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"COCODE")=gcocode;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"DEPTCD")=gdeptcd;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"EMPNO")=gusrid;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXIODIV")="A";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXDIV")=ds_default.namevalue(crow,"TAX_DIV");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXKND")=ds_default.namevalue(crow,"TAX_KND");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_CD")=ds_default.namevalue(crow,"VEND_CD");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXDAT")=ds_default.namevalue(crow,"INOUT_DT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXSUM")=ds_default.namevalue(crow,"SUPAMT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXVATAMT")=ds_default.namevalue(crow,"VATAMT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXTOT")=ds_default.namevalue(crow,"SUMAMT");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK")=ds_default.namevalue(crow,"REMARK");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXCDNBR")=ds_default.namevalue(crow,"CARD_NUM");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"ATCODE")=ds_default.namevalue(crow,"ATCODE");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXPRTYN")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXCNT")=0;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"LASTPRT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXTYPE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FSDAT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FSNBR")="";
		
		//기수처리 
		var strTaxDat=ds_default.namevalue(crow,"INOUT_DT");
		strTaxDat = strTaxDat.substring(4,6);
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXKIDIV")=fnKisuFind(strTaxDat);	
		
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FDCODE")=gfdcode;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WORKTYPE")="A";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REPORT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WRDT")= "<%=DateUtil.getCurrentDate(8)%>";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WRID")="9999998";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"UPDT")="<%=DateUtil.getCurrentDate(8)%>";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"UPID")=gusrid;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SSDAT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SSNBR")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SEQ")=0;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"CONVERSATION_ID")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SUPBUY_TYPE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"DIRECTION")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"GUBUN")=ds_default.namevalue(crow,"GUBUN");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"AMEND_CODE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"AMEND_REMARK")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"EXTCHK")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK2")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK3")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"S_BIZPLACE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"B_BIZPLACE")="";
		
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_NM")=ds_default.namevalue(crow,"VEND_NM");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_ID")=ds_default.namevalue(crow,"VEND_ID");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VD_DIRECT")=ds_default.namevalue(crow,"VD_DIRECT");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"ADDR")=ds_default.namevalue(crow,"ADDR");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"BSNS_CND")=ds_default.namevalue(crow,"BSNS_CND");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"BSNS_KND")=ds_default.namevalue(crow,"BSNS_KND");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"H_ASTNBR")=ds_default.namevalue(crow,"H_ASTNBR");
        
        ds_taxmst.namevalue(ds_taxmst.rowposition,"INGB_CD")=ds_default.namevalue(crow,"INGB_CD");
        
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COCOMYN")=ds_default.namevalue(crow,"COCOMYN");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COST_CD")=ds_default.namevalue(crow,"COST_CD");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COST_NM")=ds_default.namevalue(crow,"COST_NM");
        
		//prompt('', ds_taxmst.text);
	}
	
	<%//매입상세 %>
	function fnTaxdtl_Add(crow) {
	
	    ds_taxdtl.clearall();	
		fnSetHeader();
		ds_taxdtl.addrow();
		
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXNBR")=vt_taxnbr.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"MMDD")=vt_taxdat.text.substring(4,8);
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSEQ")="001";
		//ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPDTNAM")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSTD")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXQTY")=0;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPRIC")=0;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSUM")=vt_xsupamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXVATAMT")=vt_vatamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"BIGO")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"WRDT")="<%=DateUtil.getCurrentDate(8)%>";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"WRID")=gusrid;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"UPDT")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"UPID")="";
	}
	
	<%//DataSet Head 만들기 %>
	function fnSetHeader() {	
	
		if (ds_taxmst.countrow < 1){
			var s_temp1="TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
							   +"TAXDIV:STRING,TAXKND:STRING,VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,"
							   +"TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,"
							   +"TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,"
			   				   +"FSNBR:STRING,TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,"
							   +"WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,"
							   +"SSNBR:STRING,SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,GUBUN:STRING,"
							   +"AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,REMARK3:STRING,"
							   +"S_BIZPLACE:STRING,B_BIZPLACE:STRING,"
							   +"VEND_NM:STRING,VEND_ID:STRING,VD_DIRECT:STRING,ADDR:STRING,BSNS_CND:STRING,"
							   +"BSNS_KND:STRING,H_ASTNBR:STRING,INGB_CD:STRING,COCOMYN:STRING,COST_CD:STRING,COST_NM:STRING ";
							   
			ds_taxmst.SetDataHeader(s_temp1);
		}	
		
		
		if (ds_taxdtl.countrow < 1){
			var s_temp1="MMDD:STRING,TAXNBR:VARCHAR,TAXSEQ:VARCHAR,TAXPDTNAM:VARCHAR,TAXSTD:VARCHAR,TAXQTY:DECIMAL,"
							   +"TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:VARCHAR,"
							   +"WRDT:VARCHAR,WRID:VARCHAR,UPDT:VARCHAR,UPID:VARCHAR";
			ds_taxdtl.SetDataHeader(s_temp1);
		}		
	}
	
	
	<%//기수찾기 만들기 %>
	function fnKisuFind(strMM){
	   	
		if (strMM =='01' ||strMM =='02'|| strMM=='03') {
			return  "1";	//기수[1]
		}else if(strMM =='04' ||strMM =='05'|| strMM=='06') {
			return "2";	//기수[2]
		}else if(strMM =='07' ||strMM =='08'|| strMM=='09') {
			return "3";	//기수[3]
		}else if(strMM =='10' ||strMM =='11'|| strMM=='12') {
			return "4";	//기수[4]
		}
	}
	
	
	 <%//작성자 팝- 조회%>
    function fnSelEmpPopup(dirPath){
         //권한 체크 
        //관리자만 사용가능함. 
        if (gusrid!="6070001" && gusrid!="6060002" && gusrid != "3150005"  && gusrid != "2020013"){
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
    
	
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//합계금액 자동계산 %>	
	<script language=JavaScript for=ds_default  event=onColumnChanged(row,colid)>
	
		if(colid=="XSUPAMT"||colid=="VATAMT"){
			ds_default.namevalue(row,"XSUMAMT") = Number(ds_default.namevalue(row,"XSUPAMT")) + Number(ds_default.namevalue(row,"VATAMT")) ;
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
	    }
	 </script>
	        
     <script language="javascript"  for=gr_default event=OnClick(row,colid)>
		
		if(colid=="CHK" &&  row>0){
			if (ds_default.namevalue(row,"CHK")=="T"){
				 if(!fnCustnmDateChk(row)) return ;
				 fnTaxmst_Add(row);
				 fnAmtSum();
				 fnTaxdtl_Add(row);
			}else{
				 fnAmtSum();
			}
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
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 
 
 <script language="javascript" for="tr2" event="OnSuccess()">
	if(v_job=="A"){
	    vt_taxnbr.text = ds_taxnbr.namevalue(ds_taxnbr.rowposition,"TAXNBR");
		alert("매입등록이  성공적으로 저장되었습니다.");
		 fnSelect();
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				
			}
		}
		//gr_default.ColumnProp("XSUMAMT","SumText") =ds_default.SUM(33,0,0);
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
	
	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--조회-->
    <param name="SyncLoad"  value="false">
</object>


<object id=ds_taxmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--세금계산서 MST-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_taxdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--세금계산서 상세-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_taxnbr classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--계산서번호-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입력구분-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ingb_cd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입력구분-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--지점-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_cocode classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--사업소-->
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
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
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
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="조회창 팝">
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
                                <param name="Editable"                value="true">
                                <param name="BorderStyle"          value="0">
                                <param name=UsingOneClick       value="1">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                  value="
                                     <C> name='선택'	           ID='CHK'    	                 width=30 	align=CENTER 	 editstyle=checkbox </C>
                                     <C> name='입력구분'	   ID='INGB_CD'    	         width=90 	align=CENTER	 edit=none  editstyle=lookup Data='ds_ingb_cd:detail:detail_nm'  sumtext='총'  sumtextalign='center'</C>
                                     <C> name='일자'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 edit=none  mask='XXXX/XX/XX'   sumtext='@cnt'    sumtextalign='center'   </C>
                                     <C> name='계정'            ID='ATKORNAM'       	     width=140 	align=left 		     edit=none   sumtextalign='center'</C>
									 <C> name='매입공급가'  ID='XSUPAMT'    	         width=80 	align=right    	 edit=none  sumtext='@sum'  </C>
                                     <C> name='부가세'  	   ID='VATAMT'                   width=60 	align=right 		 edit=none  sumtext='@sum'  </C>
                                     <C> name='계'    	       ID='XSUMAMT'   	         width=80 	align=right 	     edit=none  sumtext='{SUM(Number(XSUMAMT))}'  Value={Number(XSUMAMT)} </C>
                                     <C> name='적요'   	       ID='REMARK'   	              width=120 	align=left   	     edit=none </C>
                                     <C> name='거래처'    	   ID='VEND_NM'      	          width=120 	align=left  	     edit=none </C>
                                     <C> name='거래처코드'   ID='VEND_CD'      	          width=120 	align=left  	     edit=none </C>
                                     <C> name='과세구분'      ID='TAX_KND'	              width=60 	align=left  	     edit=none  editstyle=lookup Data='ds_tax_knd:CDCODE:CDNAM'</C>
                                     <C> name='업체구분'      ID='COCOMYN'	              width=80 	align=left  	     edit=none  editstyle=Combo Data='T:간이과세자'</C>
                                     <C> name='귀속구분'	   ID='TAX_DIV'    	              width=80 	align=left 	         edit=none  editstyle=lookup Data='ds_tax_div:CDCODE:CDNAM'</C>
                                     <C> name='카드번호'	   ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX'</C>
                                     <C> name='자산번호'	   ID='H_ASTNBR'    	          width=80 	align=center 	 </C>
                         
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
        			
        			<tr>
        				<td width="80px"  class="boardt02">
        					<input type="checkbox"  name='v_chk_cost'   id='v_chk_cost'  style="width:20px;" >원가
        				</td>
        				<td bgcolor='#ffffff' colspan="7">&nbsp;
						    <input type="text" name='v_cost_nm' id="v_cost_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_cost_cd' id='v_cost_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick=" fnSelCostPop('<%=dirPath%>');" alt="조회창 팝">
						</td>
        			</tr>
        			
        			<tr height="21px">	
        			    <td width="70px" class="boardt02"><font size="2" color="red">*</font>지점 </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_fdcode>
								<param name=BindColumn       value="FDCODE">
								<param name=BindColVal         value="FDCODE">
								<param name=ListExprFormat   value="FDNAME^0^90">
								<param name=Index                  value="2">
								<param name=Enable               value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02"><font size="2" color="red">*</font>사업소 </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_cocode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_cocode>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">계산서일자 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_taxdat   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly     value="false">
                                <param name=SelectAll       value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">계산서번호 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_taxnbr classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="#######-####">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="true">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object><%=HDConstant.COMMENT_END%> 
						</td> 			
        			</tr>
                  
        			<tr >
        				<td width="70px"  class="boardt02">거래처</td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_vend_nm' id="v_vend_nm" style="width:235px;"   class='input01'   readOnly="readonly">
                            <input type="text"  name='v_vend_cd' id='v_vend_cd'  style="width:80px;"    class='input01'  readOnly="readonly" >
						</td>
	
						<td width="70px" class="boardt02">등록번호</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=vt_vend_id classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
							    <param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="000-00-00000">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="true">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">대표자</td>
						<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_vd_direct' id="v_vd_direct" style="width:100px;" class='input01'  readOnly="readonly">
						</td>
					</tr>	
					 
					<tr>	
						<td width="70px" class="boardt02">주소 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_addr' id="v_addr" style="width:320px;" class='input01'  readOnly="readonly">
						</td>
						
						<td width="70px" class="boardt02">업태 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_bsns_cnd' id="v_bsns_cnd" style="width:100px;" class='input01' >
						</td>
						<td width="70px" class="boardt02">업종 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_bsns_knd' id="v_bsns_knd" style="width:100px;" class='input01' >
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
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">매입공급가</td>
        				<td bgcolor='#ffffff' >&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsupamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text            value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">부가세 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_vatamt   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">합계 </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsumamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
        			
        			</tr>
        			<tr>	
						<td width="70px" class="boardt02">적요 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark' id="v_remark" style="width:320px;" class='input01'  readOnly="readonly">
						</td>
						
						<td width="70px" class="boardt02">수정사유 </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark2' id="v_remark2" style="width:270px;" class='input02' >
						</td>
        			</tr>
        			
        			<tr>	
						<td width="70px" class="boardt02">귀속구분 </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_div classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_div>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">발행구분 </td>
        				<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_gubun classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gubun>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">카드번호 </td>
        				<td bgcolor='#ffffff' >&nbsp;<%=HDConstant.COMMENT_START%>
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
                            </object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">자산번호 </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_h_astnbr' id="v_h_astnbr" style="width:100px;" class='input01'   readOnly="readonly">
						</td>
        			</tr>
        		</table>
        	</td>	
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
	         <td valign='top' width="845px">
	          	<%=HDConstant.COMMENT_START%>
	           		<object id=gr_default2 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='41px' border='1'>
								<param name="dataid"			  value="ds_taxdtl">
								<param name="borderstyle"   value="0">
								<param name="indwidth"        value="0">
								<param name="fillarea"		  value="true">
								<param name="colsizing"      value="true">
								<param name="editable"        value="true">
								<param name="format"			  value="  
								<C>  Name='월일'			ID=MMDD                    Width=60 	    align=center   edit=none  mask='XX/XX'</C>
								<C>  Name='품목'         ID=TAXPDTNAM           Width=250 	align=left  	    bgcolor = yellow</C>			
								<C>  Name='규격'         ID=TAXSTD          	   Width=130	    align=left  	    edit=none</C>			  					
								<C>  Name='수량'		    ID=TAXQTY          	   Width=50 	    align=right        edit=none</C>
								<C>  Name='단가'         ID=TAXPRIC                 Width=110	    align=right	    edit=none</C>					
								<C>  Name='공급가액'  ID=TAXSUM                  Width=110  	align=right	    edit=none</C>					
								<C>  Name='부가세액'  ID=TAXVATAMT             Width=110	align=right	    edit=none</C>					
						    	 ">
					</object>
			   <%=HDConstant.COMMENT_END%>
			  <td>			   
          </tr>						
        
    </table>
    
    <%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_taxmst">
	             <param name=BindInfo    value="
					<C>Col=FDCODE           Ctrl=lc_fdcode         Param=BindColVal </C>
					<C>Col=COCODE           Ctrl=lc_cocode        Param=BindColVal </C>
					<C>Col=TAXDAT           Ctrl=vt_taxdat           Param=Text </C>
					<C>Col=TAXNBR           Ctrl=vt_taxnbr           Param=Text </C>
					<C>Col=VEND_NM          Ctrl=v_vend_nm      Param=Value </C>
					<C>Col=VEND_CD          Ctrl=v_vend_cd       Param=Value </C>
					<C>Col=VEND_ID            Ctrl=vt_vend_id       Param=Text </C>
					<C>Col=VD_DIRECT        Ctrl=v_vd_direct      Param=Value </C>
					<C>Col=ADDR                Ctrl=v_addr              Param=Value </C>
					<C>Col=TAXSUM           Ctrl=vt_xsupamt         Param=Text </C>
					<C>Col=TAXVATAMT        Ctrl=vt_vatamt            Param=Text </C>
					<C>Col=TAXTOT           Ctrl=vt_xsumamt         Param=Text </C>
					<C>Col=BSNS_CND         Ctrl=v_bsns_cnd    Param=Value </C>
					<C>Col=BSNS_KND         Ctrl=v_bsns_knd     Param=Value </C>
					<C>Col=TAXKND             Ctrl=lc_tax_knd        Param=BindColVal </C>
					<C>Col=REMARK            Ctrl=v_remark            Param=Value </C>
					<C>Col=TAXDIV              Ctrl=lc_tax_div          Param=BindColVal </C>
					<C>Col=GUBUN              Ctrl=lc_gubun          Param=BindColVal </C>
					<C>Col=TAXCDNBR         Ctrl=vt_card_num    Param=Text </C>
					<C>Col=H_ASTNBR         Ctrl=v_h_astnbr        Param=Value </C>
					<C>Col=COST_CD         Ctrl=v_cost_cd        Param=Value </C>
					<C>Col=COST_NM         Ctrl=v_cost_nm        Param=Value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 


	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		