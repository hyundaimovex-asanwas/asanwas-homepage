<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 보통예금 통장 거래내역 업로드
 * 프로그램ID 	: TO010I Temporary Receipt
 * J  S  P		: Account/jsp/tp010i.jsp
 * 서 블 릿		: Tp010I
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-06-07 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2015-05-27][심동현] 관광 →  회계로 메뉴 이관하지만
 *						페이지 및 java에서는 sales.쪽 계정을 사용해야 할 듯.. 
 *						account에는 수퍼서블릿이 없다;;
 * [2016-04-21][심동현] 담당자가 최혜민 대리로 변경.
 * [2016-06-13][심동현] 외환 하나 합병으로 액셀 다운로드 양식 변경되서 맞춤
 *						거래내역 컬럼 양식이 달라졌음..^^;
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
		//전체변수 셋 : 조회구분하기 위해서
		
	        var v_job = "I";		
	        
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
				//헤더도 decimal(10)로  하는게 좋을듯.
/*				var s_temp = "UPLOAD_MSG:STRING,SEQ:STRING,COL01:STRING,"
						 	+ "COL02:STRING,COL03:STRING,COL04:STRING,COL05:STRING,COL06:STRING,"
						 	+ "COL07:STRING,COL08:STRING,COL09:STRING,COL10:STRING,COL11:STRING,"
						 	+ "COL12:STRING,COL13:STRING,COL14:STRING,COL15:STRING,COL16:STRING,"
						 	+ "COL17:STRING,COL18:STRING,COL19:STRING,"
						 	+ "YN:STRING";*/
				excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * 초기작업
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//2007-06-11 계좌번호  by 심동현 
			//계좌번호 [AC021]
			//dstype=5 : detail_nm을 보여주면서 '전체'
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
            codeDs1.Reset();
		}

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		 
		function fnExcelApply()  {
			v_job = "I";
			//alert("***"+sAcctGu.ValueOfIndex("detail", sAcctGu.Index)+"***");
			//alert("***"+file_path.value+"***");
			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)==" ") {
				alert("엑셀적용 전에 계좌번호를 선택해 주세요.");
				sAcctGu.focus();
				return false;
			}
			if(file_path.value=="") {
				alert("엑셀 파일을 찾아주세요.");
				file_path.focus();
				return false;
			}			
			
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",sAcctGu=" + sAcctGu.ValueOfIndex("detail", sAcctGu.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)",
	            v_param);                

            tr_post(tr1);
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
	            "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
	
			
		/*
		 * 저장
		 */
		function fnApply() {
			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)=="") {
				alert("저장하시기 전에 계좌번호를 선택해 주세요.");
				sAcctGu.focus();				
				return false;
			}
			v_job = "A"; //저장
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
               	  "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("업데이트된 행이 없습니다.");
			};	
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
		}

		<%//회계 거래처 조회하기%>
		function fnPopVC(dirPath,row){	
	   		var arrParam	= new Array();
	   		var arrResult	= new Array();
	   		var strURL;	 
	   		var strPos;
	   		var origin_bp_sid;
	   		var origin_bp_nm;
	   		var origin_bid_site_kind;
	   			
	   		arrParam[0] = "0020";
	   		arrParam[1] = "일반인";

	   		
	   		strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
			strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	   		arrResult = showModalDialog(strURL,arrParam,strPos);	

	   		if (arrResult != null) {
	   			arrParam = arrResult.split(";");
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= arrParam[0];//거래처코드
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= arrParam[1];//거래처명
	   		} else {
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= "Z";
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= "일반인";
	   		}				
	     	
		}
		<%//GRID 초기화%>
		function fnReset(){	
			excelDs.ClearAll();
		}
	   		
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
		
		if (v_job == "I"){//액셀적용
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "TR_SID") = 7;
			}			
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// 액셀적용할 때.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //메시지 처리
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        } else if(v_job == "H" || v_job=="S") {	// 조회할 때.
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	} else if(v_job == "A"){//값 저장시
       		msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
       		fnSelect();	//재조회
       	}
        
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

	<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
//		    	alert(gcip_file.value);
		    	file_path.value = gcip_file.value;
		    }
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
	
		

	<%// 거래처 팝 %>	
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if(colid=="VEND_NM") {
			fnPopVC('<%=dirPath%>', row);
		}
	</script>

	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
	        	sEndDate.text = sBgnDate.text;
	</script>  	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>

<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/reset.gif"  style="cursor:pointer" align=absmiddle onclick="fnReset()">
										<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcelDs1();">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">계좌번호</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							
							<object id=sAcctGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^130">
							</object>
								
						</td>
						<td align="center" width="90px" class="text">엑셀파일</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							
								<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
									<param name="Text"		value="찾아보기">
								</OBJECT>&nbsp;
								<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:pointer"  border='0' onClick='javascript:fnExcelApply();'>
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">거래일자</td>
						<td align=left bgcolor="#ffffff" width=300>&nbsp;
						     
						     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
							&nbsp;-
						     
						     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
							
						</td>
						<td align="center" width="90px" height="30px" class="text">적 요</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Sum id=sTr_Sum></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height="100%">
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="845px" height="100%">
					<tr height="100%">
						<td>
							
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="1004px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="true">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
											<C> name='계좌번호'    	ID='TR_ACCT_CD' Width=100  align=center  edit=none editstyle=lookup data='codeDs1:detail:detail_nm'</C>
							                <C> name='거래일시'    	ID='COL01'  	Width=120  align=center  show=true 	edit=none</C>
							                <C> name='거래구분'  	ID='COL02'    	Width=80  align=center  show=true	edit=none</C>
							                <C> name='적요'      	ID='COL03'    	Width=120  align=left  show=true	edit=none</C>
							                <C> name='맡기신 금액'  ID='COL04'   	Width=100  align=RIGHT  show=true	DEC=0 edit=none</C>
							                <C> name='남은 금액'  	ID='COL05'  	Width=100  align=RIGHT show=true	DEC=0 edit=none</C>
							                <C> name='취급점'   	ID='COL06'   	Width=100  align=center show=true	edit=none</C>
							                <C> name='TR_SID'    	ID='TR_SID'  	Width=100  align=left  show=false	edit=none</C>
							                <C> name='거래처'    	ID='VEND_NM'  	Width=90  align=left  show=true	EditStyle=popup </C>
							                <C> name='코드'  		ID='VEND_CD'  	Width=50  align=left  show=true	edit=none </C>
							                <C> name='접수일자'		ID='FSDAT'  	Width=66  align=center show=true	edit=none</C>
							                <C> name='접수번호'		ID='FSNBR'  	Width=60  align=center show=true	edit=none</C>
							        ">
							</object>
							
						</td>
					</tr>				
				</table>
				
			</td>
		</tr>

		<tr>
			<td>※ 액셀 시트의 이름이 "<b>Sheet1</b>" 이어야 합니다.(2016.06. KEB하나은행 통합 후)</td>
		</tr>
	</table>
		
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>		
      					

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

