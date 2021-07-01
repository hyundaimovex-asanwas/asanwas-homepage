<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 입찰 공고 / 투찰업체 목록 조회
 * 프로그램ID 	: cat011I computer added tender
 * J  S  P		: Pms/cat/cat011i.jsp
 * 서 블 릿		: Cat011I
 * 작 성 자		: 심동현
 * 작 성 일		: 2017-07-05 
 * [수  정   일  자][수정자] 내용
 * [2017-06-27][심동현] 여러 검색 조건으로 조회, 마스터의 추가입력정보 수정
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.*"%>

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
    <jsp:include page="/Pms/common/include/head.jsp"/>

<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
		//전체변수 셋 : 조회구분하기 위해서
			var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
			var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용		
	        v_job = "I";		
	        
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr_master"), "comn");
			cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
			fnInit(); 
		}

		/*
		 * 초기작업
		 */
		function fnInit(){
			//sBgnDate.text="<%=firstday%>";
			//sEndDate.text="<%=firstday%>";
		    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//공통코드 부르기 by 심동현 
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT02&s_item1=Y";
            codeDs1.Reset();	//면허
            codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT03&s_item1=Y";
            codeDs2.Reset();	//발주유형
            codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT04&s_item1=Y";
            codeDs3.Reset();	//지역
            codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT01&s_item1=Y";
            codeDs4.Reset();	//사정구간

            
		}

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		function fnExcelApply()  {
			v_job = "I";
			//alert("***"+sGubn1.ValueOfIndex("detail", sGubn1.Index)+"***");
			//alert("***"+file_path.value+"***");
			
			/*if(sGubn1.ValueOfIndex("detail", sGubn1.Index)==" ") {
				alert("엑셀적용 전에 계좌번호를 선택해 주세요.");
				sGubn1.focus();
				return false;
			}*/
			if(file_path.value=="") {
				alert("엑셀 파일을 찾아주세요.");
				file_path.focus();
				return false;
			}			
			
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",sGubn1=" + sGubn1.ValueOfIndex("detail", sGubn1.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs,O:EXCELDSM=excelDsM)",
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
                    + ",sGubn1=" + sGubn1.ValueOfIndex("detail", sGubn1.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I", 
	            "JSP(O:MAIN_DSM=excelDsM)",
	            v_param);
	        tr_post(tr1);
		}
		//디테일조회
	    function fnSelectDetail(row) {
	    	if(row>excelDsM.countrow){	//앞에서 받은 row가 ds_cul보다 크면, 즉 새로운 조건으로 ds_cul을 조회할 때
	    		row = 1;	//오류 방지용 처리
	    	}
	        v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감

	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_ot_sid="+ excelDsM.namevalue(row,"OT_SID");
			ln_TRSetting(tr2, 
					"<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr2);
	    }

			
		/*
		 * 저장
		 */
		function fnApply() {
			/*if(sGubn1.ValueOfIndex("detail", sGubn1.Index)=="") {
				alert("저장하시기 전에 계좌번호를 선택해 주세요.");
				sGubn1.focus();				
				return false;
			}*/
			
			if(excelDsM.namevalue(1,"GUBN01")==" "){
				alert("추가 입력 정보 - 면허를 선택해야 저장 가능합니다.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN02")==" "){
				alert("추가 입력 정보 - 발주유형을 선택해야 저장 가능합니다.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN03")==" "){
				alert("추가 입력 정보 - 지역을 선택해야 저장 가능합니다.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN04")==" "){
				alert("추가 입력 정보 - 사정구간을 선택해야 저장 가능합니다.");
				return false;
			}

			v_job = "A"; //저장
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated&&excelDsM.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
               	  "JSP(I:EXCELDSM=excelDsM,I:EXCELDS=excelDs,O:RESULT=ds_result)",
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
			alert("개발전입니다.");
			/*			
	        if(excelDs.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};
        	   
	        getObjectFirst("gr_detail").SetExcelTitle(0, "");
	        getObjectFirst("gr_detail").SetExcelTitle(1, "value:무통장 거래내역; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_detail").GridToExcel("Sheet1","무통장 거래내역.xls", 8);
	        */
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
			excelDsM.ClearAll();
			excelDs.ClearAll();
		}
	   		
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<%//마스터 그리드 OnClick : 계정|귀속정보 조회 %>
	<script language="javascript"  for=gr_master event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			
			if(Colid=="OT_NO"||Colid=="OT_NM"||Colid=="ORDERER_NM"||Colid=="OT_DATE"||Colid=="AMT_BASE"||Colid=="AMT_WIN"){
				fnSelectDetail(Row);				
			}
	    }
	</script>
	
	<script language=JavaScript  for=excelDsM event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
			}
		}

		
	</script>


	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
		
		if (v_job == "I"){//액셀적용
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "OT_SID") = 5;
				excelDs.namevalue(i, "DT_SID") = 3;
			}			
			for(i = 1; i <= excelDsM.countrow; i++) {
				excelDsM.namevalue(i, "OT_SID") = 5;
			}			

		};
	</script>



	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// 액셀적용할 때.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //메시지 처리
	        /*for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);*/
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
	<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
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
<object id=excelDsM classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td align="right" >
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcelDs1();"><br />&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="845px" bgcolor=#666666>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">면허</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^160">
							</object>
								
						</td>
                        <td align="center" width="90px" height="30px" class="text">발주유형</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGuBN2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>
                        <td align="center" width="90px" height="30px" class="text">지역</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs3>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>						
					</tr>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">사정구간</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs4>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>
                        <td align="center" width="90px" height="30px" class="text">추정가격</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;<select name="sGubn5" id="sGubn5">
								<option value="0">전체</option>
								<option value="101"> - 추정가격 100억 이상(전국)</option>
								<option value="99"> - 추정가격 100억미만(지역)</option>
 
							</select>				

						</td>
						<td align="center" width="90px" height="30px" class="text">공고번호</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;<input type=text name=sOT_NO id=sOT_NO style="width:160px;" class='textbox' ></td>	
					</tr>
					<tr>
						<td align=left width=90 class="text">입찰일</td>
						<td align=left bgcolor="#ffffff" >&nbsp;
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
							</object>&nbsp;~&nbsp;<object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
						<td align="center" width="90px" height="30px" class="text">공사명</td>       
						<td bgcolor=#ffffff  >&nbsp;<input type=text name=sOT_NM id=sOT_NMstyle="width:160px;" class='textbox' ></td>
						<td align="center" width="90px" height="30px" class="text">발주처</td>
						<td bgcolor=#ffffff  >&nbsp;<input type=text name=sORDERER_NM id=sORDERER_NM style="width:160px;" class='textbox' ></td>
					</tr>
				</table><br />
			</td>
		</tr>
		<tr height=2><td></td></tr>
		<tr>
			<td>
				<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master style="width:98%; height:180px" border="1">
				        <param name="DataID"            value="excelDsM">
				        <param name="BorderStyle"       value="0">
				        <param name="ColSizing"         value="true">
				       	<param name="IndWidth"  		value="20">
				        <param name="editable"          value="true">
				        <param name=SortView  			value="Left">
				        <param name="indwidth"			value="20">
				        <param name="Format"            value="
				        	<C> name='No.'    		ID='{CurRow}'		 width=30 	align=right edit=none </C>
				        <G>name='액셀 로드 정보'
							<C> name='공고번호'    	ID='OT_NO' Width=90 </C>
				        	<C> name='공사명'    	ID='OT_NM' 	Width=200  align=left  show=true 	edit=none</C>
				        	<C> name='발주처'  		ID='ORDERER_NM'    	Width=100  align=center  show=true	edit=none</C>
				        	<C> name='입찰일시'    	ID='OT_DATE'    	Width=120  align=left  show=true	edit=none</C>
				        	<C> name='기초금액'  	ID='AMT_BASE'   	Width=100  align=RIGHT  show=true	DEC=0 edit=none</C>
				        	<C> name='1순위 낙찰금액' 	ID='AMT_WIN'  	Width=100  align=RIGHT show=true	DEC=0 edit=none</C>
						</G>
						<G>name='추가 입력 정보'
							<C> name='면허'  	 	ID='GUBN01'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs1:detail:detail_nm'  </C>
							<C> name='발주유형'   	ID='GUBN02'   		width=90	align=CENTER	edit=true editstyle=lookup Data='codeDs2:detail:detail_nm'  </C>
							<C> name='지역'  	 	ID='GUBN03'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs3:detail:detail_nm'  </C>
							<C> name='사정구간'  	ID='GUBN04'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs4:detail:detail_nm'  </C>
						</G>
							<C> name='공고_SID'    	ID='OT_SID'  		Width=70	align=left  show=false	edit=none</C>
				        ">
				</object>
			</td>
		</tr>

		<tr height=10><td></td></tr>
		<tr height="100%">
			<td>
				<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_detail style="width:98%; height:300px" border="1">
				        <param name="DataID"            value="excelDs">
				        <param name="BorderStyle"       value="0">
				        <param name="ColSizing"         value="true">
				       	<param name="IndWidth"  		value="20">
				        <param name="editable"          value="true">
				        <param name=SortView  			value="Left">
				        <param name="indwidth"			value="20">
				        <param name="ViewSummary"       value="1">
				        <param name="Format"            value="
				                <C> name='순위'					ID='OT_RANK'		Width=40 	align=center  show=true decao=0 edit=none sumtext=@cnt</C>
				                <C> name='업체명'  				ID='COMPANY_NM'    	Width=130	align=center  show=true	edit=none sumtext='건'</C>
				                <C> name='사업자번호'      		ID='BIZREGI_NO'    	Width=80	align=center  show=true	edit=none</C>
				                <C> name='대표자'  				ID='EXC_MAN'   		Width=60	align=center  show=true	edit=none </C>
				                <C> name='투찰금액'  			ID='AMT_TENDER'  	Width=110	align=right		show=true	edit=none decao=0</C>
				                <C> name='예가대비\\투찰율(%)'  ID='RATE_EXPECT'	width=70 	align=center	Edit=none 	 decao=4 </C>
				                <C> name='기초대비\\투찰율(%)'  ID='RATE_BASE'		width=70 	align=center	Edit=none 	 decao=4 </C>
				                <C> name='기초대비\\사정율(%)'  ID='RATE_SHOOT'		width=70 	align=center	Edit=none 	 decao=4 </C>
			                	<C> name='투찰일시'				ID='DATE_TENDER'   	Width=110	align=center 	show=true	edit=none</C>
				                <C> name='낙찰하한가\\차이(원)' ID='AMT_DIFF_MIN'  	Width=110	align=right		show=true	edit=none decao=0</C>
				                <C> name='비고'    				ID='OT_REMARK'  	Width=110	align=left  show=true	edit=none</C>
				                <C> name='공고_SID'    			ID='OT_SID'  		Width=50	align=left  show=false	edit=none</C>
				                <C> name='디테일_SID'    		ID='DT_SID'  		Width=50	align=left  show=false	edit=none</C>
				        ">
				</object>
			</td>
		</tr>
		<tr>
			<td></td>
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

