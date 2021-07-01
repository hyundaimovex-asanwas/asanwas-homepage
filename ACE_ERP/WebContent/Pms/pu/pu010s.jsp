<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 구매현황
 * 프로그램ID 	 : PMS/PU010S
 * J  S  P		 : pu010s.jsp
 * 서 블 릿		 : Pu010S
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2011-12-22
 * 기능정의		 : 구매현황
 * [ 수정일자 ][수정자] 내용
 * [2011-12-22][박경국] 신규
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
    <script language=javascript src="<%=dirPath%>/Pms/common/js/common_pop.js"></script>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
 		v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//작업상태(조회)
    }
    
    
    
    <%//메인 조회 pr_rv200s_01_plz 호출 %>
    function fnSelect() {
	        var fr_date = v_fr_rqst_date.Text.trim();
	        var to_date = v_to_rqst_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("청구일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("청구일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_site_sid="+ v_site_sid.value
	                  + ",v_vend_cd="+ v_vend_cd.value
	                  + ",v_item_sid="+ v_item_sid.value
	                  + ",v_item_size="+ v_item_size.value
	                  + ",v_fr_rqst_date=" + fr_date
	                  + ",v_to_rqst_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010S",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:구매현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("구매현황", "구매현황.xls", 8);        
    }
    <%//도급계약명 팝- 조회%>
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

	<%//현장 팝%>
    function fnSelSitePopup___________________(dirPath) {
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
    
	<%//협력사 팝%>
    function fnSelCoopPopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtCoopPop1(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //alert(arrParam);
            v_vend_cd.value = arrParam[0];	//CD
            v_vend_nm.value = arrParam[1];//NM
        } else {
			fnSelCoopCleanup();
        }               
    }
    
    /*
	* 품목 팝업 : 상세 그리드에서 
	*/
	function fnSelItemPopup(dirPath) {
			
	   v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnItemPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //alert(arrParam);
            v_item_sid.value = arrParam[0];	//SID
            v_item_nm.value = arrParam[1];//NM
        } else {
			fnSelItemCleanup();
        }               
	}	
	
    /*
	* 품목 팝업 : 상세 그리드에서 
	*/
	function fnSelItemSizePopup(dirPath) {
			
	   v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnItemSizePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //alert(arrParam);
            v_item_size.value = arrParam[0];	//SID
            v_item_unit.value = arrParam[1];//NM
        } else {
			fnSelItemCleanup();
        }               
	}	
	
	 	 
   function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    function fnSelCoopCleanup(){
        v_vend_cd.value = "";
        v_vend_nm.value  = "";
    }
   function fnSelItemCleanup(){
        v_item_nm.value = "";
        v_item_sid.value  = "";
    }
   function fnSelItemSizeCleanup(){
        v_item_size.value = "";
    }
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        window.status="조회가 완료 되었습니다.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
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
<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 조회: 작업상태 -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDsDefault()">
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
                                    <td align="center" class="text" width="70">현장명</td>
                                    <td bgcolor="#FFFFFF" colspan="1">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="값 지우기">
                                    </td>
                    			    <td align="center" class="text" width="70">업체명</td>
                                    <td bgcolor="#FFFFFF" colspan="2">&nbsp;<input type="text" name='v_vend_nm' id="v_vend_nm" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_vend_cd' id='v_vend_cd'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCoopCleanup();" alt="값 지우기">
                                    </td>
                    			</tr>
                    			<tr>
                                    <td align="center" class="text" width="70">품목명</td>
                                    <td bgcolor="#FFFFFF" colspan="1">&nbsp;<input type="text" name='v_item_nm' id="v_item_nm" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_item_sid' id='v_item_sid'>
 						                <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelItemPopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelItemCleanup();" alt="값 지우기">
                                    </td>
                    			    <td align="center" class="text" width="70">규격명</td>
                                    <td bgcolor="#FFFFFF" colspan="2">&nbsp;<input type="text" name='v_item_size' id="v_item_size" style="width:200px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_item_unit' id='v_item_unit'>
                         			    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelItemSizePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelItemSizeCleanup();" alt="값 지우기">
                                    </td>
                    			</tr>
                    			<tr>
			                        <td align=left class="text"  width="70">청구일자</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=v_to_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
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
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                            <table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
                                <tr>
                                    <td valign=top>
                                        <%=HDConstant.COMMENT_START%>
                                       <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='450px' border='1'>
			                                <param name="DataID"            value="ds_default">
			                                <param name="ColSizing"         value="true">
			                                <param name="Editable"          value="false">
			                                <param name="SuppressOption"    value="1">
			                                <param name="BorderStyle"       value="0">
			                                <param name="ViewSummary"       value="1">
			                                <param name="Format"            value="
			                                     <C> name='작업상태'	ID='RQST_STATUS'    	width=100 	align=CENTER	Edit=None 		show=false	suppress=1</C>
			                                     <C> name='작업상태'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=true</C>
			                                     <C> name='청구일자' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		suppress=2</C>
			                                     <C> name='청구번호'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None	</C>
			                                     <C> name='청구SID'    ID='RQST_SID'       		show=false width=60 	align=CENTER	Edit=None 		decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
			                                     <C> name='현장코드'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=TRUE</C>
			                                     <C> name='품목'			ID='ITEM_NM' 				width=120 align=CENTER	Edit=None	show=TRUE		</C>
			                                     <C> name='규격'			ID='ITEM_SIZE' 				width=120 align=CENTER	Edit=None	show=TRUE		</C>
			                                     <C> name='단위'			ID='ITEM_UNIT' 				width=120 align=CENTER	Edit=None	show=TRUE		</C>
			                                     <C> name='수량'    		ID='RQST_CNT'       		width=60 		show=TRUE	 align=CENTER	Edit=None	decao=0	 		 </C>
			                                     <C> name='단가'    		ID='EST_AMT'       		width=60 		show=TRUE	 align=CENTER	Edit=None	decao=0	 		 </C>
			                                     <C> name='금액'    		ID='FN_EST_AMT'       		width=60 		show=TRUE	 align=CENTER	Edit=None	decao=0	 		 </C>			                                     			                                     
			                                     <C> name='품의번호'	ID='CON_NO' 				width=120 align=CENTER	Edit=None	</C>
			                                     <C> name='품의일자'	ID='DATE_CON' 				width=120 align=CENTER	Edit=None	</C>
			                                     <C> name='사용처'		ID='RQST_USE' 				width=120 align=CENTER	Edit=None	</C>
			                                     <C> name='담당자'		ID='PU_EMPNO' 				width=120 align=CENTER	Edit=None	</C>			                                     			                                     			                                     			                                     			                                     			                                     			                                     

                             ">
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
    </table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		