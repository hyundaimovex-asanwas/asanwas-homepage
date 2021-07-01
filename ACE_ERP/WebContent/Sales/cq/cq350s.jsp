<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 인원목록 - 통통 업로드용
 * 프로그램ID 	: CQ330S
 * 기능정의		: 예약정보(인원)를 통통양식으로 다운로드 받는 화면. 통통에 업로드하면 대북/군부용 액셀파일로 다운가능.
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2010-02-08][박경국] 예약확정명단(통통업로드 용)화면 신규.
 * [2010-03-22][심동현] 새 검색조건으로 수정 : 차량탑승과 동일하게
 * [2013-12-11][심동현] 새 시스템으로 이전
 * [2015-09-11][심동현] 15 추석 상봉 준비 : 통통 양식 맞춤
 *						방문지역 대분류 코드가 바뀐 듯
 * [2015-10-22][심동현] 출입 시각 서블릿으로 전달 안됨
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
		
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());		
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
		 var div='';
		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			sDate.text='<%=firstday%>';	
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//출입방향

	   }
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("detail", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_class=" + lc_class.ValueOfIndex("class", lc_class.Index)
			          + ",v_team=" + lc_team.ValueOfIndex("teams", lc_team.Index)
			          + ",v_jobsel=" + sJobsel.value
			          + ",v_accept_no=" + v_accept_no.Text;
			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq350S",
			    "JSP(O:DS1=ds1,O:DS2=ds2)",
			    param);
			   
			tr_post(tr1);
		}
			
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:통통업로드(인원계획신청); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("통통업로드(인원계획신청)","통통업로드(인원계획신청).xls", 8);
	        
	        /*if(ds2.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:통통업로드(인원계획변경); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("통통업로드(인원계획변경)","통통업로드(인원계획변경).xls", 8);
	        */
		}
    	
		// 출경시간, 상품조회
		function fnSelectDs3() {
			//alert("fnSelectDs3()::::22222");
			//alert("fnSelectDs3()");
		    msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		     
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 			//alert(lc_code1.ValueOfIndex("detail", lc_code1.Index));
	 			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=2"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    //alert(v_param);
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		}else{
	 			//alert("출경시간조회");
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=3"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    //alert("tr1 before");
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_GOODS_DS=ds_goods,O:S_DEPART_TIME_DS_NEW=ds_time)",
			        v_param);		
			    //alert("tr1 ");

	 		} ;

		        
		    tr_post(tr1);
		}

		
		// 반
		function fnClass() {
			if (div == 'init') {
				//alert("div == 'init'");
				//alert(ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
				//alert(ds_goods.namevalue(0,"goods_sid"));
				//alert(ds_goods.namevalue(1,"goods_sid"));
				//alert(ds_goods.CountColumn);
				//alert(ds_goods.CountRow);
				//alert(ds_goods.RowPosition);
				//alert(ds_goods.Text);
				//prompt(ds_goods.txet);
				//alert(ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
				ln_TRSetting(tr3, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS6=ds_class)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.NameValue(ds_goods.RowPosition,"goods_sid"));
		        tr_post(tr3);
			} else {
				//alert("div != 'init'");
				ln_TRSetting(tr3, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS6=ds_class)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.NameValue(ds_goods.RowPosition,"goods_sid"));
	        	tr_post(tr3);
			}
		}

		
		// 조 	
		function fnTeam() {
			if (div == 'init') {
				ln_TRSetting(tr4, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS7=ds_team)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="
		            		+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
		        tr_post(tr4);
			} else {
				ln_TRSetting(tr4, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS7=ds_team)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="
	            			+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
	        	tr_post(tr4);
			}
			div='';
		}	

		// 신청서 번호 조회
	    function fnAcceptNoPopup(){
	        v_cust_row = 0;
	        var arrResult   = new Array();
	        arrResult = fnAcceptNoPop("<%=dirPath%>");
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            getObjectFirst("v_accept_sid").value = arrParam[0];
	            getObjectFirst("v_accept_no").Text   = arrParam[1];
	        }
	    }

		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="작업이 성공적으로 완료되었습니다.";
	</script>	
	
	<script language=JavaScript for=sDate event=OnKillFocus()>
		if ( div != 'init' ) {	//출입일자 포커스 이동 
			if ( sDate.Modified ) {
				div = 'init';
				fnSelectDs3();
			}
		}
	</script>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for= lc_code1 event=OnSelChange()>
		if ( div != 'init' ) {	//방향
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for=lc_time event=OnSelChange()>
		if ( div != 'init' ) {	//출경시간
			div = 'init';
			fnClass();
		}
	</script>
    <script language=JavaScript for=lc_goods event=OnSelChange()>
        if ( div != 'init' ) {  //상품
            div = 'init';
            fnClass();
        }
    </script>
	<script language=JavaScript for=lc_class event=OnSelChange()>
		if ( div != 'init' ) {	//반
			div = 'init';
			fnTeam();// 조 호출
		}
	</script>

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
	</script>
	<script language=JavaScript for=ds_goods event=OnLoadCompleted(rowcnt)> <!-- 상품 -->
		fnClass();
	</script>
	<script language=JavaScript for=ds_class event=OnLoadCompleted(rowcnt)> <!-- 반 -->
		fnTeam();
	</script>
	<script language=JavaScript  for=ds_team event="OnLoadCompleted(row)"> <!-- 조 -->
		div=''
	</script>	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--계획신청-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--계획변경-->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_code1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_team classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='1002'>	
		<tr>
			<td align='right'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
				<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- 엑셀 -->

			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td >
				<table border='0' cellpadding='0' cellspacing='1' width="1002" bgcolor="#666666">
					<tr height='25px'>
						<td width="80" height="20px" class="text">신청서번호</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                        </td>
						<td align=left class="text" width="50">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							
						</td>
						<td align=left class="text"  width="50">방향</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							
	                    </td>						
						<td align=left class="text"  width="70">출입일자</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							
							<object id=sDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny  	value="false">																				
							</object>&nbsp;
                            <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_time>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail_nm">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^50"></object>
							
						</td>																							
						<td align=left class="text" width="60">상품(출)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							
						</td>
					</tr>
					<tr height='20px'>
						<td align=left class="text">반/조</td>
                        <td align=left bgcolor="#ffffff" colspan=5>&nbsp;																										
							
                            <object id=lc_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_class>
								<param name=BindColumn      value="class">
                                <param name=BindColVal      value="class">
								<param name=EditExprFormat	value="%,%;class,class_nm">
								<param name=ListExprFormat  value="class_nm^0^70"></object>
                            <object id=lc_team classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_team>
								<param name=BindColumn      value="teams">
                                <param name=BindColVal      value="teams">
								<param name=EditExprFormat	value="%,%;teams,teams_nm">
								<param name=ListExprFormat  value="teams_nm^0^70"></object>
							
						</td>	
			            <td align=left class="text">고객구분</td>
			            <td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
	    					<select name="sJobsel"> 
		    					 <option value="0" SELECTED>전체</option>
								 <option value="1">관광객</option>
								 <option value="2">사업자</option>
								 <option value="3">관광도우미</option>
								 <option value="4">운전자</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='30px'>
			<td></td>
		</tr>
		<tr>
			<td>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr valign="top"">
						<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
							<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:13; top:180; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="계획신청"</T>
									<T>divid="mxTab_page2"	title="계획변경"</T>
									'>
							</object>
							<div class=page id="mxTab_page1" style="position:absolute; left:13; top:200; width:1002; height:300">
							
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <FC> name='성명'      		ID='CUST_NM'     	width=60 	align=left editlimit=30 show=true SumText='총계'</FC>
						              <FC> name='영문성명'      	ID='CUST_NM_ENG'   	width=100 	align=left editlimit=30 show=true SumText=@count</FC>
						              <C> name='재외국민여부'      	ID='LIVE_OUT_YN'   	width=80 	align=left editlimit=30 show=true </C>
						              <C> name='주민등록번호'    	ID='REGI_NO'	   	width=80	align=center editlimit=14 show=true</C>
						              <C> name='여권번호'	    	ID='PASS_NO'   		width=60	align=left editlimit=30 show=true</C>
						              <C> name='방문목적대분류'	    ID='NORTH_PURPOSE_L_CD'   		width=90	align=left editlimit=30 show=true</C>
						              <C> name='방문목적중분류'	    ID='NORTH_PURPOSE_S_CD'   		width=90	align=left editlimit=30 show=true</C>
						              <C> name='방문목적상세'	    ID='NORTH_PURPOSE'  width=100	align=left editlimit=30 show=true</C>
						              <C> name='방문지역'	    	ID='SAUP_NM'	   	width=60	align=left editlimit=30 show=true</C>
 									  <C> name='소속'  			  	ID='COMPANY_NM'   	width=80 	align=left editlimit=50 show=true</C>
									  <C> name='영문소속'    		ID='ENG_COMPANY_NM'	width=80 	align=left editlimit=50 show=true</C>
									  <C> name='직위' 		  		ID='POSITIONS'  	width=60 	align=left editlimit=61 show=true</C>
									  <C> name='영문직위'   		ID='ENG_POSITION'  	width=80 	align=left editlimit=61 show=true</C>
									  <C> name='성별'   			ID='SEX'			width=50 	align=center editlimit=6 show=true</C>
									  <C> name='생년월일'    		ID='BIRTHDAY'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='주소'    			ID='ADDRESS'   	width=120 	align=left editlimit=50 show=true</C>
									  <C> name='출입경구분'    		ID='CQ_GUBN'   	width=70 	align=center editlimit=50 show=true</C>
									  <C> name='출경일자'    		ID='DEPART_DATE'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='출경시간'    		ID='DEPART_TIME'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='입경일자'    		ID='ARRIVE_DATE'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='입경시간'    		ID='ARRIVE_TIME'   	width=60 	align=center editlimit=50 show=true</C>
						              <C> name='탑승차량'     		ID='CAR_NO' 	  	width=70 	align=center editlimit=60 show=true</C>
						              <C> name='승차호수'    		ID='RIDE_CAR_NUM'  	width=55 	align=center editlimit=30 show=true</C>
						              <C> name='변경사유'      		ID='REASON'     	width=60 	align=left editlimit=50 show=FALSE </C>
						              <C> name='영문국적'    		ID='NATION_NM_ENG' 	width=80 	align=left editlimit=30 show=true</C>
						              <C> name='국적코드'  			ID='NATION_NM'    	width=50 	align=center editlimit=60 show=true</C>
						              <C> name='방문유형'      		ID='VISIT_TYPE'	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='관광유형'      		ID='TOUR_TYPE'	width=60 	align=center editlimit=50 show=true</C>
    								  <C> name='정렬순서'      		ID='{STRING(CURROW)}'		width=55 	align=right editlimit=50 show=true</C>
									  <C> name='심사여부'      		ID='PERMIT_YN'	width=55 	align=center editlimit=50 show=true</C>
									  <C> name='비고'      			ID='REMARKS'		width=70 	align=center editlimit=50 show=true</C>
						              <C> name='M_RSV_SID'    		ID='m_rsv_sid'   	width=100 	align=left editlimit=12 show=false</C>
						              <C> name='RSV_SID'      		ID='rsv_sid'     	width=100 	align=left editlimit=12 show=false</C>
               					">
							</object>   
									
							</div>
							<div class=page id="mxTab_page2" style="position:absolute; left:13; top:200; width:1002; height:300">
							
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='370px' border='1'>
                    			<param name="DataID"		VALUE="ds2">
                    			<param name="BorderStyle"   VALUE="0">
                    			<param name=ColSizing       value="true">
                    			<param name="editable"      value="false">
                    			<param name=UsingOneClick  	value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <param name=ViewSummary     value=1>
                                <param name="SortView"      value="Right">
								<param name=SuppressOption value=1>
								<param name="Format" 			value="
									<FC> name='성명'      		ID='CUST_NM'     	width=60 	align=left editlimit=30 show=true SumText='총계'</FC>
						              <FC> name='영문성명'      	ID='CUST_NM_ENG'   	width=100 	align=left editlimit=30 show=true</FC>
						              <C> name='재외국민여부'      	ID='LIVE_OUT_YN'   	width=80 	align=left editlimit=30 show=true  SumText=@count</C>
						              <C> name='주민등록번호'    	ID='REGI_NO'	   	width=80	align=center editlimit=14 show=true</C>
						              <C> name='여권번호'	    	ID='PASS_NO'   		width=60	align=left editlimit=30 show=true</C>
						              <C> name='방문목적대분류'	    ID='NORTH_PURPOSE_L_CD'   		width=90	align=left editlimit=30 show=true</C>
						              <C> name='방문목적중분류'	    ID='NORTH_PURPOSE_S_CD'   		width=90	align=left editlimit=30 show=true</C>
						              <C> name='방문목적상세'	    ID='NORTH_PURPOSE'  width=100	align=left editlimit=30 show=true</C>
						              <C> name='방문지역'	    	ID='SAUP_NM'	   	width=60	align=left editlimit=30 show=true</C>
 									  <C> name='소속'  			  	ID='COMPANY_NM'   	width=80 	align=left editlimit=50 show=true</C>
									  <C> name='영문소속'    		ID='ENG_COMPANY_NM'	width=80 	align=left editlimit=50 show=true</C>
									  <C> name='직위' 		  		ID='POSITIONS'  	width=60 	align=left editlimit=61 show=true</C>
									  <C> name='영문직위'   		ID='ENG_POSITION'  	width=80 	align=left editlimit=61 show=true</C>
									  <C> name='성별'   			ID='SEX'			width=50 	align=center editlimit=6 show=true</C>
									  <C> name='생년월일'    		ID='BIRTHDAY'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='주소'    			ID='ADDRESS'   	width=120 	align=left editlimit=50 show=true</C>
									  <C> name='원출입경구분'    	ID='CQ_GUBN'   	width=80 	align=center editlimit=50 show=true</C>
									  <C> name='원출경일자'    		ID='DEPART_DATE'   	width=70 	align=center editlimit=50 show=true</C>
									  <C> name='원출경시간'    		ID='DEPART_TIME'   	width=70 	align=center editlimit=50 show=true</C>
									  <C> name='원입경일자'    		ID='F_ARRIVE_DATE'   	width=70 	align=center editlimit=50 show=true</C>
									  <C> name='원입경시간'    		ID='F_ARRIVE_TIME'   	width=70 	align=center editlimit=50 show=true</C>
						              <C> name='출입경구분'    		ID='CQ_GUBN'   	width=70 	align=center editlimit=50 show=true</C>
									  <C> name='출경일자'    		ID='DEPART_DATE'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='출경시간'    		ID='DEPART_TIME'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='입경일자'    		ID='L_ARRIVE_DATE'   	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='입경시간'    		ID='L_ARRIVE_TIME'   	width=60 	align=center editlimit=50 show=true</C>
						              <C> name='탑승차량'     		ID='CAR_NO'   	width=70 	align=center editlimit=60 show=true</C>
						              <C> name='승차호수'    		ID='RIDE_CAR_NUM'  	width=55 	align=center editlimit=30 show=true</C>
						              <C> name='변경사유'      		ID='REASON'     	width=60 	align=left editlimit=50 show=FALSE </C>
						              <C> name='영문국적'    		ID='NATION_NM_ENG' 	width=80 	align=left editlimit=30 show=true</C>
						              <C> name='국적코드' 			ID='NATION_NM'    	width=50 	align=center editlimit=60 show=true</C>
						              <C> name='방문유형'      		ID='VISIT_TYPE'	width=60 	align=center editlimit=50 show=true</C>
									  <C> name='관광유형'      		ID='TOUR_TYPE'	width=60 	align=center editlimit=50 show=true</C>
    								  <C> name='정렬순서'      		ID='{STRING(CURROW)}'		width=55 	align=right editlimit=50 show=true</C>
									  <C> name='심사여부'      		ID='PERMIT_YN'	width=55 	align=center editlimit=50 show=true</C>
									  <C> name='비고'      			ID='REMARKS'		width=70 	align=center editlimit=50 show=true</C>
						              <C> name='M_RSV_SID'    		ID='m_rsv_sid'   	width=100 	align=left editlimit=12 show=false</C>
						              <C> name='RSV_SID'      		ID='rsv_sid'     	width=100 	align=left editlimit=12 show=false</C>
								">
							</object>
							
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	※ 금강산 방북신청현황(인원) 통통 업로드 용 화면입니다.<br>
	※ 고객 <b><font color=red>주민번호/여권번호의 정보보호</font></b>에 각별히 유의하여 주시기 바랍니다.

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

