<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 프로그램 정보
 * 프로그램ID 	 : CM040I
 * J  S  P		 : cm040i
 * 서 블 릿		 : CM040I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2007-07-20
 * 기능정의		 : 프로그램 정보 (조회, 수정, 삭제, 추가)
 * [수  정   일  자][수정자] 내용
 * [2014-06-12][심동현] 해당 메뉴의 권한 사용자 그리드 추가
 * [2014-11-27][심동현] 페이지 임포트 등은 ap100i.jsp 결재함 파일과 동일하게
 *						config 메뉴 스탈임. 공통코드는 sales 쪽
 * [2014-11-28][심동현] 설명 업데이트 가능하려나.. 가능함~! 수정완료.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="config.common.*"%>
<%@ page import="sales.common.HDUtil" %>
<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

    <jsp:include page="/Config/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
		var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
        var v_job = "H";
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit();		//해당 페이지의 세팅 초기화
		fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]
	}

	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
		//fnSetHeader();
        
        ds_lc1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CN002&s_Item1=Y";
        ds_lc1.Reset();	//Schema 공통코드에 따로 관리. sales공통코드에 CN=config로 시작함..
        //alert(lc1.index);
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
      	     	+ "v_snm=" + ds_lc1.namevalue(ds_lc1.rowposition,"detail")
      	     	+ ", v_jnm=" + ds_lc1.namevalue(ds_lc1.rowposition,"detail_nm")
      	     	;
        //alert(param);
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Db010I",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);
    }


	/* 서브 조회 - gr2 */
    function fnSelectGR2(row) {
		v_default_row = row;
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "Sgr2";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
  	     	+ "v_tnm=" + ds1.namevalue(row,"TABLE_NAME")
  	     	+ ",v_snm=" + ds_lc1.namevalue(ds_lc1.rowposition,"detail");
        ln_TRSetting(tr1, 
        	"<%=dirPath%><%=HDConstant.PATH_SY%>Db010I",
            "JSP(O:DS2=ds2)",
            param);
        tr_post(tr1);
    }
	<%//저장 (신규메뉴 권한 신청)- 관리자가 확인 후 실제로 저장해주는 것.. 엄청 피곤할지도.. ;; %>
	function fnApply() {
		if (ds1.IsUpdated||ds2.IsUpdated) {
			v_job = "A";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	  	     	+ ",v_snm=" + ds_lc1.namevalue(ds_lc1.rowposition,"detail");
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Db010I",
			    "JSP(I:DS1=ds1,I:DS2=ds2)",
			    param);
			tr_post(tr1);  
		} else {
			alert("수정된 행이 없습니다.");
			//alert("비밀번호를 초기화할 계정이 없습니다.");
		};
	}
	
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//메뉴 선택시 사용자정보 불러오기 %>
	<script language=javascript for="gr1" event="OnClick(Row, Colid)">
	    if(Row==0) return;
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectGR2(Row);
	    }		    
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
	

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	

	<script language=javascript for="ds1" event="OnLoadCompleted(row)">
	    msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}else{
				fnSelectGR2(v_default_row);
			}
		}
	</script>		

	<script language=javascript for="ds2" event="OnLoadCompleted(row)">
	    msgTxt.innerHTML="조회가 완료 되었습니다.";
	</script>	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object id=ds_lc1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</head>
	
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->
		
	<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
		<tr>
			<td>
			
				<table border="0" width="845px"  cellpadding="0" cellspacing="0">									
					<tr height="50px">
						<td align="left" >
							<table width="1000px" border="0"  cellspacing="0" cellpadding="0" >
								<tr> 
									<td align="right">
										<table border="0"  cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="right" height="30px">		
													<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
													<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:pointer" onclick="fnApply()">													
									 			</td>
											</tr>																		
										</table>
									</td>
								</tr>															
							</table>	
						</td>											
					</tr>
					
					<tr height="30px">
						<td align="left" >
							<table width="1000px" border="0"  cellspacing="0" cellpadding="0" >
								<tr> 
									<td  width="1000px">
				                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
				                            <tr bgcolor="#6f7f8d">
				            					<td align=left class="text" width=70>&nbsp;Schema</td>
				                                <td align=left bgcolor="#ffffff">&nbsp;																										
      												
						                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=150 border="0" align=absmiddle>
														<param name=ComboDataID		value=ds_lc1>
			                                            <param name=BindColumn      value="detail">
			                                            <param name=BindColVal      value="detail">
			                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
			                                            <param name=ListExprFormat  value="detail^0^100">
													</object>
													
												</td>
				            				</tr>
				            			</table>
									</td>
								</tr>															
							</table>	
						</td>											
					</tr>
					<tr height="10">
						<td></td>
					</tr>		
					<tr>
						<td width="1000px">
							
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="580px">
										<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:450px; height:500px " border="1" >
	                            			<param name="DataID"		VALUE="ds1">
	                            			<param name="BorderStyle"   VALUE="0">
	                            			<param name=ColSizing       value="true">
	                            			<param name="editable"      value="true">
	                            			<param name=UsingOneClick  	value="1">
	                                        <Param Name="AllShowEdit"   value="True">
	                                        <param name="SortView"      value="Right">
	                                        <param name="SuppressOption"    value="1">
											<param name="Format" 			value="
											 	<C> name='No'        	ID='{STRING(CURROW)}'   Width=30    align=center edit=none</C>
												<C> name='테이블명'		ID='TABLE_NAME'			width=150  	align=left show=true  edit=none</C>
												<C> name='타입'   		ID='TABLE_TYPE' 		width=50	align=center show=true edit=none</C>
												<C> name='설명'   	 	ID='COMMENTS'			width=200	align=left show=true edit=true</C>
											">
										</object>
									</td>
									<td>&nbsp;</td>
									<td align="left" width="370px">
										<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:520px; height:500px " border="1" >
	                            			<param name="DataID"		VALUE="ds2">
	                            			<param name="BorderStyle"   VALUE="0">
	                            			<param name=ColSizing       value="true">
	                            			<param name="editable"      value="true">
	                            			<param name=UsingOneClick  	value="1">
	                                        <Param Name="AllShowEdit"   value="True">
	                                        <param name="SuppressOption"    value="1">
											<param name="Format" 			value="
											 	<C> name='C_ID'      	ID='column_id'   Width=30    align=center</C>
												<C> name='컬럼명'		ID='COLUMN_NAME'    width=100	align=left editlimit=30 show=true  edit=true </C>
											 	<C> name='데이터타입'	ID='data_type'		width=80  	align=left show=true edit=none </C>
												<C> name='길이'			ID='data_length'	width=50  	align=center  show=true edit=none </C>
												<C> name='null'			ID='nullable'   	width=40	align=center  show=true  edit=none bgColor={IF(nullable='Y','#FFFF00','#FFFFFF')}</C>
												<C> name='설명'   	 	ID='COMMENTS'		width=200	align=left show=true edit=true</C>
												<C> name='테이블'  	 	ID='table_name'		width=50	align=left show=false edit=true</C>
											">
										</object>
										
									</td>		

								</tr>
							</table>
						</td>
					</tr>											
				</table>
			</td>
		</tr>
        <tr>
			<td><br>※ ERP 스키마의 Table 속성을 조회하고 [설명] 컬럼만을 수정 가능합니다.<BR>
			　 테이블명, 컬럼명 보면서 개발할 때 참고하려고 만든 겁니다.<br>
			　 현재 화면은 전산팀만 볼 수 있어야 합니다.
			</td>
        </tr>
		
	</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->
		
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
