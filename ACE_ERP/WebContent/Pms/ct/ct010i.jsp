<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 도급계약 등록
 * 프로그램ID 	: CT010 (코드는 대문자)
 * J  S  P		: ct010 (jsp파일명은 소문자로 한다 )
 * 서 블 릿		: Ct010
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-07-04
 * 기능정의	: 도급계약 등록/조회/관리
 * 수정내용	: 신규
 * [ 수정일자 ][수정자] 내용
 * [2014-07-07][심동현] 그리드 사이즈 변경, 현장 단축병 | 전화 | 팩스 | 구매현장코드(XXXX) 추가
 * [2014-07-07][심동현] 계약금액은 보통 얼마 단위?
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>	
	<script language="javascript">
	
	var gs_userid = gusrid;
	var gs_fdcode = gfdcode;
	var v_default_row = 1;
	
   	/*
 	 * 페이지 로딩
 	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		fnInit();
		cfStyleGrid(getObjectFirst("gr1"), "comn1");	//도급계약 메인
		cfStyleGrid(getObjectFirst("gr2"), "comn");	//공동도급
		cfStyleGrid(getObjectFirst("gr3"), "comn1");	//도급계약 차수
	}

	<% // 초기화 작업 %>
	function fnInit(){ 
		ds_site_joint.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT009&s_item1=Y";
        ds_site_joint.Reset(); //공동여부
        ds_site_main.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT010&s_item1=Y";
        ds_site_main.Reset();	//주관여부
		ds_site_attr1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT011&s_item1=Y";
        ds_site_attr1.Reset(); //속성1
        ds_site_attr2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT012&s_item1=Y";
        ds_site_attr2.Reset();	//속성2
        ds_use_yn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_use_yn.Reset();	//사용유무
        
        codeDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT013&s_item1=Y";
        codeDs1.Reset();	//계약차수
		codeDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT014&s_item1=Y";
        codeDs2.Reset();	//변경차수
        codeDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT015&s_item1=Y";
        codeDs3.Reset();	//계약상태
                
        lc_site_joint.index = 0;
		lc_site_main.index = 0;
		lc_site_attr1.index = 0;
		lc_site_attr2.index = 0;
		//lc_use_yn.index = 0;
		
		
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

		/*
		 * 데이터셋 헤더 설정 (메인)
		 */	
		
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+
				"site_sid:INT,site_cd:STRING,site_nm:STRING,site_joint_nm:STRING,site_main_nm:STRING,site_attr1_nm:STRING,site_attr2_nm:STRING,site_joint:STRING,site_main:STRING,site_attr1:STRING,site_attr2:STRING,orderer_sid:INT,vend_cd:STRING,orderer_nm:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
		/*
		 * 데이터셋 헤더 설정 (공동도급)
		 */
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp = ""
				+
				"{CURROW}:INT,coop_sid:INT,coop_nm:STRING,site_rate:INT,site_sid:INT";
				ds2.SetDataHeader(s_temp);
			}
		}
		/*
		 * 데이터셋 헤더 설정 (변경계약)
		 */
		function fnSetHeaderDs3(){
			if (ds3.countrow<1){
				var s_temp = ""
				+
				"site_seq_ct:STRING,site_seq_ch:STRING,site_status:STRING,date_made:STRING,date_ct:STRING,date_begin:STRING,date_end:STRING,amt_ct_tot:DECIMAL(15.0),amt_ct:DECIMAL(15.0),amt_ct_vat:DECIMAL(15.0),remarks:STRING,site_eno:STRING,rate_ac:INT,u_empno:STRING,site_sid:INT";
				ds3.SetDataHeader(s_temp);
			}
		}
		
		
		/*
		 * 도급계약 메인조회
		 */
		function fnSelect(){   
		
			if(getObjectFirst("v_site_nm").value.trim()=="" & getObjectFirst("v_orderer_nm").value.trim()==""){
                alert("현장명 또는 발주처<%=HDConstant.A_MSG_MUST_INPUT%>");
                //getObjectFirst("v_site_nm").Focus();
                return;
            }
            
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				alert("수정중인 행인 있습니다.");
			} else {
			    //gr1.ReDraw = "False";
		        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                    + ",dsType=1"  
		                    + ",v_site_sid="+ v_site_sid.value
							+ ",v_orderer_sid=" + v_orderer_sid.value
							; 
				//alert(v_param);
		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
		            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)",
		            v_param);
		        tr_post(tr1);
			}
		} 
		/*
		 * 도급계약 디테일조회
		 */
		function fnSelect2(row){   
					    //gr1.ReDraw = "False";
					    v_default_row = row;
					    
				        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							        + ",dsType=1"  
				                    + ",v_site_sid="+getObjectFirst("ds1").NameValue(row, "site_sid")
									+ ",v_orderer_sid="+getObjectFirst("ds1").NameValue(row, "orderer_sid");
						//alert(v_param);
				        ln_TRSetting(tr2, 
				            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
  				           "JSP(O:DS2=ds2,O:DS3=ds3)",
				            v_param);
				        tr_post(tr2);
		}
		
		/*
		 * 도급계약 메인 신규 
		 */
		function fnAddRowDs1(){
			if(ds2.IsUpdated || ds3.IsUpdated) {
				alert("수정중인 행이 있으면 삽입할 수 없습니다.");
				return;
			}else {
				//fnSetHeaderDs1();
				ds1.addrow();
				//site_nm.readOnly = false;
				//orderer_nm.readOnly = false;
				row.value = ds1.RowPosition;
				gr1.setcolumn("site_nm");
		        lc_site_joint.index = 0;
				lc_site_main.index = 0;
				lc_site_attr1.index = 0;
				lc_site_attr2.index = 0;
				lc_use_yn.index = 0;				
				ds2.clearall();
				ds3.clearall();
				//fnSetHeaderDs2();
				//fnSetHeaderDs3();
				return;
			}
		}
				
		/*
		 * 공동도급 행추가 
		 */
		function fnAddRowDs2() {
			if (ds1.namevalue(ds1.rowposition,"site_nm") == undefined || ds1.namevalue(ds1.rowposition,"site_nm") == "" ) {
					alert('추가할 현장명이 선택되지 않았습니다.');
					gr2.setcolumn("coop_nm");
			} else {
				fnSetHeaderDs2();
				ds2.addrow();
				ds2.namevalue(ds2.rowposition, "site_sid") = ds1.namevalue(ds1.rowposition, "site_sid");
				//coop_nm.readOnly = false;
				//site_rate.readOnly = false;
				row.value = ds2.RowPosition;
				//gr2.setcolumn("coop_nm");
				
				return;
			}
		}
		
		/*
		 * 도급변경계약 행추가 
		 */
		function fnAddRowDs3() {
			
			if (ds1.namevalue(ds1.rowposition,"site_nm") == undefined || ds1.namevalue(ds1.rowposition,"site_nm") == "" ) {
					alert('추가할 현장명이 선택되지 않았습니다.');
					gr3.setcolumn("site_seq_ct");
			} else {
				fnSetHeaderDs3();
				ds3.addrow();
				ds3.namevalue(ds3.rowposition, "site_sid") = ds1.namevalue(ds1.rowposition, "site_sid");
				gr3.setcolumn("site_seq_ct");
				
				return;
			}
		}
		

		/*
		 * 마스터 삭제 
		 * 삭제 액션시 바로 적용
		 */
		function fnDeleteRowDs1() {			
			if(ds2.IsUpdated) {
				alert("수정중인 행이 있으면 삭제할 수 없습니다.");
				return;
			}else if(ds3.IsUpdated) {
				alert("수정중인 행이 있으면 삭제할 수 없습니다.");
				return;
			}else{
				if (confirm("입력하신 사항을 삭제하시겠습니까?")) {
					
					ds1.deleterow(ds1.rowposition);
					ds2.deleteall();
					ds3.deleteall();
					
					fnApply();
					
					msgTxt.innerHTML="도급계약 메인행이 삭제되었습니다.";
				
					return;
				}
			}
		}

		/*
		 * 공동수급 행삭제 
		 */
		function fnDeleteRowDs2(){
			//alert("ds2삭제");
			ds2.deleterow(ds2.rowposition);
			msgTxt.innerHTML="공동수급 행이 삭제되었습니다.";
		}

		/*
		 * 도급계약변경 행삭제 
		 */
		function fnDeleteRowDs3(){
			//alert("ds3삭제");
			ds3.deleterow(ds3.rowposition);
			msgTxt.innerHTML="도급계약_변경 행이 삭제되었습니다.";
		}

		/*
		 * 적용
		 * 도급계약 변경시 추가, 공동수급 행추가, 도급계약 변경 행추가,삭제 후 적용 
		 */
		function fnApply(){
		
			if (ds1.namevalue(ds1.rowposition,"site_joint") == undefined || ds1.namevalue(ds1.rowposition,"site_joint") == "" || ds1.namevalue(ds1.rowposition,"site_joint") == 0 ) {
				alert("공동여부를 선택해 주세요");
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_main") == undefined || ds1.namevalue(ds1.rowposition,"site_main") == "" || ds1.namevalue(ds1.rowposition,"site_main") == 0 ) {
				alert("주관여부를 선택해 주세요");
				//alert(ds1.namevalue(ds1.rowposition,"site_joint"));
				//alert(ds1.namevalue(ds1.rowposition,"site_main"));
				//alert(ds1.namevalue(ds1.rowposition,"site_attr1"));
				//alert(ds1.namevalue(ds1.rowposition,"site_attr2"));
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_attr1") == undefined || ds1.namevalue(ds1.rowposition,"site_attr1") == "" || ds1.namevalue(ds1.rowposition,"site_attr1") == 0 ) {
				alert("속성1을 선택해 주세요");
				return;
			}else if (ds1.namevalue(ds1.rowposition,"site_attr2") == undefined || ds1.namevalue(ds1.rowposition,"site_attr2") == "" || ds1.namevalue(ds1.rowposition,"site_attr2") == 0 ) {
				alert("속성2를 선택해 주세요");
				return;
			}
			
			
			
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CT%>Ct010I",
	                "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
	                //prompt('ds1',ds1.text);
	                //prompt('ds2',ds2.text);
	                //prompt('ds3',ds3.text);
            		tr_post(tr1);
            	}
			}else {
         		alert("업데이트된 행이 없습니다.");
		 	}
		}

		/*
		 * 취소 
		 * 도급계약, 공동수급, 도급계약변경
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated) {
				ds1.undoall();
				ds2.undoall();
				ds3.undoall();
			}
			msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
			return;
		}

		/*
		 * 엑셀 
		 */
		/*
		function fnExcelGr1(){
			gr2.runexcel("공통코드관리");
		}
		*/
		
		<%//현장 팝%>
	    function fnSelSitePopup(dirPath) {
	        v_cust_row = 0;
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
	    
		<%//발주처 팝%>
	    function fnCtOrdererPopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtOrdererPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            v_orderer_nm.value = arrParam[1];	//NM
	            v_orderer_sid.value = arrParam[2];	//SID
	        } else {
				fnCtOrdererCleanup();
	        }               
	    }
	    <%//발주처 팝2%>
	    function fnCtOrdererPopup2(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtOrdererPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            orderer_nm.value = arrParam[1];	//NM
	            orderer_sid.value = arrParam[2];	//SID
	        } else {
				fnCtOrdererCleanup2();
	        }               
	    }
	    
	    
		<%//협력사 팝%>
	    function fnSelCoopPopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtCoopPop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            ds2.namevalue(ds2.rowposition,"coop_nm")  = arrParam[1];	//NM
	           	ds2.namevalue(ds2.rowposition,"coop_sid")  = arrParam[2];	//SID
	        } else {
				fnSelCoopCleanup();
	        }               
	    }

	    function fnSelCoopCleanup(){
	        coop_nm.value = "";
	        coop_sid.value  = "";
	    }

	     function fnSelSiteCleanup(){
		        v_site_nm.value = "";
		        v_site_sid.value  = "";
  		 }
   
   		function fnCtOrdererCleanup(){
		        v_orderer_nm.value = "";
		        v_orderer_sid.value  = "";
  		 }
  		 
  		function fnCtOrdererCleanup2(){
		        orderer_nm.value = "";
		        orderer_sid.value  = "";
  		 }
   
		/*
		 * 입력값 체크 
		 */
		function ln_Chk() {
			
			var row1=ds1.countrow;
			var row2=ds2.countrow;
			var row3=ds3.countrow;
			/*
			if(row1==0 || row2==0 || row3==0){
				alert("도급계약/공동계약/변경계약  값들을 입력하세요.");
				site_nm.focus();
				return;
			}
			*/
			for(i=1;i<=row1;i++) {
				if(ds1.namevalue(i,"site_nm")=="") {
					alert("도급계약 명을 입력해 주십시오");
					site_nm.focus();
					return;
				}else if (ds1.namevalue(i,"orderer_nm")=="") {			
					alert("발주처를 입력해 주십시오");
					orderer_nm.focus();
					return;
				}
			}		
			for(i=1;i<=row3;i++) {
				if(ds3.namevalue(i,"site_seq_ct")=="") {
					alert("계약 차수를 입력해 주십시오");
					return;
				} else if (ds3.namevalue(i,"site_seq_ch")=="") {			
					alert("변경 차수를 입력해 주십시오");
					return;
				} else if (ds3.namevalue(i,"site_status")=="") {			
					alert("계약 상태를 입력해 주십시오");
					return;
				}
			}			
			return true;
		}
	</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--도급계약-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  공동도급 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  변경계약 -->
	<param name="SyncLoad" 	value="true">
</object>
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<object id=ds_site_joint classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--공동여부-->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  주관여부 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_attr1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  속성1 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_site_attr2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  속성2 -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_use_yn classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용유무 -->
    <param name="SyncLoad"  value="false">
</object>

<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--계약차수-->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  변경차수 -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 계약상태 -->
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<!-- 
		마스터 그리드 OnClick
	-->
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
			fnSelect2(Row);
			row.value = ds1.RowPosition;
	</script>
	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
		if (colid=="coop_nm") {
			fnSelCoopPopup('<%=dirPath%>');
		}
	</script>
	<script language=JavaScript for=gr3 event=OnClick(row,colid)>
		if (colid=="site_seq_ct") {
			if (ds3.namevalue(ds3.rowposition, "site_seq_ct") != ""){
				alert("계약 차수는 수정할 수 없습니다.\n행추가시 1회 입력 가능합니다.");
			};
		}
		if (colid=="site_seq_ch") {
			if (ds3.namevalue(ds3.rowposition, "site_seq_ch") != ""){
				alert("변경 차수는 수정할 수 없습니다.\n행추가시 1회 입력 가능합니다.");
			};
		}		
	</script>
		
		        
	<!-- 
		디테일 행추가 
		방향키 아래를 누를경우 추가됨
	-->
	<script language=JavaScript for=gr2 event=onKeyPress(keycode)>
      	if (keycode == 40 && (ds2.CountRow == ds2.RowPosition) && ds2.namevalue(ds2.rowposition,"coop_sid") != "" && ds2.namevalue(ds2.rowposition,"site_rate") != "") {
				fnAddRowDs2();
    	}
      	if (keycode == 40 && (ds3.CountRow == ds3.RowPosition) && ds3.namevalue(ds3.rowposition,"site_seq_ct") != "" && ds3.namevalue(ds3.rowposition,"site_seq_ch") != "") {
				fnAddRowDs3();
    	}
    	
 	</script>
 	<script language=javascript for=gr3 event="OnExit(Row,Colid,OldData)">
	    if(Row==0) return;
	    if(Colid=="amt_ct_vat"){
		   	ds3.NameValue(Row, "amt_ct_tot") = 	ds3.NameValue(Row, "amt_ct") + ds3.NameValue(Row, "amt_ct_vat");
	   	}
	</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<!-- 
		마스터 작업 완료
	-->
		<script language="javascript" for="tr1" event="onsuccess()">
			msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
		</script>
	<!-- 
		마스터 작업 에러
	-->
		<script language="javascript" for="tr1" event="onfail()">
			msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
		</script>
	<!-- 
		디테일1 작업 완료
	-->		
		<script language="javascript" for="tr2" event="onsuccess()">
			msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
		</script>
	<!-- 
		디테일1 작업 에러
	-->
		<script language="javascript" for="tr2" event="onfail()">
			msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
		</script>
	<!-- 
		디테일2 작업 완료
	-->		
		<script language="javascript" for="tr3" event="onsuccess()">
			msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
		</script>
	<!-- 
		디테일2 작업 에러
	-->
		<script language="javascript" for="tr3" event="onfail()">
			msgTxt.innerHTML="작업이 성공적으로 완료되지 못했습니다.";
		</script>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' > 
  <tr>
	<td align='right'>
		<table border='0' cellpadding='0' cellspacing='0' width='845px'>
		  <tr>
			<td height='25px' align='right'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" 	onclick="fnSelect()">
				<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:pointer"   onClick="fnAddRowDs1()" >
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" 	onClick="fnApply();">
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"   onclick="fnCancel()">
			</td>
		  </tr>
		</table>
	</td>
  </tr>
    <tr>
        <td >
            <table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
            	<tr>
                	<td align="center" class="text" width="70">현장명</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
                    </td>
                    <td align="center" class="text" width="70">발주처</td>
                    <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_orderer_nm' id="v_orderer_nm" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnCtOrdererPopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_orderer_sid' id='v_orderer_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererPopup('<%=dirPath%>');" alt="조회창 팝">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererCleanup();" alt="값 지우기">
                    </td>
                </tr>					
			</table>
		</td>
	</tr>
	<tr height="12">
		<td></td>
  </tr>	
  <tr>
	<td>
		<table cellpadding="0" cellspacing="0">
		  <tr>
			<td class="l t" width="505px" >
				<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width:505px; height:312px" border="1">
					<param name="DataID"			value="ds1">
					<param name="BorderStyle"   	value="0">
					<param name="Fillarea"			value="true">
					<param name="ColSizing"     	value="true">
					<param name="IndWidth"     		value="0">
					<param name="editable"      		value="true">
					<param name="ViewSummary"       value="1">
					<param name="LineColor" 		value="#dddddd">
					<param name="Format"		value="  
						<C> name='현장\\번호' 	ID='site_sid'    width=50 	align=CENTER	 Edit=None show=true SumText='총' </C>
						<C> name='도급현장명' 	ID='site_nm' 	 Width=182  align=left 	 Edit=None editlimit=100 SumText=@count</C>
						<C> name='발주처'  		ID='orderer_nm'  Width=115  align=center Edit=None editlimit=50	</C>			
						<C> name='단축명' 	ID='site_nm_s'  width=80 	align=CENTER	Edit=None </C>
						<C> name='구매코드' ID='pu_site_cd'  width=60 	align=CENTER	Edit=None </C>
						<C> name='전화' 	ID='site_tel'  width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='팩스' 	ID='site_fax'  width=60 	align=CENTER	Edit=None show=false</C>

						
						<C> name='공동여부' 	ID='site_joint'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='주관여부' 	ID='site_main'    	width=60 	align=CENTER	Edit=None show=false</C>											
						<C> name='속성1' 		ID='site_attr1'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='속성2' 		ID='site_attr2'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='공동여부_NM' 	ID='site_joint_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='주관여부_NM' 	ID='site_main_nm'    	width=60 	align=CENTER	Edit=None show=false</C>											
						<C> name='속성1_NM' 	ID='site_attr1_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='속성2_NM' 	ID='site_attr2_nm'    	width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='발주처SID' 	ID='orderer_sid'  width=60 	align=CENTER	Edit=None show=false</C>
						<C> name='발주사이름' 	ID='orderer_nm'  width=60 	align=CENTER	Edit=None show=false</C>
					">
				</object>
			</td>

			<td class="r t " width="340px">
				<table border="0" cellpadding="0" cellspacing="0">
				  <tr>
					<td class="t">
						<table border='0' cellpadding='0' cellspacing='1' bgcolor="#666666">
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">현장명</td>
							<td colspan="3"  bgcolor="#FFFFFF" align="left">&nbsp;
								<input id="site_nm" type="text" class="textbox"   size="30" value="" maxlength="100" onBlur="bytelength(this,this.value,100);">
							</td>
						  </tr>
		                  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">발주처</td>
							<td bgcolor="#FFFFFF"  colspan="3" align=left>&nbsp;&nbsp;<input type="text" name='orderer_nm'  id="orderer_nm" size="23" class='input01'  onkeydown="if(event.keyCode==113) fnCtOrdererPopup2('<%=dirPath%>');" readOnly="readonly">
								<input type="hidden"  name='orderer_sid' id='orderer_sid'>
			                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererPopup2('<%=dirPath%>');" alt="조회창 팝">
			                    <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnCtOrdererCleanup2();" alt="값 지우기">
							</td>
						  </tr>	
						  <tr>
							<td height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">단축명</td>
		                    <td width="100px" class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="site_nm_s" type="text" class="textbox"   size="13" maxlength="10" ></td>
                   			<td width="60px" bgcolor="#eeeeee" align="center" class="boardt02">구매코드</td>
		                    <td width="100px" class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="pu_site_cd" type="text" class="textbox"   size="10" maxlength="4" ></td>   			                        
						  </tr>
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">전화</td>
		                    <td align=left bgcolor="#ffffff">&nbsp;
		                    	<input id="site_tel" type="text" class="textbox"   size="13" maxlength="20" ></td>
                   			<td bgcolor="#eeeeee" align="center" class="boardt02">팩스</td>
		                    <td class="l" bgcolor="#ffffff">&nbsp;
		                    	<input id="site_fax" type="text" class="textbox"   size="13" maxlength="20" ></td>   			                        
						  </tr>
						  <tr>
							<td height="24px" bgcolor="#eeeeee" align="center" class="boardt02">공동여부</td>
		                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
		                    	<object id=lc_site_joint classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
		                        	<param name=ComboDataID     value=ds_site_joint>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02">주관여부</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_main classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_main>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                        </td>   			                        
						  </tr>
						  <tr>
							<td  height="24px" bgcolor="#eeeeee" align="center" class="boardt02">속성1</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_attr1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_attr1>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02">속성2</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_site_attr2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_site_attr2>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>  
		                  </tr>
						  <tr>
							<td  height="24px" bgcolor="#eeeeee" align="center" class="boardt02">사용</td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            <object id=lc_use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
	                                <param name=ComboDataID     value=ds_use_yn>
                                          <param name=BindColumn      value="detail">
                                          <param name=BindColVal      value="detail">
                                          <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                          <param name=ListExprFormat  value="detail_nm^0^100">
	                            </object>
	                            
	                        </td>
							<td bgcolor="#eeeeee" align="center" class="boardt02"></td>
	                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;
	                            
	                        </td>  
		                  </tr>		                  
						</table>
					</td>
				  </tr>
				  <tr>
					<td class="r" style='padding-top:6px;padding-bottom:4px;'>
						<table border= "0" cellpadding=0 cellspacing=0 width="100%" >
							<tr>
								<td class="l">■ 공동도급</td>
								<td class="r">
									<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs2()" >
									<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs2()" >
								</td>
							</tr>
						</table>					
					</td>
				  </tr>

				  <tr>
					<td class="l t">
						<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr2  style="width:323px; height:100px" border="1">
							<param name="DataID"			value="ds2">
							<param name="BorderStyle"   	value="0">
							<param name="Fillarea"			value="true">
							<param name="ColSizing"     	value="true">
							<param name="IndWidth"     		value="0">
							<param name="editable"      	value="true">
							<param name="ViewSummary"       value="1">
							<param name="LineColor" 		value="#dddddd">
							<param name="Format"		value="  
								<C> name='순' 		ID='{CURROW}'   Width=50  align=center SumText='총계' </C>
								<C> name='회사sid' 	ID='coop_sid' 	 Width=125  align=left editlimit=50 show=false decao=0</C>
								<C> name='회사' 	ID='coop_nm' 	 BgColor=#D7FFDA Width=183  align=left editlimit=50  SumText=@count editstyle=popup </C>
								<C> name='비율(%)'  ID='site_rate'   Width=70 align=center editlimit=70 SumText=@sum	decao=0</C>				
								<C> name='Sitesid' 	ID='site_sid' 	 Width=125  align=left editlimit=50 show=false decao=0 </C>							
							">
						</object>
					</td>
				  </tr>
				</table>
			</td>

		  </tr>
		</table>
	</td>
  </tr>
	<tr>
		<td height="7"></td>
	</tr>
	<tr>
		<td height="10">
			<table border= "0" cellpadding=0 cellspacing=0 width="100%" >
				<tr>
					<td class="l">■ 계약정보</td>
					<td class="r">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDs3()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRowDs3()" >
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			<table border='0' cellpadding='0' cellspacing='0' width="845px"> 
				<tr>
					<td>
							<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr3"  style="WIDTH:845px;HEIGHT:200px" border="1">
								<param name="DataID"		value="ds3">
								<param name="BorderStyle"   value="0">
								<param name="Fillarea"		value="true">
								<param name="ColSizing"		value="true">
								<param name="IndWidth"		value="0">
								<param name="ViewSummary"       value="1">
								<param name="Editable"      value="true">
								<param name=SortView  		value="RIGHT">
								<param name="Format"		value="  
								    <C> name='계약\\차수' 	 ID='site_seq_ct'    BgColor=#D7FFDA	Width=50 	align=left editlimit=5 show=true 	sort=true	SumText='총' editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								    <C> name='변경\\차수' 	 ID='site_seq_ch'    BgColor=#D7FFDA	Width=50 	align=left editlimit=5 show=true  	sort=true	editstyle=lookup data='codeDs2:detail:detail_nm' SumText=@count</C>
								    <C> name='계약\\상태' 	 ID='site_status'    Width=50	align=left editlimit=10 show=true 	sort=true editstyle=lookup data='codeDs3:detail:detail_nm'</C>
								    <C> name='작성일자'      ID='date_made'       Width=80 	align=left  show=false sort=true</C>
								    <C> name='계약일자'      ID='date_ct'     	Width=75 	align=center show=true 	sort=true mask='XXXX-XX-XX'</C>
								    <C> name='시작일자'      ID='date_begin'	Width=75 	align=center show=true sort=true mask='XXXX-XX-XX'</C>
								    <C> name='종료일자'		 ID='date_end'      Width=75 	align=center show=true sort=true mask='XXXX-XX-XX'</C>
								    <C> name='공급가액'      ID='amt_ct'      	Width=102 		align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='부가세'        ID='amt_ct_vat'    Width=90 	align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='계약금액'      ID='amt_ct_tot'    Width=110 	edit=none align=right editlimit=15 show=true	SumText=@sum	decao=0</C>
								    <C> name='선수율\\(%)'   ID='rate_ac'       Width=50 	align=center show=true	decao=0</C>
								    <C> name='비고'        	 ID='remarks'       Width=100 	align=left editlimit=50 show=true</C>
								    <C> name='전자계약서\\번호'        	ID='site_eno'       Width=80 	align=left  show=false </C>
								    
								    <C> name='U_EMPNO'    ID='u_empno'     Width=50 	align=left editlimit=7 show=false</C>
   									<C> name='Sitesid' 		ID='site_sid' 	Width=125  align=left editlimit=50 show=false decao=0 </C>							
								">
							</object>
						
					</td>
				</tr>
			</table>
			※ 최초 입력시 계약차수="전체", 변경차수="-", 계약상태="진행"으로 입력해 주세요.<br>
			※ 한 번 저장한 계약차수와 변경차수는 수정되지 않습니다. 주의해 주세요.
			  
			
		</td>																		
	</tr>
</table>											
<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>	

        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=site_sid 	 	    	Ctrl=site_sid	 	       Param=value </C>
                    <C>Col=site_cd         		Ctrl=site_cd 	           Param=value </C>
                    <C>Col=site_nm  	       	Ctrl=site_nm 	           Param=value </C>
                    <C>Col=site_nm_s  	       	Ctrl=site_nm_s 	           Param=value </C>
                    <C>Col=pu_site_cd 	       	Ctrl=pu_site_cd	           Param=value </C>
                    <C>Col=site_tel  	       	Ctrl=site_tel	           Param=value </C>
                    <C>Col=site_fax 	       	Ctrl=site_fax 	           Param=value </C>
                    
                    <C>Col=site_joint 	        Ctrl=lc_site_joint             Param=BindColVal </C>
                    <C>Col=site_main 	        Ctrl=lc_site_main             Param=BindColVal </C>
                    <C>Col=site_attr1 	        Ctrl=lc_site_attr1             Param=BindColVal </C>
                    <C>Col=site_attr2 	        Ctrl=lc_site_attr2             Param=BindColVal </C>
                    <C>Col=use_yn	 	        Ctrl=lc_use_yn             Param=BindColVal </C>
                    <C>Col=orderer_sid   	  	Ctrl=orderer_sid	       Param=value </C>
                    <C>Col=orderer_nm   	  	Ctrl=orderer_nm	       Param=value </C>                    
                    <C>Col=coop_sid      	    Ctrl=coop_sid             Param=valuel </C>
                    <C>Col=site_rate 		    Ctrl=site_rate   		   Param=value </C>
                    <C>Col=site_seq_ct         Ctrl=site_seq_ct          Param=value </C>
                    <C>Col=site_seq_ch        Ctrl=site_seq_ch          Param=value </C>
                    <C>Col=site_status    	 	Ctrl=site_status    	   Param=value </C>
                    <C>Col=date_ct 			    Ctrl=date_ct	           Param=value </C>
                    <C>Col=date_begin    	    Ctrl=date_begin 	       Param=value </C>
                    <C>Col=date_end		    Ctrl=date_end		       Param=value </C>
                    <C>Col=amt_ct_tot          Ctrl=amt_ct_tot            Param=value </C>
                    <C>Col=amt_ct        		Ctrl=amt_ct 		       Param=value </C>
                    <C>Col=amt_ct_vat          Ctrl=amt_ct_vat           Param=value </C>
                    <C>Col=date_made          Ctrl=date_made           Param=value </C>
                    <C>Col=site_eno     	    Ctrl=site_eno 	           Param=value </C>
                    <C>Col=rate_ac         		Ctrl=rate_ac	           Param=value </C>
            ">
        </object>
         
		<input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		