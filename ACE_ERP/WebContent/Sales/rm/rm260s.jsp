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
	var menuWin;	//새창 띄우기용.
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_ccl"), "comn1");	//work master list
		fnInit();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    //v_date.Text = "201403";

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
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260S",
            "JSP(O:DS_CCL=ds_ccl)",
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
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm260S",
            "JSP(O:DS_CCL=ds_ccl)",
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
        if(ds_ccl.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_ccl").SetExcelTitle(0, "");
        getObjectFirst("gr_ccl").SetExcelTitle(1, "value:일보 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_ccl").GridToExcel("일보 조회", v_date.text+"일보 조회.xls", 8);        
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
    
    <%
	//Description  : web 예약 화면 보기  
	%>
	function showRsv(Row) {
		if(ds_main.CountRow==0){
		alert("데이터를 먼저 조회하시길 바랍니다.");
		return;
		}
		//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
		//http://www.hdasantour.com/web/sub/rsv_view.php?v_param2=99000170614001&v_param3=010-6239-7178
		var link ='http://www.hdasantour.com/web/sub/rsv_view.php?v_param2='+ getObjectFirst("ds_main").NameValue(Row, "RACCEPT_NO") +'&v_param3='+ getObjectFirst("ds_main").NameValue(Row, "RMOB") ;
		var features ='height=768, width=1024, status=no, scrollbars=yes, resizable=yes';
		window.open(link, 'watchwin', features); 
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
    <script language="JavaScript"  for="ds_ccl" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_ccl event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
    </script>


	<script language=javascript for=gr_ccl event="OnDblClick(Row,Colid)">
	 	//alert(ds_ccl.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_ccl.NameValue(Row, "DWR_SID"),ds_ccl.NameValue(Row, "W_STS"));
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

<object id=ds_gc_type	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_country	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_city	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_useyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_licyn	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
    <table border='0' cellpadding='0' cellspacing='0'  width="100%"> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0'  width="100%" >
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
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666"  width="100%">
           			<tr>
						<td align="left" class="text" width="90">컨텐츠 타입</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_type classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gc_type>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>              			
                        <td align="center" class="text" width="70">이름(한글)</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:120px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="값 지우기">
                        </td>
						<td align="left" class="text" width="90">사용여부</td>           			
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=100 width=70 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
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
                <object id=gr_ccl classid=<%=HDConstant.MxGrid_CLSID_S%> style="width:98%; height:440px" border='1'>
                    <param name="DataID"            value="ds_ccl">
                    <param name="Editable"          value="true">
                    <param name="ColSizing"         value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                         <C> name='컨텐츠\\타입'		ID='CD_TYPE'   	width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_type:detail:detail_nm' </C>
                         <C> name='국가'	ID='CD_COUNTRY'   	width=70 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_country:detail:detail_nm'  </C>
                         <C> name='도시'	ID='CD_CITY'		width=70 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_city:detail:detail_nm'</C>
                         <C> name='이름\\(한글)'	ID='NAME_KOR'   	width=100 	align=left	Edit=true  </C>
                         <C> name='이름\\(영문)'	ID='NAME_ENG'   	width=70 	align=left	Edit=true  </C>
                         <C> name='이름\\(local)'	ID='NAME_LOCAL'   	width=70 	align=left	Edit=true  </C>
                         <C> name='위도'    ID='GMAP_N'	width=70 	align=center	Edit=NONE	 </C>
                         <C> name='경도'    ID='GMAP_E'	width=70 	align=center	Edit=none 	 </C>
                         <C> name='기본설명'    ID='DESC_BASIC'	width=80 	align=left 	Edit=none/C>
                         <C> name='이미지설명'    ID='DESC_IMG'	width=80 	align=left	Edit=none/C>
                         <C> name='추가설명'    ID='DESC_ADD'	width=80 	align=left 	Edit=none</C>
                         <C> name='저작권'    ID='FROM_LIC'	width=70 	align=center	Edit=none editstyle=lookup Data='ds_gc_licyn:detail:detail_nm' </C>
                         <C> name='출처(URL)'    ID='FROM_URL'	width=80 	align=left	Edit=none	</C>
                         <C> name='출처'    ID='FROM_TXT'	width=80 	align=center	Edit=none	</C>
                         <C> name='사용'    ID='CD_USEYN'	width=40 	align=center	Edit=none editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' </C>  
                         <C> name='작성자'    ID='I_EMPNO'	width=60 	align=center	Edit=none	</C>
                         <C> name='웹보기'   ID='WEBVIEW'   Width=60   Edit=none align=CENTER</C>
				                              
					">
				</object><br />
				※ 웹보기 컬럼의 <b>[웹화면]을 더블클릭</b>하면, 예약자의 웹화면을 볼 수 있습니다.



            </td>
        </tr>
    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		