<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 정산관리
 * 프로그램ID 	: AC710I
 * J  S  P		: ac710i
 * 서 블 릿		: Ac710I
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-08-07
 * 기능정의		: 상품권 입고(조회 등록 삭제 수정)
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
   	String firstday = m_today.format(date.getTime());	
   	date.add(date.MONTH,-1);
    String lastday = m_today.format(date.getTime());		

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
		 var v_job = "H";
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			sSDate.Text = '<%=lastday%>';	
			sEDate.Text = '<%=firstday%>';
			fnInit();
		} 
		 
		function fnInit() {
			ds_giftType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC003";
            ds_giftType.Reset();
		}
				/*
		 * 데이터셋 헤더 설정 (마스터)
		 */	
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp =  "IPGO_NO:STRING,"
							+ "IPGO_DATE:STRING,"
							+ "IPGO_EMPNO:STRING,"
							+ "EMPNMK:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
			/*
		 * 데이터셋 헤더 설정 (디테일)
		 */
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp =  "IPGO_NO:STRING,"
							+ "GIFT_TYPE:STRING,"
							+ "GIFT_TYPE_NM:STRING,"
							+ "FR_GIFT_SEQ:STRING,"
							+ "TO_GIFT_SEQ:STRING,"
							+ "IPGO_QTY:INT,"
							+ "IPGO_PRICE:INT,"
							+ "IPGO_AMT:INT";
									
				ds2.SetDataHeader(s_temp);
			}
		}
		/*
		 * 메인 조회(마스터 조회, 디테일조회)
		 */
		function fnSelect(){
		if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("수정중인 행이 있습니다.");
				return;
			}
			fnSelectDs1();
			fnSelectDs2();
		}
		/*
		 * 마스터 조회
		 */
		function fnSelectDs1() {
			if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("수정중인 행인 있습니다.");
			} else {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac710I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
			}
		}
		/*
		 * 디테일 조회
		 */
		function fnSelectDs2(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					  + ",sIpgoNo=" + ds1.namevalue(ds1.rowposition,"ipgo_no");
			ln_TRSetting(tr1,
				"<%=dirPath%><%=HDConstant.PATH_AC%>Ac710I",
				"JSP(O:DS2=ds2)",
				param);
			tr_post(tr1);
			
		}
		/*
		 * 마스터 신규 
		 */
		function fnAddRowDs1(){
			fnSetHeaderDs1();
			 for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.RowStatus(i)==1){
                    if(ds2.CountRow==0){
                        alert("상품권  입고정보(상세)를 먼저 등록하시길 바랍니다.");
                        return;
                    }
                }
            }
            
            if(ds1.IsUpdated || ds2.IsUpdated){
                alert("먼저 저장하시길 바랍니다.");
                return;
            }
            
            ds1.addrow();
            ds2.clearall();
            v_ipgo_date.Text = '<%=firstday%>';
            fnInit();
		}
			/*
		 * 디테일 행추가 
		 */
		function fnAddRowDs2() {
			fnSetHeaderDs2();
			
			
				ds2.addrow();

				ds2.namevalue(ds2.RowPosition, "ipgo_no") = ds1.namevalue(ds1.rowposition, "ipgo_no");
				gr2.setcolumn("gift_type");
			
				window.status="Detail 행이 삽입되었습니다.";
		}
		/*
		 * 마스터 삭제 
		 * 삭제 액션시 바로 적용
		 */
		function fnDeleteRowDs1() {			
			if(ds2.IsUpdated) {
				alert("수정중인 행이 있으면 삭제할 수 없습니다.");
				return;
			}else{
				if (confirm("입력하신 사항을 삭제하시겠습니까?")) {
					
					ds1.deleterow(ds1.rowposition);
					ds2.deleteall();
					
					fnApplyDs1();
					fnApplyDs2();
					
					
					window.status="Master 행이 삭제되었습니다.";
				
					return;
				}
			}
		}

		/*
		 * 디테일 행삭제 
		 */
		function fnDeleteRowDs2(){
			ds2.deleterow(ds2.rowposition);
			window.status="Detail 행이 삭제되었습니다.";
		}

		/*
		 * 적용
		 * 마스터 변경시 추가, 디테일 행추가,삭제 후 적용 
		 */
		function fnApply(){
			var v_gift_cnt = 0;
            var v_gift_amt = 0;
            
            if(ds1.IsUpdated==false && ds2.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
            
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "IPGO_DATE")==""){
                    alert("입고일<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_ipgo_date").Focus();
                    return;
                }
                if(ds1.NameValue(i, "IPGO_EMPNO")==""){
                    alert("입고자<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_ipgo_empno").focus();
                    return;
                }
            }
			fnApplyDs1();
		}

		/*
		 * 마스터 적용 1
		 */	
		function fnApplyDs1() {
			if (ds1.IsUpdated || ds2.IsUpdated ) {
						v_job=="I";
						window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
				         ln_TRSetting(tr1, 
				             "<%=dirPath%><%=HDConstant.PATH_AC%>Ac710I",
				             "JSP(I:DS1=ds1,I:DS2=ds2,O:msgDS=msgDS,O:ipgonoDs=ipgonoDs)",
				             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
				         tr_post(tr1);
				}
		}

		/*
		 * 디테일 적용
		 */		
		function fnApplyDs2() {
			if (ds2.IsUpdated) {
					v_job=="I";
					tr2.KeyValue = "Ac710I(I:DS2=ds2)";
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_AC%>Ac710I?proType=A&dsType=1";
					tr2.post();
			}
		}

		/*
		 * 취소 
		 * 마스터, 디테일
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated || ds2.IsUpdated) {
				ds1.undoall();
				ds2.undoall();
			}
			window.status="데이터 변경이 취소되었습니다.";
			return;
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:출발일별현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("출발일별현황","출발일별현황.xls", 8);
		}
	/*
	 * 사원정보
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy020h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	v_ipgo_empno.value = arrParam[0];
				ipgo_empnmk.value = arrParam[1];
				ds1.namevalue(ds1.RowPosition,"ipgo_empno")=arrParam[0];
                ds1.namevalue(ds1.RowPosition, "empnmk") = arrParam[1];
                					
			}
	} 	
	 /**
         * 화면 Control
         */
        function fnDisplay(){
            if(ds1.CountRow>0){
                getObjectFirst("v_ipgo_date").Enable= "true";
                getObjectFirst("v_pay_gu").Enable = "true";
                getObjectFirst("empno_btn").style.display = "inline";
                getObjectFirst("plus_btn").style.display = "inline";
                getObjectFirst("minus_btn").style.display = "inline";
            } else {
                getObjectFirst("v_ipgo_date").Enable= "false";
                getObjectFirst("v_pay_gu").Enable = "false";
                getObjectFirst("empno_btn").style.display = "none";
                getObjectFirst("plus_btn").style.display = "none";
                getObjectFirst("minus_btn").style.display = "none";
                getObjectFirst("v_pay_empno").value = "";
                getObjectFirst("v_pay_empnmk").value = "";
            }
        }
        function fnGiftSelect(Row, Colid, OldData){
            if(Colid=="GIFT_TYPE" || Colid=="FR_GIFT_SEQ" || Colid=="TO_GIFT_SEQ"){
                if(getObjectFirst("ds2").NameValue(Row, "GIFT_TYPE")!=""
                    && getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ")!=""
                    && getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ")!="")
                {
                    if(OldData != getObjectFirst("ds2").NameValue(Row, Colid)){
                        for(var i=getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ") = "0"+getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ");
            
                        for(var i=getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ") = "0"+getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ");
            			
            			getObjectFirst("ds2").NameValue(Row, "IPGO_QTY") 
            				= (Number(getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ"))-Number(getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ"))+1);
                    }
                }
            }
        }
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
<!-- 
		마스터 그리드 OnClick
	-->
	<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>

	<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
		if (ds1.IsUpdated || ds2.IsUpdated) {
			
		} else {
			fnSelectDs2();
		}
	</script>
	<script language="javascript" for="tr2" event="onsuccess()">
	    document.all.LowerFrame.style.visibility="hidden";
	    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>
	
	<script language="javascript" for="tr2" event="onfail()">
	    document.all.LowerFrame.style.visibility="hidden";
	    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
	    var error_cnt = tr2.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
	</script>
	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if (row < 1) {
			return;
		}
		
		if (ds1.namevalue(ds1.rowposition , "sub_chk") == "Y") {
			fnSubSelect();
		}
	</script>
	<script language="javascript" for="gr2" event="OnCloseUp(Row, Colid)">
	    if(Row==0) return;
	    
		    fnGiftSelect(Row, Colid, ds2.OrgNameValue(Row, Colid));
	</script>
	<script language="javascript" for="gr2" event="OnExit(Row, Colid, OldData)">
    if(Row==0) return;
		    fnGiftSelect(Row, Colid, OldData);
	</script>
	<script language=javascript for=msgDS event="OnLoadCompleted(Row)">
    var v_result_msg = "";
    if(msgDS.CountRow>0){
        for(var i=1; i<=ds_detail_result.CountRow; i++){
            if(msgDS.NameValue(i, "MSG_CD")!="0000")
                v_result_msg = msgDS.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
	</script>
	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 상세  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ipgonoDs classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  상품 -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_giftType classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  권종코드 -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_giftAmt classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
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


<table  width="845px"  cellpadding="0" cellspacing="0" >

		<tr>
			<td align="left">
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr height="50px" > 
						<td align="left"  width="355px">
							<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left" width="300">
						
								<tr  bgcolor="#6f7f8d" align="left">
									<td align=left class="text"  width="60">입고일</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 		value="">
											<param name=Alignment 	value=1>
											<param name=Format 		value="0000-00-00">
											<param name=Cursor	 	value="iBeam">
											<param name=Border	 	value="false">		
											<param name=InheritColor      value="true">																																																				
											<param name=ReadOnly  	value="false">
											<param name=SelectAll  	value="true">
											<param name=SelectAllOnClick  	value="true">		
											<param name=SelectAllOnClickAny   value="false">
										</object>&nbsp;~&nbsp;
				                       	<object id=sEDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 		value="">
											<param name=Alignment 	value=1>
											<param name=Format 		value="0000-00-00">
											<param name=Cursor	 	value="iBeam">
											<param name=Border	 	value="false">		
											<param name=InheritColor      value="true">																																																				
											<param name=ReadOnly  	value="false">
											<param name=SelectAll  	value="true">
											<param name=SelectAllOnClick  	value="true">	
											<param name=SelectAllOnClickAny   value="false">
										</object>&nbsp;
										<%=HDConstant.COMMENT_END%>																				
									</td>
								</tr>
							 
							</table>
						</td>
						
						<td align="right">
							<table border="0"  cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="right" height="30px">		
										<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand" onClick="fnAddRowDs1()" >
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
										<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:hand" onClick="fnDeleteRowDs1();" >
						 			</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>	
			</td>											
		</tr>
		<tr height="5">
			<td></td>
		</tr>			
		<tr>
			<td align="left">
				<table  width="845px"  cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="5"  align="left">
							<table width="845px" border="0" cellpadding="0" cellspacing="0" >
								<tr>
									<td align="left" valign="top" width="300px" >
										<%=HDConstant.COMMENT_START%>
										<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=300px; height:383px" border="1">
											<param name="DataID"            value="ds1">
			                                <param name="ColSizing"         value="true">
			                                <param name="Editable"          value="false">
			                                <param name="SuppressOption"    value="1">
			                                <param name="BorderStyle"       value="0">
			                                <param name=UsingOneClick       value="1">
			                                <Param Name="AllShowEdit"       value="True">
			                                 <param name="SuppressOption"    value="1">
			                                <param name="Format"            value="
											
												<C> name='입고일' 		ID='IPGO_DATE' 	   Width=80  align=left editlimit=8 mask=XXXX-XX-XX  suppress=1</C>
												<C> name='입고번호'  		ID='IPGO_NO'	   Width=100 align=right editlimit=20</C>
												<C> name='입고자사번'  	ID='IPGO_EMPNO'	   Width=100 align=left editlimit=50 show=false</C>
												<C> name='입고자성명'  	ID='EMPNMK'		   Width=100 align=left editlimit=15 show=false</C>											
											">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>
									<td width="10px"></td>
									<td valign="top">
										<table width="530px" cellpadding="0" cellspacing="0" >
											<tr>
												<td align="center">
													<table width="530px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
														<tr>
															<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">입 고 일 자</td>
																<td align=left bgcolor="#ffffff" width="160">&nbsp;																							
																<%=HDConstant.COMMENT_START%>
																<object id=v_ipgo_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
																	<param name=Alignment 	value=1>
																	 <param name=Format      value="YYYY-MM-DD">
                                                        			<param name=InputFormat value="YYYYMMDD">
																	<param name=Cursor	 	value="iBeam">
																	<param name=Border	 	value="false">		
																	<param name=InheritColor      value="true">																																																				
																	<param name=ReadOnly  	value="false">
																	<param name=SelectAll  	value="true">
																	<param name=SelectAllOnClick  	value="true">		
																	<param name=SelectAllOnClickAny   value="false">
																</object>
																<%=HDConstant.COMMENT_END%>	
															</td>
															<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">입 고 번 호</td>
															<td align=left bgcolor="#ffffff">&nbsp;
															<%=HDConstant.COMMENT_START%>
		                                                    <object id=v_ipgo_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
		                                                        <param name=Alignment   value=1>
		                                                        <param name=Format      value="000000-000">
		                                                        <param name=Cursor      value="iBeam">
		                                                        <param name=Border      value="false">
		                                                        <param name=InheritColor      value="true">
		                                                        <param name=Enable      value="false">
		                                                        <param name=SelectAll   value="true">
		                                                        <param name=SelectAllOnClick    value="true">
		                                                        <param name=SelectAllOnClickAny   value=false>
		                                                    </object>
		                                                    <%=HDConstant.COMMENT_END%>
															</td>
														</tr>
														<tr>
															<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">입&nbsp;&nbsp;고&nbsp;&nbsp; 자</td>
															<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
																<input id="v_ipgo_empno" type="text" readonly='readonly'  class='input01'    value="" size="11">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0" id="empno_btn"  ALT="입고자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=absmiddle onclick="fnPopup();">
																 <input type="text" name='ipgo_empnmk' id='ipgo_empnmk' value='' size='11' readonly='readonly'  class='input01'>
															</td>
														</tr>	
													</table>
												</td>
											</tr>
											<tr>
												<td height="7">
												<tr>
													<td align="right" height="30px">
													<img src="<%=dirPath%>/Sales/images/plus.gif"	id="plus_btn" style="cursor:hand"  onClick="fnAddRowDs2();" >
													<img src="<%=dirPath%>/Sales/images/minus.gif"	id="minus_btn"	style="cursor:hand" onClick="fnDeleteRowDs2();"></td>
												</tr>
												</td>
											</tr>
										
											<tr>
												<td height="5"></td>
											</tr>
											<tr>
												<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
													<%=HDConstant.COMMENT_START%>
														<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr2"  style="WIDTH:530px;HEIGHT:290px" border="1">
															 <param name="DataID"            value="ds2">
					                                            <param name="ColSizing"         value="true">
					                                            <param name="Editable"          value="true">
					                                            <param name="SuppressOption"    value="1">
					                                            <param name="BorderStyle"       value="0">
					                                            <param name=UsingOneClick       value="1">
					                                            <Param Name="AllShowEdit"       value="True">
					                                            <param name="ViewSummary"       value="1">
					                                            <param name="Format"            value="
					                                             <C> name=''				ID={currow}				width=30</C>
															    <C> name='입고번호' 		ID='IPGO_NO'	        Width=100 	align=left editlimit=5 show=false</C>
															    <C> name='권종'       	ID='GIFT_TYPE'  	    Width=120 	SumText='금액' align=left editlimit=1 show=true align=left EditStyle=Lookup Data='ds_giftType:detail:detail_nm'</C>
															    <C> name='상품권시작번호'	ID='FR_GIFT_SEQ'   		Width=100 	align=right editlimit=6 show=true</C>
															    <C> name='상품권종료번호'	ID='TO_GIFT_SEQ'       	Width=100 	align=right editlimit=6 show=true</C>
															    <C> name='매수'        	ID='IPGO_QTY'       	Width=50 	SumText=@sum align=right  show=true</C>
															    <C> name='단가'        	ID='IPGO_PRICE'       	Width=100 	align=left editlimit=6 show=false</C>
															    <C> name='금액'        	ID='IPGO_AMT'       	Width=100 	SumText=@sum align=right show=true dec=0</C>
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
			</td>												
		</tr>
	</table>												 

<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='  
		<C>Col=ipgo_date      Ctrl=v_ipgo_date        Param=Text</C>
		<C>Col=ipgo_no        Ctrl=v_ipgo_no          Param=Text</C>
		<C>Col=empnmk         Ctrl=ipgo_empnmk      Param=Value</C>
		<C>Col=ipgo_empno     Ctrl=v_ipgo_empno      Param=Value</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>  
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		



