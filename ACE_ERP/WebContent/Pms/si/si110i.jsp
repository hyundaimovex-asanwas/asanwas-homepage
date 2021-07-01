<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사>현장관리>작업관리>작업 등록
 * 프로그램ID 	 : PMS/SI110I
 * J  S  P		 : si110i.jsp
 * 서 블 릿		 : Si110I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2014-03-27
 * [ 수정일자 ][수정자] 내용
 * [2014-03-27][심동현] 신규 개발 
 * [2014-04-07][심동현] GAUCE MX component 5.x로 클래스ID수정
 *						CSS 추가 : 그리드 칼라랑 동일한 테이블 헤더. 안함
 * [2014-04-11][심동현] 같은 날짜 입력시 경고.. ← 이런거 처리해야 합니다.
 * [2014-06-13][심동현] 기안 팝 스크립트, 페이지 추가
 * [2014-06-26][심동현] 화면 사이즈 다듬기, 인원GRID에 직종 추가, 현대아산 dummy데이터 추가 (TPC010, TBC030 두 테이블)
 *						투입인원 팝업 창 수정 = 직종 추가, 중복체크 스크립트 수정, 인서트/업뎃 쿼리에 직종 추가
 * [2014-06-27][심동현] 문서 상태 추가. 작성중(110)만 상신 가능합니다.
 
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
<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
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

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_wd"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail1"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail2"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail3"), "comn");
		
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
//	    v_date.Text = "20140329";

	    gr_wd.RowHeight = "70";	//그리드 로우하이트 변경

        ds_gc_weather.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY017&s_item1=Y";
        ds_gc_weather.Reset();	//날씨 코드 SY017 (선택+)

        ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        ds_gc_wdcode.Reset();	//작업 구분(일지용) SI004

        ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        ds_gc_bskind.Reset();	//입찰 공종 CT001 

        ds_gc_bpjob.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI006&s_item1=Y";
        ds_gc_bpjob.Reset();	//투입인원 직종 SI006 

        
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WM=ds_wm,O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
		//사용자별 담당 현장 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct013I",
            "JSP(O:DS_SITE_EMP=ds_site_emp)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

        
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var v_wdate = v_date.Text.trim();

        if(v_wdate.length!=8) {
            alert("일자를 입력하시길 바랍니다.");
            return;
        }
        if(v_site_sid.value==""){
        	alert("먼저 현장을 선택해 주세요.");
        	return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid="+ v_site_sid.value
			+ ",v_date=" + v_wdate
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WM=ds_wm)",
            param);
        tr_post(tr1);
    }

    <%// 디테일 그리드 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            v_param);
        tr_post(tr2);
    }

	<%//저장 %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_wm.RowPosition;
		
		if (ds_wm.IsUpdated || ds_wd.IsUpdated || ds_detail1.IsUpdated || ds_detail2.IsUpdated || ds_detail3.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
                "JSP(I:DS_WM=ds_wm,I:DS_WD=ds_wd,I:DS_DETAIL1=ds_detail1,I:DS_DETAIL2=ds_detail2,I:DS_DETAIL3=ds_detail3)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	+ ",v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID")
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
	<%// 입력값 체크 %>
	function ln_Chk() {
		var row1=ds_wm.countrow;
		//var row2=ds_tender.countrow;

		if(w_date.Text.length<8) {
			alert("날짜를 정확히 입력해 주십시오");
			w_date.focus();
			return;
		}
		return true;
	}

	
	


	<%//현장 팝- 조회%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }

    function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    

    <%// Work Master 신규 %>
	function fnNewDWR(){
		if(ds_wm.IsUpdated||ds_wd.IsUpdated) {
			alert("수정중인 기본정보 또는 상세정보가 있으면\n\n신규 작업정보를 생성할 수 없습니다.");
			return;
		}else {
			if(v_site_sid.value==""||v_site_sid.value=="0"){
				alert("먼저 현장을 선택해 주세요.");
				return;
			}
			v_job="N";
			
			//날짜 중복 체크
	        var v_wdate = v_date.Text.trim();
	        if(v_wdate.length!=8) {
	            alert("일자를 입력하시길 바랍니다.");
	            return;
	        }
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_site_sid="+ v_site_sid.value
				+ ",v_date=" + v_wdate
				;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
	            "JSP(O:DS_WM_CHK=ds_wm_chk)",
	            param);
	        tr_post(tr1);
			
	        //tr1 결과에 따라 작동
		}
	}
    <%// Work Master 신규 %>
	function fnNewDWR1(){	
	    ds_wm.ClearData();
	    ds_wd.ClearData();
	    ds_detail1.ClearData();
	    ds_detail2.ClearData();
	    ds_detail3.ClearData();
	    
		ds_wm.addrow();
		site_sid.value = v_site_sid.value;	//현장sid 받기
	    w_date.Text = v_date.Text.trim();
	    lc_gc_weather.index = 1;
		TEMP_MIN.text="0";
		TEMP_MAX.text="0";
		RATE_PLAN.text="0.0";
		RATE_RESULT.text="0.0";
		PROG_RATE.value="0.0";
		man_pre.text="0";
		machine_pre.text="0";
		man_now.text="0";
		machine_now.text="0";
		w_pre.value="";
		w_now.value="";
		w_remark.value="";
	
		w_date.focus();
	}

	
	
    <%// Work Detail 신규 %>
	function fnAddRowWd(){
		if(ds_wm.IsUpdated) {
			alert("작업 기본정보가 수정중입니다. 저장 후 추가해 주세요.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("작업 기본정보를 조회 또는 저장 후 상세정보를 추가해 주세요.");
		} else {
			ds_wd.addrow();
			ds_wd.namevalue(ds_wd.RowPosition, "dwr_sid") = ds_wm.namevalue(ds_wm.rowposition,"dwr_sid");
			msgTxt.innerHTML="작업 상세 행이 삽입되었습니다.";
		}
	}

	<%// Work Detail 삭제 %>
	function fnDeleRowWd() {
		ds_wd.DeleteRow(ds_wd.RowPosition);
	};

	<%// 신규 입력 취소 %>
	function fnCancel() {
        ds_wm.undoall();
        ds_wd.undoall();
        ds_detail1.undoall();
        ds_detail2.undoall();
        ds_detail3.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
	}
	

    <%// Work Detail 신규 %>
	function fnAddRowDt1(){
		if(ds_wm.IsUpdated) {
			alert("작업 기본정보가 수정중입니다. 저장 후 추가해 주세요.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("작업 기본정보를 조회 또는 저장 후 상세정보를 추가해 주세요.");
		} else {
			ds_detail1.addrow();
			msgTxt.innerHTML="[인원] 행이 삽입되었습니다.";
		}
	}
	function fnAddRowDt2(){
		if(ds_wm.IsUpdated) {
			alert("작업 기본정보가 수정중입니다. 저장 후 추가해 주세요.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("작업 기본정보를 조회 또는 저장 후 상세정보를 추가해 주세요.");
		} else {
			ds_detail2.addrow();
			msgTxt.innerHTML="[장비] 행이 삽입되었습니다.";
		}
	}
	function fnAddRowDt3(){
		if(ds_wm.IsUpdated) {
			alert("작업 기본정보가 수정중입니다. 저장 후 추가해 주세요.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("작업 기본정보를 조회 또는 저장 후 상세정보를 추가해 주세요.");
		} else {
			ds_detail3.addrow();
			msgTxt.innerHTML="[주요자재] 행이 삽입되었습니다.";
		}
	}
	
	
	
	
	<%//외주 협력사 조회하기%>
	function fnPopBP(dirPath,row){	

		if(ds_detail1.namevalue(row,"NEW_VAL")=="N"){	// 추가된 것이 아닌 이미 있던 협력사.
			alert("이미 입력한 협력사를 변경할 수는 없습니다.\n\n새 행을 추가해주세요.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_01.jsp";
   		strPos = "dialogWidth:575px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_sid")  		= arrParam[0];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_nm")   		= arrParam[1];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bid_site_kind")   = arrParam[2];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bid_sid")   		= arrParam[3];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")   		= arrParam[4];	//직종 추가	2016-06-23
   	   		
  			for (row = 1; row < ds_detail1.countrow; row++) {
  				//회사와 공종이 같으면 중복 입력 안됨
  				if (ds_detail1.namevalue(row,"bp_sid") == arrParam[0] && ds_detail1.namevalue(row,"bid_site_kind") == arrParam[2] && ds_detail1.namevalue(row,"bp_job") == arrParam[4]) {
  					alert("같은 협력회사(=공종)와 직종을 중복 등록할 수 없습니다!\n\n이미 입력된 행의 금일 투입 값을 입력해 주세요.");
  					ds_detail1.namevalue(ds_detail1.rowposition,"bp_sid") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bp_nm") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_site_kind") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_sid") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")  	="";
  					return;
  				}
  			}
   		} else {
				ds_detail1.namevalue(ds_detail1.rowposition,"bp_sid") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bp_nm") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_site_kind") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_sid") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")  	="";
   		}				
     	
	}

	<%//주요 자재 조회하기%>
	function fnPopITEMx(dirPath,row){	

		if(ds_detail2.namevalue(row,"item_sid")>0){
			alert("누계 계산을 위해 이미 입력한 장비를 변경할 수는 없습니다.\n\n새 행을 추가해주세요.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_02.jsp";
   		strPos = "dialogWidth:695px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_sid")  = arrParam[0];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_nm")   = arrParam[1];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_size")   = arrParam[2];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_nm_s")   = arrParam[3];

  			for (row = 1; row < ds_detail2.countrow; row++) {
  				//회사와 공종이 같으면 중복 입력 안됨
  				if (ds_detail2.namevalue(row,"bp_sid") == arrParam[0] && ds_detail2.namevalue(row,"bid_site_kind") == arrParam[2]) {
  					alert("같은 장비를 중복 등록할 수 없습니다!");
  					ds_detail2.namevalue(ds_detail2.rowposition,"item_sid") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_size") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm_s") = "";
  					return;
  				}
  			}
   		} else {
				ds_detail2.namevalue(ds_detail2.rowposition,"item_sid") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_size") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm_s") = "";
   		}				
     	
	}

	
	<%//주요 자재 조회하기%>
	function fnPopITEM(dirPath,row){	

		if(ds_detail3.namevalue(row,"item_sid")>0){
			alert("누계 계산을 위해 이미 입력한 자재를 변경할 수는 없습니다.\n\n새 행을 추가해주세요.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_03.jsp";
   		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_sid")  = arrParam[0];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_nm")   = arrParam[1];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_size")   = arrParam[2];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_unit")   = arrParam[3];

  			for (row = 1; row < ds_detail3.countrow; row++) {
  				//회사와 공종이 같으면 중복 입력 안됨
  				if (ds_detail3.namevalue(row,"bp_sid") == arrParam[0] && ds_detail3.namevalue(row,"bid_site_kind") == arrParam[2]) {
  					alert("같은 자재를 중복 등록할 수 없습니다!");
  					ds_detail3.namevalue(ds_detail3.rowposition,"item_sid") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_nm") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_size") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_unit") = "";
  					return;
  				}
  			}
   		} else {
				ds_detail3.namevalue(ds_detail3.rowposition,"item_sid") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_nm") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_size") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_unit") = "";
   		}				
     	
	}

	
	
	
    <%//기안-팝업 = 작업일보 Daily Work Report %>
    function fnDraft() {
        if(ds_wm.CountRow==0){
            alert("기안할 작업일보를 먼저 조회해 주세요.");
            return false;
        }
        
    	//alert(ds_wm.NameValue(ds_wm.row, "W_STS"));
    	if(ds_wm.NameValue(ds_wm.row, "W_STS")=="010"){
			// 팝업 고고
    	}else if(ds_wm.NameValue(ds_wm.row, "W_STS")=="011"||ds_wm.NameValue(ds_wm.row, "W_STS")=="012"){
    		alert("이미 기안한 작업일보입니다.\n\n일보 조회 메뉴를 이용해 확인해 주세요.");
    		return;
    	}else if(ds_wm.NameValue(ds_wm.row, "W_STS")=="013"){
			if(confirm("반려된 작업일보입니다.\n\n재상신하시겠습니까?")){	
				// 팝업 고고
			}else{
				return;
			}
    	}
    	
        var link ="si110i_h1.jsp?v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID")+"&v_status=010&";
        var dialogWidth = 930; 
        //a4사이즈를 맞춘다면 630*891 근데 그게 잘 안돼 -_- 차라리 A4 가로를 맞추는게..ㅋ
        // 팝업창 930에 본문 891로..?
        var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height="+(screen.availHeight-52)+", width="+dialogWidth+",toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes";
        /* titlebar=no, 
        	location=no, 주소가 수정 가능한지 여부 
        	menubar=no, scrollbars=yes,status=no,toolbar=no, directories=no,
        	resizable=yes 크기 조절 가능 여부
        */
        var pop_ap_dwr = window.open(link, 'pop_ap_dwr', features); 

    
    }   		
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//디테일1 : 투입 인원 팝 %>	
	<script language=JavaScript for=gr_detail1 event=OnPopup(row,colid,data)>
		if(colid=="BP_NM") {
			fnPopBP('<%=dirPath%>', row);
		}
	</script>
	<%//디테일2 : 투입 장비 팝 %>	
	<script language=JavaScript for=gr_detail2 event=OnPopup(row,colid,data)>
		if(colid=="ITEM_NM_S"||colid=="ITEM_NM") {
			fnPopITEMx('<%=dirPath%>', row);
		}
	</script>

	<%//디테일3 : 투입 자재 팝 %>	
	<script language=JavaScript for=gr_detail3 event=OnPopup(row,colid,data)>
		if(colid=="ITEM_NM") {
			fnPopITEM('<%=dirPath%>', row);
		}
	</script>

	
	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
		fnSelect(); // 디테일들 조회하기
	}
	
	if(v_job=="N"){// 신규행 클릭시 날짜 조회
	    for(var i=1; i<=ds_wm_chk.CountRow; i++){
	        if(ds_wm_chk.NameValue(i, "S_YN")!="Y"){ // 정상이 아니면 
	            if(ds_wm_chk.NameValue(i, "MSG_CD")!="0000"){
	                alert(ds_wm_chk.NameValue(i, "MSG"));
	                return;
	            }
	        } else {
	            //alert(ds_wm_chk.NameValue(i, "MSG"));
	            	//alert("239라인");        
	            getObjectFirst("ds_wm_chk").ClearAll();
	            fnNewDWR1();
	        }
	    }

	}	
	
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_wm" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_wm event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_wm.ClearData();
			    ds_wd.ClearData();
			    ds_detail1.ClearData();
			    ds_detail2.ClearData();
			    ds_detail3.ClearData();
			}else{
				fnSelectDetail(row);
			}
		}
    </script>

    <script language="JavaScript"  for="ds_site_emp" event="OnLoadCompleted(row)" >
	    if(row==0){
	        alert("현장 담당자 설정이 되어 있지 않습니다.\n\n현장을 검색해주세요.\n\n현장 담당자 설정 요청 → 현장지원팀 과장 조진우");
	    }else{
	    	getObjectFirst("v_site_nm").value = ds_site_emp.NameValue(row,"SITE_NM");
	    	getObjectFirst("v_site_sid").value = ds_site_emp.NameValue(row,"SITE_SID");
	    }
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_wm classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wm_chk classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_site_emp classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_weather classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_wdcode classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bskind classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bpjob	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:pointer" onclick="fnDraft()">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:pointer"  onClick="fnNewDWR()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='890px'>
           			<tr>
                        <td align="center" class="text" width="70">현장명</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
                        </td>
                        <td align="left" class="text" width="70">일자</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:2px;width:79px; height:17px;">
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
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='6px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="16px">
									<td width="129px"  bgcolor="#ffffff" rowspan="2" class="c">
										<input type="hidden" name='site_sid' id="site_sid"  readOnly="readonly">
			                            <object id=w_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" tabindex="1">
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
									<td width="80px"  class="c" bgcolor="#eeeeee" rowspan="2" >날씨</td>
									<td width="110px" bgcolor="#ffffff" rowspan="2" >&nbsp;
			                            <object id=lc_gc_weather classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  tabindex="2">
			                                <param name=ComboDataID     value=ds_gc_weather>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
									</td>
									<td width="80px"  class="c" bgcolor="#eeeeee" >최저기온</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=TEMP_MIN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:30px; height:16px;"  tabindex="3">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=0>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;˚C</td>
									<td width="80px"  class="c" bgcolor="#eeeeee"  rowspan="2" >공정율</td>
									<td width="60px" class="c" bgcolor="#eeeeee">계획</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=RATE_PLAN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:16px;" tabindex="5">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=2>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;%</td>
									<td width="80px" class="c" bgcolor="#eeeeee"  rowspan="2" >대비</td>
									<td width="100px" bgcolor="#ffffff"  rowspan="2"  align="center">
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly">&nbsp;%</td>																	
								</tr>

								<tr height="16px">
									<td class="c" bgcolor="#eeeeee" >최고기온</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=TEMP_MAX classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:30px; height:17px;"  tabindex="4">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=0>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;˚C</td>

									<td  class="c" bgcolor="#eeeeee" >실적</td>
									<td bgcolor="#ffffff" align="center">
			                            <object id=RATE_RESULT classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;" tabindex="6">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=2>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;%</td>								
								</tr>
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td colspan="2" class="c" bgcolor="#eeeeee">인원/기계</td>
									<td colspan="2" class="c" bgcolor="#eeeeee" >주요작업</td>
									<td width="150px" rowspan="2"  class="c" bgcolor="#eeeeee">비고</td>
								</tr>
								<tr height="20px">
									<td width="100px"  class="c" bgcolor="#eeeeee" >전일</td>
									<td width="100px"  class="c" bgcolor="#eeeeee" >금일</td>
									<td width="267px"  class="c" bgcolor="#eeeeee" >전일</td>
									<td width="267px"  class="c" bgcolor="#eeeeee" >금일</td>
								</tr>
								<tr height="50px">
									<td bgcolor="#ffffff" align="center">
			                            <object id=man_pre classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="7">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <span style= "position:relative;left:0px;top:0px;width:10px; height:17px;">&nbsp;/&nbsp;</span>
			                            <object id=machine_pre classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="8">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
									<td bgcolor="#ffffff" align="center">
			                            <object id=man_now classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="9">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <span style= "position:relative;left:0px;top:0px;width:10px; height:17px;">&nbsp;/&nbsp;</span>
			                            <object id=machine_now classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;"  tabindex="10">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="w_pre" id="w_pre"  class=textbox cols=39 rows=3  tabindex="11"></textarea>
									</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="w_now" id="w_now"  class=textbox cols=39 rows=3  tabindex="12"></textarea>
								
									</td>
									<td bgcolor="#ffffff" align="center">
										<textarea name="w_remark" id="w_remark"  class=textbox cols=21 rows=3  tabindex="13"></textarea>
									
									</td>
								</tr>
							</table>
						</td>
					</tr>					
                    <tr>
                        <td height="4" align="right">
						<!-- <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowWd()" > -->
						<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowWd()" > -->
						</td>
					</tr>
                    <tr>
                        <td valign='top' align="right">
                        <object id=gr_wd classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='300px' border='1'>
                            <param name="DataID"            value="ds_wd">
                            <param name="Editable"          value="true">
                            <param name="BorderStyle"       value="0">
                            <param name="Format"            value="
                                 <C> name='구분'		ID='WD_CODE'	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wdcode:detail:detail_nm'</C>
                                 <C> name='금일작업'	ID='WD_NOW'   	width=370 	align=left	Edit=true  multiline=true</C>
                                 <C> name='명일작업'    ID='WD_POST'	width=418 	align=left	Edit=true  multiline=true</C>
                         ">                             
                        </object>                        
                        </td>
                    </tr>
                    <tr>
                        <td valign='top'>
                        <table border="0" cellpadding="0" cellspacing="0">
	                      <tr>
	                        <td height="22" width="150" class="r b bold ">인원</td>
	                        <td class="r">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
							</td>
							<td height="22" width="140" class="r b bold ">장비</td>
	                        <td height="22" align="right">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt2()" >
								<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt2()" > -->
							</td>
							<td height="22" width="170" class="r b bold ">주요자재</td>
	                        <td height="22" align="right">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt3()" >
								<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt3()" > -->
							</td>
						  </tr>
                          <tr>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail1 classid=<%=HDConstant.MxGrid_CLSID_S%> width='316px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail1">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='회사'		ID='BP_NM'  width=80 	align=left  EditStyle=popup sumtext='소계'  </C>
		                                 <C> name='회사sid'		ID='BP_SID' width=80 	align=CENTER  edit=none  show=false</C>
		                                 <C> name='입찰sid'		ID='BID_SID' width=80 	align=CENTER  edit=none  show=false</C>
		                                 <C> name='공종'		ID='BID_SITE_KIND'   	width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bskind:detail:detail_nm'</C>
										<C> name='직종'		ID='BP_JOB'  				width=60 	align=CENTER	Edit=None editstyle=lookup Data='ds_gc_bpjob:detail:detail_nm'</C>
										<C> name='금일'    	ID='NOW_COMMIT'		width=40 	align=right Edit=true decao=0 sumtext=@sum </C>
										<C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum </C>
		                         ">
		                        </object>
                          	</td>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='256px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail2">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='장비'		ID='ITEM_NM_S'		width=80 	align=left		 EditStyle=popup sumtext='소계'  </C>
		                                 <C> name='장비SID'		ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
		                                 <C> name='규격'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
		                                 <C> name='금일'    	ID='NOW_COMMIT'		width=40 	align=CENTER	Edit=true  sumtext=@sum </C>
		                                 <C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=CENTER	Edit=None  sumtext=@sum </C>
		                         ">                             
		                        </object>   
                          	</td>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='314px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail3">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='품명'		ID='ITEM_NM'		width=80 	align=left   EditStyle=popup sumtext='소계'  </C>
		                                 <C> name='품목SID'		ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
		                                 <C> name='규격'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
		                                 <C> name='단위'		ID='ITEM_UNIT'   	width=58 	align=CENTER	Edit=None</C>
		                                 <C> name='금일'    	ID='NOW_COMMIT'		width=40 	align=CENTER	Edit=true  sumtext=@sum </C>
		                                 <C> name='누계'    	ID='TOT_COMMIT'		width=60 	align=CENTER	Edit=None  sumtext=@sum </C>
		                         ">                             
		                        </object>   

                          	</td>
                          </tr>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="21px">
									<td width="160px"class="text">본사 요청사항</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="remark" id="remark"  class=textbox cols=116 rows=3  tabindex="14"></textarea>
									</td>
								</tr>
							</table>
						</td>
					</tr>

                </table>

            </td>
        </tr>
    </table>

<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.MxBinder_CLASSID%>>
	             <param name="DataId" value="ds_wm">
	             <param name=BindInfo    value="
					<C>Col=SITE_SID    		Ctrl=site_sid		Param=Value </C>
					<C>Col=W_DATE			Ctrl=w_date        Param=Text </C>
					<C>Col=WED      		Ctrl=lc_gc_weather     Param=BindColVal </C>
					<C>Col=TEMP_MAX       	Ctrl=TEMP_MAX      Param=Text </C>
					<C>Col=TEMP_MIN        	Ctrl=TEMP_MIN       Param=Text </C>
					<C>Col=RATE_PLAN		Ctrl=RATE_PLAN  	Param=Text </C>
					<C>Col=RATE_RESULT		Ctrl=RATE_RESULT    Param=Text </C>
					<C>Col=PROG_RATE	    Ctrl=PROG_RATE     Param=Value </C>
					<C>Col=MAN_PRE       	Ctrl=man_pre       Param=Text </C>
					<C>Col=MACHINE_PRE      Ctrl=machine_pre   Param=Text </C>
					<C>Col=MAN_NOW     		Ctrl=man_now   Param=Text </C>
					<C>Col=MACHINE_NOW  	Ctrl=machine_now    Param=Text </C>
					<C>Col=W_PRE        	Ctrl=w_pre        Param=Value </C>
					<C>Col=W_NOW    		Ctrl=w_now    	Param=Value </C>
					<C>Col=W_REMARK   		Ctrl=w_remark	Param=Value </C>
					<C>Col=REMARK   		Ctrl=remark		Param=Value </C>
	              ">
	      </object>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		