<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	 : 구매_발주서
 * 프로그램ID 	 : PMS/PU090I
 * J  S  P		 	 : pu090i.jsp
 * 서 블 릿		 : Pu090I
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2012-04-10
 * 기능정의		 : 구매_발주서
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
       
		//v_fr_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
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
	                  //+ ",v_site_sid="+ v_site_sid.value
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090I",
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
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090I",
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
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

	<%//저장 %>
	function fnApply(){
		v_job = "A";
				
		if ( ds_detail.CountRow==0 ) { 
			alert("적어도 하나의 견적품목을 조회 하셔야 합니다."); 
			return;
	 	} 	

		if (ds_default.IsUpdated	||	ds_tender.IsUpdated	||	ds_detail.IsUpdated) {
			  //alert("1");
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu090I",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_TENDER=ds_tender,I:DS_DETAIL=ds_detail)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        		fnSelect();
    	}else
     		alert("업데이트된 행이 없습니다.");
	}

	<%// 그리드 수정 취소 %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="데이터 변경이 취소되었습니다.";
		return;		
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
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //로컬

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
	
	<%//본사발주담당자 팝- 조회%>
    function  fnSelSitePopup1(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnPuSitePop1(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
//			v_pu_site_cd.value= arrParam[0];	//현장코드
//			v_site_nm1.value= arrParam[1];	//현장명
            v_bon_empno.value = arrParam[2];	//본사발주담당자사번
            v_bon_empnm.value = arrParam[3];	//본사발주담당자성명            
//            v_site_sid1.value = arrParam[4];	//SID
        } else {
			fnSelSiteCleanup1();
        }               
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

<script language=JavaScript for=tr1 event=OnFail()>
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
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
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
                                <param name="SuppressOption"    value="0">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='작업상태'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='작업상태'	ID='CON_STATUS_NM' width=80 	align=CENTER	Edit=None 		show=TRUE	</C>
                                     <C> name='품의일자' 	ID='DATE_CON'    		width=80 	align=CENTER	Edit=None 		</C>
                                     <C> name='품의번호'	ID='CON_NO' 				width=120 align=CENTER	Edit=None		</C>
                                     <C> name='품의SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='견적SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
                                     <C> name='청구일자' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='청구번호' 	ID='RQST_NO'	    		width=150 	align=CENTER	Edit=None 		</C>
                                     <C> name='청구SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장담당자'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='현장명'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='현장SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		 show=false  </C>
                                     <C> name='사용처'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='납기일자'		ID='DATE_DDL'    		width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='투입창고'		ID='PUT_WH' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='인도조건'    	ID='TERMS_TRANS' width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='검사방법'		ID='WAY_CHK' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='지불조건'		ID='TERMS_PAY'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='운반비부담'	ID='BUR_TRANS' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='공급자 준수사항'    ID='OSV_PVR'  width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='특기사항'		ID='CON_NOTE' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='선급금율'    				ID='PREPAY_AMT_RATE'  width=60 	align=CENTER	Edit=None	 	limitdec=0 show=false decao=0	 </C>                                     
									 <C> name='선급금'    					ID='PREPAY_AMT'   			width=60 	align=CENTER	Edit=None	 	 show=false Dec=0	 </C>                                                                          
                                     <C> name='이행보증금율'    		ID='CH_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>
                                     <C> name='이행보증금'    			ID='CH_AMT'       			    width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>
                                     <C> name='하자보수보증금율'      ID='DB_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='하자보수보증금'         ID='DB_AMT'       		   	 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='보증기간' 					ID='TERM_GRN'    		 	width=80 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='결정금액'         			ID='TOT_FN_EST_AMT'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     
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
									</td>
								</tr>	
								<tr height="21px">
									<td width="120px" class="text">품의일자</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_con classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
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
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'   readOnly="readonly"> 
										<input type="hidden"  name='v_pu_site_cd' id='v_pu_site_cd'>
										<input type="hidden"  name='v_pu_empno' id='v_pu_empno'>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">현장명</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  readOnly="readonly">
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
	 		                                <param name=Enable  value=false>
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
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
											<param name=ReadOnly    value="false">
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
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">공급자특기사항</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_osv_pvr' id="v_osv_pvr" style="width:100px;" class='input01' readOnly="readonly" >
                                    </td>
									<td width="120px" class="text">품의특기사항</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_con_note' id="v_con_note" style="width:100px;" class='input01' readOnly="readonly" >
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
									<td width="120px" class="text" >하자보수보증금율</td>
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
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_term_grn' id="v_term_grn" style="width:80px;" class='input01'  readOnly="readonly">&nbsp;개월
									<input type="hidden"  name='v_tot_fn_est_amt' id='v_tot_fn_est_amt'>
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
									<td width="120px" class="text"><font color="green"><b>본사담당자사번</b></font></td>
									<td bgcolor='#ffffff' colspan="1">&nbsp;<input type="text" name='v_bon_empno' id="v_bon_empno" style="width:100px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup1('<%=dirPath%>');" alt="조회창 팝">
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
                         <C> name='증감비율(%)'		ID='UD_RATE'  	width=100 		align=right 	 decao=0 edit=none</C>                                                  
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
						 <C> name='순번' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
                         <C> name='품명' 				ID='ITEM_NM'    		width=150 	align=CENTER	 	edit=none sumtext='총'  sumtextalign='right'</C>
                         <C> name='규격' 				ID='ITEM_SIZE'   		width=150 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right'</C>
                         <C> name='단위' 				ID='ITEM_UNIT'   		width=50 		align=CENTER		edit=none sumtext='품목' sumtextalign='left'</C>

                    <G> name='도급'
                         <C> name='수량' 		ID='DG_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='단가'    	ID='DG_AMT'    	    width=70 		align=right	 show=true decao=0	 </C>
                         <C> name='금액'   		ID='DG_SUM_AMT'   width=80 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                    </G>
					<G> name='예산'
                         <C> name='수량' 		ID='RQST_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='단가' 		ID='YS_AMT'   			width=70 		align=right	 decao=0 	</C>
                         <C> name='금액'    	ID='YS_SUM_AMT'    width=80 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                    </G>
					<G> name='결정'
                         <C> name='수량' 		ID='EST_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='단가' 		ID='FN_EST_AMT'   			width=70 		align=right	 decao=0 	</C>
                         <C> name='금액'    	ID='FN_SUM_AMT'    width=80 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
                    </G>
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
					<C>Col=PU_EMPNM    	 	 Ctrl=v_pu_empnm   		Param=value </C>
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
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>																						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		