<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사>현장관리>작업관리>작업 현황
 * 프로그램ID 	 : PMS/SI120S
 * J  S  P		 : si120s.jsp
 * 서 블 릿		 : Si120S
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2014-03-27
 * [ 수정일자 ][수정자] 내용
 * [2014-03-27][심동현] 신규 개발 
 * [2014-04-07][심동현] GAUCE MX component 5.x로 클래스ID수정
 * [2015-08-05][심동현] 클래스ID 변수명 수정
 
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
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    gr_default.RowHeight = "50";	//그리드 로우하이트 변경
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
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
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si120S",
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
        getObjectFirst("gr_default").SetExcelTitle(1, "value:주요 작업 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("주요 작업 현황", v_date.text+"주요 작업 현황.xls", 8);        
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

    <%// 팝업 = 작업일보 Daily Work Report %>
    function fnDraft(sid,sts) {
        var link ="si110i_h1.jsp?v_dwr_sid="+ sid +"&v_status="+ sts;
        
        var dialogWidth = 930; 
        var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height="+(screen.availHeight-52)+", width="+dialogWidth+",toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes";
        var pop_ap_dwr1 = window.open(link, 'pop_ap_dwr1', features); 

    
    }
    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<%// 더블 클릭시 작업일보 조회 팝 %>
	<script language=javascript for="gr_default" event="OnDblClick(Row, Colid)">
	    if(Row==0) return;
	 	fnDraft(ds_default.NameValue(Row, "DWR_SID"),ds_default.NameValue(Row, "W_STS"));
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
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_default" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}
		}
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
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

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDsDefault()">
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
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='890px'>
                    			<tr>
                                    <td align="center" class="text" width="70">현장명</td>
                                    <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="값 지우기">
                                    </td>
			                        <td align="left" class="text" width="70">일자</td>
			                        
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=v_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
                         
                        <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='890px' height='450px' border='1'>
                            <param name="DataID"            value="ds_default">
                            <param name="ColSizing"         value="true">
                            <param name="Editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="BorderStyle"       value="0">
                            <param name="ViewSummary"       value="0">
                            <param name="Format"            value="
                                 <C> name='현장명'		ID='SITE_NM_S'	width=80 	align=CENTER	Edit=None </C>
								<G> name='인원/기계'
                                 <C> name='전일'		ID='MM_PRE'   	width=80 	align=CENTER	Edit=None</C>
                                 <C> name='금일'    	ID='MM_NOW'		width=80 	align=CENTER	Edit=None</C>
								</G>
								<G> name='주요 작업'
                                 <C> name='전일'		ID='W_PRE'  	width=240 	align=left	Edit=None multiline=true </C>
                                 <C> name='금일'    	ID='W_NOW'		width=240 	align=left	Edit=None multiline=true </C>
								</G>
                                 <C> name='비고'		ID='W_REMARK' 	width=150 	align=left	Edit=None multiline=true </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top"><br>

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		