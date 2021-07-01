<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 구매_발주
 * 프로그램ID 	 : PMS/PU090S
 * J  S  P		 	 : pu090s.jsp
 * 서 블 릿		 : Pu090S
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2012-04-10
 * 기능정의		 : 구매_품의
 * [ 수정일자 ][수정자] 내용
 * [2012-04-10][박경국] 신규
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
	
	  //파일리스트 html 만들기
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//값을 불러와서 
		String sys_fileList ="";
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
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
       
       // v_fr_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        v_fr_con_date.Text = "20130101";
        //v_to_con_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
       ds_con_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_con_status.Reset();	//작업상태
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//사용처
       ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//투입창고
       ds_terms_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU004&s_item1=Y";
       ds_terms_trans.Reset();	//인도조건
       ds_way_chk.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU005&s_item1=Y";
       ds_way_chk.Reset();	//검사방법
       ds_terms_pay.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU006&s_item1=Y";
       ds_terms_pay.Reset();	//지불조건
       ds_bur_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU007&s_item1=Y";
       ds_bur_trans.Reset();	//운반비부담
       
      
      
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender,O:DS_DETAIL=ds_detail)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    <%//메인 조회  %>
    function fnSelect() {
    
    	//alert("1");
		if (ds_default.IsUpdated || ds_tender.IsUpdated|| ds_detail.IsUpdated) {
			alert("수정중인 행인 있습니다.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_con_date.Text.trim();
	        var to_date = v_to_con_date.Text.trim();
	
	
	        if(fr_date.length!=8) {
	            alert("품의일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("품의일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
	 
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) 
   	                  + ",v_rqst_no="+ sRqstNo.value
	                  + ",v_site_sid="+ v_site_sid.value;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090S",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        
	         //첨부파일 쪼개기
	        var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//배열로 정리
			sys_file10 = sys_fileList.split(":");	//배열로 정리
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
	        
	        
	        
		};
    }    

    <%//tender 조회%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_default").NameValue(row, "EST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090S",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
        fnSelectDetail2(1);
    }

    <%//detail 조회%>
    function fnSelectDetail2(row) {
        //v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID")
                    + ",v_vend_cd="+getObjectFirst("ds_tender").NameValue(row, "VEND_CD");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090S",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

	
	//첨부파일(1) 다운로드_열기
    function fnFile(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
	if(real_file1==''){
			alert("첨부파일이 존재하지 않습니다")
			return;
		}else if(real_file1.length==1){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //운영
			//location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //운영

		}

	}
	//첨부파일(2) 다운로드_열기
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	

		//alert(real_file2);				
		//alert(sys_file2);						
		//alert(real_file2.length);
		
		if(real_file2.length==0){
		alert("2번째 파일이 존재하지 않습니다")
		}
		if(real_file2.length>0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //로컬

		}
	}
	//첨부파일(3) 다운로드_열기
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//배열로 정리
		sys_file10 = sys_fileList.split(":");	//배열로 정리
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3번째 파일이 존재하지 않습니다")
		}
		if(real_file3.length >0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //운영
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //로컬
		}
	}

	<%//현장명 팝- 조회%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnPuSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[4];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    
	function fnSelSiteCleanup(){
	    v_site_nm.value = "";
	    v_site_sid.value  = "";
    }

	function fnExcel() {
		if(ds_default.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:발주조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("발주조회","발주조회.xls", 8);

	    if(ds_tender.RowCount==0){
            return;
        }
        
        getObjectFirst("gr_tender").SetExcelTitle(0, "");
        getObjectFirst("gr_tender").SetExcelTitle(1, "value:견적내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_tender").GridToExcel("견적내역","견적내역.xls", 8);
        
         if(ds_detail.RowCount==0){
            return;
        } 
        getObjectFirst("gr_detail").SetExcelTitle(0, "");
        getObjectFirst("gr_detail").SetExcelTitle(1, "value:발주품목; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_detail").GridToExcel("발주품목","발주품목.xls", 8);
	}	
	
	/*
	 * 레포트
	 */
	function fnPrint() {
	    v_job = "S";
       var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
        			 + ",v_con_sid="+v_con_sid.value;
        			// alert(v_param);
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090S",
            "JSP(O:DS9=ds9)",
            v_param);
        tr_post(tr1);
        pr1.PreView();
    }

</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%//품의정보 클릭시 견적내역 조회 %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("수정중인  작업이 있을 경우에는 조회를 할수 없습니다!");
			return false;
		} else {
		    var row2=ds_tender.countrow;
		    if(Row==0) return;
		    if(v_default_row==Row){
				return;
			}else{
			    fnSelectDetail(Row);				
		    }
		};
	</script>
<%//견적내역 클릭시 견적품목 조회 %>
	<script language=javascript for="gr_tender" event="OnClick(Row, Colid)">
			    fnSelectDetail2(Row);				
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
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_tender.clearall();
			}else{
				fnSelectDetail(row);
			}
		}
	</script>
	<script language=javascript for="ds_tender" event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_detail.clearall();
			}else{
				fnSelectDetail2(row);
			}
		}
	</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_tender classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 조회: 작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_con_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  작업상태 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  사용처 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 투입창고 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_date_ddl classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  납기일자 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  인도조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_way_chk classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  검사방법 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지불조건 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bur_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  운반지부담 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--레포트--%>

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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                     <tr>
                    	<td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">		<!-- 엑셀 -->							
							<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:pointer"  onclick="fnPrint()">		<!-- 인쇄 -->							
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
			                        <td align=left class="text"  width="70">품의일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">
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
			                            <object id=v_to_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" onkeydown="if(event.keyCode==13) fnSelect();">            
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
                    				<td align=left class="text">작업상태</td>
			                        <td align=left bgcolor="#ffffff" WIDTH="220">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_srch_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_srch_rqst_status>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>			                        
			             		</tr>
			             		<tr>
									<td align=left width="70px" class="text">청구번호</td>
									<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sRqstNo" value="" size="20" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>			                        
								    <td align="center" class="text" width="70">현장명</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
                                    </td>
                    			</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='285px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name=SortView  value="Right">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='작업상태'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1 sort=true </C>
                                     <C> name='작업상태'	ID='CON_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=TRUE	 sort=true </C>
                                     <C> name='청구일자' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 	 sort=true 	</C>
                                     <C> name='품의일자' 	ID='DATE_CON'    		width=80 	align=CENTER	Edit=None 	 sort=true 	</C>
                                     <C> name='청구번호' 	ID='RQST_NO'	    		width=200 	align=CENTER	Edit=None 	 sort=true 	</C>
                                     <C> name='품의번호'	ID='CON_NO' 				width=100 align=CENTER	Edit=None	 sort=true 	</C>
                                     <C> name='품의SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='견적SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
                                     <C> name='청구SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='현장SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		 show=false  </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='납기일자'		ID='DATE_DDL'    		width=60 	align=CENTER	Edit=None 	 sort=true 	show=false</C>
                                     <C> name='투입창고'		ID='PUT_WH' 			width=60 	align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='인도조건'    	ID='TERMS_TRANS' width=60 	align=CENTER	Edit=None 	 sort=true 	show=false</C>
                                     <C> name='검사방법'		ID='WAY_CHK' 			width=60 	align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='지불조건'		ID='TERMS_PAY'    	width=60 	align=CENTER	Edit=None  sort=true 		show=false</C>
                                     <C> name='운반비부담'	ID='BUR_TRANS' 		width=60 	align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='공급자 준수사항'    ID='OSV_PVR'  width=60 	align=CENTER	Edit=None 	 sort=true 	show=false</C>
                                     <C> name='특기사항'		ID='CON_NOTE' 		width=60 	align=CENTER	Edit=None	 sort=true 	show=false</C>
                                     <C> name='선급금율'    				ID='PREPAY_AMT_RATE'  width=60 	align=CENTER	Edit=None	 	limitdec=0 show=false decao=0	 sort=true  </C>                                     
									 <C> name='선급금'    					ID='PREPAY_AMT'   			width=60 	align=CENTER	Edit=None	 	 show=false Dec=0	 sort=true  </C>                                                                          
                                     <C> name='이행보증금율'    		ID='CH_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>
                                     <C> name='이행보증금'    			ID='CH_AMT'       			    width=60 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>
                                     <C> name='하자보수보증금율'      ID='DB_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>                                     
                                     <C> name='하자보수보증금'         ID='DB_AMT'       		   	 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>                                     
                                     <C> name='보증기간' 					ID='TERM_GRN'    		 	width=80 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>                                     
                                     <C> name='결정금액'         			ID='TOT_FN_EST_AMT'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	 sort=true  </C>                                     
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">작업상태</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_con_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_con_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=ReadOnly    value="true">											
											<param name="Editable"          value="false">											
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">사용처</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_use>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="true">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									<input type="hidden"  name='v_rqst_sid' id='v_rqst_sid'>
									<input type="hidden"  name='v_est_sid' id='v_est_sid'>
									<input type="hidden"  name='v_con_sid' id='v_con_sid'>
									</td>
								</tr>	
								<tr height="21px">
									<td width="120px" class="text">품의일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_con classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="true">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                                <param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">품의번호</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_con_no' id="v_con_no" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">청구일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=SelectAll   value="true">
			                                <param name=Enable  value=false>
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">청구번호</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'   readOnly="readonly"> </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">현장명</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">납기일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_ddl classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=Enable  value=false>
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">투입창고</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_put_wh classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_put_wh>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">인도조건</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_trans>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">검사방법</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_way_chk classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_way_chk>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">지불조건</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_pay>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">운반비부담</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_bur_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_bur_trans>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">공급자특기사항</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_osv_pvr' id="v_osv_pvr" style="width:100px;" class='input01'  readOnly="readonly">
                                    </td>
									<td width="120px" class="text">품의특기사항</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_con_note' id="v_con_note" style="width:100px;" class='input01'  readOnly="readonly">
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">선급금율</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_prepay_amt_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
											<param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">선급금</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_prepay_amt' id="v_prepay_amt" style="width:130px;" limitdec=0 class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">계약이행보증금율</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_ch_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
											<param name=Enable  value=false>
			                                
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">계약이행보증금</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_ch_amt' id="v_ch_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">하자보수보증금율</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_db_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
											<param name=Numeric			value=true>	
											<param name=IsComma			value=true>		                               
											<param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">하자보수보증금</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_db_amt' id="v_db_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">보증기간</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_term_grn' id="v_term_grn" style="width:80px;" class='input01'  readOnly="readonly" >&nbsp;개월
                                    </td>
									<td width="120px" class="text">현장담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_empnm' id="v_pu_empnm" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr>
									<td width="120px" class="text">첨부파일</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;
                                        <input type="hidden"  name='txt_sys_file' id='txt_sys_file'>
                                        <input type="text" name='txt_real_file' id="txt_real_file" style="width:310px;" class='input01'   readOnly="readonly">
                                        <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='input01' value="(1)"  onclick="fnFile()" readOnly="readonly">
					                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='input01'   value="(2)" onclick="fnFile2()" readOnly="readonly">
					                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='input01'   value="(3)" onclick="fnFile3()" readOnly="readonly">
									</td>
								</tr>
								<tr>
									<td width="120px" class="text">본사담당자사번</td>
									<td bgcolor='#ffffff' colspan="1">&nbsp;<input type="text" name='v_bon_empno' id="v_bon_empno" style="width:100px;" class='input01'  readOnly="readonly">
									</td>
									<td width="120px" class="text">본사담당자</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" edit='false' name='v_bon_empnm' id="v_bon_empnm" style="width:100px;" class='input01'  readOnly="readonly" > </td>
								</tr>
							</table>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr>
        	<td align=right>
        	<b>[견적내역]</b>
        	</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='80px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                          <C> name='순위' 				ID={CurRow}	   			width=100 		align=CENTER	edit=none show=TRUE</C>
	                     <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false </C>
                         <C> name='거래처코드' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='협력사명' 			ID='VEND_NM'    		width=200 	align=CENTER	edit=none</C>
                         <C> name='견적금액'			ID='TOT_EST_AMT'  width=90 		align=right 	 decao=0 edit=none </C>
                         <C> name='결정금액'			ID='TOT_FN_EST_AMT'  	width=90 		align=right 	 decao=0	edit=none</C>
                         <C> name='증감액'				ID='UD_EST_AMT'  	width=90 		align=right 	 decao=0 edit=none</C>                                                  
                         <C> name='견적서번호'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
                         <C> name='증감비율(%)'		ID='UDRATE_EST_AMT'  	width=100 		align=right 	 decao=0 edit=none</C>                                                  
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
     	<tr>
            <td align=right>
				<b>[견적품목]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_detail" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='180px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                     <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
                         <C> name='EST_SID' 			ID='EST_SID'   			width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='품명' 				ID='ITEM_NM'    		width=150 	align=CENTER	 	edit=none sumtext='총'  sumtextalign='right'</C>
                         <C> name='규격' 				ID='ITEM_SIZE'   		width=150 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right'</C>
                         <C> name='단위' 				ID='ITEM_UNIT'   		width=60 		align=CENTER		edit=none sumtext='품목' sumtextalign='left'</C>
                         <C> name='수량' 				ID='EST_CNT'   		width=60 		align=right		edit=none </C>
                        <G> name='도급'
                         <C> name='단가'    		ID='DG_AMT'    	    width=85 		align=right	 show=true decao=0	sumtext='@sum' sumtextalign='right'	 </C>
                         <C> name='금액'   			ID='DG_SUM_AMT'   width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                         </G>
						<G> name='예산'
                         <C> name='단가' 			ID='YS_AMT'   			width=85 		align=right	 decao=0 sumtext='@sum' sumtextalign='right'	</C>
                         <C> name='금액'    			ID='YS_SUM_AMT'    width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                         </G>
                         <C> name='견적금액'    		ID='SUM_AMT'    	    width=85 		align=right	 show=false decao=0	sumtext='@sum' sumtextalign='right'	 </C>
                         <C> name='결정금액'    		ID='FN_SUM_AMT'    width=85 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
                         <C> name='견적비고' 				ID='EST_ITEM_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>                         
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>

              
            </td>
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
					<C>Col=CON_STATUS     	 Ctrl=lc_con_status    	Param=BindColVal </C>
					<C>Col=CON_STATUS_NM     	 Ctrl=v_con_status_nm    	Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        	Param=Text </C>
					<C>Col=DATE_DDL       	 Ctrl=v_date_ddl         	Param=Text </C>					
					<C>Col=DATE_CON       	 Ctrl=v_date_con        	Param=Text </C>
					<C>Col=DATE_FR       	 	 Ctrl=v_date_fr  	     	Param=Text </C>
					<C>Col=DATE_TO       	 	 Ctrl=v_date_to        	 	Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 	Param=value </C>
					<C>Col=CON_NO       	 	 Ctrl=v_con_no        	 	Param=value </C>					
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     	Param=Value </C>
					<C>Col=CON_SID		       	 Ctrl=v_con_sid 	     	Param=Value </C>					
					<C>Col=EST_SID		       	 Ctrl=v_est_sid 	     	Param=Value </C>										
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     	Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     	Param=value </C>
					<C>Col=PUT_WH     		 	 Ctrl=lc_put_wh	     	Param=BindColVal </C>
					<C>Col=TERMS_TRANS     Ctrl=lc_terms_trans  	Param=BindColVal </C>
					<C>Col=WAY_CHK     		 Ctrl=lc_way_chk	     	Param=BindColVal </C>
					<C>Col=TERMS_PAY     	 Ctrl=lc_terms_pay    	Param=BindColVal </C>
					<C>Col=BUR_TRANS     	 Ctrl=lc_bur_trans     	Param=BindColVal </C>
					<C>Col=OSV_PVR       	 	 Ctrl=v_osv_pvr		     	Param=value </C>
					<C>Col=CON_NOTE	       	 Ctrl=v_con_note	    	Param=Value </C>					
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        	Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     	Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   		Param=value </C>
					<C>Col=BON_EMPNO    	 	 Ctrl=v_bon_empno   		Param=value </C>
					<C>Col=BON_EMPNM    	 	 Ctrl=v_bon_empnm   		Param=value </C>
					<C>Col=PREPAY_AMT_RATE    Ctrl=v_prepay_amt_rate   	Param=text </C>
					<C>Col=PREPAY_AMT    			Ctrl=v_prepay_amt   		Param=value </C>
					<C>Col=CH_RATE    	 	 			Ctrl=v_ch_rate   		Param=text </C>
					<C>Col=CH_AMT    	 	 			Ctrl=v_ch_amt   		Param=value </C>
					<C>Col=DB_RATE    	 	 			Ctrl=v_db_rate   		Param=text </C>
					<C>Col=DB_AMT    	 	 			Ctrl=v_db_amt   		Param=value </C>
					<C>Col=TERM_GRN    	 	 		Ctrl=v_term_grn   		Param=value </C>																				
					<C>Col=TOT_FN_EST_AMT  	 	 		Ctrl=v_tot_fn_est_amt		Param=value </C>		
					<C>Col=AP_DESC_RE 	 	 Ctrl=v_ap_desc_re   	 Param=value </C>											
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>																						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
		
<%
/*=============================================================================
			레포트 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<PARAM NAME="Format"                VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=1135 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=101 ,top=344 ,right=1900 ,bottom=1135 ,border=true ,penstyle=solid ,penwidth=4</X>
	<T>id='발  주  서' ,left=759 ,top=116 ,right=1241 ,bottom=228 ,face='Tahoma' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=101 ,top=278 ,right=759 ,bottom=344 ,border=true ,penstyle=solid ,penwidth=4</X>
	<L> left=315 ,top=278 ,right=315 ,bottom=937 </L>
	<L> left=101 ,top=476 ,right=1900 ,bottom=476 </L>
	<L> left=101 ,top=609 ,right=1900 ,bottom=609 </L>
	<L> left=101 ,top=873 ,right=1900 ,bottom=873 </L>
	<L> left=101 ,top=741 ,right=1900 ,bottom=741 </L>
	<L> left=101 ,top=741 ,right=1900 ,bottom=741 </L>
	<L> left=101 ,top=807 ,right=1900 ,bottom=807 </L>
	<L> left=101 ,top=675 ,right=1900 ,bottom=675 </L>
	<L> left=101 ,top=939 ,right=1900 ,bottom=939 </L>
	<L> left=101 ,top=1003 ,right=1900 ,bottom=1003 </L>
	<L> left=101 ,top=1069 ,right=1900 ,bottom=1069 </L>
	<L> left=757 ,top=347 ,right=757 ,bottom=677 </L>
	<L> left=1463 ,top=347 ,right=1463 ,bottom=677 </L>
	<L> left=1251 ,top=347 ,right=1251 ,bottom=876 </L>
	<L> left=1402 ,top=939 ,right=1402 ,bottom=1135 </L>
	<L> left=1500 ,top=939 ,right=1500 ,bottom=1135 </L>
	<L> left=680 ,top=939 ,right=680 ,bottom=1135 </L>
	<T>id='발주번호' ,left=108 ,top=283 ,right=310 ,bottom=336 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='하자보증금율' ,left=106 ,top=1072 ,right=447 ,bottom=1124 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='하자보증금' ,left=685 ,top=1072 ,right=1037 ,bottom=1124 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약이행보증금' ,left=688 ,top=1016 ,right=1040 ,bottom=1069 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='선급금' ,left=691 ,top=945 ,right=1042 ,bottom=997 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='%' ,left=606 ,top=1008 ,right=675 ,bottom=1064 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='%' ,left=611 ,top=1077 ,right=669 ,bottom=1117 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원' ,left=1416 ,top=945 ,right=1484 ,bottom=1000 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원' ,left=1418 ,top=1072 ,right=1487 ,bottom=1127 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원' ,left=1416 ,top=1008 ,right=1484 ,bottom=1064 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=757 ,top=410 ,right=1251 ,bottom=410 </L>
	<L> left=757 ,top=542 ,right=1251 ,bottom=542 </L>
	<T>id='TEL' ,left=765 ,top=355 ,right=897 ,bottom=410 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='TEL' ,left=762 ,top=614 ,right=894 ,bottom=669 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='FAX' ,left=762 ,top=548 ,right=894 ,bottom=603 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='TEL' ,left=762 ,top=479 ,right=894 ,bottom=534 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='FAX' ,left=762 ,top=418 ,right=894 ,bottom=474 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담   당' ,left=1257 ,top=378 ,right=1458 ,bottom=431 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담   당' ,left=1257 ,top=513 ,right=1458 ,bottom=566 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='FAX' ,left=1257 ,top=614 ,right=1458 ,bottom=667 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결제조건' ,left=974 ,top=680 ,right=1175 ,bottom=733 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='투입장소' ,left=974 ,top=751 ,right=1175 ,bottom=804 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운반비' ,left=974 ,top=818 ,right=1175 ,bottom=870</T>
	<T>id='부가세 포함' ,left=1511 ,top=947 ,right=1886 ,bottom=997 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부가세 포함' ,left=1508 ,top=1074 ,right=1884 ,bottom=1124 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부가세 포함' ,left=1508 ,top=1013 ,right=1884 ,bottom=1064 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='con_no', left=323, top=286, right=746, bottom=331, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='bon_empnm', left=323, top=619, right=746, bottom=664, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='vend_nm', left=323, top=355, right=746, bottom=471, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='pu_site_nm', left=325, top=484, right=749, bottom=601, face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='vd_direct', left=1471, top=352, right=1884, bottom=468, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='pu_empnm', left=1474, top=487, right=1886, bottom=603, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='vd_telno', left=910, top=355, right=1241, bottom=400, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='faxno', left=1474, top=619, right=1884, bottom=664, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='telno', left=913, top=616, right=1244, bottom=661, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='pu_fax', left=913, top=553, right=1244, bottom=598, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='pu_tel', left=913, top=487, right=1244, bottom=532, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='vd_faxno', left=913, top=426, right=1244, bottom=471, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='%' ,left=609 ,top=947 ,right=677 ,bottom=1003 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=598 ,top=939 ,right=598 ,bottom=1135 </L>
	<C>id='prepay_amt_rate', left=458, top=945, right=593, bottom=1000, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ch_rate', left=458, top=1011, right=593, bottom=1066, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='db_rate', left=455, top=1072, right=593, bottom=1127, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREPAY_AMT', left=1058, top=945, right=1394, bottom=997, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DB_AMT', left=1058, top=1074, right=1394, bottom=1127, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CH_AMT', left=1058, top=1011, right=1394, bottom=1064, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='today', left=1474, top=267, right=1894, bottom=333, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='osv_pvr', left=323, top=884, right=1889, bottom=931, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WAY_CHK', left=325, top=815, right=886, bottom=865, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TERMS_TRANS', left=331, top=749, right=892, bottom=802, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='date_ddl', left=333, top=685, right=894, bottom=733, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BUR_TRANS', left=1259, top=818, right=1879, bottom=868, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PUT_WH', left=1262, top=749, right=1879, bottom=802, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TERMS_PAY', left=1259, top=685, right=1881, bottom=733, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=450 ,top=939 ,right=450 ,bottom=1135 </L>
	<L> left=1050 ,top=939 ,right=1050 ,bottom=1135 </L>
	<L> left=905 ,top=347 ,right=905 ,bottom=876 </L>
	<T>id='발주일자 :' ,left=1251 ,top=270 ,right=1468 ,bottom=336 ,align='right' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='계약이행보증금율' ,left=108 ,top=1013 ,right=450 ,bottom=1066 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='선급금율' ,left=111 ,top=947 ,right=450 ,bottom=1000 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특기사항' ,left=108 ,top=881 ,right=310 ,bottom=934 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검수방법' ,left=108 ,top=818 ,right=310 ,bottom=870 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인도조건' ,left=108 ,top=749 ,right=310 ,bottom=802 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납 기 일' ,left=114 ,top=685 ,right=315 ,bottom=738 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='본사담당' ,left=111 ,top=616 ,right=312 ,bottom=669 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='납품현장' ,left=108 ,top=521 ,right=310 ,bottom=574 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공급업체' ,left=108 ,top=392 ,right=310 ,bottom=445 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=101 ,top=0 ,right=1900 ,bottom=66 ,border=true ,penstyle=solid ,penwidth=4</X>
	<L> left=479 ,top=0 ,right=479 ,bottom=66 </L>
	<L> left=749 ,top=0 ,right=749 ,bottom=66 </L>
	<L> left=900 ,top=0 ,right=900 ,bottom=66 </L>
	<L> left=1651 ,top=0 ,right=1651 ,bottom=66 </L>
	<L> left=1101 ,top=0 ,right=1101 ,bottom=66 </L>
	<L> left=1352 ,top=0 ,right=1352 ,bottom=66 </L>
	<T>id='품명' ,left=106 ,top=8 ,right=471 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비고' ,left=1656 ,top=8 ,right=1886 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금액' ,left=1357 ,top=5 ,right=1643 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단가' ,left=1109 ,top=8 ,right=1347 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수량' ,left=905 ,top=5 ,right=1095 ,bottom=53 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='단위' ,left=754 ,top=8 ,right=894 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='규격' ,left=489 ,top=8 ,right=741 ,bottom=56 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=101 ,top=0 ,right=101 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1900 ,top=0 ,right=1900 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=101 ,top=66 ,right=1900 ,bottom=66 </L>
	<L> left=479 ,top=0 ,right=479 ,bottom=66 </L>
	<L> left=749 ,top=0 ,right=749 ,bottom=66 </L>
	<L> left=900 ,top=0 ,right=900 ,bottom=66 </L>
	<L> left=1651 ,top=0 ,right=1651 ,bottom=66 </L>
	<L> left=1101 ,top=0 ,right=1101 ,bottom=66 </L>
	<L> left=1352 ,top=0 ,right=1352 ,bottom=66 </L>
	<C>id='item_nm', left=106, top=8, right=471, bottom=56</C>
	<C>id='est_wri_note', left=1656, top=8, right=1886, bottom=56, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='fn_sum_amt', left=1357, top=5, right=1643, bottom=56, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='fn_est_amt', left=1109, top=8, right=1347, bottom=56, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='est_cnt', left=905, top=5, right=1095, bottom=53, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='item_unit', left=754, top=8, right=894, bottom=56, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='item_size', left=489, top=8, right=741, bottom=56</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=883 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=101 ,top=0 ,right=101 ,bottom=601 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1900 ,top=0 ,right=1900 ,bottom=601 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=101 ,top=601 ,right=1900 ,bottom=601 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=101 ,top=66 ,right=1900 ,bottom=66 </L>
	<L> left=101 ,top=198 ,right=1900 ,bottom=198 </L>
	<L> left=302 ,top=0 ,right=302 ,bottom=66 </L>
	<L> left=701 ,top=0 ,right=701 ,bottom=66 </L>
	<L> left=902 ,top=0 ,right=902 ,bottom=66 </L>
	<L> left=1302 ,top=0 ,right=1302 ,bottom=66 </L>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=66 </L>
	<T>id='공급가액' ,left=111 ,top=8 ,right=299 ,bottom=64 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='합계금액' ,left=1310 ,top=3 ,right=1498 ,bottom=58 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='부가세액' ,left=706 ,top=3 ,right=894 ,bottom=58 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='tot_fn_est_amt', left=312, top=5, right=691, bottom=61, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='tot_fn_est_amt2', left=910, top=5, right=1296, bottom=61, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='tot_fn_est_amt3', left=1508, top=3, right=1892, bottom=58, align='right', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='상기와 같이 자재를 발주하오니 납기를 준수 바랍니다.' ,left=111 ,top=77 ,right=1886 ,bottom=183 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' ※ 당사 홈페이지(www.hdasan.com)에서 발주조건을 반드시 확인바랍니다.' ,left=108 ,top=249 ,right=1886 ,bottom=315 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Multiline=true</T>
	<T>id='      계약이행보증기간 : 발주(계약)일로부터 납품완료 후 60일까지' ,left=108 ,top=450 ,right=1886 ,bottom=516 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Multiline=true</T>
	<T>id='      (사이버홍보실/자료실/문서자료/자재납품 발주조건)' ,left=108 ,top=315 ,right=1886 ,bottom=381 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Multiline=true</T>
	<T>id=' ※ 선급금보증기간 : 보증서 발급일로부터 납품완료 후 60일까지' ,left=108 ,top=384 ,right=1886 ,bottom=450 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Multiline=true</T>
	<T>id='현대아산(주) 사업지원부' ,left=751 ,top=611 ,right=1894 ,bottom=762 ,face='Tahoma' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='      하자담보책임기간 : 납품완료 후       개월' ,left=108 ,top=519 ,right=1886 ,bottom=585 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3, Multiline=true</T>
	<C>id='term_grn', left=656, top=508, right=704, bottom=569, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
</object> 
<%=HDConstant.COMMENT_END%>

<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		