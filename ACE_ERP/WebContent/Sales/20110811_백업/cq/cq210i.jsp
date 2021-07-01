<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 호차배정
 * 프로그램ID 	: CQ210I
 * J  S  P		: cq210i
 * 서 블 릿		: Cq210I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-11
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
		
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			
			fnInit(); 
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			
			div.value = 'init';
			initDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			initDs1.Reset(); //지역코드
	   }
		
		/*
		 * 출경시간, 상품조회
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + initDs1.namevalue(initDs1.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=initDs2,O:S_GOODS_DS=initDs3)",
	            param);
	        tr_post(tr2);
		}	
		
		
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index)
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * 저장
		 */
		function fnApply() {
            if(ds1.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "TEAMS_CUST_NM")!="" && ds1.NameValue(i, "TEAMS_CUST_SID")==0){
                    alert("조장은 임의로 지정할 수 없습니다.");
                    gr1.setColumn("TEAMS_CUST_NM");
                    ds1.RowPosition = i;
                    return;
                }
                if(ds1.NameValue(i, "DRIVE_CUST_NM")!="" && ds1.NameValue(i, "DRIVE_CUST_SID")==0){
                    alert("운전자명은 임의로 지정할 수 없습니다.");
                    gr1.setColumn("DRIVE_CUST_NM");
                    ds1.RowPosition = i;
                    return;
                }
            }
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
			         + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
			
			fnSelect();
		}
		
		
		 /*
		 * 생성
		 */
		function fnCreate() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
			         + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
			
			fnSelect();
		}
		
		 /*
		 * 삭제
		 */
		function fnDelete() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3"
			         + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
			
			fnSelect();
		}
        
        /**
         * 조장, 운전자 조회 Help
         * arrParam[0] : 성명
         * arrParam[1] : 주민등록번호
         * arrParam[2] : 고객 SID
         */
        function fnDrivePeoplePopup(v_saup_gu){
            var arrParam    = new Array();
            var arrResult   = new Array();
            
            arrParam[0] = v_saup_gu;
            arrParam[1] = sBgnDate.Text;
            arrParam[2] = lc2.ValueOfIndex("depart_time",lc2.Index);
            arrParam[3] = lc1.ValueOfIndex("saup_sid", lc1.Index);
            arrParam[4] = lc3.ValueOfIndex("goods_sid", lc3.Index);
            
            if(v_saup_gu == "50"){
                arrResult = fnDrivePeoplePop('<%=dirPath%>', arrParam);
                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    ds1.NameValue(ds1.RowPosition, "TEAMS_CUST_NM") = arrParam[0];
                    ds1.NameValue(ds1.RowPosition, "TEAMS_CUST_SID") = arrParam[2];
                }
            } else if(v_saup_gu == "60"){
                arrResult = fnDrivePeoplePop('<%=dirPath%>', arrParam);
                if (arrResult != null) {
                    arrParam = arrResult.split(";");
                    ds1.NameValue(ds1.RowPosition, "DRIVE_CUST_NM") = arrParam[0];
                    ds1.NameValue(ds1.RowPosition, "DRIVE_CUST_SID") = arrParam[2];
                }
            }
        }
        
        /**
         * 차량조회 Help
         * arrParam[0] : 차량등록번호
         * arrParam[1] : 차명
         * arrParam[2] : 차량SID
         */
        function fnCarInfoPopup(){
            var arrParam    = new Array();
            var arrResult   = new Array();
            arrResult = fnCarInfoPop('<%=dirPath%>');
            
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                ds1.NameValue(ds1.RowPosition, "CAR_NO") = arrParam[0];
                ds1.NameValue(ds1.RowPosition, "CAR_NM") = arrParam[1];
                ds1.NameValue(ds1.RowPosition, "CAR_SID") = arrParam[2];
            }
        }
		</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
        document.all.LowerFrame.style.visibility="hidden"; 
	</script>	

    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    </script>
	
    <script language=JavaScript for=gr1 event="OnPopup(Row,Colid,data)">
        if(Row==0) return;
        if(Colid == "TEAMS_CUST_NM"){
            fnDrivePeoplePopup("50");
        } else if(Colid == "DRIVE_CUST_NM"){
            fnDrivePeoplePopup("60");
        } else if(Colid="CAR_NO"){
            fnCarInfoPopup();
        }
    </script>

    <script language=JavaScript for=gr1 event="OnExit(Row,Colid,olddata)">
        if(Row==0) return;
        if(Colid == "TEAMS_CUST_NM"){
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "TEAMS_CUST_SID") = 0;
            }
        } else if(Colid == "DRIVE_CUST_NM") {
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "DRIVE_CUST_SID") = 0;
            }
        } else if(Colid="CAR_NO"){
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "CAR_SID") = 0;
                ds1.NameValue(Row, "CAR_NM") = "";
            }
        }
    </script>
    
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)"> <!-- 지역 -->
			if (row <1) return;
			for (i = 1; i <= ds1.countrow; i++) {
				ds1.namevalue(i, "is_flag") = ds1.namevalue(i,"status_cd");
			}
	</script>
	
	<script language=JavaScript  for=initDs1 event="OnLoadCompleted(row)"> <!-- 지역 -->
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=initDs2 event="OnLoadCompleted(row)"> <!-- 출경시간 -->
			initDs2.deleteRow(1); <!-- 전체 삭제 -->
			lc2.Index = 0;
	</script>
	
	
	<script language=JavaScript  for=initDs3 event="OnLoadCompleted(row)"> <!-- 상품 -->
			div.value = '';
			initDs3.deleteRow(1);
			lc3.Index = 0;
	</script>
	
	
	<script language=JavaScript for= lc1 event=OnSelChange()> <!-- 지역 체인지 -->
		if ( div.value != 'init') {
			fnSelectDs3();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()> <!-- 출경시간 변경 -->
		if ( div.value != 'init' ) {	//출발일자
			if ( sBgnDate.Modified ) {
				div.value = 'init';
				fnSelectDs3();			
			}
		}				
	</script>
	
	
<%



/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=initDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=initDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  출경시간 -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=initDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
	<param name="SyncLoad" 	value="true">
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
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr>
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td align=right>
							<table width='845'>
									<tr>
										<td align=right>
											<img src="<%=dirPath%>/Sales/images/n_create.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCreate()"> 		<!-- 생성 -->
											<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
											<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"	align=absmiddle onClick="fnApply()">		<!-- 저장 -->
											<img src="<%=dirPath%>/Sales/images/delete.gif"		style="cursor:hand"	align=absmiddle onClick="fnDelete()">		<!-- 삭제 -->
										</td>
									</tr>
								</table>
						</td>
					</tr>
					<tr height="10px">
						<td></td>
					</tr>
					<tr height="30px">
						<td width=845>
							<table border='0' cellpadding="0" cellspacing="1" width="845" bgcolor="#666666">
								<tr height='30px'>
									<td align=left class="text" width="80px">지역</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs1>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^120">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=left class="text"  width="80">출발일자</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000-00-00">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="true">																					
										</object>&nbsp;
									
				                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs2>
											<param name=BindColumn      value="depart_time">
				                            <param name=BindColVal      value="depart_time">
											<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
											<param name=ListExprFormat  value="depart_time_nm^0^50">
										</object>
										<%=HDConstant.COMMENT_END%>																				
									</td>																							
									<td align=left class="text" width="80">상품정보</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
				                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs3>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^140"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr>
			<td colspan=2>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td width='845'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
                                <Param Name="AllShowEdit"   value="True">
								<param name="Format" 			value="
									<C> name='반'        		ID='CLASS'       		width=60 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
					               	<C> name='조'        		ID='TEAMS'       		width=40 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
					               	<C> name='호차'    			ID='HO_CAR_NM'   		width=100 align=left editlimit=5</C>
					               	<C> name='조장명'        	    ID='TEAMS_CUST_NM'      width=100  align=left editStyle=Popup editlimit=30</C>
					               	<C> name='운전자명'        	ID='DRIVE_CUST_NM'      width=100  align=left editStyle=Popup editlimit=30</C>
					               	<C> name='차량등록번호'      	ID='CAR_NO'      		width=100 align=left editStyle=Popup editlimit=30</C>
								 ">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<input type='hidden' name='div' value=''>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

