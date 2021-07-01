<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 제품 엑셀 업로드 등록/조회
 * 프로그램ID 	 : ML110I
 * J  S  P		 : ml110i
 * 서 블 릿		 : ML110I
 * 작 성 자		 : 정하나
 * 작 성 일		 : 2011-07-14
 * 기능정의		 : 제품등록(엑셀 업로드, 조회,저장)
 * [수  정   일  자][수정자] 카테고리 구분/조회/저장 변경 2012-01-06 정하나
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/*=============================================================================,
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
     //   var v_job = "H";
	    var v_job = "I";	 
		//전체변수 셋 : 조회구분하기 위해서		        
     
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description 	:  페이지 로딩
	// Parameter 	:
	%>
	function fnOnLoad(tree_idx){
	
		
		fnInit_tree(tree_idx);	//트리초기화 호출		
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
		
		fnInit();
		
			if (excelDs.countrow<1){

			//  업로드 헤더 설정
									
							var s_temp =  "COL01:STRING,COL02:STRING,COL03:STRING,COL04:STRING,"
									 	+ "COL05:STRING,COL06:STRING,COL07:STRING,COL08:STRING,COL09:STRING,"
									 	+ "COL10:NUMBER,COL11:STRING,COL12:STRING,COL13:NUMBER,COL14:NUMBER,"
									 	+ "COL15:NUMBER,COL16:NUMBER,COL17:STRING,COL18:NUMBER,COL19:STRING,COL20:STRING,"
									 	+ "GARBAGE_SID:NUMBER;";
									 				
							excelDs.SetDataHeader(s_temp);
			}
					
	}

	<%
	///////////////////////////////////////////////////////////////////////////////   
	// Description 	: 선조회
	// Parameter 	:
	%>
	function fnInit(){
	
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        		
        
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();  //쇼핑몰 거래구분1 (개성현지불,면세복지,선물세트)
        
        
       // codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML002&s_item1=Y";
      //  codeDs2.Reset();  쇼핑몰 거래구분2 (2012설,추석등)      
      
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML003&s_item1=Y";
        ds2.Reset();  
        //구분2의 코드값은 ML002   SELECT HEAD, DETAIL, DETAIL_NM FROM   SALES.TSY010 where head='ML003' 카테고리값들
        
  
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML004&s_item1=Y";
        ds3.Reset();   //공급자SID
                
               
	}
	
	
	

		/**
		 * 엑셀적용 
		 * 파일 업로드 후에 조회 
		 */
		 

		function fnExcelApply()  {
		    // v_job = "S";
			tempExcelDs.addrow();		
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;		
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;		 	
       	    v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
       	    
       	  // alert(v_param);
		//	alert(v_job);
			
			ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)",
	            v_param);                
			//prompt('tempExcelDs',tempExcelDs.text);
            tr_post(tr1);
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	:
%>
    function fnSelect() {
        //window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        //document.all.LowerFrame.style.visibility="visible";
      
        v_job = "S";
           
     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
					+ "sTrGu=" + codeDs1.namevalue(codeDs1.rowposition,"detail") + "," 
					+ "sTrGu2=" + codeDs2.namevalue(codeDs2.rowposition,"detail") + "," 
					+ "v_cate1=" + ds2.namevalue(ds2.rowposition,"detail") ;										
     
             //  alert(param);
        ln_TRSetting(tr1, 
   		    "<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I", 
            "JSP(O:MAIN_DS=excelDs)",
            param);
        tr_post(tr1);
    }
    
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용
// Parameter 	:
%>

		/*
		 * 저장
		 */
		function fnApply() {
			alert("전산팀에 문의해 주세요.");
			return;
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I",
               	  "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("업데이트된 행이 없습니다.");
			};	
		}
		
			

		function fnExcelDs1() {
	        if(excelDs.CountRow==0){
    	        alert("데이터를 먼저 조회하시길 바랍니다.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:선물세트 상품목록; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","선물세트 상품목록.xls", 8);
		}	
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


	<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
				alert(gcip_file.value);
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
		
		
	<script language=JavaScript for=sTrGu event=OnSelChange()>
	
        //    ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_SaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&s_UpjangType=10&s_use_yn=Y";
        //ds3.Reset(); //영업장코드 
        
        
        codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML002&s_item1=Y&s_item2="+codeDs1.namevalue(codeDs1.RowPosition, "detail")+" ";
        codeDs2.Reset();
                    
	</script>   			


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>


		<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
		if (v_job == "I"){
			for(i = 1; i <= excelDs.countrow; i++) {
				//alert(i);
				excelDs.namevalue(i, 'GARBAGE_SID') = 0;
				//alert(excelDs.namevalue(i, 'GARBAGE_SID'));
			}			
		};
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
			//	alert(gcip_file.value);
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



<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>

<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s05.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td align="right" width="550" style="padding-right:6px">
					<input type="text" name="file_path" value="" >&nbsp;
					<%=HDConstant.COMMENT_START%>
					<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;position:relative;left:3px;top:3px"  >
					<param name="Text"		value="찾아보기">
					</OBJECT>&nbsp;			
					<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand;position:relative;left:3px;top:3px"  border='0' onClick='javascript:fnExcelApply();'>						
					<%=HDConstant.COMMENT_END%>	
						<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnExcelDs1();">       					
														
									
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
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" width=845>
							<tr bgcolor="#6f7f8d">
							
		                        <td align="center" width="90px" height="30px" class="text">거래구분</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=180 width=123 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								
		                        <td align="center" width="90px" height="30px" class="text">거래구분2</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=180 width=150 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								
		                        <td align="center" width="90px" height="30px" class="text">카테고리</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=v_cate1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=180 width=150 border="0" align=absmiddle>
									<param name=ComboDataID			value=ds2>
									<param name=BindColumn      value="detail">
	                                <param name=BindColVal      value="detail">
									<param name=EditExprFormat	value="%,%;detail,detail_nm">
									<param name=ListExprFormat  value="detail_nm^0^80">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>						
							</tr>
						</table>
					</td>
            	</tr>
            	            	
            	<tr>
            		<td height=3  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:470px" border="1">
                            			<param name="DataID"		VALUE="excelDs">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="                                      		
                                            <FC> name='카테고리'    ID='COL01'          Width=80   align=left    EditStyle=Lookup Data='ds2:detail:detail_nm' editlimit=5 Sort=True</FC>
                                            <FC> name='구분2'     ID='COL02'          Width=50   align=left      Edit=Any </FC>
                                            <C> name='브랜드'          ID='COL03'      Width=100   align=left      Edit=Any</C>
                                            <C> name='제품명'          ID='COL04'    Width=200   align=left      Edit=Any</C>
                                            <C> name='제조사'     ID='COL05'        Width=140    align=left      Edit=Any </C>
                                            <C> name='원산지'    ID='COL06'     Width=60   align=left        Edit=Any  </C>                    
                                            <C> name='디피여부'         ID='COL07'       Width=60  align=Center EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='사용여부'           ID='COL08'             Width=60  align=center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='공급자제품코드'     ID='COL09'            Width=100   align=left      Edit=Any</C>
                                            <C> name='공급자SID'     ID='COL10'            Width=80   align=left     editstyle=lookup Data='ds3:detail:detail_nm'  DEC=0 </C>
                                            <C> name='과세 여부'     ID='COL11'            Width=80   align=center      EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='통화'     ID='COL12'            Width=50   align=left      Edit=Any </C>
                                            <C> name='단가'     ID='COL13'            Width=60   align=center     	DEC=0</C>
                                            <C> name='공급가'     ID='COL14'            Width=60   align=center     DEC=0 </C>
                                            <C> name='부가세'     ID='COL15'            Width=60   align=center     DEC=0</C>
                                            <C> name='직원가'     ID='COL16'            Width=60   align=center     DEC=0</C>
											<C> name='거래구분'     ID='COL17'            Width=60   align=left   editstyle=lookup  data='codeDs1:detail:detail_nm'   Edit=Any</C>                                            
											<C> name='원가'     ID='COL18'            Width=60   align=center      DEC=0</C>                                                 
                                            <C> name='참고사항'     ID='COL19'            Width=1000   align=left      Edit=Any</C> 
											<C> name='선물세트구분'     ID='COL20'            Width=80   align=left  editstyle=lookup  data='codeDs2:detail:detail_nm'   Edit=Any</C>                                                   
											<C> name='GARBAGE_SID'  		ID='GARBAGE_SID'  Width=80   align=center  show=false	</C>                                                                                  
										">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
                		    </tr><br>
                		    <tr><td>※ 액셀 시트의 이름이 "Sheet1" 이어야 합니다.</td></tr>
  							<tr><td>&nbsp; <font color=blue>* 찾아보기 --> 엑셀적용 --> 저장  </font></td></tr>                		    
                		</table>
                    </td>
                </tr>
            </table>
       
  
	<%=HDConstant.COMMENT_START%>	
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>		
      	<%=HDConstant.COMMENT_END%>	

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

