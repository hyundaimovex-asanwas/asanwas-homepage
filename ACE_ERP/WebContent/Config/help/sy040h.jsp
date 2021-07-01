<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 결재선 지정
 * 프로그램ID   : SY040H
 * J  S  P      : Common/help/sy040h
 * 서 블 릿        : Sy040h
 * 작 성 자        : 정하나
 * 작 성 일        : 2010-09-06
 * [ 수정일자 ][수정자] 내용
 * [2014-06-17][심동현] 작업일보 하면서 공통 모듈로 새로 옮겨서 제작
 *						√ 대상 DB를 ASNHR로 이전, 프로시저 COMMON으로 이전
 *						√ 이름 검색시 트리 펼치기
 *						√ 조직트리가 기안자의 부서에서 열려 있기, 그 부서원이 우측에 표시되기.
 *						√ 올리기 내리기 삭제 기능
 * [2014-06-18][심동현] √ UI 수정
 * [2014-07-01][심동현] 내 결재선 관리 테스트
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

    //로그인 체크 : 2013-12-04 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크

	// (ssID + 유저포지션값 + IP) 비교
	if(!gusrpos.equals("Tadaima") ){
	//경고와 함께 메인 화면으로 
		%>
		<script language="javascript">
		alert("시간이 오래되어 자동 로그아웃되었거나\n정상 접근이 아닙니다.\n\n새로 로그인 해주세요.");
		window.close();	//창모드로 변경(2013-12-04)
		</script>
		<%
		return;
	}
	//로그인 체크 끝 ///////////////////////////////////////////////////////////////////////////////////////
%>
<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="viewport" content="width=1080" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<title>전자결재 : 결재선 지정　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
	</title>
	
	<%
	/*=============================================================================
				Style Sheet, Common Java Script Link
	=============================================================================*/
	%>		
	<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
	<link href="<%=dirPath%>/Common/css30/ap_layout.css" rel="stylesheet" type="text/css">  <%//전자결재용용... %>	
	<%// 전자결재용 소스 %>
	<script language="javascript" src="<%=dirPath%>/Config/common/js/ap_gauce.js"></script>
    
<%
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
	<script language="javascript">
		function cfLengthCheck(targetObj, maxLength) {
		    var len = 0;
		    var newtext = "";
		    for(var i=0 ; i < targetObj.value.length; i++) {
		        var c = escape(targetObj.value.charAt(i));
	
		        if ( c.length == 1 ) len ++;
		        else if ( c.indexOf("%u") != -1 ) len += 2;
		        else if ( c.indexOf("%") != -1 ) len += c.length/3;
	
		        if( len <= maxLength ) newtext += unescape(c);
		    }
	
		    if ( len > maxLength ) {
		        targetObj.value = newtext;
		        targetObj.focus();
		        return false;
		    }
		}

		var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
		var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
		var  gcurdate	="<%=(String)session.getAttribute("vcurdate")%>";
		var  gdeptcd	="<%=(String)session.getAttribute("vdeptcd")%>";
		var v_default_row = 1;
		var sApproveLine;

		
		
		
		<% //페이지로딩%>
		function fnOnLoad(){
			cfStyleGrid(getObjectFirst("gr_master"), "approval");
			cfStyleGrid(getObjectFirst("gr_detail"), "apline");
			fnInit(); 					//초기화 작업
			ln_tree(gdeptcd);			// 조직 트리 펼치기
			fnTreeOnlick(gdeptcd,"3");	// 로긴 사용자 부서원 조회
			fnMyApline(); 				// 내 결재선 관리 조회 : 이걸 가장 늦게 불러야 나의 부서원 정보를 받아올 수 있습니다.
			
		} 
        
        <% //초기작업 : 공통코드, 조직트리 %> 
		function fnInit() {    
			ln_SetDataHeader();			// 결재선 헤더 설정
			ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
			ds_gc_aptype.Reset();	//결재유형 AP005

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";
			ln_TRSetting(tr1,
	        	"<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H", 
	        	"JSP(O:DS_ORG_TREE=ds_org_tree)",
	       		param);
	        tr_post(tr1);
		}
		
		<% //나의 결재선(luxcombo) 조회%>
		function fnMyApline() {				
			v_job = "S";         
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" ;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_MY_APLINE=ds_my_apline)",
	            param);
	        tr_post(tr2);  	        	        
	     }
	    
	    <% // 내 결재선 콤보 변경시 불러오기%>
	    function fnSelect2(){
	        v_job = "S";         
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
			    + "v_sid=" + lc_apline.BindColVal;
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
			    "JSP(O:DS_APLINE=ds_apline)",
			    param);
			tr_post(tr2);  
				       
	    }
		
	    <% // 트리 클릭시 해당 부서원 조회 %>
		function fnTreeOnlick(dptcd,dptlv){					
	        v_job = "S";         
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
	        	+ "v_dept_lv =" + dptlv + ","    
	        	+ "v_dept_cd =" + dptcd ;       
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_EMPLIST=ds_emplist)",
	            param);
	        tr_post(tr1);
	        			
		}

		<% //부서원조회 - 이름 검색%>
	    function fnSelect(){  
	        v_job = "emplist";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "v_cust_nm=" + v_cust_nm.value;       
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(O:DS_EMPLIST=ds_emplist)",
	            param);
	        tr_post(tr2);	       
	    }		
		
	    <% //결재선 데이터셋 헤더 %>
		function ln_SetDataHeader(){
			if (ds_apline.countrow<1){
				var s_temp = " CREATE_YN:STRING(1),DUMMY:DECIMAL(1),SEQ: DECIMAL(5),ENO_NO:STRING(7),APPROVE_TYPE:STRING(10),ENO_NM:STRING(30),"
						   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),SID:NUMERIC(10.0) ";
				ds_apline.SetDataHeader(s_temp);
			}
		}

		<% //메뉴트리 펼치기 %>
		function ln_tree(dptcd){
			if(dptcd=="undefined"){	//초기 인덱스화면인 경우
	       		TreeView_org.Expand(0);
			} else{
		    	for (i = 1; i <= ds_org_tree.countrow; i++) {
		    		if(dptcd == ds_org_tree.namevalue(i,"DEPTCD")) {
			       		TreeView_org.Expand(i);
		    		};
		    	};
			};
		}
		
		<% //결재선 행상태, 순번 설정 %>
		function ln_add_seq(){
			for(i=1;i<=ds_apline.CountRow;i++){
	      		ds_apline.namevalue(i,"DUMMY") = 1;	//더미 컬럼을 1로 변경 ==>> 업데이트행이 됨.
	      	}     

	        for(k=1;k<=ds_apline.CountRow;k++){
				ds_apline.NameValue(k, "SEQ") =  ds_apline.CountRow-k+1 ;	//위에서부터 역순으로 세팅
			}	
		}
		
		<% // 결재선 초기화 : 담당=로그인사용자로 설정 %>
		function fnInitApline(){;
			ds_apline.ClearData();
			ds_apline.AddRow();
			ds_apline.NameValue(1, "APPROVE_TYPE") = 1;
			ds_apline.NameValue(1, "SEQ") = 1;
			ds_apline.NameValue(1, "ENO_NO")    	= gusrid;
	    	for (i = 1; i <= ds_emplist.countrow; i++) {
	    		if(gusrid == ds_emplist.NameValue(i, "ENO_NO")) {
	    			ds_apline.NameValue(1, "ENO_NM")     	= ds_emplist.NameValue(i, "ENO_NM");
	    		    ds_apline.NameValue(1, "JOB_NM")      	= ds_emplist.NameValue(i, "JOB_NM");
	    		    ds_apline.NameValue(1, "DPT_NM")       	= ds_emplist.NameValue(i, "DPT_NM");
	    		};
	    	};
		};		

		<% // 결재선 취소 %>
	    function fnCancel(){    
	        ds_apline.UndoAll();
	        fnInitApline();    
	    }
	    
		<% // 결재선 행삭제%>
		function fnAplineDel() {
			ds_apline.DeleteRow(ds_apline.RowPosition);	
		} 

		<% // 결재선 행 올리기%>
		function fnAplineUp() {
			var nowPos = ds_apline.RowPosition; 
			var newRowPos;
			var oldRowPos;
			
			if(nowPos > 1){//1보다큰행이어야 올라올 자리 잇음
				newRowPos = nowPos - 1;
				ds_apline.InsertRow(newRowPos);	// 나보다 1개 위 행에서 인서트로우
				oldRowPos = nowPos + 1;			// 원본 행은 +1 자리로 밀린다. 
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(oldRowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(oldRowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(oldRowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(oldRowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(oldRowPos, "DPT_NM");
			    ds_apline.DeleteRow(oldRowPos);	// 원본 행 삭제
			    ln_add_seq();
			}else{
				return false;
			}
		} 		
		

		<% // 결재선 행 내리기%>
		function fnAplineDown() {
			var nowPos = ds_apline.RowPosition;
			var totRow = ds_apline.countrow;
			var newRowPos;
			newRowPos = nowPos + 2;	// 갈 자리는 다다음행
			
			if(newRowPos > totRow){ // 다음 행이 끝자리면 //totRow와 같지 않아야 내려갈 자리 잇음
				ds_apline.AddRow();	// 끝행 추가
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(nowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(nowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(nowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(nowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(nowPos, "DPT_NM");
			    ds_apline.DeleteRow(nowPos);	// 원본 행 삭제
			    ln_add_seq();
			}else if(newRowPos <= totRow){ // 다음 행이 끝자리면 //totRow와 같지 않아야 내려갈 자리 잇음
				ds_apline.InsertRow(newRowPos);	// 갈 자리에서 인서트로우;
				ds_apline.NameValue(newRowPos, "APPROVE_TYPE") = ds_apline.NameValue(nowPos, "APPROVE_TYPE");
				ds_apline.NameValue(newRowPos, "ENO_NO") = ds_apline.NameValue(nowPos, "ENO_NO");
			    ds_apline.NameValue(newRowPos, "ENO_NM") = ds_apline.NameValue(nowPos, "ENO_NM");
			    ds_apline.NameValue(newRowPos, "JOB_NM") = ds_apline.NameValue(nowPos, "JOB_NM");
			    ds_apline.NameValue(newRowPos, "DPT_NM") = ds_apline.NameValue(nowPos, "DPT_NM");
			    ds_apline.DeleteRow(nowPos);	// 원본 행 삭제
			    ln_add_seq();
			}else{
				return false;
			}
		} 			
		
						
		<% 
		// Description 	:  팝업창 닫기
		// Parameter 	: A - 선택
		%>			
		function fnClose(p){	
			var returnValue;
			var returnValue2="";
			if (p=="A") {
				if(ds_apline.countrow>0){
					for(i=1;i<=ds_apline.countrow;i++){
						//alert("::"+ds_apline.namevalue(i,"APPROVE_TYPE")+"::");
						if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
							alert("결재 유형을 선택해 주세요."); 
							return false;
						}
						if(ds_apline.namevalue(i,"ENO_NO")==""){
							alert("결재자를 선택해 주세요."); 
							return false;
						}
						
						returnValue = "1" + "/" 
							+ ds_apline.namevalue(i,"SEQ")  + "/" 
							+ ds_apline.namevalue(i,"APPROVE_TYPE")  + "/" 
							+ ds_apline.namevalue(i,"ENO_NO")  + "/"
							+ ds_apline.namevalue(i,"ENO_NM")  + "/"
							+ ds_apline.namevalue(i,"JOB_NM")+"/"
							+ ds_apline.namevalue(i,"DPT_NM")+"/"
							+ ds_apline.namevalue(i,"SID")+";"  
				   		returnValue2 =    returnValue2 + returnValue;            
					                   	 	
		
					}
					//alert(returnValue2);
					window.returnValue = 	returnValue2 ;			
					window.close();
				}else{
					alert("반영할 결재선이 없습니다. 결재선을 생성해주세요.");
				}
			} else {	//취소 닫기
				window.close();
			}
		}

    

	
		<% //내 결재선 저장 %>      
		function fnSave(){
			if (ds_apline.isUpdated ){  		
  			 	if (v_app_nm.value==""){
  		 			alert("개인결재선명을 입력해주세요");
  		 			return false;
  		 		}
				for(var i=1; i<=ds_apline.CountRow; i++){
					if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
						alert("결재 유형을 선택해 주세요."); 
						ds_apline.RowPosition = i;
						return;
					}
	         	}
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	     				+ "v_app_nm=" + v_app_nm.value+","
	     				+ "v_sid=" + lc_apline.BindColVal;  
	     	
				ln_TRSetting(tr_save,
				        "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
						"JSP(I:DS1=ds_apline)",
						param);
				tr_post(tr_save);
				fnMyApline();
	 		}else{
				alert("변경된 결재선이 없습니다.\n\n결재선을 새로 만들어 주세요.");
	 		}
		}
		
		<% //내 결재선 수정 %>
		function fnCorrect(){
			for(var i=1; i<=ds_apline.CountRow; i++){
				if(ds_apline.namevalue(i,"APPROVE_TYPE")==""){
					alert("결재 유형을 선택해 주세요."); 
					ds_apline.RowPosition = i;
					return;
				}
         	}

			// 그냥 서밋하면 데이터셋이 전달이 안되네.. 아무 변동이 없어서..
			// 따라서 데이터셋을 강제로 업뎃 상태로 만들어주기
			for(i=1;i<=ds_apline.CountRow;i++){
				ds_apline.namevalue(i,"DUMMY") = 1;
			}

			// 그리고나서 마스터는 업데이트, 디테일은 삭제 후 새로 insert 해주기
		    var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2,"
 					+ "v_app_nm=" + v_app_nm.value+","
		   	     	+ "v_sid=" + lc_apline.BindColVal;  
		   	     	
		    ln_TRSetting(tr_save,
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	            "JSP(I:DS1=ds_apline)",
	            param);
			tr_post(tr_save);
			fnMyApline();
		}
    
	<% // 내 결재선 삭제 %>
    function fnDelete(){
        if(confirm("삭제하시겠습니까? ")==false){
            return;
		}    
         for(i=1;i<=ds_apline.CountRow;i++){
        	ds_apline.namevalue(i,"DUMMY") = 1;
         }

	     var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3,"
	   	     	+ "v_app_nm=" + v_app_nm.value+","
	   	     	+ "v_sid=" + lc_apline.BindColVal;  
	   	     	
		 ln_TRSetting(tr_save,
	    	"<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
	     	"JSP(I:DS1=ds_apline)",
	     	param);
	     tr_post(tr_save);
	     fnMyApline();
    }	

    


    </script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="TreeView_org" event="onClick()">
	var dptcd = ds_org_tree.namevalue(ds_org_tree.rowposition,"DEPTCD");
	var dptlv = ds_org_tree.namevalue(ds_org_tree.rowposition,"DEPT_LEVEL");
	fnTreeOnlick(dptcd,dptlv);
</script>


<script language="javascript" for="ds_my_apline" event="onloadCompleted(row,colid)">
	ds_my_apline.insertrow(1);
	ds_my_apline.namevalue(1,"SID") = "";
	ds_my_apline.namevalue(1,"APPROVE_NM") = "신규등록";
	lc_apline.index = 0;
</script>

<% //내 결재선 관리 처음 불러올 때 %>
<script language=JavaScript for=lc_apline event=OnSelChange()>
	if (lc_apline.index ==0 ) {
		sp0.style.display = "";		//버튼 제어
		sp1.style.display = "none";
		sp2.style.display = "none";
		v_app_nm.value = "";		// 결재선명 공란
	
		fnInitApline();	// 결재선 초기화 : 담당=로그인사용자로 설정
		
    }else{
		sp0.style.display = "none";
		sp1.style.display = "";
		sp2.style.display = "";	 	    	 	        	
		fnSelect2();
	
		v_app_nm.value = ds_my_apline.NameValue(ds_my_apline.RowPosition, "APPROVE_NM");
	}        	                   
</script>
  
		      
<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">
	for (i = 1; i <= ds_apline.countrow; i++) {
		if(ds_apline.NameValue(i, "ENO_NO") == ds_emplist.NameValue(Row, "ENO_NO")) {
			alert("결재자를 중복 지정할 수 없습니다.");
			return false;
		};
	};
	var RowPos ;
    if(ds_apline.RowPosition==0) {	//다 지우고 추가할 때
    	RowPos = 1;
    }else{
    	RowPos = ds_apline.RowPosition;
    }
    ds_apline.InsertRow(RowPos);
    ds_apline.NameValue(RowPos, "ENO_NO")    	= ds_emplist.NameValue(Row, "ENO_NO");
    ds_apline.NameValue(RowPos, "ENO_NM")     	= ds_emplist.NameValue(Row, "ENO_NM");
    ds_apline.NameValue(RowPos, "JOB_NM")      	= ds_emplist.NameValue(Row, "JOB_NM");
    ds_apline.NameValue(RowPos, "DPT_NM")       = ds_emplist.NameValue(Row, "DPT_NM");
	ln_add_seq();

</script>		


												
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="onsuccess()">
</script>

<script language="javascript" for="tr1" event="onfail()">
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr2" event="onsuccess()">
	if(v_job=="emplist"){
		var dptcd= ds_emplist.namevalue(ds_emplist.rowposition,"DPT_CD");
		ln_tree(dptcd);    
	}

</script>

<script language="javascript" for="tr2" event="onfail()">
    
    alert("<%=HDConstant.S_MSG_SAVE_ERR%>");         
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    
    alert("<%=HDConstant.S_MSG_SAVE_DONE%>");
//     fnMyApline();
    
    
</script>

<script language="javascript" for="tr_save" event="onfail()">
    
    alert("<%=HDConstant.S_MSG_SAVE_ERR%>");         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
        
    fnSelect();
</script>


<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<!--조직트리 --> 
<OBJECT id=ds_org_tree classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="TREECD">
</OBJECT>

<!--부서원 --> 
<OBJECT id=ds_emplist classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--결재선 --> 
<OBJECT id=ds_apline classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--결재선관리 --> 
<object  id=ds_my_apline classid=<%=HDConstant.CT_DATASET_CLSID%>>  
    <param name="SyncLoad"  value="False">
</object>  

<!--결재선타입 --> 
<object  id=ds_gc_aptype classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
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
</head>

<body onLoad="fnOnLoad();">
<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border=0 cellpadding='0' cellspacing='0'>
  <tr>
  	<td width="10">&nbsp;</td>
  	<td width="600" class="t"><br>
    <table border='0' cellpadding='0' cellspacing='0'> 
	  <tr>
		<td>
		<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
		  <tr height='25px'>
			<td class="text" width="80">이름</td>
			<td class="l" width="517" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
			<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer"  onclick="fnSelect()" >
			</td>	                                                                                 
			<!-- <td class="text" width="80">부서</td> -->
			<!-- <td class="c" width="275" bgcolor="#ffffff">&nbsp;<input type="text" name="v_dept_nm" maxlength="14" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"> -->
				
			</td>
		  </tr>
    	</table>
		</td>
	  </tr>
	  <tr height='6px'>
		<td></td>
	  </tr>
	  <tr>
		<td class="t">
		<table border=0 cellspacing=0 cellpadding=0>
		  <tr>
			<td width="241" style="border:1 solid #666666;">                           
			<object id="TreeView_org" classid="clsid:4401B994-DD33-11D2-B539-006097ADB678" style="width:241px; height:230px; font-size:9pt"> 
				<Param Name="DataID"		value="ds_org_tree">
				<Param Name="TextColumn"	value="DEPTNM">
				<Param Name="LevelColumn"	value="DEPT_LEVEL">
				<Param Name="BorderStyle"	value="0">
				<param name="useimage"		value="false">
			</object>			                            
			</td>
			<td width="356" style="border-top:1 solid #666666;border-bottom:1 solid #666666;border-right:1 solid #666666;">
				<object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='356px' height='230px' border='0'>
					<param name="DataID"            value="ds_emplist">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="true">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name="Format"            value="
						<C>ID=ENO_NO		 Name=사번	 width=70	align=center	Edit=None	show=false</C>
						<C>ID=ENO_NM	 Name=이름	 width=70 	 align=center	 Edit=None</C>
						<C>ID=JOB_NM	 Name=직위	 width=100	 align=center 	 Edit=None</C>																					
						<C>ID=DPT_NM	 Name=부서	 width=169	 align=left 	 Edit=None</C>												
					">
				</object>
			</td>       
		  </tr>
		</table>

		</td>
	  </tr>
	  <tr height=5><td></td></tr>
	  <tr>
		<td>
		<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
		  <tr height='25px'>
			<td class="text" width="100">내 결재선 관리</td>
			<td width="140" class="c" bgcolor="#ffffff">																									
	            <object id=lc_apline classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
					<param name=ComboDataID		value=ds_my_apline>
					<param name=BindColumn      value="sid"">
					<param name=BindColVal      value="sid">
					<param name=EditExprFormat	value="%,%;sid,approve_nm">
					<param name=ListExprFormat  value="approve_nm^0^120">
				</object>
			</td>		                                                                                 
			<td class="text" width="100">내 결재선명</td>
			<td class="l" width="255" bgcolor="#ffffff">&nbsp;<input type="text" name="v_app_nm" size="20" maxlength="20" class="textbox"  OnKeyUp="cfLengthCheck(this, 20);">
				<span id=sp0 style="display:none;">						                 		
				<img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:pointer" onclick="fnSave()">
				</span>
				<span id=sp1 style="display:none;">
				<img src="<%=dirPath%>/Sales/images/correct.gif"  style="cursor:pointer" onclick="fnCorrect()">
				</span>
				<span id=sp2 style="display:none;">
				<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:pointer" onclick="fnDelete()">
        		</span>
			</td>
		  </tr>
		</table>	
		</td>
	  </tr>    	
	  <tr height=5><td></td></tr>	  
	  <tr>
		<td height='25px' align='right'>
			<img src="<%=dirPath%>/Sales/images/btn_ap_up.gif" style="cursor:pointer"  onClick="fnAplineUp()">
			<img src="<%=dirPath%>/Sales/images/btn_ap_dn.gif" style="cursor:pointer"  onClick="fnAplineDown()">
			<img src="<%=dirPath%>/Sales/images/btn_ap_del.gif" style="cursor:pointer" onClick="fnAplineDel()">
			  
			
		</td>
	  </tr>
	  <tr>
		<td class="t" style="border:1 solid #666666;">
        <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='598px' height='100px' border='0'>
			<param name="DataID"            value="ds_apline">
			<param name="ColSizing"         value="true">
			<param name="Editable"          value="true">
			<param name="SuppressOption"    value="1">
			<param name="BorderStyle"       value="0">
			<param name="Format"            value="												    
				<C>ID='CREATE_YN'	 Name='선택'	 Width=35	 align=center editlimit=1 editstyle=checkbox show=false</C>
					<C>ID='DUMMY'			 Name='DUM'	 Width=40	 align=center Edit=None SHOW=false </C>
				<C>ID='SEQ'			 Name='순번'	 Width=40	 align=center Edit=None</C>
				<C>ID=APPROVE_TYPE	 Name='유형'	 width=80	 align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' </C> 
				<C>ID=ENO_NM		 Name=이름		 width=121	 align=center Edit=None</C>
				<C>ID=JOB_NM		 Name=직위		 width=120	 align=center Edit=None</C>
				<C>ID=DPT_NM		 Name=부서		 width=220	 align=left Edit=None</C>	       
				<C>ID=ENO_NO		 Name=사번		 width=70	 align=center Edit=None show=false </C>
				<C>ID=SID			 Name=결재선sID	 width=70	 align=center Edit=None show=false </C>

			">
		</object>
		</td>																	
	  </tr>
	  <tr>
		<td height='25px' align='right'>
			<img src="<%=dirPath%>/Sales/images/ap_line.gif" style="cursor:pointer"  onClick="fnClose('A')" >
			<img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:pointer" onclick="fnCancel()">                              
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"  style="cursor:pointer" onclick="fnClose('C')">                          
    </td>
</tr>  


	</table>
  	</td>
  	<td width="10">&nbsp;</td>
  </tr>
</table>
  	
                                

                              

                                                                                  						                 						                 
</body>
</html>
<!-- BODY footer end-->


