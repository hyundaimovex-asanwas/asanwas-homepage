<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>관광>객실>컨텐츠카드>정보 조회
 * 프로그램ID 	 : SALES/RM/RM260S
 * J  S  P		 : rm260s.jsp
 * 서 블 릿		 : Rm260s
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2017-09-04
 * [ 수정일자 ][수정자] 내용
 * [2017-09-04][심동현] 신규 개발 
 *						- 뭐가 필요하다고도 안하고.. 일단 한다 .-_
 * [2017-09-27][심동현] 이것저것 ui가 건드릴게 많습니다.
 *						이미지가 몇개 저장될지 모릅니다. 수십개일 수도 있죠.. 원래 따로 간다고 해놓고 ㅋㅋ-_- 에고 머리야.. 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
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
		cfStyleGrid(getObjectFirst("gr_ccl"), "comn");	//contents card list
		cfStyleGrid(getObjectFirst("gr_ccimg"), "comn");	//contents card Images
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    
        ds_gc_type_sc.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM028&s_item1=Y&s_item2=Y";
        ds_gc_type_sc.Reset();	//컨텐츠 타입 RM028
        ds_gc_country_sc.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY005&s_item1=Y";
        ds_gc_country_sc.Reset();	//국가코드 SY005
        ds_gc_city_sc.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY018&s_item1=Y";
        ds_gc_city_sc.Reset();	//도시코드 SY018 
        ds_gc_useyn_sc.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY011&s_item1=Y";
        ds_gc_useyn_sc.Reset();	// 사용여부 sy011

        
	    ds_gc_type.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM028&s_item1=Y&s_item2=Y";
        ds_gc_type.Reset();	//컨텐츠 타입 RM028

        ds_gc_country.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY005&s_item1=Y";
        ds_gc_country.Reset();	//국가코드 SY005

        ds_gc_city.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY018&s_item1=Y";
        ds_gc_city.Reset();	//도시코드 SY018 

        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY011&s_item1=Y";
        ds_gc_useyn.Reset();	// 사용여부 sy011
        
        ds_gc_licyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=RM029&s_item1=Y";
        ds_gc_licyn.Reset();	// 저작권 RM029 
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
            "JSP(O:DS_CCL=ds_ccl,O:DS_CCIMG=ds_ccimg)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
            + ",vCountry=" + lc_gc_country_sc.ValueOfIndex("detail", lc_gc_country_sc.Index)
            + ",vCity=" + lc_gc_city_sc.ValueOfIndex("detail", lc_gc_city_sc.Index)
            + ",vCdType=" + lc_gc_type_sc.ValueOfIndex("detail", lc_gc_type_sc.Index)
            + ",vCdUseYn=" + lc_gc_useyn_sc.ValueOfIndex("detail", lc_gc_useyn_sc.Index)
            ;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
            "JSP(O:DS_CCL=ds_ccl)",
            param);
        tr_post(tr1);
    }

    <%// Contents Card 신규 %>
	function fnNewCC(){
		if(ds_ccl.IsUpdated) {
			alert("수정중인 기본정보 또는 상세정보가 있으면\n\n신규 정보를 생성할 수 없습니다.");
			return;
		}else {
	        ds_ccl.addrow();
	        ds_ccl.namevalue(ds_ccl.rowposition,"CD_USEYN") 	= "Y" ;
	        ds_ccl.namevalue(ds_ccl.rowposition,"FROM_LIC") 	= "Q" ;
	        ds_ccl.namevalue(ds_ccl.rowposition,"FROM_URL") 	= " " ;
	        ds_ccl.namevalue(ds_ccl.rowposition,"FROM_TXT") 	= " " ;	        
		}
	}

	<%//저장 - 메인 그리드%>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_ccl.RowPosition;
		
		if (ds_ccl.IsUpdated) { 	//|| ds_wd.IsUpdated || ds_detail1.IsUpdated || ds_detail2.IsUpdated || ds_detail3.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
                "JSP(I:DS_CCL=ds_ccl)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	+ ",v_dwr_sid=1"//+ ds_wm.namevalue(ds_wm.row,"DWR_SID")
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
		
	<%// 입력값 체크 %>
	function ln_Chk() {
		/*var row1=ds_wm.countrow;
		//var row2=ds_tender.countrow;

		if(w_date.Text.length<8) {
			alert("날짜를 정확히 입력해 주십시오");
			w_date.focus();
			return;
		}*/
		return true;
	}

    <%// 디테일 그리드 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Si110I",
            "JSP(O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            v_param);
        tr_post(tr1);
    }

    
    <%// 첨부 IMG 목록 조회 %>
    function fnSelectIMG() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
        			+ ",v_ctscard_sid=" + ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID") 
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
            "JSP(O:DS_CCIMG=ds_ccimg)",
            param);
        tr_post(tr1);
    }
    
	<%// 저장 - 첨부 IMG 정보 %>
	function fnApplyIMG(){
		v_job = "A";
		if (ds_ccimg.IsUpdated) { 	//|| ds_wd.IsUpdated || ds_detail1.IsUpdated || ds_detail2.IsUpdated || ds_detail3.IsUpdated) {
			ln_TRSetting(tr1, 
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
               "JSP(I:DS_CCIMG=ds_ccimg)",
               "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
               	);
       		tr_post(tr1);
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}
	}
    
    
    
    function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
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
		//ds_wd.DeleteRow(ds_wd.RowPosition);
	};

	<%// 신규 입력 취소 %>
	function fnCancel() {
		ds_ccl.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
	}
	
	

	//파일업로드 함수 1
	//이미지 서버로 올리기
	function tempUpload(){
		if (ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID") == 0 ) {
			alert("'관광정보'가 저장되지 않았습니다.\n신규 '관광정보'는 먼저 저장(상단 버튼) 후 이미지를 업로드해야 합니다.");
			return;
		}
		
		if (ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID") == undefined || ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID") == "" ) {
			alert("'관광정보'가 선택되지 않았습니다.\n이미지를 업로드하기 전에 해당하는 '관광정보'를 선택해야 합니다.");
			return;	
		}

		return false;

		
		f = document.fileForm;
		
	    if(f.file1.value.length == 0 || f.file1.value == "첨부파일은 최대 10M까지 가능합니다.")
		{
			alert('업로드할 파일을 선택하여 주십시요');
			return;
		}
	
	    var realFileName = f.file1.value;
		var idx = realFileName.lastIndexOf("\\");
		realFileName = realFileName.substring(idx+1);
		//alert(realFileName);
		

		if(realFileName.indexOf(".jpg") < 0 && realFileName.indexOf(".JPG") < 0){
			alert("'jpg파일'만 첨부 가능합니다.\n\n파일을 확인해주세요.");
			return;
		}
		
		strArray = realFileName.split("."); 
		strArray2 = realFileName.split("|");
	  
		//파일이름에 [.] 이 있으면 안된다.(확장자 제외)
		if(strArray.length > 2){
		  alert("파일이름 중 '.' 이 있으면 삭제하여 주십시요 ");
		  return;
		}

		if(strArray.length < 1){
		  alert("확장자명은 반드시 있어야 합니다.  ");
		  return;
		}
				
		//파일이름에 [|] 이 있으면 안된다.
		if(strArray2.length > 1){
		  alert("파일이름중 '|' 이 있으면 모두 삭제하여 주십시요 ");
		  return;
		}

		f.target="tempUploadFrm";	//업로드 폼의 타겟은 iFrame !
		f.realFileName.value=realFileName;
		f.mode.value="insert";
		f.m_cc_sid.value = ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID");
		f.action = "./rm_upload.jsp";
		f.submit();
	}
	
	//파일업로드 2
	//파일 subgrid 저장 : iFrame 안에서 호출한다
	function addFileList(realName, virtualName)	{
		//alert("리얼?="+realName);	//IMG_NM
		//alert("virtualName="+virtualName);	//IMG_FILE
		v_job = "IMG";

		ds_ccimg.addrow();
			ds_ccimg.namevalue(ds_ccimg.rowposition,"CTSCARD_SID")	= ds_ccl.namevalue(ds_ccl.rowposition,"CTSCARD_SID");
			ds_ccimg.namevalue(ds_ccimg.rowposition,"FILE_IMG")		= realName;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"FILE_SVR") 	= virtualName;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"WEB_DESC") 	= " " ;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"WEB_SHOW") 	= "N" ;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"WEB_SEQ") 	= 0 ;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"FROM_LIC") 	= "Q" ;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"FROM_URL") 	= " " ;
			ds_ccimg.namevalue(ds_ccimg.rowposition,"FROM_TXT") 	= " " ;
			
		//이렇게 받으면 음.. 파일명을 나중에 편집하라고 할끄나.. 일단은 원래 이름으로 하고?
		if (ds_ccimg.IsUpdated) {
			ln_TRSetting(tr2, 
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260I",
               "JSP(I:DS_CCIMG=ds_ccimg)",
               "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
               	+ ",v_dwr_sid=1"		// 뭔가 던져야 할 수도
               	);
       		tr_post(tr2);
		}else {
     		alert("업데이트된 행이 없습니다.");
	 	}				
				
	}
	

	
	
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>


	<script language="javascript"  for=gr_ccl event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			
			//if(Colid=="OT_NO"||Colid=="OT_NM"||Colid=="ORDERER_NM"||Colid=="OT_DATE"||Colid=="AMT_BASE"||Colid=="AMT_WIN"){
				fnSelectIMG();				
			//}
	    }
	</script>


	<script language="javascript"  for=gr_ccimg event=OnClick(Row,Colid)>
	    if(Row==0) return;
	    //alert(document.all.thum_img.src);
	    document.all.thum_img.src = "../file/ctscard/"+ds_ccimg.namevalue(Row, "FILE_SVR");	//로컬
	    //document.all.thum_img.src = "../files/ctscard/"+ds_ccimg.namevalue(Row, "FILE_SVR");	//서버
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
	
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
	if(v_job=="IMG"){
		alert("성공적으로 저장되었습니다.");
		fnSelectIMG();
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
<object id=ds_ccl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_ccimg classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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

<object id=ds_gc_type_sc	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code search condition-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_country_sc	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code search condition-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_city_sc	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code search condition-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_useyn_sc	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code search condition-->
    <param name="SyncLoad"  value="true"/>
</object>

<object id=ds_gc_type	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_country	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_city	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_useyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="true"/>
</object>
<object id=ds_gc_licyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="true"/>
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
    <table border='0' cellpadding='0' cellspacing='0' width="100%"> 
		<tr>
            <td class="l">
                <table border='0' cellpadding='0' cellspacing='0' width="850px">
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:pointer"  onClick="fnNewCC()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="l">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666"  width="850px">
           			<tr>
						<td align="center" class="text" width="70">국가</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=lc_gc_country_sc classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0">
                                <param name=ComboDataID     value=ds_gc_country_sc>
                                         <param name=BindColumn      value="detail">
                                         <param name=BindColVal      value="detail">
                                         <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                         <param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
						<td align="center" class="text" width="70">도시</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=lc_gc_city_sc classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0">
                                <param name=ComboDataID     value=ds_gc_city_sc>
                                         <param name=BindColumn      value="detail">
                                         <param name=BindColVal      value="detail">
                                         <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                         <param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
						<td align="left" class="text" width="90">컨텐츠 타입</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_type_sc classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_type_sc>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>              			
                        <!-- <td align="center" class="text" width="70">이름(한글)</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:120px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
                        </td>-->
						<td align="left" class="text" width="90">사용여부</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn_sc classid=<%=HDConstant.MxCombo_CLSID_S%> height=100 width=70 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn_sc>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        
                        <!-- 
                        <td align="left" class="text" width="70">년월</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:2px;width:59px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        </td> -->                                
					</tr>
           		</table>
            </td>
        </tr>         
        <tr height='6px'>
            <td></td>
        </tr>
		<tr>
            <td valign="top">
                <object id=gr_ccl classid=<%=HDConstant.MxGrid_CLSID_S%> style="width:850px; height:140px" border='1'>
                    <param name="DataID"            value="ds_ccl">
                    <param name="Editable"          value="true">
                    <param name="ColSizing"         value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="viewSummary"    value="1">
                    <param name="Format"            value="
                    	<C> name='sid'			ID='CTSCARD_SID'   	width=30 	align=LEFT	edit=none show=true </C>
                         <C> name='국가'	ID='CD_COUNTRY'   	width=70 	align=CENTER  edit=none editstyle=lookup Data='ds_gc_country:detail:detail_nm'  sumtext='총' suppress='1' </C>
                         <C> name='도시'	ID='CD_CITY'		width=70 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_city:detail:detail_nm' sumtext='@cnt' suppress='2' </C>
                         <C> name='컨텐츠타입'		ID='CD_TYPE'   	width=80 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_type:detail:detail_nm' sumtext='개' suppress='3' </C>
                         <C> name='이름(한글)'	ID='NAME_KOR'   	width=150 	align=left	Edit=true  </C>
                         <C> name='기본설명'    ID='DESC_BASIC'	width=180 	align=left 	Edit=none/C>
                         <C> name='사용'    ID='CD_USEYN'	width=40 	align=center	Edit=none editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' </C>  
                         <C> name='작성자'    ID='I_EMPNO'	width=60 	align=center	Edit=none	</C>
                         <C> name='미리보기'   ID='WEBVIEW'   Width=70   Edit=none align=CENTER show=true</C>
				                              
					">
				</object>
            </td>
        </tr>        

        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' width="852px;">
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="20px">
									<td align="center" class="text" width="70">국가</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;
			                            <object id=lc_gc_country classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=200 border="0"  tabindex="2">
			                                <param name=ComboDataID     value=ds_gc_country>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                        <!-- <input type="text" name='cd_country_nm' id="cd_country_nm" style="width:120px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
			                            <input type="hidden"  name='cd_country' id='cd_country' value="">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
			                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">-->
			                        </td>
									<td align="center" class="text" width="70">도시</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;
			                            <object id=lc_gc_city classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=200 border="0"  tabindex="3">
			                                <param name=ComboDataID     value=ds_gc_city>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                        
			                        <!-- <input type="text" name='cd_city_nm' id="cd_city_nm" style="width:120px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
			                            <input type="hidden"  name='cd_city' id='cd_city' value="">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
			                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기"> -->
			                        </td>			                        
									<td width="70px"  class="c" bgcolor="#eeeeee" >타입</td>
									<td width="110px" bgcolor="#ffffff" >&nbsp;
			                            <object id=lc_gc_type classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  tabindex="1">
			                                <param name=ComboDataID     value=ds_gc_type>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
									</td>
								</tr>
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="20px">
				                	<td align="center" class="text" width="70">이름(한글)</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='name_kor' id="name_kor" style="width:600px;" class='input' tabindex="4">
			                        </td>
								</tr>
								<tr height="20px">
				                	<td align="center" class="text" width="70">이름(영문)</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='name_eng' id="name_eng" style="width:600px;" class='input' tabindex="5"> * 영어로 적어주세요.
			                        </td>
								</tr>
								<tr height="20px">
				                	<td align="center" class="text" width="70">이름(local)</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='name_local' id="name_local" style="width:600px;" class='input' tabindex="6"> * 현지어로 적어주세요.
			                        </td>
								</tr>
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign="top"><!-- 위/경도 설명 시작 -->
							<table border="0" cellpadding="0" cellspacing="0" align="right" width="100%">
							  <tr>
							  	<td class="c">
									<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
										<tr height="20px">
											<td class="c" bgcolor="#eeeeee">구글맵 위도( * 소숫점 6자리까지)</td>
											<td bgcolor="#ffffff" class="c">
					                            <object id=GMAP_N classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:0px;width:100px; height:20px;" tabindex="7">
					                                <param name=Text        value="">
					                                <param name=Alignment   value=1>
					                                <param name=VAlign	    value=1>
					                                <param name=Numeric  	value="true">
					                                	<param name=MaxLength	value=9>
														<param name=MaxDecimalPlace	value=6>
					                                <param name=Border      value="false">      
					                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
					                                <param name=ReadOnly    value="false">
					                                <param name=SelectAll   value="true">
					                                <param name=SelectAllOnClick    value="true">
					                                <param name=SelectAllOnClickAny   value="false">
					                            </object>
											</td>
											<td class="c" bgcolor="#eeeeee">구글맵 경도( * 소숫점 6자리까지)</td>
											<td bgcolor="#ffffff" class="c">
					                            <object id=GMAP_E classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:0px;width:100px; height:20px;" tabindex="8">
					                                <param name=Text        value="">
					                                <param name=Alignment   value=1>
					                                <param name=VAlign	    value=1>
					                                <param name=Numeric  	value="true">
					                                	<param name=MaxLength	value=9>
														<param name=MaxDecimalPlace	value=6>
					                                <param name=Border      value="false">      
					                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
					                                <param name=ReadOnly    value="false">
					                                <param name=SelectAll   value="true">
					                                <param name=SelectAllOnClick    value="true">
					                                <param name=SelectAllOnClickAny   value="false">
					                            </object>
											</td>
										</tr>
										<tr height="20px">
											<td colspan="2" class="c" bgcolor="#eeeeee" >기본설명</td>
											<td colspan="2" class="c" bgcolor="#eeeeee" >대표이미지 설명</td>											
										</tr>
										<tr height="20px">
											<td colspan="2" bgcolor="#ffffff" align="center" >
												<textarea name="desc_basic" id="desc_basic"  class=textbox cols=65 rows=3  tabindex="9"></textarea>
											</td>
											<td colspan="2" bgcolor="#ffffff" align="center" >
												<textarea name="desc_img" id="desc_img"  class=textbox cols=65 rows=3  tabindex="10"></textarea>
											</td>
										</tr>
									</table>	  	
							  	</td><!-- 위/경도 설명 끝 -->
							  </tr>
							</table>
						</td>
					</tr>
	
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="21px">
									<td width="70px"class="text">추가설명</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="desc_add" id="desc_add"  class=textbox cols=124 rows=5  tabindex="11"></textarea>
									</td>
								</tr>
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="18px">
									<td width="70px"  class="c" bgcolor="#eeeeee" >저작권</td>
									<td width="90px" bgcolor="#ffffff" >&nbsp;
			                            <object id=lc_gc_licyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=80 border="0"  tabindex="12">
			                                <param name=ComboDataID     value=ds_gc_licyn>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
									</td>
									<td align="center" class="text" width="70">출처(url)</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='from_url' id="from_url" style="width:140px;" class='input' tabindex="13">
			                        </td>
									<td align="center" class="text" width="70">출처(메모)</td>
			                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='from_txt' id="from_txt" style="width:140px;" class='input' tabindex="14">
			                        </td>
			                        <td width="80px"  class="c" bgcolor="#eeeeee" >사용여부</td>
									<td width="70px" bgcolor="#ffffff" >&nbsp;
			                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=40 width=60 border="0" tabindex="15">
			                                <param name=ComboDataID     value=ds_gc_useyn>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^40">
			                            </object>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					
					
					<tr>
						<td valign="top"><!-- 이미지 업로드 시작 -->
							<!-- 파일 첨부용 폼-->
							<form name="fileForm" method="post" encType="multipart/form-data">
								<input type="hidden" name="m_cc_sid">
								<input type="hidden" name="realFileName">
								<input type="hidden" name="virtualFileName">
								<input type="hidden" name="mode">                          

					  		<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%" height="100%">
							  <tr height="20px">
							  	<td colspan="2" class="c" bgcolor="#eeeeee" >이미지</td>
							  </tr>
	                          <tr>
	                            <td width="140"><img id="thum_img" src="../images/person_icon/cat.gif" style="width:140px; height:166px" /></td>
	                            <td bgcolor="#ffffff" ><!-- 파일 복수 업로드 -->
								  <table cellpadding="0" cellspacing="0" border=0 align="right">
									<tr>
									  <td width="265px"><input type="text" name="file1" id="file1" style="width:260px;" value="첨부파일은 최대 10M까지 가능합니다." readonly  class=textbox></td>
									  <td width="100px" style="padding-left:8px;padding-top:3px;">
	                                      <div style="cursor:pointer; position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
	                                      <input type='file' name='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:19;filter:alpha(opacity=0);"></div>
									  </td>
									  <td width="300px" style="padding-left:8px;padding-top:1px;">
										<a href="javascript:tempUpload()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_upload.gif" border=0></a>
										<a href="javascript:fileDelete()"><img src="http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_del.gif" border=0></a>
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApplyIMG();">
									  </td>
									</tr>
									<tr>
							            <td colspan=3 valign="top">
							                <object id=gr_ccimg classid=<%=HDConstant.MxGrid_CLSID_S%> style="width:670px; height:140px" border='1'>
							                    <param name="DataID"            value="ds_ccimg">
							                    <param name="Editable"          value="true">
							                    <param name="ColSizing"         value="true">
							                    <param name="BorderStyle"       value="0">
							                    <param name="SuppressOption"    value="1">
							                    <param name="viewSummary"    value="1">
							                    <param name="Format"            value="
							                         <C> name='sid'			ID='CTSCARD_SID'   	width=30 	align=LEFT	edit=none show=true </C>
							                         <C> name='순서'    	ID='WEB_SEQ'	width=50 	align=right	sumtext='총' </C>
							                         <C> name='이름'		ID='IMG_NM'   	width=80 	align=LEFT	sumtext='@cnt' </C>
							                         <C> name='웹설명'		ID='WEB_DESC'	width=170 	align=left	 sumtext='개' </C>
							                         <C> name='웹공개'    	ID='WEB_SHOW'	width=50 	align=center editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' </C>  
							                         <C> name='저작권'    	ID='FROM_LIC'	width=70 	align=center editstyle=lookup Data='ds_gc_licyn:detail:detail_nm' </C>
							                         <C> name='출처(URL)'   ID='FROM_URL'	width=80 	align=left	 </C>
							                         <C> name='출처'    	ID='FROM_TXT'	width=80 	align=left </C>
							                         <C> name='원 파일명'	ID='FILE_IMG'   	width=70 	align=LEFT edit=none  sumtext='@cnt' show=false </C>
							                         <C> name='서버 파일명'	ID='FILE_SVR'   	width=70 	align=LEFT edit=none  </C>
							                         
												">
											</object>
										</td>

									</tr>
								  </table>
								</td>
	                          </tr>
					  		</table><!-- 이미지 업로드 끝 -->
							</form>


							<!-- 파일 삭제용 폼-->
							<FORM METHOD=POST NAME="file_del">
							<input type="hidden" name="realFileName">
							<input type="hidden" name="virtualFileName">
							<input type="hidden" name="saveDir">
							<input type="hidden" name="mode">
							<input type="hidden" name="brd_gu" value="<%//=brd_gu%>">
							</FORM>
												  		
					  		<!-- 파일 임시 업로드용 iFrame -->
							<iframe name="tempUploadFrm" width="0" height="0" src="about:blank"></iframe>
			            </td>
			        </tr>
                 </table>
            </td>
        </tr>



        <tr>
            <td class="l">
				<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="852px" height="100%">
				  <tr height="20px">
				  	<td colspan="2" class="c" bgcolor="#eeeeee" >★ 여행지 ★</td>
				  	<td colspan="4" class="c" bgcolor="#ffffff" ></td>
				  </tr>
				  <tr>
				  	<td align="center" class="text" width="70">위치</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_loc' id="txt_loc" style="width:200px;" class='input'></td>
			        <td align="center" class="text" width="70">주소</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_addr' id="txt_addr" style="width:200px;" class='input'></td>
			        <td align="center" class="text" width="70">연락처</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_phone' id="txt_phone" style="width:200px;" class='input'></td>
			      </tr>
			      <tr>
			        <td align="center" class="text" width="70">URL</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_url' id="txt_url" style="width:200px;" class='input'></td>
			      	<td align="center" class="text" width="70">찾아가기</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_approach' id="txt_approach" style="width:200px;" class='input'></td>
			      	<td align="center" class="text" width="70">요금</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_fee' id="txt_fee" style="width:200px;" class='input'></td>
			      </tr>
			      <tr>
			      	<td align="center" class="text" width="70">소요시간</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_leadtime' id="txt_leadtime" style="width:200px;" class='input'></td>
			      	<td align="center" class="text" width="70">영업시간</td>
			        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='txt_saletime' id="txt_saletime" style="width:200px;" class='input'></td>
			        <td colspan="2" class="c" bgcolor="#ffffff" ></td>
			      </tr>
			</table>
            </td>
        </tr>


        <tr>
            <td class="l">

            </td>
        </tr>  

    </table>            
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.MxBinder_CLASSID%>>
	             <param name="DataId" value="ds_ccl">
	             <param name=BindInfo    value="
					<C>Col=CTSCARD_SID    	Ctrl=ctscard_sid		Param=Value </C>
					<C>Col=CD_TYPE    		Ctrl=lc_gc_type   Param=BindColVal </C>
					<C>Col=CD_CITY       	Ctrl=lc_gc_city      Param=BindColVal </C>
					<C>Col=CD_COUNTRY      	Ctrl=lc_gc_country  Param=BindColVal </C>
					<C>Col=NAME_KOR       	Ctrl=name_kor      Param=Value </C>
					<C>Col=NAME_ENG       	Ctrl=name_eng      Param=Value </C>
					<C>Col=NAME_LOCAL      	Ctrl=name_local      Param=Value </C>
					<C>Col=GMAP_N       	Ctrl=gmap_n      Param=Text </C>
					<C>Col=GMAP_E       	Ctrl=gmap_e      Param=Text </C>
					
					<C>Col=DESC_BASIC	    Ctrl=desc_basic    Param=Value </C>
					<C>Col=DESC_IMG	    	Ctrl=desc_img      Param=Value </C>
					<C>Col=DESC_ADD		    Ctrl=desc_add      Param=Value </C>
					
					
					<C>Col=FROM_LIC    		Ctrl=lc_gc_licyn   Param=BindColVal </C>
					<C>Col=FROM_URL       	Ctrl=from_url      Param=Value </C>
					<C>Col=FROM_TXT       	Ctrl=from_txt      Param=Value </C>
					<C>Col=CD_USEYN    		Ctrl=lc_gc_useyn   Param=BindColVal </C>

	              ">
	      </object>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		