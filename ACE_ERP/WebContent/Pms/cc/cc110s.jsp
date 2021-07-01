<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>법인카드>카드 관리>사용 현황
 * 프로그램ID 	 : PMS/CC110S
 * J  S  P		 : cc110s.jsp, GAUCE5.x
 * 서 블 릿		 : Cc110s
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-07-30
 * [ 수정일자 ][수정자] 내용
 * [2015-07-30][심동현] 신규 개발 
 *						- 재무팀 관리자용, 전체 카드 사용현황 조회
 *							진행상황 : 작성중 → 현장결재진행중 → 현장결재완료
 * [2015-08-04][심동현] html5 로 가볼가나? 근데 뭔가 이클립스가 반응이.. 후움;(__);
 * [2015-08-25][심동현] 디테일 조회까지 메인조회 쿼리 수정할 것~ [처리자부분]
 * [2015-11-19][심동현] 디테일 조회 java 추가
 *						GRID의 공제여부 컬럼 체크박스로 변경
 *						메인조회 쿼리 수정 : 카드번호, 처리자 (권한 무관하게 기록상TCC110.U_EMPNO=처리자로 검색
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


<!-- HTML 시작 : doctype를 html5로 해볼까? 훔;;-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
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
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
		cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail

		fnInit();
		
	}
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
    	
	    v_job ="I";
	    v_todt.Text = "<%=DateUtil.getCurrentDate(8)%>";
	    v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    

        ds_gc_ccstat.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC010&s_item1=Y";
        ds_gc_ccstat.Reset();	//카드 처리상태 CC010 (전체+ : dsType=4) 선택:dsType=3

        ds_gc_ddyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_gc_ddyn.Reset();	//공제여부 YN (SY010)

		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110S",
            "JSP(O:DS_CUL=ds_cul)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        //tr_post(tr1);
        
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var v_frdate = v_frdt.Text.trim();
        var v_todate = v_todt.Text.trim();
        
        if(v_frdate.length!=8||v_todate.length!=8) {
            alert("년월을 입력하시길 바랍니다.");
            return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid=1"
			+ ",v_frdt=" + v_frdate	//조회기간
			+ ",v_todt=" + v_todate	//조회기간
			+ ",v_ccstat=" + lc_gc_ccstat.ValueOfIndex("detail", lc_gc_ccstat.Index)	//처리상태
			+ ",v_card_num=" + v_card_num.value	//카드번호
			+ ",v_mgr_no=" + v_mgr_no.value	//처리자 사번
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110S",
            "JSP(O:DS_CUL=ds_cul)",
            param);
        tr_post(tr1);
    }

    <%// 디테일 계정정보 %>
    function fnSelectDetail(row) {
        v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
		tr_post(tr2);
    }
    
    
    <%//직원 팝- 검색조건 처리자%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }

    function fnCardNoCleanup(){
    	v_card_num.value = "";
    }
    
	<%//액셀 다운하기%>
    function fnExcelDsDefault() {
        if(ds_cul.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_cul").SetExcelTitle(0, "");
        getObjectFirst("gr_cul").SetExcelTitle(1, "value:법인카드 사용현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_cul").GridToExcel("법인카드 사용현황", "법인카드 사용현황.xls", 8);        
    }

    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_todt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>

	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectDetail(Row);
	    }
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
    <script language="JavaScript"  for="ds_cul" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_cul event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
			}
		}
	</script>
    	
    


	<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">
	 	//alert(ds_cul.NameValue(Row, "DWR_SID"));

	 	fnDraft(ds_cul.NameValue(Row, "DWR_SID"),ds_cul.NameValue(Row, "W_STS"));
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
<object id=ds_cul classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_culd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_gc_ccstat	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_ddyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="90">처리자</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>

                        <td align="center" class="text" width="90">조회기간</td>
                        <td bgcolor="#FFFFFF" >&nbsp;
                            <object id=v_frdt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
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
                            &nbsp;~&nbsp;
                            <object id=v_todt classid=<%=HDConstant.MxMaskEdit_CLSID_S%>  class="textbox" style= "position:relative;left:0px;top:2px;width:70px; height:17px;">
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
                        <td align="left" class="text" width="90">처리 상태</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_ccstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_ccstat>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                                                        
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">카드번호</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="값 지우기">                            
                        </td>
                        <td align="left" class="text" width="90"></td>
                        
                        <td align="left" bgcolor="#ffffff"><!-- &nbsp;
							<object id=gcem_fs02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox"  style="width:15px;height:17px;position:relative;left:0px;top:2px">				
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="#">
								<param name=PromptChar    value="_">
								<param name=UpperFlag     value=1>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="width:70px;height:17px;position:relative;left:0px;top:2px">		
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="YYYY/MM/DD">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object>
							&nbsp;-&nbsp;
							<object id=gcem_fsnbr02 classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="width:50px;height:17px;position:relative;left:0px;top:2px">				
								<param name=Text		value="">
								<param name=Alignment   value=1>
								<param name=VAlign	    value=1>
								<param name=Border      value="false">
								<param name=Format        value="######">
								<param name=PromptChar    value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object> -->
							   
                        </td>
                        <td colspan=2 bgcolor="#ffffff">&nbsp;</td>
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='400px' border='1'>
                    <param name="DataID"            value="ds_cul">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<param name=ColSelect    value="True">
					<param name="ViewSummary"       value="1">
					<param name="ColSizing"         value="true">																								                                        
					<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
						<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
					">
                    <param name="Format"            value="
						<FC> name='No'			ID='{CurRow}'		 width=40 	align=right edit=none SumText=@cnt</FC>
                        <FC> name='처리자'		ID='MGR_NM'   		 width=50 	align=CENTER  edit=none show=true</FC>
                        <FC> name='매입SId'		ID='ACquiRE_SID'	 width=50 	align=left show=false</FC>
					  <FG> name='카드정보'
                        <FC> name='관리부서'	 ID='DPT_NM'   		 width=80 	align=left  edit=none SumText='개' </FC>
                        <FC> name='보유자'	ID='EMP_NM'  	 width=50 	align=CENTER edit=none bgColor={IF(EMP_NM='미등록','#ffcccc','#FFFFFF') } </FC>
                        <FC> name='번호'	ID='CARD_NUM'  		 width=120 	align=right	edit=none mask='XXXX-XXXX-XXXX-XXXX' </FC>
                      </FG>
					  <G> name='거래처 정보 (ERP)'
                        <C> name='상호'			ID='VEND_NM'   	width=70 	align=left	edit=none </C>
                        <C> name='주소'			ID='ADDR1'   	width=90 	align=left	edit=none bgColor={IF(ADDR1='미등록 거래처','#ffff00','#FFFFFF') } </C>
                        <C> name='과세'			ID='COCOMYN_NM'   	width=40 	align=CENTER	edit=none </C>
                      </G>
                      <G> name='이용정보'
                        <C> name='일자'		ID='APPROVE_DATE'	 width=70 	align=CENTER edit=none mask='XXXX-XX-XX'</C>
                        <C> name='시각'		ID='APPROVE_TIME'	 width=40 	align=CENTER edit=none mask='XX:XX'</C>
                        <C> name='금액'     ID='AMT_TOTAL'	width=70 	align=right		Edit=NONE	 decao=0  </C>
                      </G>
                        <C> name='공급가액'     ID='AMT_NET'	width=70 	align=right		Edit=NONE	 decao=0  </C>
                        <C> name='부가세'    	ID='AMT_TAX'	width=60 	align=right		Edit=NONE	 decao=0  </C>
                        <C> name='봉사료\\(면세액)'    	ID='AMT_SVC'	width=50 	align=right		Edit=NONE	 decao=0  </C>
						<C> name='처리\\상태'   ID='STAT'   	width=50 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_ccstat:detail:detail_nm' </C>
						<C> name='공제\\여부'	ID='DDYN'   	width=30 	align=CENTER	edit=true editstyle=CheckBox  bgColor={IF(DDYN='T','#CCFFCC','#FFFF00') } </C>
						<C> name='통화'			ID='CURRENCY'   	 width=40 	align=CENTER  edit=none</C>
					  <G> name='가맹점 정보 (BC제공)'
						<C> name='사업자번호'	ID='VENDOR_TAX_NUM'  width=80 	align=left	edit=none mask='XXX-XX-XXXXX'</C>
						<C> name='가맹점명'		ID='VENDOR_NAME'	 width=100 	align=left	edit=none </C>
						<C> name='대표자' 		ID='VENDOR_PERSON'   width=50 	align=center edit=none </C>
						<C> name='전화'			ID='VENDOR_TEL'   	width=80 	align=left	edit=none </C>
						<C> name='주소'			ID='VENDOR_ADDRESS1'   	width=100 	align=left	edit=none </C>
					  </G>
                 ">                             
                </object>                        

            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-top:4px"><b>계정정보</b>
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='100px' border='1'>
                    <param name="DataID"            value="ds_culd">
                    <param name="Editable"          value="false">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value="
                        <C> name='계정명'	ID='ATCODENM'	width=200 	align=left EditStyle=popup </C>
                        <C> name='계정코드'	ID='ATCODE'		width=70 	align=center edit=none </C>
                        <C> name='적요'		ID='REMARK'   	width=320 	align=left </C>
                        <C> name='공급가액' ID='FSAMT'		width=70 	align=right		decao=0  </C>
                        <C> name='귀속정보'	ID='PL_DEPT_NM' width=200 	align=left EditStyle=popup </C>
                        <C> name='귀속코드'	ID='PL_DEPT' 	width=70 	align=center  edit=none show=true  </C>
                        <C> name='귀속구분'	ID='PL_DEPT_DIV'	width=60 	align=CENTER show=false	</C>
                        <C> name='매입SID'	ID='acquire_sid'	width=60 	align=CENTER	edit=none show=false</C>
                        
                 ">                             
                </object>
            </td>
        </tr>
        <tr> 
        	<td>※ Zace(건설ERP)에서 처리한 내역은 하단 [계정정보]가 표시되지 않습니다.</td>       
		</tr>

        
    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		