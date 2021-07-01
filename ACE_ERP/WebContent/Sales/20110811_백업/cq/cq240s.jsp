<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 확정차량 자료검사
 * 프로그램ID 	: cq240s
 * J  S  P			: cq240s
 * 서 블 릿		: Cq240s
 * 기능정의		: 확정차량 자료검사
 * [ 수정일자 ][수정자] 내용
 * [2010-04-12][박경국] 신규. 확정차량의 자료검사.
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
//   	firstday="20060805";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
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
         var v_job = "H";		
		 var div='';

		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
	        v_job = "H";		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			sDate.Text = '<%=firstday%>';	
			fnInit()
		} 
		function fnInit() {
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//출입방향

	        ds_code2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ004&s_item1=Y";
	        ds_code2.Reset();	//운전여부
		}
		// 차량정보 조회 (GR1)
		function fnSelect1() {
			v_job = "S";	//select 일듯..
			 if ( sParam01.checked == true ) 
	         	sParam01.value='Y';
	         else
	         	sParam01.value='N';	         
	         if ( sParam02.checked == true ) 
	         	sParam02.value='Y';
	         else
	         	sParam02.value='N';
	        
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("depart_time", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_accept_no=" + v_accept_no.Text
					  + ",sParam01=" + sParam01.value 
	            	  + ",sParam02=" + sParam02.value   ;
	        ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq240S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}

		// 출경시간, 상품조회
		function fnSelectDs3() {
		    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		     
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 		
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		}else{
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_DEPART_TIME_DS_NEW=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		
	 		} ;
		    tr_post(tr1);
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
	    /*
	 * 엑셀
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("확정차량 자료검사");
	}		
</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
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

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
	</script>
	
	<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table width="845" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #6f7f8d">
					<tr>
						<td width="270" height="20">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="25" height="25"><input name="sParam01" type="checkbox" value="Y"></td>
									<td>&nbsp;차량 관리번호가 없는 경우</td>
								</tr>
							</table>
						</td>
						<td width="270">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="25" height="25"><input name="sParam02" type="checkbox" value="Y"></td>
									<td >&nbsp;차량명칭이 없는 경우</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table  border='0' cellpadding='0' cellspacing='0' width='845' >
					<tr height=50px>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect1()"> 		<!-- 조회 -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  	<!-- 엑셀 -->																																																																																		
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td width="70px" height="25px" class="text">신청서번호</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                        </td>
						<td align=left class="text" width="50">지역</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text"  width="50">방향</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							<%=HDConstant.COMMENT_END%>
	                    </TD>						
						<td align=left class="text"  width="60">출입일자</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							<%=HDConstant.COMMENT_START%>
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
							<%=HDConstant.COMMENT_END%>
						</td>																							
						<td align=left class="text" width="60">상품(출)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10'>
			<td></td>
		</tr>
		<tr>
			<td align=center>
				<%=HDConstant.COMMENT_START%>
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=845 height=190 border=1 style="display:;">
                    <param name="DataID"            value="ds1">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"         value="true">
                    <param name="editable"          value="True">
                    <param name="SuppressOption"    value="1">
                    <param name="Format"            value=" 
					<G> name='출입정보'
						<C> name='신청서번호'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX'</C>
						<C> name='상품명'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 </C>
						<C> name='출발일자'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
						<C> name='시간'    		ID='DEPART_TIME'	width=35 	align=center	Edit=None suppress=4 mask='XX:XX'</C>
						<C> name='복귀일자'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
						<C> name='시간'     	ID='arrive_time' 	width=35 	align=CENTER	Edit=None suppress=6 mask='XX:XX'</C>
					</G>
					<G> name='출입시 차량정보'
						<C> name='호수' 		ID='RIDE_CAR_NUM'	Width=35   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
						<C> name='명칭' 		ID='RIDE_CAR_NM'	Width=70   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
					</G>
                        <C> name='협력업체명'   ID='CLIENT_NM'		Width=100  Edit=none align=Left</C>
                        <C> name='코드'    		ID='CLIENT_CD'		Width=40   Edit=none align=Left </C>
						<C> name='차량예약ID' 		ID='CAR_RSV_SID'    Width=80   Edit=none align=Left show=false</C>
					<G> name='차량정보'
                        <C> name='등록번호'     ID='CAR_NO'             Width=80   Edit=none align=Left</C>
                        <C> name='차명'             ID='CAR_NM'             Width=80   Edit=none align=Left		show=false</C>
                        <C> name='차종'             ID='CAR_FORM'           Width=80   Edit=none align=Left	show=false</C>
                        <C> name='형식'             ID='CAR_TYPE'           Width=80   Edit=none align=Lef	show=false</C>
                        <C> name='연식'             ID='CAR_YEAR'           Width=40   Edit=none align=Righ	show=false</C>
                        <C> name='배기량(cc)'       ID='CAR_CC'             Width=80   Edit=none align=Right	show=false</C>
                        <C> name='승차인원'         ID='CAR_PERSONS'        Width=60   Edit=none align=Right</C>
                        <C> name='최대적재량(kg)'   ID='MAX_KG'             Width=100  Edit=none align=Right	show=false</C>
                        <C> name='차종1'            ID='CAR_TYPE_CD_NAME'   Width=80   Edit=none align=Left	show=false</C>
                        <C> name='차대번호'         ID='CAR_DNO'            Width=80   Edit=none align=Left	show=false</C>
					</G>
                    ">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

