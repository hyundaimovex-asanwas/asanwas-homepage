<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 무통장 거래내역 조회화면
 * 프로그램ID 	: AC080S
 * J  S  P		: ac080S
 * 서 블 릿		: Ac080S
 * 작 성 자		: 박경국
 * 작 성 일		: 2009-12-28 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-12-28][박경국] 무통장 거래내역 조회화면 신규생성
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	//날짜 세팅.
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
	 
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
			if (excelDs.countrow<1){
				var s_temp = "TR_ACCT_CD:STRING,COL01:STRING,"
						 	+ "COL02:STRING,COL03:STRING,COL04:NUMBER,COL05:NUMBER,COL06:STRING,"
						 	+ "TR_SID:NUMBER;";
				excelDs.SetDataHeader(s_temp);
			}
		}		
		/*
		 * 초기작업
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
        	//2007-06-11 계좌번호  by 심동현 
			//계좌번호 [AC021]
			//dstype=5 : detail_nm을 보여주면서 '전체'
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
            codeDs1.Reset();
		}
		/*
		 * 메인 조회
		 */
		function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",sBgnDate=" + sBgnDate.text
		            + ",sEndDate=" + sEndDate.text
		            + ",sTr_Sum=" + sTr_Sum.value
                    + ",sAcctGu=" + sAcctGu.ValueOfIndex("detail", sAcctGu.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac080S", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        	tr_post(tr1);
	    }
		/*
		 * 엑셀
		 */
		function fnExcelDs1() {
	        if(excelDs.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:무통장 거래내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","무통장 거래내역.xls", 8);
	        
	        //gr1.runexcelsheet("무통장 거래내역");	
	        
		}
		</script>
		

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript  for=excelDs3 event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
	</script>
	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';
	</script>
	<script language="javascript" for="tr2" event="onsuccess()">
        var msg='';
	</script>
	<script language="javascript" for="tr3" event="onsuccess()">
        var msg='';
	</script>
	<script language=JavaScript for=tr3 event=OnFail()>
	 var error_cnt = tr3.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr3.ErrorCode + "\n" + "Error Message : " + tr3.ErrorMsg + "\n");
	</script>
	<script language=JavaScript for=tr2 event=OnFail()>
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
	<script language=JavaScript for=tr1 event=OnFail()>
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
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
	    if(ds_result.CountRow>0){
	        var v_result_msg = "";
	        for(var i=1; i<=ds_result.CountRow; i++){
	            if(ds_result.NameValue(i, "MSG_CD")!="0000")
	                v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
	        }
	
	        if(v_result_msg!="")
	            alert(v_result_msg);
	    }
	</script>
	<!--  팝업 차량 -->
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if(colid=="COL04") {                            
			fnConfirm(row);   
		}            
	</script>	  
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand" align=absmiddle onClick="fnExcelDs1();">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="845" bgcolor=#666666>
					<tr>
                        <td align="center" width=130 height="30px" class="text">계좌번호</td>
						<td align="left" bgcolor="#ffffff" width=170>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sAcctGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=240 width=120 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^130">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
						<td align=left width=130 class="text">거래일자</td>
						<td align=left bgcolor="#ffffff" width=350>&nbsp;
						     <%=HDConstant.COMMENT_START%>
						     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=100 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;-
						     <%=HDConstant.COMMENT_START%>
						     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=100 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align="center" width=90 height="17" class="text">적 요</td>       
						<td bgcolor=#ffffff width=170 valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Sum id=sTr_Sum class="textbox"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10">
			<td></td>
		</tr>
		<tr>
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="845px" >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="SuppressOption"    value="1">
	            	                <param name="ViewSummary"       value="1">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
							        	<G>name='입금 정보'
											<C> name='계좌번호'    		ID='TR_ACCT_CD' 	Width=90  suppress=1	align=center  editstyle=lookup data='codeDs1:detail:detail_nm'</C>
								            <C> name='취급점'   		ID='COL06'   		Width=60  suppress=2	align=center  show=true	</C>
								            <C> name='거래구분'  		ID='COL02'    		Width=70  suppress=3	align=center  show=true	</C>
								            <C> name='거래일시'   	 	ID='COL01'  		Width=100 suppress=4	align=center  show=true 	</C>
								            <C> name='적요'      		ID='COL03'    		Width=100 suppress=5	align=center  show=true	</C>
								            <C> name='입금액'    		ID='COL04'   		Width=60  suppress=6	align=RIGHT   show=true	DEC=0</C>
											<C> name='남은 금액(통장)'  ID='COL05'  		Width=60  align=RIGHT 	show=false	</C>
											<C> name='총 상계액'  		ID='COL07'  		Width=60  suppress=7	align=RIGHT   show=true	</C>
								            <C> name='남은 금액'  		ID='COL08'  		Width=60  suppress=8	align=RIGHT   show=true	</C>
								        </G>
							            <G>name='상계 정보'
								            <C> name='TR_SID'    		ID='TR_SID'  		Width=50  align=left show=false	</C>
		                    	            <C> name='입금일자'     	ID='VIEW_PAY_DATE'  Width=50  Edit=none 	align=center	show=false </C>
		                        	        <C> name='계좌번호'         ID='BANK_ACCT'   	Width=50  Edit=none 	align=center 	show=false</C>
		                            	    <C> name='은행'        		ID='BANK_NM'   		Width=50  Edit=none 	align=center 	show=false</C>
			                                <C> name='입금방법'      	ID='PAY_CD_NM'      Width=50  Edit=none 	align=center 	show=false </C>
											<C> name='입금자'      		ID='ORDER_NM'       Width=50  Edit=none 	align=center 	show=false </C>
		    	                            <C> name='관리번호'         ID='PAY_MANAGE_NO'  Width=80  suppress=9	Edit=none 		align=center Dec=0</C>
		    	                            <C> name='상계(결제)액'		ID='PAY_AMT'        Width=80  suppress=10	SumText=@sum Edit=none 		align=center dec=0</C>
		        	                        <C> name='PAY_SID'          ID='PAY_SID1'   	Width=50  Edit=none 		align=center show=false</C>
			                            </G>    
							            <G>name='관광객 상세'
                                            <C> name='입금일자'         ID='VIEW_PAY_DATE'  Width=50  Edit=none     align=center    show=false </C>
                                            <C> name='입금방법'         ID='PAY_CD_NM'      Width=50  Edit=none     align=center    show=false</C>
                                            <C> name='입금여부'         ID='PAY_YN'         Width=50  Edit=none     align=Center    show=false</C>
                                            <C> name='회계구분'         ID='ACCT_GUBN_NM'   Width=50  Edit=none     align=Center    show=false</C>
                                            <C> name='출발일자'         ID='DEPART_DATE'    Width=60  suppress=10	Edit=none     	align=center    show=true </C>
                                            <C> name='상품'             ID='GOODS_NM'       Width=80  suppress=12	Edit=none     	align=center    show=true </C>
                                            <C> name='신청서번호'       ID='ACCEPT_NO'      Width=100 suppress=13	Edit=none     	align=Center    show=true </C>
                                            <C> name='성명'             ID='CUST_NM'        Width=50  Edit=none     	align=Center    show=true </C>
                                            <C> name='입금액'           ID='PAY_AMT2'       Width=60  SumText=@sum  Edit=none       align=center 	dec=0</C>
                                            <C> name='관리번호'         ID='PAY_MANAGE_NO2' Width=80  Edit=none     align=center    Dec=0   		show=false</C>
                                            <C> name='PAY_SID'          ID='PAY_SID1'       Width=50  Edit=none     align=center    show=false</C>
                                        </G>
	                        	    ">
	                        </object>
	                        <%=HDConstant.COMMENT_END%>
						</td>
					</tr>				
				</table>
			</td>
		</tr>
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

