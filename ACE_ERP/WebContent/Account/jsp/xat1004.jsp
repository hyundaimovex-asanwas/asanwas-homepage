<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자동전표 - POS 데이터 업로드 
+ 프로그램 ID	:  xat1004.jsp
+ 기 능 정 의	:  POS 데이터(엑셀) 업로드   
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2018.04.23
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>POS 데이터 업로드</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드

var gs_upload_gb="";  //엑셀 그리드 업로드시 구분하기 


<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	
	gcem_saledt_fr.text = gs_date;
	gcem_saledt_to.text = gs_date;
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){
	gcds_grid_info.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_s1?v_str1=&v_str2=&v_str3=&v_str4=&v_str5=T";                           
	gcds_grid_info.Reset();
}

<%
/******************************************************************************
	Description : 엑셀 적용 버튼 작업시 엑셀Data ==> Grid로 업로드 함               
******************************************************************************/
%>
function ln_Excel_Apply(){
		
  	var s_temp = "";
  	
  	gs_upload_gb="1";

    //excel_upload ( grid와 연동 )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head 만들기
    //파일경로
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL")  = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_xat1004_t1(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_xat1004_t1?";
	gctr_data_excel.post();
	
}

<%
/******************************************************************************
	Description : 저장  수정건은 없음.. 패스 
******************************************************************************/
%>

/*
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_excel_grid.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue = "Account.a400020_t2(I:USER=gcds_excel_grid)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_excel_grid.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}	
*/

<%
/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
%>
/*
function ln_Chk_Save() {
	
    //필수항목 체크 
	for(i=1;i<=gcds_excel_grid.countrow;i++){
		if(gcds_excel_grid.namevalue(i,"ACCTNO") == ""){ 			
			alert("계좌번호를 입력하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"ACCTCD") == ""){
			alert("계좌코드를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"DEALDT") == ""){ 				
			alert("거래일시를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") == ""){ 				
			alert("통화를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") != "WON"){ 				
			if(gcds_excel_grid.namevalue(i,"EXRATE")==0){
				alert("환율을 입력하십시요.");
				return false;
			}
		}
	} 
	
	return true;
}
*/

<%
/******************************************************************************************
	Description : 업로드 데이터 생성건.
*****************************************************************************************/
%>
function ln_Create(){
	
	// 업로드 데이터의 중복 체크하기 
	
	
	if(gcds_excel_grid.countrow>0) {	
		if (confirm("POS 매출 정보를  업로드 하시겠습니까?")){	
			
			//gctr_data.KeyValue = "Account.a400020_t1(I:USER=gcds_excel_grid)";
			
			gctr_data.KeyValue = "Account.xat1004_t1(I:USER=gcds_excel_grid)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			//prompt('gcds_excel_grid',gcds_excel_grid.text);
			
			gctr_data.post();
		}
	}else{
		alert("생성하실 정보가 없습니다.");
	}
}


<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_s1?v_str1="+gcem_dfscost.text
    		                                                                  +"&v_str2="+gcem_saledt_fr.text
    		                                                                  +"&v_str3="+gcem_saledt_to.text;
    		                                                                  	
	gcds_excel_grid.Reset();
}



<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>
function ln_Delete(){

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/





<%
/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
%>
function ln_Excel(){

	gcgd_disp01.GridToExcel("POS 데이터","",2);
}



<%
/******************************************************************************
Description : 매장정보
******************************************************************************/
%>
/*
function ln_Popup_Dfsinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//strURL = "./acctinfo_popup.jsp";

    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_dfscd.text = arrResult[0];   // 매장코드 
		gcem_dfsnm.text = arrResult[1];  // 매장명
	}else{
		gcem_dfscd.text = "";
		gcem_dfsnm.text = "";
	}
}
*/

<%//매장 찾기   %>
function ln_Popup_DfsCost(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0] = "001"; //매장정보
	
	strURL = "./xat_dfscost_popup.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_dfscost.text    = arrParam[0];
	}else{
	    gcem_dfscost.text    = "";
	}
}



<%
/******************************************************************************
Description : 업로드시점에 그리드 데이터 제어 
******************************************************************************/
%>
function fn_user_id(){
	
	for(var j=1;j<=gcds_excel_grid.countrow;j++){
		
		//작업자  id 셋팅		
		gcds_excel_grid.namevalue(j,"CREATE_ID") =gs_userid ;     
		
	}
	gs_upload_gb="";
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">


<!--엑셀 -->
<object  id=gcds_excel classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--엑셀업로드 후 그리드 DATA -->
<object  id=gcds_excel_grid classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--그리드 포맷 정보 -->
<object  igcds_grid_infonfo classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--그리드 Data를 Table에 insert Tail -->
<object  id=gcds_tail_b classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
	if(gs_upload_gb=="1"){
		fn_user_id();
	}
	
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

	if(row>0){ 
		if(colid=="EXRATE"){
			if(gcds_excel_grid.namevalue(row,"CURUNIT")!="WON"){
				gcgd_disp01.ColumnProp("EXRATE","Edit")="";
			}else{
				gcgd_disp01.ColumnProp("EXRATE","Edit")="none";
			}
		}
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("데이터 생성이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("데이터 생성이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	//ln_Upload_Grid();
	alert("엑셀 업로드 준비를 완료하였습니다. [생성]버튼을 실행하여 ERP에 적용가능합니다.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<!--<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">-->
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="1000px"> 
					<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>엑셀파일</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
						<input type="text" name="file_path" value="" style="width:630px;position:relative;top:-2px" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcip_file classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE	style="width:70;height:20;position:relative;top:4px;fontSize=8"  >
						<param name = "Text"		value="찾아보기">
						</OBJECT>&nbsp;
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:2px"  onClick="ln_Excel_Apply()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_create.gif"    style="cursor:hand;position:relative;top:2px"  onClick="ln_Create()">
						</comment><script>__ws__(__NSID__);</script>  
						</nobr>
					</td> 
				</tr>
			</table>
		</td>
	</tr>
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>매장정보</nobr></td>
					<td class="tab23" style="width:270px">
						<object id=gcem_dfscost classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Enable          value=false>
							<param name=PromptChar	    value="_">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>&nbsp;
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_DfsCost()">
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>매출일자</nobr></td>
					<td class="tab23" style="width:500px">
						<comment id="__NSID__">
							<object  id=gcem_saledt_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							~
							
							<object  id=gcem_saledt_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							</nobr>
					</td>
										
				
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:597px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<FG> Name ='매장정보'     	            HeadAlign=Center HeadBgColor=#B9D4DC   
								<FC> Name='코드'     	ID=DFSCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	    align=center	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='매장명'     	ID=DFSNM        HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=left  	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='매출일자'	    ID=SALEDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  edit=none MASK ='XXXX/XX/XX'</FC> 
								<FC> Name='포스'     	ID=POSNO        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB'  edit=none SumText='건수'</FC>
								<FC> Name='영수증'	    ID=RECNO  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none SumText=@count</FC>
								</FG>
							    <C> Name='구분1'	        ID=GUBUN  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>	   
								<C> Name='구분2'	        ID=GUBUN2  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>
								<G> Name ='주문시간'                      HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='최초'	        ID=ORDTM  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='결제'	        ID=APPTM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<G> Name ='상품정보'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='상품코드'       ID=GOODCD	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='바코드'	        ID=BARCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='상품명'	        ID=GOODNM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
				                </G>
				                
				                <G> Name ='판매정보'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='수량'	    	ID=GOODCNT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='매입가'	        ID=BUYAMT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='총매출액'       ID=TSALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='할인액'        ID=DISCAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='할인구분'      ID=DISGB  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='실매출액'      ID=SALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='가액'         ID=PRIAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='부가세'        ID=VATAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='에누리'        ID=ADJAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='결재합계'      ID=APPSUM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='원화합계'      ID=WONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='신용카드'      ID=CARDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='현금원화'      ID=CASHAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='위안'         ID=CNYAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='위안원화'      ID=CWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='달러'         ID=USDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='달러원화'      ID=UWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='포인트'        ID=PNTAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='카드코드'	    ID=CARDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center  	SumBgColor='#C3D0DB'  edit=none	</C>
								<C> Name='카드명'	        ID=CARDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 