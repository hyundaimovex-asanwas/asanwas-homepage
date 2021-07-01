<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>법인카드>전표 관리>사용 처리
 * 프로그램ID 	 : PMS/CC110I
 * J  S  P		 : cc110ijsp, GAUCE5.x
 * 서 블 릿		 : Cc110I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-08-21
 * [ 수정일자 ][수정자] 내용
 * [2015-07-30][심동현] 신규 개발 
 *						- 재무팀 관리자용, 전체 카드 사용현황 조회
 *							진행상황 : 작성중 → 현장결재진행중 → 현장결재완료
 * [2015-08-04][심동현] 팀 처리자용
 * [2015-08-25][심동현]	계정정보 저장시 매입건(TCC110)의 상태 [처리]로 업데이트	完
 *                      완전 삭제시 매입건(TCC110)의 상태 [미처리]로 업데이트	完
 * [2015-08-26][심동현] 거래처 등록 요청으로 연결하기 필요~! ()
 * [2015-08-26][심동현] 6월 재경부 전체 카드 건수 43건으로 전표 생성 테스트~ 전표의 대상은 27건 1,245,350원
 *						계정정보 보관 기능 추가 完
 *						to-do
 *							부가세:신용카드(공제) 정보의 처리 : 회의 후 프로세스 변경하기로
 *							전표 증빙 자료(승인내역) 뽑기
 * [2015-09-01][심동현] 재경부 미팅 : 김양묵, 김효중, 봉균일, 이예빈, 정영식 : 진행상황 공유 및 방향 정리
 *						홈>PMS>법인카드>전표 관리>전표 발행						
 *						√	세목 기본값은 비워두고 저장시 체크해주기
 *						√	공제 Y인 것만 부가세 처리
 *						홈>PMS>법인카드>전표 관리>사용 처리
 *							공제여부 수정 가능하도록 : 기본은 N, 부가세 있으면 Y
 *								부가세가 0이라도 일반 과세 거래처면 입력 가능하도록 (Y)
 *								Y로 하는 거래처는 모두 거래처 등록+일반N(과세) 되어야 함
 *								마트 : 부가세0으로 날아옴. 영수증 보고 강제 입력 처리
 *  권부장님께, 설명자료 보고 + 모두 발언 협조 : 법카 처리 프로세스 변경, 부가세 기준 변경, 실무자 협조 당부
 *			기+티
 * [2015-09-01][심동현] 프로세스 정리 및 수정내역
 *						√ 1. [개인사용] 버튼 추가 : [미처리]인 것만 개인사용으로 변환 가능
 *						2. 거래처 등록요청
 *						√ 3. 공제여부 일괄 처리 : javascript
 *							등록된 거래처 && 일반(과세) && 세금 > 0 && [미처리]]상태만 → 공제여부 Y
 *							PMS.TCC110으로 EDI입력시 공제여부='F' 기본이므로.. 
 *							화면 조회 후 [버튼] 클릭시 수정 script 루프 ok
 *						√ 4. 세금 및 공제여부 체크 : javascript 먼저 공급가액을 나누고 계정|귀속으로 넘어가야 함
 *						√ 5. 공급가액, 세금, 봉사료(면세액) 직접 입력 (마트 등) 처리 + 금액 체크
 *							이 단계에서 마스터 그리드 저장하고 (공급가액, 부가세 봉사료, 공제여부 컬럼만. 처리상태는 여기서 하는게 아님여~~!) 
 *						√ 6. 거래내역 저장
 *						√ 7. 계정|귀속정보 저장
 * [2015-09-03][심동현] √계정귀속 행추가시 접대비는 부가세 있으면 안되게
 *						√ 일괄매입 버튼 추가
 *						계산서정보 팝 만들기
 * [2015-09-10][심동현] 9.9 1차 설명회 후 피드백 반영
 *						미처리 ↔ 개인사용 상호 업데이트
 *						매입생성 조건 : 처리 → 적요, 귀속코드 전달
 * [2015-11-23][심동현] 계정|귀속정보에 세목 추가 - 저장, 임시 정보에 세목 처리 완료
 * [2015-11-24][심동현] 세목코드 값까지 TCC120에서 PK로 잡아야 할 듯. 기본값 00으로..
 *						TCC120_PK = (ACQUIRE_SID, PL_DEPT, ATCODE, REFCD)
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

<!-- HTML 시작 : doctype를 html5로 해볼까? 훔;;-->
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
		cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail

		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    v_todt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    //v_todt.Text = "20150630";
	    //v_frdt.Text = "20150601";
	    

        ds_gc_ccstat.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC010&s_item1=Y";
        ds_gc_ccstat.Reset();	//카드 처리상태 CC010 (전체+ : dsType=4) 선택:dsType=3
        ds_gc_ddyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_gc_ddyn.Reset();	//공제여부 YN (SY010)

		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CUL=ds_cul,O:DS_CULD=ds_culd)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        fnSelect();
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
        	+ ",v_mgr_no=" + v_mgr_no.value	//처리자 사번
			+ ",v_frdt=" + v_frdate	//조회기간
			+ ",v_todt=" + v_todate	//조회기간
			+ ",v_ccstat=" + lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)	//처리상태
			+ ",v_card_num=" + v_card_num.value	//카드번호
			+ ",v_acquire_sid="
			;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CUL=ds_cul)",
            param);
        tr_post(tr1);
    }

    
    <%// 디테일 계정정보 %>
    function fnSelectDetail(row) {
    	if(row>ds_cul.countrow){	//앞에서 받은 row가 ds_cul보다 크면, 즉 새로운 조건으로 ds_cul을 조회할 때
    		row = 1;	//오류 방지용 처리
    	}
        v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
        tr_post(tr2);
    }
    
    <%//디테일 계정정보 행추가 %>
	function fnAddRowDt1(){
		if(ds_cul.RowPosition>0){
			//계정정보의 총 공급가액 = 거래 건의 공급가액 + 봉사료
			var totAmt = ds_cul.namevalue(ds_cul.RowPosition,"AMT_NET")+ds_cul.namevalue(ds_cul.RowPosition,"AMT_SVC")
			var subAmt = 0;
			if(ds_culd.RowPosition==0){//계정정보가 없을 때
				subAmt = 0;
			}else{
				for(i=1;i<=ds_culd.countrow;i++) {
					subAmt += ds_culd.namevalue(i,"FSAMT");	
				}			
			}
			ds_culd.addrow();
			ds_culd.namevalue(ds_culd.RowPosition, "acquire_sid") 	= ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID");	
			ds_culd.namevalue(ds_culd.RowPosition, "FSAMT") 		= totAmt - subAmt;
			//ds_culd.namevalue(ds_culd.RowPosition,"REFCDNM")		= "세목";
			ds_culd.namevalue(ds_culd.RowPosition,"REFCD")			= "00";
			if(v_memory_chk.checked){//체크면. 1행의 값만 복사해서 보관
				ds_culd.namevalue(ds_culd.RowPosition,"GROUP_NM")		= v_groupnm.value; 
				ds_culd.namevalue(ds_culd.RowPosition,"ATCODENM")		= v_atcodenm.value; 
				ds_culd.namevalue(ds_culd.RowPosition,"ATCODE")			= v_atcode.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REMARK")			= v_remark.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT_NM")		= v_pl_dept_nm.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT")		= v_pl_dept.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"PL_DEPT_DIV")	= v_pl_dept_div.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REFCDNM")		= v_refcdnm.value ;
				ds_culd.namevalue(ds_culd.RowPosition,"REFCD")			= v_refcd.value ;
				
			}
			msgTxt.innerHTML="[계정정보] 행이 추가되었습니다.";
			gr_culd.Focus();//행추가 후 그리드로 포커스
		}else{
			alert("카드 매입 건을 선택하셔야 계정정보를 추가할 수 있습니다.");
		}
    }
    <%//디테일 계정정보 행삭제 %>
	function fnDelRowDt1(){
		ds_culd.DeleteRow(ds_culd.RowPosition);
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
    		if(arrParam[0]=="4402810"||arrParam[0]=="4402820"||arrParam[0]=="4331700"){//접대비들이면
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
		fnSelect();
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
    		if(ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="01"||ds_cul.namevalue(ds_cul.RowPosition,"STAT")=="03"){//미처리 상태or개인사용상태
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

	<%// 일괄공제 버튼 - 등록된 거래처 && 일반 && 세금 > 0 && [미처리] → 공제여부 Y   %>
    function fnSettle(){
		for(var i=1;i<=ds_cul.countrow;i++){
			if(ds_cul.namevalue(i,"COCOMYN")=="N"){	//등록된 거래처 && 일반(N)
				if(ds_cul.namevalue(i,"AMT_TAX")>0){	//세금 > 0
					if(ds_cul.namevalue(i,"STAT")=="01"){//미처리
						ds_cul.namevalue(i,"DDYN") = "T"; //공제여부 T로 변환						
					}
				}
			}
    	}
	}
    <%// 일괄매입 버튼 - 공제T인 건들 모두  %>
    function fnTaxCreate(){
    	//alert("일괄매입");
    	//그리드의 값을 미리 변경해주고
		for(var i=1;i<=ds_cul.countrow;i++){
			
			//alert(ds_cul.namevalue(i,"TAXYN"));
			if(ds_cul.namevalue(i,"STAT")=="02"&&ds_cul.namevalue(i,"DDYN")=="T"&&ds_cul.namevalue(i,"TAXYN")=="F"){	//공제 TRUE이면서 매입정보 없는 것들
				ds_cul.namevalue(i,"TAXYN") = "T"; //매입생성 T로 변경 후 전송						
			}
    	}


    	//저장전송
		if (ds_cul.IsUpdated) {
			v_job=="AT";

			ln_TRSetting(tr1, 
	        	"<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
	            "JSP(I:DS_CULT=ds_cul)",
	            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	            		+ ",v_mgr_no=" + v_mgr_no.value	//처리자 사번
	            		+ ",v_mgr_deptcd=<%=(String)session.getAttribute("vdeptcd")%>"	//처리자 팀(ERP 로긴상 부서)
	            );

	        tr_post(tr1);
		}
    }    

    

	<%//저장 %>
	function fnApply(){
		v_job = "A";
		//v_default_row = ds_culd.RowPosition;
		
		if (ds_culd.IsUpdated||ds_cul.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
                "JSP(I:DS_CUL=ds_cul, I:DS_CULD=ds_culd)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	+ ",v_acquire_sid="+ ds_cul.namevalue(ds_cul.RowPosition,"ACQUIRE_SID")	
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
			alert("이용금액과 (공급가액+부가세+봉사료)가 일치하지 않습니다.\n다시 확인해 주십시오.");
			return;				
		}
		
		
		//prompt(this, ds_cul.text);
		
		
		
		//마스터 그리드 체크		
		if(ds_cul.namevalue(ds_cul.RowPosition,"ADDR1")=="미등록 거래처"&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			alert("미등록 거래처는 공제여부를 체크할 수 없습니다.\n다시 확인해 주십시오.");
			return;				
		}
		
		/* 2018.02.13 김인호 과장 요청으로 이동훈 수정 */
		if(ds_cul.namevalue(ds_cul.RowPosition,"COCOMYN")=="T"&&ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")!=0){
			alert("간이과세 업체일 경우 부가세를 0으로 만들어주시기 바랍니다.");
			return;				
		}			
		
		
		if(ds_cul.namevalue(ds_cul.RowPosition,"AMT_TAX")==0&&ds_cul.namevalue(ds_cul.RowPosition,"DDYN")=="T"){
			alert("부가세가 ' 0 원' 이면 공제여부를 체크할 수 없습니다.\n다시 확인해 주십시오.");
			return;				
		}
		
	
		
		
		
		for(i=1;i<=row1;i++) {//계정|귀속정보 체크
			if(ds_culd.namevalue(i,"GROUP_NM")==""){
				alert("계정정보의 처리그룹명이 입력되지 않았습니다.");
				return;				
			}

			if(ds_culd.namevalue(i,"PL_DEPT")==""){
				alert("계정정보의 귀속정보가 정상적으로 입력되지 않았습니다.\n검색 창을 이용해 다시 입력해 주십시오.");
				return;				
			}

			if(ds_culd.namevalue(i,"ATCODE")==""){
				alert("계정정보의 계정명이 정상적으로 입력되지 않았습니다.\n검색 창을 이용해 다시 입력해 주십시오.");
				return;				
			}			

			if(ds_culd.namevalue(i,"REMARK")==""){
				alert("계정정보의 적요가 입력되지 않았습니다. 다시 확인해 주십시오.");
				return;				
			}
			
			if(ds_culd.namevalue(i,"FSAMT")==0){
				alert("계정정보의 공급가액이 0 입니다. 다시 확인해 주십시오.");
				return;				
			}
			
			subAmt += ds_culd.namevalue(i,"FSAMT");//공급가액의 합과  불일치 체크
		}
		
		if(row1>0&&totAmt!=subAmt) {
			alert("계정정보의 공급가액 합("+subAmt+")이 부가세를 제외한 카드사용 금액("+totAmt+")과 일치하지 않습니다.");
			return;
		}
		
		
		if(v_memory_chk.checked){//체크면. 1행의 값만 복사해서 보관
			v_groupnm.value 	= ds_culd.namevalue(1,"GROUP_NM");
			v_atcodenm.value 	= ds_culd.namevalue(1,"ATCODENM");
			v_atcode.value 		= ds_culd.namevalue(1,"ATCODE");
			v_remark.value 		= ds_culd.namevalue(1,"REMARK");
			v_pl_dept_nm.value 	= ds_culd.namevalue(1,"PL_DEPT_NM");
			v_pl_dept.value 	= ds_culd.namevalue(1,"PL_DEPT");
			v_pl_dept_div.value = ds_culd.namevalue(1,"PL_DEPT_DIV");
			v_refcdnm.value 	= ds_culd.namevalue(1,"REFCDNM");
			v_refcd.value 		= ds_culd.namevalue(1,"REFCD");
		}
		return true;
	}    

	
	function fnCancel() {
		ds_cul.undoall();
		ds_culd.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
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


    <%//전표 발행 클릭시%>
    function fnStateCreate(){
    	
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		

    	
		strURL = "<%=dirPath%>/Pms/new/sta/sta210.jsp";
		
    	strPos = "dialogWidth:1050px;dialogHeight:800px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		

    		
        } else {
        	

			
        }    
        
        
    }
    
    
    
    
    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_todt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>

	<%//마스터 그리드 OnClick : 계정|귀속정보 조회 %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectDetail(Row);
	    }
	</script>
	
	<%//마스터 그리드 OnDblClick : 거래처 등록 요청 팝%>
	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
		if(Colid=="ADDR1"&&ds_cul.NameValue(Row, "VEND_NM")==""){
			fnVendNew(Row);			
		}
		if(Colid=="TAXYN"&&ds_cul.NameValue(Row, "TAXYN")=="T"){
			fnTaxPopup(Row);
		}
	</script>

	<%//마스터 그리드 / 공제여부 OnCheckClick %>
	<script language="javascript"  for=gr_cul event=OnCheckClick(Row,Colid,Check)>
    	<%	// 공제여부 체크시 세액 자동계산
			//		미처리 상태 + 일반과세 인 것만 작동함 %>
		//if(ds_cul.namevalue(Row,"STAT")=="01"&&ds_cul.namevalue(Row,"COCOMYN")=="N"){
			//alert(Check);
			//alert(ds_cul.namevalue(Row,"AMT_TAX_BC"));
		if(ds_cul.namevalue(Row,"STAT")=="01"){
			if(Check=="1"){	//AMT_TAX_BC 컬럼으로 재설정:20151215
				//ds_cul.namevalue(Row,"AMT_TAX") = ds_cul.namevalue(Row,"AMT_TAX_BC") ;
				//ds_cul.namevalue(Row,"AMT_NET") = ds_cul.namevalue(Row,"AMT_TOTAL") - ds_cul.namevalue(Row,"AMT_TAX_BC");
				
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
		/*		BOOL check : Click한 CheckBox의 체크된 상태(1 : 체크된 상태, 0 : 체크해제된 상태)
	    			 컬럼값은 T,F로 작동 T=체크상태
		*/
	</script>
	
	<%//마스터 그리드 / 공제여부 OnCheckClick %>
	<script language="javascript"  for=gr_cul event=CanColumnPosChange(Row,Colid)>
		var amt_total = ds_cul.namevalue(Row,"AMT_TOTAL");
		var amt_use	  = ds_cul.namevalue(Row,"AMT_NET")+ds_cul.namevalue(Row,"AMT_TAX")+ds_cul.namevalue(Row,"AMT_SVC");
		/*if(amt_total!=amt_use){//금액이 일치하지 않을 때는 공급가액, 부가세만 탭으로 벗어날 수 있음
			if(Colid=="AMT_NET"){
				ds_cul.namevalue(Row,"AMT_TAX") = Math.round(ds_cul.namevalue(Row,"AMT_NET")/10);	//세금=공급가액=1/10
				ds_cul.namevalue(Row,"AMT_SVC") = ds_cul.namevalue(Row,"AMT_TOTAL") - ds_cul.namevalue(Row,"AMT_NET") - ds_cul.namevalue(Row,"AMT_TAX"); //봉사료역산
				return true;
			//}else if(Colid=="AMT_TAX"){
				//return true;
			}else{
				alert("공급가액+부가세+봉사료의 합이 이용금액과 일치하지 않습니다.\n\n수정 내용이 취소됩니다.");
				fnCancel();
				//return false;				
			}
		}*/
	</script>

	
	

	<%//디테일 : 팝업  %>	
	<script language=JavaScript for=gr_culd event=OnPopup(row,colid,data)>
		if(colid=="ATCODENM") {
			//alert(row);
			fnAtcodePopup('<%=dirPath%>', row);
		}
		if(colid=="PL_DEPT_NM") {
			//alert(row);
			fnPldeptPopup('<%=dirPath%>', row);
		}
		if(colid=="REFCDNM") {
			//alert(row);
			fnRefcodePopup('<%=dirPath%>', row);
		}

	</script>



<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"||v_job=="UP"||v_job=="AT"){
		alert("성공적으로 저장되었습니다.");
		fnSelect(); // 디테일들 조회하기
	}
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_cul" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_cul event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
				
				<%//처리 상태로 조회 완료시에만 일괄매입 버튼 보이기 20150910%>
				if(lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)=="02"){
					document.getElementById("butTax").style.display = "inline";
				}else{
					document.getElementById("butTax").style.display = "none";
				}
			}
		}
	</script>
    	
    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
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
            <td>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=left >&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/sta_issue.gif"				style="cursor:pointer" onClick="fnStateCreate();">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"			style="cursor:pointer" onclick="fnSelect()">
							<!--  <img src="<%=dirPath%>/Sales/images/use_private.gif" 	style="cursor:pointer" onClick="fnUsePrivate();"> -->
							<img src="<%=dirPath%>/Sales/images/taxCal.gif" 		style="cursor:pointer" onClick="fnSettle();">
							<img src="<%=dirPath%>/Sales/images/taxCreate.gif" 		id="butTax" style="cursor:pointer;display:none;" onClick="fnTaxCreate();">
							<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"			style="cursor:pointer"  onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1002px'>
           			<tr>
                        <td align="center" class="text" width="60">처리자</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrid")%>">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:45px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrnm")%>">
                        	<%=(String)session.getAttribute("vdeptnm")%>(<%=(String)session.getAttribute("vdeptcd")%>)
                        	<% if("CC20".equals((String)session.getAttribute("vdeptcd"))){%>
                        	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                            <%}%>
                        </td>

                        <td align="center" class="text" width="60">거래일자</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=v_frdt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            &nbsp;~&nbsp;
                            <object id=v_todt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>                            
                            
                        </td>
                        <td align="left" class="text" width="60">처리 상태</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_ccstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_ccstat>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
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

                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='380px' border='1'>
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
						<C> name='No'			 		ID='{CurRow}'		 	width=30 	align=CENTER  	edit=none sumtext=@cnt </C>
                        <C> name='처리자'		 		ID='MGR_NM'   		 	width=50 	align=CENTER  	edit=none show=false</C>
                        <C> name='매입SId'		 		ID='ACQUIRE_SID'		width=50 	align=left 		show=false</C>
                        <C> name='카드\\보유자' 		ID='EMP_NM'   		 	width=55 	align=CENTER 	edit=none bgColor={IF(EMP_NM='미등록','#ffcccc','#FFFFFF') } sumtext='건' </C>
                        <C> name='카드번호'	 			ID='CARD_NUM'  	 		width=130 	align=CENTER	edit=none mask='XXXX-XXXX-XXXX-XXXX' sort=true </C>
					  <G> name='거래처 정보 (ERP)'
                        <C> name='상호'					ID='VEND_NM'   			width=85 	align=left		edit=none  sort=true </C>
                        <C> name='주소'					ID='ADDR1'   			width=80 	align=left		edit=none bgColor={IF(ADDR1='미등록 거래처','#ff3300','#FFFFFF') } </C>
                        <C> name='과세'					ID='COCOMYN_NM'   		width=40 	align=CENTER	edit=none </C>
                      </G>
                      <G> name='이용정보'
                        <C> name='일자'					ID='APPROVE_DATE'	 	width=80 	align=CENTER 	edit=none 	mask='XXXX-XX-XX'</C>
                        <C> name='시각'					ID='APPROVE_TIME'	 	width=40 	align=CENTER 	edit=none 	mask='XX:XX'</C>
                        <C> name='금액'     			ID='AMT_TOTAL'			width=70 	align=right		Edit=NONE	 decao=0  sort=true  sumtext=@sum </C>
                      </G>
                        <C> name='공급가액'     		ID='AMT_NET'			width=70 	align=right		Edit=true	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
                        <C> name='부가세'    			ID='AMT_TAX'			width=60 	align=right		Edit=tree	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
                        <C> name='봉사료\\(면세액)'    	ID='AMT_SVC'			width=60 	align=right		Edit=true	 decao=0   sumtext=@sum		bgColor='#ffff00'</C>
						<C> name='처리\\상태'   		ID='STAT'   			width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_ccstat:detail:detail_nm' SumText={sum(AMT_NET)+sum(AMT_TAX)+sum(AMT_SVC)} SumTextColor='#ff0000' </C>
						<C> name='공제\\여부'			ID='DDYN'   			width=40 	align=CENTER	edit=true editstyle=CheckBox  bgColor={IF(DDYN='T','#CCFFCC','#FFFF00') } </C>
						<C> name='매입\\생성'			ID='TAXYN'   			width=40 	align=CENTER	edit=none editstyle=CheckBox  bgColor={IF(TAXYN='T','#CCFFCC','#FFFFFF') } </C>
						<C> name='통화'					ID='CURRENCY'   	 	width=40 	align=CENTER  	edit=none</C>
					  <G> name='가맹점 정보 (BC제공)'
						<C> name='사업자번호'			ID='VENDOR_TAX_NUM'  	width=80 	align=left		edit=none mask='XXX-XX-XXXXX' show=false</C>
						<C> name='가맹점명'				ID='VENDOR_NAME'	 	width=100 	align=left		edit=none show=false</C>
						<C> name='대표자' 				ID='VENDOR_PERSON'   	width=50 	align=center 	edit=none show=false</C>
						<C> name='전화'					ID='VENDOR_TEL'   		width=80 	align=left		edit=none show=false</C>
						<C> name='주소'					ID='VENDOR_ADDRESS1'   	width=100 	align=left		edit=none show=false</C>
					  </G>
					    <C> name='BC\\부가세'    		ID='AMT_TAX_BC'			width=60 	align=right		decao=0   show=false</C>
                 ">                             
                </object>                        

            </td>
        </tr>
		<tr>
			<td height='31px' class="r bold"><!-- 계정정보 임시보관용 -->

			<br>
					계정정보<input type="checkbox" name='v_memory_chk' id="v_memory_chk" ><input type="text" name="v_groupnm" 	id="v_groupnm" 	  style="width:140px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_pl_dept_nm" 	id="v_pl_dept_nm"  style="width:100px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_pl_dept" 	id="v_pl_dept" 	   style="width:40px;" class="input01"  readOnly="readonly" value="">				
					<input type="text" name="v_pl_dept_div" id="v_pl_dept_div" style="width:20px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_atcodenm" 	id="v_atcodenm"    style="width:130px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_atcode" 		id="v_atcode" 	   style="width:50px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_refcdnm" 	id="v_refcdnm"     style="width:90px;" class="input01"  readOnly="readonly" value="">				
					<input type="text" name="v_refcd" 		id="v_refcd" 	   style="width:40px;" class="input01"  readOnly="readonly" value="">
					<input type="text" name="v_remark" 		id="v_remark" 	   style="width:140px;" class="input01"  readOnly="readonly" value="">				
				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt1()" >
			</td>
		</tr>        
        
        <tr>
            <td valign="top">
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='60px' border='1'>
                    <param name="DataID"            value="ds_culd">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
						<C> name='No'			ID='{CurRow}'		width=30 	align=right 	edit=none sumtext=@cnt </C>
						<C> name='처리 그룹명'	ID='GROUP_NM'		width=140 	align=left </C>
                        <C> name='귀속정보'		ID='PL_DEPT_NM' 	width=170 	align=left 		EditStyle=popup </C>
                        <C> name='귀속코드'		ID='PL_DEPT' 		width=70	align=center  	edit=none show=true  bgcolor=#9e9e9e show=false</C>
                        <C> name='귀속구분'		ID='PL_DEPT_DIV'	width=60 	align=CENTER 	show=false	</C>
                        <C> name='계정명'		ID='ATCODENM'		width=150 	align=left 		EditStyle=popup </C>
                        <C> name='계정코드'		ID='ATCODE'			width=70 	align=center 	edit=none bgcolor=#9e9e9e show=false</C>
                        <C> name='세목명'		ID='REFCDNM'		width=120 	align=left 		EditStyle=popup </C>
                        <C> name='세목코드'		ID='REFCD'			width=60 	align=center 	edit=none bgcolor=#9e9e9e show=false</C>
                        <C> name='적요'			ID='REMARK'   		width=250 	align=left </C>
                        <C> name='공급가액' 	ID='FSAMT'			width=100 	align=right		decao=0  </C>
                        <C> name='매입SID'		ID='acquire_sid'	width=60 	align=CENTER	edit=none show=false </C>
                        
                 ">                             
                </object>                        
            </td>
        </tr>
        <tr>
            <td valign="top"><br>
		            ※ 계정정보<b>□ Check</b>하면, 저장시 계정정보를 보관하여, 반복 작업에 유리합니다. 세목이 없는 계정은 <b>세목코드="00"</b>이 기본값입니다.<br>
		            ※ 처리 프로세스<br>
            　			1. 접 대 비　　: 접대비로 처리할 사용 건은 공제여부를 체크→체크해제하여 <b>부가세를 0</b>으로 만들어야 합니다.<BR>
 			　	2. 공제 처리<br>
 			　　		1) 거 래 처　: 부가세 공제할 사용 건 중 <b>미등록 거래처</b>가 있다면 거래처 등록요청을 합니다.<br>
 			　　		2) 일괄 공제 : 일반과세 거래처로 <b>미처리 and 부가세가 0보다 큰</b> 사용 건들을 일괄공제 처리합니다.<br>
 			　　		3) 직접 공제 : 마트 사용 등 부가세가 나눠지지 않은 사용 건 중 공제받을 건을 처리합니다.(영수증 보고 금액 직접 입력, <b>실물 영수증</b> 필요)<br>
			　	3. 계정 정보　 : 공제여부 처리를 마친 후에 각 사용 건의 계정정보를 저장하면 상태가 [처리]로 변경됩니다.<br>
			　	4. 매입 생성　 : [일괄매입] 버튼을 누르면, 공제여부가 체크된 건 모두 계산서정보를 자동으로 생성합니다.
            </td>
        </tr>

    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		