<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>공사>현장>작업 관리>일보 조회/등록
 * 프로그램ID 	 : PMS/SI110S
 * J  S  P		 : si110s.jsp
 * 서 블 릿		 : Si110s
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2014-06-24
 * [ 수정일자 ][수정자] 내용
 * [2014-06-24][심동현] 신규 개발 
 *						- 내가 등록한 것 전부 조회 : 진행상황 관리
 *							진행상황 : 작성중 → 현장결재진행중 → 현장결재완료
 *						- 확 365일 기본 값을 일괄 생성해줄까?
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
	var menuWin;	//새창 띄우기용.
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_wml"), "comn");	//work master list
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    //v_date.Text = "201403";

        //ds_gc_weather.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY017&s_item1=Y";
        //ds_gc_weather.Reset();	//날씨 코드 SY017 (선택+)

        //ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        //ds_gc_wdcode.Reset();	//작업 구분(일지용) SI004

        //ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        //ds_gc_bskind.Reset();	//입찰 공종 CT001 

        ds_gc_wsts.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI007&s_item1=Y";
        ds_gc_wsts.Reset();	// 일보 작업상태 	SI007 

        
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WML=ds_wml)",
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

        if(v_wdate.length!=6) {
            alert("년월을 입력하시길 바랍니다.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid="+ v_site_sid.value
			+ ",v_date=" + v_wdate
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110S",
            "JSP(O:DS_WML=ds_wml)",
            param);
        tr_post(tr1);
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
    
	<%//액셀 다운하기%>
    function fnExcelDsDefault() {
        if(ds_wml.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_wml").SetExcelTitle(0, "");
        getObjectFirst("gr_wml").SetExcelTitle(1, "value:일보 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_wml").GridToExcel("일보 조회", v_date.text+"일보 조회.xls", 8);        
    }

    <%// 팝업 = 작업일보 Daily Work Report %>
    function fnDraft(sid,sts) {
    	if(sts=="013"){
    		alert("반려된 문서의 결재선과 의견은 통합결재함/기안한 문서에서 확인하실 수 있습니다.\n\n상신 모드로 이동합니다.");
    	}
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
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_wml" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_wml event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
    </script>


	<script language=javascript for=gr_wml event="OnDblClick(Row,Colid)">
	 	//alert(ds_wml.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_wml.NameValue(Row, "DWR_SID"),ds_wml.NameValue(Row, "W_STS"));
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
<object id=ds_wml classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_wsts	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_site_emp classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" onclick="fnExcelDsDefault()">
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
                <object id=gr_wml classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='440px' border='1'>
                    <param name="DataID"            value="ds_wml">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                         <C> name='현장명'	ID='SITE_NM'   	width=300 	align=left	Edit=true  suppress='1' </C>
                         <C> name='작성일자'	ID='W_DATE'	width=100 	align=CENTER	edit=none mask='XXXX-XX-XX'</C>
                         <C> name='상태'	ID='W_STS'   	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wsts:detail:detail_nm' suppress='2' </C>
                         <C> name='계획(%)'    ID='RATE_PLAN'	width=70 	align=center	Edit=NONE	 decao=2  </C>
                         <C> name='실적(%)'    ID='RATE_RESULT'	width=70 	align=center	Edit=none 	 decao=2 </C>
                         <C> name='대비(%)'    ID='PROG_RATE'	width=80 	align=center	Edit=none	 decao=2 </C>
                         <C> name='작성자'    ID='I_EMPNM'	width=80 	align=center	Edit=none	suppress='3' </C>
                 ">                             
                </object>                        

            </td>
        </tr>
    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		