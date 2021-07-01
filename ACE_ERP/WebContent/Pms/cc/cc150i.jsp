		<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 *****************************************************************************
 * 시스템명 	 : 홈>PMS>법인카드>전표 관리>사용 처리 ver2.0
 * 프로그램ID 	 : PMS/CC150I
 * J  S  P		 : cc150ijsp, GAUCE5.x
 * 서 블 릿		 : Cc150I
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2020-01-07
 * [ 수정일자 ][수정자] 내용
 * [2020-01-07][이동훈] 신규 개발 
 *			- 기존 법카 처리의 불편 사항을 개선하여 빠르게 처리 가능하도록 수정
 *****************************************************************************
 *****************************************************************************/
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


<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>


<script language="javascript">

	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;	//새창 띄우기용.
	

	
	/*
	 * 페이지로딩
	 */
	 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list

		fnInit();
		
	}
	
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    v_todt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    

        ds_gc_ccstat.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC010&s_item1=Y";
        ds_gc_ccstat.Reset();	//카드 처리상태 CC010 (전체+ : dsType=4) 선택:dsType=3
        
        
        ds_gc_ddyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_gc_ddyn.Reset();	//공제여부 YN (SY010)

		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc150I",
		            "JSP(O:DS_CUL=ds_cul,O:DS_CULD=ds_culd)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        
        //tr_post(tr1);
        
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	
    	v_job="S";
    	
        var v_frdate = v_frdt.Text.trim();
        var v_todate = v_todt.Text.trim();
        
        if(v_frdate.length!=8||v_todate.length!=8) {
            alert("거래일자를 입력하시길 바랍니다.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							        	+ ",v_mgr_no=" + v_mgr_no.value												//처리자 사번
										+ ",v_frdt=" + v_frdate														//조회기간
										+ ",v_todt=" + v_todate														//조회기간
										+ ",v_ccstat=" + lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)	//처리상태
										+ ",v_card_num=" + v_card_num.value											//카드번호
										;
        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc150I",
		            "JSP(O:DS_CUL=ds_cul)",
		            param);
        

        tr_post(tr1);
        
    }

    
    
    

    
    
    
    

	
	


	
	
	
	
	<%//계정과목 검색 팝%>
    function fnAtcodePopup(dirPath, row){
    	
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
    	
		sendParam[0] = ds_culd.namevalue(row, "atcodenm");		<%//검색 키워드 전달:현재 계정코드명%>
		sendParam[1] = "02";	<%//지점코드 : 서울=02%>
    	strURL = dirPath+"/Account/jsp/actcode_popup_ifrm.jsp";
    	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);

    	
    	if (arrResult != null) {
    		
    	   	//alert(arrResult);
    		arrParam = arrResult.split(";");
    		
    		if(arrParam[0]=="4402810"||arrParam[0]=="4402820"||arrParam[0]=="4331700"){	//접대비들이면
    			
    			if(ds_cul.namevalue(ds_cul.RowPosition, "AMT_TAX")>0){
    				
    				alert("접대비로 처리할 건은 부가세가 '0'이어야 합니다.\n공제여부를 체크 해제하시기 바랍니다.");
    				ds_culd.undoall();
    				msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
    				return;		
    				
    			}
    		
    			ds_culd.namevalue(row, "refcd") 	= "006";	//세목값의 코드
        		ds_culd.namevalue(row, "refcdnm") 	= "신용카드";	//세목값의 코드명
    		}
    		
    		ds_culd.namevalue(row, "ATCODE") = arrParam[0];	//계정코드
    		ds_culd.namevalue(row, "ATCODENM") = arrParam[1];	//계정명
        	ds_culd.namevalue(row, "refcd") 	= "00";	//세목값의 코드
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//세목값의 코드명
    		
        } else {
        	
        	ds_culd.namevalue(row, "ATCODE") = "";	//계정코드
        	ds_culd.namevalue(row, "ATCODENM")= "";	//계정명
        	ds_culd.namevalue(row, "refcd") 	= "00";	//세목값의 코드
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//세목값의 코드명
        	
        }       
    	
    }
    
    
    
    
    
	<%//세목-공통코드 검색 팝 20150910%>
    function fnRefcodePopup(dirPath, row){
    	
    	
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
    	var atcd, fsrefcd;
    	
    	
    	atcd = ds_culd.namevalue(row, "atcode");//해당row의 계정코드
    	
    	
    	
    	//계정코드 ↔ 세목 매핑/////////////////////////
	    	if(atcd=="4402110")	fsrefcd="1022"	;	<%//판매관리비/복리후생비 	→ 4. 복리후생비%>
	    	if(atcd=="4402120")	fsrefcd="1022"	;	<%//판매비/복리후생비     	→ 4. 복리후생비%>
	    	if(atcd=="4402130")	fsrefcd="1022"	;	<%//관리비/복리후생비 	  	→ 3. 복리후생비%>
	    	if(atcd=="4402210")	fsrefcd="1023"	;	<%//판매관리비/여비교통비 	→ 4. 여비교통비%>
	    	if(atcd=="4402220")	fsrefcd="1023"	;	<%//판매비/여비교통비     	→ 4. 여비교통비%>
	    	if(atcd=="4402230")	fsrefcd="1023"	;	<%//관리비/여비교통비 	  	→ 3. 여비교통비%>
	    	if(atcd=="4402310") fsrefcd="1024" 	; 	<%//판매관리비/교육훈련비   → 4. 교육훈련비%>
	    	if(atcd=="4402320")	fsrefcd="1024"	;	<%//판매비/교육훈련비     	→ 8. 교육훈련비%>
	    	if(atcd=="4402330")	fsrefcd="1024"	;	<%//관리비/교육훈련비 	  	→ 3. 교육훈련비%>
	    	if(atcd=="4402410")	fsrefcd="1025"	;	<%//판매관리비/통신비     	→ 4. 통신비 %>
	    	if(atcd=="4402420")	fsrefcd="1025"	;	<%//판매비/통신비         	→ 4. 통신비 %>
	    	if(atcd=="4402430")	fsrefcd="1025"	;	<%//관리비/통신비         	→ 4. 통신비 %>
	    	if(atcd=="4402510")	fsrefcd="1026"	;	<%//판매관리비/사무용품비     	→ 4. 사무용품비 %>
	    	if(atcd=="4402520")	fsrefcd="1026"	;	<%//판매비/사무용품비         	→ 4. 사무용품비 %>
	    	if(atcd=="4402530")	fsrefcd="1026"	;	<%//관리비/사무용품비         	→ 3. 사무용품비 %>
	    	if(atcd=="4402610")	fsrefcd="1027"	;	<%//판매관리비/소모품비     	→ 4. 소모품비 %>
	    	if(atcd=="4402620")	fsrefcd="1027"	;	<%//판매비/소모품비         	→ 4. 소모품비 %>
	    	if(atcd=="4402630")	fsrefcd="1027"	;	<%//관리비/소모품비         	→ 3. 소모품비 %>
	    	if(atcd=="4402710")	fsrefcd="1028"	;	<%//판매관리비/도서인쇄비     	→ 4. 도서인쇄비 %>
	    	if(atcd=="4402720")	fsrefcd="1028"	;	<%//판매비/도서인쇄비         	→ 4. 도서인쇄비 %>
	    	if(atcd=="4402730")	fsrefcd="1028"	;	<%//관리비/도서인쇄비         	→ 3. 도서인쇄비 %>
	    	if(atcd=="4403210")	fsrefcd="1029"	;	<%//판매관리비/세금과공과     	→ 4. 세금과공과 %>
	    	if(atcd=="4403220")	fsrefcd="1029"	;	<%//판매비/세금과공과         	→ 4. 세금과공과 %>
	    	if(atcd=="4403230")	fsrefcd="1029"	;	<%//관리비/세금과공과         	→ 3. 세금과공과 %>
	    	if(atcd=="4403310")	fsrefcd="1030"	;	<%//판매관리비/보험료     	→ 4. 보험료 %>
	    	if(atcd=="4403320")	fsrefcd="1030"	;	<%//판매비/보험료         	→ 4. 보험료 %>
	    	if(atcd=="4403330")	fsrefcd="1030"	;	<%//관리비/보험료         	→ 3. 보험료 %>
	    	if(atcd=="4403410")	fsrefcd="1031"	;	<%//판매관리비/수수료     	→ 4. 수수료 %>
	    	if(atcd=="4403420")	fsrefcd="1031"	;	<%//판매비/수수료         	→ 4. 수수료 %>
	    	if(atcd=="4403430")	fsrefcd="1031"	;	<%//관리비/수수료         	→ 3. 수수료 %>
	    	if(atcd=="4403510")	fsrefcd="1032"	;	<%//판매관리비/수도광열비     	→ 4. 수도광열비 %>
	    	if(atcd=="4403520")	fsrefcd="1032"	;	<%//판매비/수도광열비         	→ 4. 수도광열비 %>
	    	if(atcd=="4403530")	fsrefcd="1032"	;	<%//관리비/수도광열비         	→ 3. 수도광열비 %>
	    	if(atcd=="4403610")	fsrefcd="1033"	;	<%//판매관리비/임차사용료     	→ 4. 임차사용료 %>
	    	if(atcd=="4403620")	fsrefcd="1033"	;	<%//판매비/임차사용료         	→ 4. 임차사용료 %>
	    	if(atcd=="4403630")	fsrefcd="1033"	;	<%//관리비/임차사용료         	→ 3. 임차사용료 %>
	    	if(atcd=="4403710")	fsrefcd="1034"	;	<%//판매관리비/통관운반비     	→ 4. 통관운반비 %>
	    	if(atcd=="4403720")	fsrefcd="1034"	;	<%//판매비/통관운반비         	→ 4. 통관운반비 %>
	    	if(atcd=="4403730")	fsrefcd="1034"	;	<%//관리비/통관운반비         	→ 3. 통관운반비 %>
	    	if(atcd=="4403810")	fsrefcd="1035"	;	<%//판매관리비/수선비     	→ 4. 수선비 %>
	    	if(atcd=="4403820")	fsrefcd="1035"	;	<%//판매비/수선비         	→ 4. 수선비 %>
	    	if(atcd=="4403830")	fsrefcd="1035"	;	<%//관리비/수선비         	→ 3. 수선비 %>
	    	if(atcd=="4403910")	fsrefcd="1036"	;	<%//판매관리비/차량유지비     	→ 4. 차량유지비 %>
	    	if(atcd=="4403920")	fsrefcd="1036"	;	<%//판매비/차량유지비         	→ 4. 차량유지비 %>
	    	if(atcd=="4403930")	fsrefcd="1036"	;	<%//관리비/차량유지비         	→ 3. 차량유지비 %>
	    	if(atcd=="4404310")	fsrefcd="1039"	;	<%//판매관리비/전산비     	→ 4. 전산비 %>
	    	if(atcd=="4404320")	fsrefcd="1039"	;	<%//판매비/전산비         	→ 4. 전산비 %>
	    	if(atcd=="4404330")	fsrefcd="1039"	;	<%//관리비/전산비         	→ 3. 전산비 %>
	    	if(atcd=="4404010")	fsrefcd="1144"	;	<%//판매관리비/광고선전비     	→ 4. 광고선전비 %>
	    	if(atcd=="4404020")	fsrefcd="1144"	;	<%//판매비/광고선전비         	→ 4. 광고선전비 %>
	    	if(atcd=="4404030")	fsrefcd="1144"	;	<%//관리비/광고선전비         	→ 3. 광고선전비 %>
	    	if(atcd=="4402810")	fsrefcd="1103"	;	<%//판매관리비/접대비구분     	→ 4. 접대비구분 %>
	    	if(atcd=="4402820")	fsrefcd="1103"	;	<%//판매비/접대비구분         	→ 4. 접대비구분 %>
	    	if(atcd=="4402830")	fsrefcd="1103"	;	<%//관리비/접대비구분         	→ 3. 접대비구분 %>
	    	
	    	if(atcd=="4330900")	fsrefcd="1022"	;	<%//매출원가/복리후생비   	→ 5. 복리후생비%>
	    	if(atcd=="4331000")	fsrefcd="1023"	;	<%//매출원가/여비교통비     → 8. 여비교통비%>
	    	if(atcd=="4331100") fsrefcd="1024" 	; 	<%//매출원가/교육훈련비   	→ 5. 교육훈련비%>
	    	if(atcd=="4331200")	fsrefcd="1025"	;	<%//매출원가/통신비       	→ 5. 통신비%>
	        if(atcd=="4331300") fsrefcd="1026" 	; 	<%//매출원가/사무용품비    	→ 5. 사무용품비%>
	        if(atcd=="4331400") fsrefcd="1027" 	; 	<%//매출원가/소모품비    	→ 5. 소모품비%>
	        if(atcd=="4331600") fsrefcd="1028" 	; 	<%//매출원가/도서인쇄비    	→ 5. 도서인쇄비%>
	        if(atcd=="4332100") fsrefcd="1029" 	; 	<%//매출원가/세금과공과    	→ 5. 세금과공과%>
	        if(atcd=="4332200") fsrefcd="1030" 	; 	<%//매출원가/보험료    		→ 5. 보험료%>
	        if(atcd=="4332300") fsrefcd="1124" 	; 	<%//매출원가/수수료    		→ 5. 수수료  2017.11.13 이동훈 수정 // 관리항목 : 수수료 => 매출원가수수료%>
	        if(atcd=="4332400") fsrefcd="1032" 	; 	<%//매출원가/수도광열비    	→ 5. 수도광열비%>
	        if(atcd=="4332500") fsrefcd="1033" 	; 	<%//매출원가/임차사용료    	→ 5. 임차사용료%>
	        if(atcd=="4332600") fsrefcd="1034" 	; 	<%//매출원가/통관운반비    	→ 5. 통관운반비%>
	        if(atcd=="4332700") fsrefcd="1035" 	; 	<%//매출원가/수선비    		→ 5. 수선비%>
	        if(atcd=="4332800") fsrefcd="1036" 	; 	<%//매출원가/차량유지비    	→ 5. 차량유지비%>
	        if(atcd=="4333300") fsrefcd="1039" 	; 	<%//매출원가/전산비    		→ 5. 전산비%>
	        if(atcd=="4333100") fsrefcd="1144" 	; 	<%//매출원가/광고선전비    	→ 5. 광고선전비%>
	        if(atcd=="4331700") fsrefcd="1103" 	; 	<%//매출원가/접대비    	→ 5. 접대비구분%>
    	//계정코드 ↔ 세목 매핑/////////////////////////    	
      
		sendParam[0] = fsrefcd;
		sendParam[1] = ds_culd.namevalue(row, "refcdnm");<%//검색 키워드 전달:현재 세목명%>
		strURL = dirPath+"/Account/jsp/commdtil_popup_ifrm.jsp";
    	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);
    	
    	
	   	//alert(arrResult);	//01;중식.야근식대; ;01
	   	
	   	
	   	if (arrResult != null) {
	   		
    		arrParam = arrResult.split(";");
    		ds_culd.namevalue(row, "refcd") 	= arrParam[0];	//세목값의 코드
    		ds_culd.namevalue(row, "refcdnm") 	= arrParam[1];	//세목값의 코드명
    		
        } else {
        	
        	ds_culd.namevalue(row, "refcd") 	= "00";	//세목값의 코드
    		ds_culd.namevalue(row, "refcdnm") 	= "";	//세목값의 코드명
    		
        }               
	   	
    }

    
    
    
    
    
	<%//귀속정보 검색 팝%>
    function fnPldeptPopup(dirPath, row){
    	
    	
    	
    	var sendParam	= new Array();
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
    	
    	
    	
		sendParam[0] = ds_culd.namevalue(row, "pl_dept_nm");	<%//검색 키워드 전달:현재 귀속코드명%>
    	strURL = dirPath+"/Pms/help/cc110h_01.jsp";
    	strPos = "dialogWidth:490px;dialogHeight:339px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,sendParam,strPos);

    	
    	
    	
    	if (arrResult != null) {
    		
    	   	//alert(arrResult);
    		arrParam = arrResult.split(";");
    		ds_culd.namevalue(row, "PL_DEPT_DIV") = arrParam[0];	//귀속코드 구분
    		ds_culd.namevalue(row, "PL_DEPT") = arrParam[1];	//귀속코드
    		ds_culd.namevalue(row, "PL_DEPT_NM") = arrParam[2];	//귀속코드명
    		
    		
        } else {
        	
        	
        	
        	ds_culd.namevalue(row, "PL_DEPT_DIV") = "";	//귀속코드 구분
        	ds_culd.namevalue(row, "PL_DEPT") = "";	//귀속코드
        	ds_culd.namevalue(row, "PL_DEPT_NM")= "";	//귀속코드명
        	
        }               
    	
    }
    
    
    
    <%// 신규거래처 등록 : 팝%>
    function fnVendNew(Row){
    	
		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		
		sendParam[0] = ds_cul.namevalue(Row, "VENDOR_TAX_NUM"); <%//등록 키워드 전달:사업자번호%>
		sendParam[1] = ds_cul.namevalue(Row, "VENDOR_NAME"); <%//등록 키워드 전달:가맹점명%>
		sendParam[2] = ds_cul.namevalue(Row, "VENDOR_PERSON"); <%//등록 키워드 전달:대표자%>
		sendParam[3] = ds_cul.namevalue(Row, "VENDOR_TEL"); <%//등록 키워드 전달:전화%>
		sendParam[4] = ds_cul.namevalue(Row, "VENDOR_ADDRESS1"); <%//등록 키워드 전달:주소%>
		sendParam[5] = ds_cul.namevalue(Row, "COCOMYN"); <%//등록 키워드 전달: 거래처 등록요청 상태%>
		
		strURL = "<%=dirPath%>/Pms/help/cc110h_02.jsp";
		strPos = "dialogWidth:340px;dialogHeight:530px;status:no;scroll:no;resizable:no";
		
		//alert(sendParam);
		
		arrResult = showModalDialog(strURL,sendParam,strPos);

		var row = ds_cul.RowPosition;		
		
		fnSelect();
		
		//2019.12.11 김철민 과장 요청으로 이동훈 수정 
		ds_cul.RowPosition = row;		
		
		
		
		
	}
    
    
    
    
    <%// 매입 계산서정보 : 팝%>
    function fnTaxPopup(Row){
    	
		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		
		sendParam[0] = ds_cul.namevalue(Row, "TAXNBR").substring(0,1);   //매입매출구분 (A-매입, B-매출)
		sendParam[1] = "02";                          //지점코드
		sendParam[2] = ds_cul.namevalue(Row, "TAXNBR").substring(1,11);  //접수번호
		sendParam[3] = "";   //전표행번호
		sendParam[4] = "";   //거래처코드
		sendParam[5] = "";   //거래처명
		sendParam[6] = "103";  //증빙명
		sendParam[7] = ds_cul.namevalue(Row, "TAXNBR");	//계산서번호
		
		strURL = "<%=dirPath%>/Account/jsp/a040110_view_popup.jsp";
		strPos = "dialogWidth:970px;dialogHeight:435px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,sendParam,strPos);
		
	}

    
    
    


    <%// 개인사용 버튼: 해당 사용 건은 개인사용으로 변경 %>
    function fnUsePrivate(){
    	
    	if(ds_cul.RowPosition>0){
    		
    		if(ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="01"||ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="03"){  //미처리 상태 or 개인사용상태
    			
    	    	v_job="UP"; //개인사용
    	    	
    			ln_TRSetting(tr1, 
    					"<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
    					"JSP(I:DS_CUL_USE=ds_cul)",
    					"proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
    					+ ",v_acquire_sid="+ ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID")	
    					);
    	    	
    			tr_post(tr1);
    		
    		}else{
    			
        		alert("미처리, 개인사용 상태의 사용 건만 변경할 수 있습니다.")
        		
        	}
    		
    	}else{
    		
    		alert("선택된 카드사용 건이 없습니다.");
    		
    	}
    	
    }

    
    
    

    

	<%//저장 %>
	function fnApply(){
		
		v_job = "A";
		
		//v_default_row = ds_culd.RowPosition;
		
		if (ds_culd.IsUpdated||ds_cul.IsUpdated) {
			
			if(ln_Chk()){
		
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc150I",
					              "JSP(I:DS_CUL=ds_cul)",
					              "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                			);

        		tr_post(tr1);
        		
        	}
			
		}else {
			
     		alert("업데이트된 행이 없습니다.");
     		
	 	}
		
	}
	
	
	
	<%// 저장시 입력값 체크 %>
	function ln_Chk() {
		
		var row1=ds_culd.countrow;
		
		var totAmt = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET") + ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC")	//처리 대상 금액
		var subAmt = 0;
		var amt_total = ds_cul.namevalue(ds_cul.RowPosition,"AMT_TOTAL");//이용금액
		var amt_use	  = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC");
		
		
		if(amt_total!=amt_use){//금액이 일치하지 않을 때
			
			alert("이용금액과 (공급가액+부가세+봉사료)가 일치하지 않습니다.\n\n다시 확인해 주십시오.");
		
			return;				
			
		}
		

		
		
		//마스터 그리드 체크		
		if(ds_cul.namevalue(ds_cul.RowPosition,"ADDR1")=="미등록 거래처"&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			
			alert("미등록 거래처는 공제여부를 체크할 수 없습니다.\n\n다시 확인해 주십시오.");
			return;				
			
		}
		
		
		
		/* 2018.02.13 김인호 과장 요청으로 이동훈 수정 */
		if(ds_cul.namevalue(ds_cul.RowPosition,"COCOMYN")=="T"&&ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")!=0){
			
			alert("간이과세 업체일 경우 부가세를 0으로 만들어주시기 바랍니다.");
			return;				
			
		}			
		
		
		
		
		if(ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")==0&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			alert("부가세가 ' 0 원' 이면 공제여부를 체크할 수 없습니다.\n\n다시 확인해 주십시오.");
			return;				
		}
		

		
		
		for(i=1;i<=row1;i++) {//계정|귀속정보 체크
			
			
			
			if(ds_culd.namevalue(i,"GROUP_NM")==""){
				alert("계정정보의 처리그룹명이 입력되지 않았습니다.");
				return;				
			}

		
		
			//특수기호
			var matching = 	ds_culd.namevalue(i,"GROUP_NM");
			
			if(matching.match(',')){
				alert("처리 그룹명에 들어 있는 콤마는 빼시기 바랍니다");
				return;	
			}
			
			

		
			if(ds_culd.namevalue(i,"PL_DEPT")==""){
				alert("계정정보의 귀속정보가 정상적으로 입력되지 않았습니다.\n\n검색 창을 이용해 다시 입력해 주십시오.");
				return;				
			}

			
			
			if(ds_culd.namevalue(i,"ATCODE")==""){
				alert("계정정보의 계정명이 정상적으로 입력되지 않았습니다.\n\n검색 창을 이용해 다시 입력해 주십시오.");
				return;				
			}			

			
			
			if(ds_culd.namevalue(i,"REMARK")==""){
				alert("계정정보의 적요가 입력되지 않았습니다.\n\n다시 확인해 주십시오.");
				return;				
			}
			
			
			
			if(ds_culd.namevalue(i,"FSAMT")==0){
				alert("계정정보의 공급가액이 0 입니다.\n\n다시 확인해 주십시오.");
				return;				
			}
			
			subAmt += ds_culd.namevalue(i,"FSAMT");//공급가액의 합과  불일치 체크
			
			
		}
		
		if(row1>0&&totAmt!=subAmt) {
			
			alert("계정정보의 공급가액 합("+subAmt+")이 부가세를 제외한 카드사용 금액("+totAmt+")과 일치하지 않습니다.");
			
			return;
			
		}


		if(ds_culd.namevalue(1,"GROUP_NM") != undefined) {


		
		}
		

		
		
		return true;
		
	}    

	
	
	

	
	
	
	
	<%// 카드번호 검색조건 초기화 %>
	
	function fnCardNoCleanup(){
		
    	v_card_num.value = "";
    	
    }

	
	

	
	
	
    <%//직원 팝- 검색조건 처리자 : 관리자만 가능하게%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    		
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
    		
        } else {
        	
			fnEmpNoCleanup();
			
        }               
    	
    }

    
    
    function fnEmpNoCleanup(){
    	
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
        
    }


    
    
    
	<%//액셀 다운하기%>
    function fnExcel() {
    	
        if(ds_cul.CountRow==0){
        	
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
            
        }
        
        getObjectFirst("gr_cul").SetExcelTitle(0, "");
        
        getObjectFirst("gr_cul").SetExcelTitle(1, "value:카드사용현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        
        getObjectFirst("gr_cul").GridToExcel("카드사용현황", "카드사용현황.xls", 50);        
        
    }    
    
    
    
    </script>
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_frdt event=onKeyDown(kcode,scode)>
		if (kcode == 13) 
			fnSelect();
	</script>

	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_todt event=onKeyDown(kcode,scode)>
		if (kcode == 13) 
			fnSelect();
	</script>


	<%//마스터 그리드 OnClick : 계정|귀속정보 조회 %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
	
		v_job="SD";
		
	    if(Row==0) return;
	    
	    if(v_default_row==Row){
	    	
			return;
			
		}else{
			

			
	    }
	    
	</script>
	
	
	<%//마스터 그리드 OnDblClick : 거래처 등록 요청 팝%>
	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
	
		if(Colid=="VEND_NM"&&ds_cul.NameValue(Row, "VEND_NM")==""){
			
			fnVendNew(Row);			
			
		}
		
		
		if(Colid=="TAXYN"&&ds_cul.NameValue(Row, "TAXYN")=="T"){
			
			fnTaxPopup(Row);
			
		}
		
	</script>



	<%//마스터 그리드 / 공제여부 OnCheckClick %>
	<script language="javascript"  for=gr_cul event=OnCheckClick(Row,Colid,Check)>
	
    	<%	// 공제여부 체크시 세액 자동계산
			// 미처리 상태 + 일반과세 인 것만 작동함 %>


		if(ds_cul.namevalue(Row,"STAT")=="01"){
			
			if(Check=="1"){	//AMT_TAX_BC 컬럼으로 재설정:20151215
				ds_cul.namevalue(Row,"AMT_TAX") = ds_cul.namevalue(Row,"AMT_TAX_BC") ;
				ds_cul.namevalue(Row,"AMT_NET") = ds_cul.namevalue(Row,"AMT_TOTAL") - ds_cul.namevalue(Row,"AMT_TAX_BC");
				
			}else{
				
				ds_cul.namevalue(Row,"AMT_NET") = ds_cul.namevalue(Row,"AMT_TOTAL");
				ds_cul.namevalue(Row,"AMT_TAX") = 0;
				ds_cul.namevalue(Row,"AMT_SVC") = 0;
			}
			
		}else{
			
			//alert("공제여부를 변경하려면, [일반]과세 거래처이고,\n처리상태가 [미처리]여야 합니다.")
			alert("공제여부를 변경하려면, 처리상태가 [미처리]여야 합니다.");
			
			ds_cul.namevalue(Row,"DDYN") = "F";
			
		}
		
		
		/*		
			BOOL check : Click한 CheckBox의 체크된 상태(1 : 체크된 상태, 0 : 체크해제된 상태)
	    	컬럼값은 T,F로 작동 T=체크상태
		*/
		
	</script>
	
	
	
	
	<%//마스터 그리드 / 공제여부 OnCheckClick %>
	<script language="javascript"  for=gr_cul event=CanColumnPosChange(Row,Colid)>
	
		var amt_total = ds_cul.namevalue(Row,"AMT_TOTAL");
		
		var amt_use	  = ds_cul.namevalue(Row,"AMT_NET")+ds_cul.namevalue(Row,"AMT_TAX")+ds_cul.namevalue(Row,"AMT_SVC");
		
	</script>









<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"||v_job=="UP"||v_job=="AT"){
		
		alert("성공적으로 저장되었습니다.");

		var row = ds_cul.RowPosition;

		fnSelect(); // 디테일들 조회하기
			
		ds_cul.RowPosition = row;

	}
	
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    <script language="JavaScript"  for="ds_cul" event="OnLoadStarted()" >
    
        msgTxt.innerHTML="데이타 조회중입니다. 잠시만 기다려 주십시오.";
        
    </script>
 
 
    <script language=JavaScript  for=ds_cul event="OnLoadCompleted(row)">
    
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        
		if(v_job=="S"){
			
			if(row==0){
				
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
		        
			}else{

				
			}
			
		}
		
	</script>
    	
    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="true"/>
</object>


<object id=ds_culd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_gc_ccstat	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_gc_ddyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>


<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='1500px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"			style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"  		style="cursor:pointer" 	onclick="fnExcel()">							
							<img src="<%=dirPath%>/Sales/images/use_private.gif" 	style="cursor:pointer" onClick="fnUsePrivate();">
							<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:pointer" onClick="fnApply();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td>
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1500px'>
           			<tr>
                        <td align="center" class="text" width="50">처리자</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        <input type="text" name='v_mgr_no' id="v_mgr_no" style="width:50px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrid")%>">
                        
                        <input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:50px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrnm")%>">
                        	<%=(String)session.getAttribute("vdeptnm")%>(<%=(String)session.getAttribute("vdeptcd")%>)
                        	<% if("CC20".equals((String)session.getAttribute("vdeptcd"))){%>
                        	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" 	onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" 	onclick="fnEmpNoCleanup();" alt="값 지우기">
                            <%}%>
                        </td>

                        <td align="center" class="text" width="60">거래일자</td>
                        <td bgcolor="#FFFFFF" >
                            <object id=v_frdt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=VAlign	    			value=1>
                                <param name=Format      			value="YYYY-MM-DD">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <img src="<%=dirPath%>/Common/img/btn_calendar.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('v_frdt', 'Text')" style="position:relative;width:20px;left:0px;top:0px;cursor:hand;">
                            &nbsp;~&nbsp;
                            
                            <object id=v_todt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=VAlign	    			value=1>
                                <param name=Format      			value="YYYY-MM-DD">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>    
                            <img src="<%=dirPath%>/Common/img/btn_calendar.gif" value="com_btn_calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('v_todt', 'Text')" style="position:relative;width:20px;left:00px;top:0px;cursor:hand;">
                  
                        </td>
                        
                        <td align="left" class="text" width="60">처리 상태</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_ccstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     		value=ds_gc_ccstat>
								<param name=BindColumn      		value="detail">
								<param name=BindColVal      		value="detail">
								<param name=EditExprFormat  		value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  		value="detail_nm^0^80">
                            </object>                     
                        </td>                                

                        <td align="center" class="text" width="60">카드번호</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="값 지우기">
                        </td>

					</tr>
           		</table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top">

                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1500px' height='600px' border='1'>
                    <param name="DataID"            value="ds_cul">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"       	value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="ViewSummary"       value="1">
                    <Param Name="SortView"     		value="Right">
                    <Param Name="UsingOneClick"     value="1">
   					<param name="ColSelect"    		value="True">																								                                        
					<param name="SelectionColor"    value="
						<SC>Type='FocusEditCol', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', 		BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', 		BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', 			BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', 			BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', 	BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', 			BgColor='#D1DEF0', TextColor='Black'</SC>
					">
                    <param name="Format"            value="
						<FC> name='No'			 		ID='{CurRow}'		 	width=25 	align=CENTER 	HeadBgColor='#5C7CAC' edit=none sumtext=@cnt </FC>
                        <FC> name='처리자'		 		ID='MGR_NM'   		 	width=50 	align=CENTER  	edit=none show=false</FC>
                        <FC> name='매입SId'		 		ID='ACQUIRE_SID'	 	width=50 	align=left 		show=false</FC>
                        
                        <FC> name='프로젝트코드'		ID='PROJECT'	 		width=100 	align=left 		HeadBgColor='#5C7CAC' EditStyle=Popup</FC>
                        <FC> name='계정코드'			ID='ACCOUNT'	 		width=150 	align=left 		HeadBgColor='#5C7CAC' EditStyle=Combo, Data='1:매출원가/행사진행비,2:매출원가/여비교통비,3:매출원가/관광객숙식비,4:매출원가/접대비'</FC>
                        <FC> name='적요'				ID='REMARK'	 			width=150 	align=left 		HeadBgColor='#5C7CAC' Edit=true</FC>               	
                        	
                        	
                        <FC> name='카드\\보유자' 		ID='EMP_NM'   		 	width=50 	align=CENTER 	HeadBgColor='#5C7CAC' edit=none bgColor={IF(EMP_NM='미등록','#ffcccc','#FFFFFF') } sumtext='건' </FC>
                        <FC> name='카드번호'	 		ID='CARD_NUM'  	 	 	width=125 	align=CENTER	HeadBgColor='#5C7CAC' edit=none mask='XXXX-XXXX-XXXX-XXXX' sort=true </FC>
					  
					  <G> name='거래처 정보 (ERP)' 		 
                        <C> name='상호'					ID='VEND_NM'   		 	width=150 	align=left		edit=none sort=true bgColor={IF(ADDR1='미등록 거래처','#ff3300','#FFFFFF') }  value={IF(ADDR1='미등록 거래처','미등록거래처',VEND_NM)}</C>
                        <C> name='주소'					ID='ADDR1'   		 	width=80 	align=left		edit=none bgColor={IF(ADDR1='미등록 거래처','#ff3300','#FFFFFF') } show=false</C>
                        <C> name='과세'					ID='COCOMYN_NM'   	 	width=70 	align=CENTER	edit=none bgColor={IF(COCOMYN_NM='간이과세','#CCFFCC','#FFFFFF') } sort=true</C>
                      </G>
                      
                      <G> name='이용정보'
                        <C> name='일자'					ID='APPROVE_DATE'	 	width=80 	align=CENTER 	edit=none    mask='XXXX-XX-XX' sort=true</C>
                        <C> name='시각'					ID='APPROVE_TIME'	 	width=40 	align=CENTER 	edit=none 	 mask='XX:XX'</C>                        
                        <C> name='금액'     			ID='AMT_TOTAL'			width=70 	align=right		Edit=NONE	 decao=0  sort=true  sumtext=@sum </C>
                      </G>
                      
                        <C> name='공급가액'     		ID='AMT_NET'			width=70 	align=right		Edit=true	 decao=0   sumtext=@sum		sort=true</C>
                        <C> name='부가세'    			ID='AMT_TAX'			width=60 	align=right		Edit=true	 decao=0   sumtext=@sum		</C>
                        <C> name='봉사료\\(면세액)'    	ID='AMT_SVC'			width=60 	align=right		Edit=true	 decao=0   sumtext=@sum		</C>
						<C> name='처리\\상태'   		ID='STAT'   			width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_ccstat:detail:detail_nm' SumText={sum(AMT_NET)+sum(AMT_TAX)+sum(AMT_SVC)} SumTextColor='#ff0000' </C>
						<C> name='공제\\여부'			ID='DDYN'   			width=30 	align=CENTER	edit=true editstyle=CheckBox  bgColor={IF(DDYN='T','#CCFFCC','#FFFFFF') } </C>
						<C> name='매입\\생성'			ID='TAXYN'   			width=30 	align=CENTER	edit=none editstyle=CheckBox  bgColor={IF(TAXYN='T','#CCFFCC','#FFFFFF') } </C>
						<C> name='통화'					ID='CURRENCY'   	 	width=40 	align=CENTER  	edit=none show=false</C>
					  
					  <G> name='가맹점 정보'
						<C> name='사업자번호'			ID='VENDOR_TAX_NUM'  	width=80 	align=left		edit=none mask='XXX-XX-XXXXX'</C>
						<C> name='가맹점명'				ID='VENDOR_NAME'	 	width=200 	align=left		edit=none </C>
						<C> name='대표자' 				ID='VENDOR_PERSON'   	width=60 	align=center 	edit=none </C>
						<C> name='전화'					ID='VENDOR_TEL'   		width=100 	align=left		edit=none </C>
						<C> name='주소'					ID='VENDOR_ADDRESS1'   	width=250 	align=left		edit=none </C>
					  </G>
					  
					    <C> name='BC\\부가세'    		ID='AMT_TAX_BC'			width=50 	align=right		edit=none	 decao=0   </C>
                 ">                             
                </object>                        
            </td>
        </tr>
        

        <tr>
            <td valign="top"><br>

            </td>
        </tr>

    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		