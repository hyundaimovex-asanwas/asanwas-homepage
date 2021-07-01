<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>SMS전송>SMS전송
* 프로그램 ID	: sms010.jsp
* 기 능 정 의	: 차량운행입력
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2019.06.17
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>SMS전송</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


/*----------------------------------------------------------------------------
 * 페이지로딩
----------------------------------------------------------------------------*/

		function fnOnLoad(tree_idx){
			
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gcgd_disp1"), "comn");  //grid 헤드색 

		    fnInit();

			//fnSelect();
		    
		}



/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function fnSelect(){


		     
}


/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function fnInit(){

	  	//대상자(재직자) 일단 조회
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Sms010",  "JSP(O:gcds_data00=gcds_data00)",  param);

	    tr_post(tr1);	  	        

}



/*----------------------------------------------------------------------------
	Description : 저장 
----------------------------------------------------------------------------*/

function fn_Save(){  
		
		if(!fnSave_Chk()) return;

		if(confirm("메세지를 저장하시겠습니까?")){			
	
			var message = document.getElementById("txtComment").innerText;
			
			for(i=1;i<=gcds_data00.countrow;i++){

				if(gcds_data00.namevalue(i,"CHK") == "T"){

					gcds_data00.namevalue(i,"MEMO")=message;

				}
				
			}

		}			

}



/*---------------------------------------------------------------------------
	Description : 저장시 체크  
---------------------------------------------------------------------------*/

function fnSave_Chk(){

		return true;	

}



/*----------------------------------------------------------------------------
Description : 퇴사자 추가 
----------------------------------------------------------------------------*/

function fn_Add(){  
	

	if(confirm("퇴사직원을 추가하시겠습니까?")){			

		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		
		strURL = "<%=dirPath%>/Security/lc/sms011.jsp"
		
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		
		if (arrResult != null) {
			
			gcds_data00.addrow();
			
			arrParam = arrResult.split(";");
			
			gcds_data00.namevalue(gcds_data00.rowposition, "DPT_NM" ) 		= arrParam[0];		
			gcds_data00.namevalue(gcds_data00.rowposition, "JOB_NM" ) 		= arrParam[1];
			gcds_data00.namevalue(gcds_data00.rowposition, "ENO_NM" ) 		= arrParam[2];
			gcds_data00.namevalue(gcds_data00.rowposition, "EM_PHN_NO" ) 	= arrParam[3];
			
   		}	

	}			

}

/******************************************************************************
Description :  SMS 전송
******************************************************************************/

function fn_Tran(){

	
	if(!gcds_data00.IsUpdated) {

		alert("입력된 내용이 없습니다.");
		
		return false;
		
	}	
	
	for(i=1;i<=gcds_data00.countrow;i++){

		if(gcds_data00.namevalue(i,"CHK") == "T"){
			
			if(gcds_data00.namevalue(i,"MEMO") == ""){
				
				alert("메세지를 저장하시기 바랍니다.");
				
				return false;
				
			}
		}
	}
	
	
	if(confirm("메세지를 전송하시겠습니까?")){			
		
		//var date;
		//var phone;
		
		//if (ds_default01.CountColumn == 0) {
		//	ds_default01.setDataHeader("MESSAGE:STRING, EM_PHN_NO:STRING");
		//}
		
		// 행 추가
		//ds_default01.AddRow();	

		//date = gcem_staxdate.text;
		//date = date.substring(0,4) + "년" + date.substring(4,6) + "월" + date.substring(6,8) + "일";

		//phone = txt_phone_no.value;
		//phone = phone.replace("-","").replace("-", ""); 

		 // 기본정보
         var param = "proType=A";   			 

	     ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Sms010",  "JSP(I:gcds_data00=gcds_data00)",  param);

	     //prompt(this, gcds_data00.text);

	     tr_post(tr1);	 

	}	
	
}

</script>




<script language="javascript" for="gcgd_disp1" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

	    if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;		
		
		for(i=1;i<=gcds_data00.countrow;i++){

			if(gs_gubun=="1"||gs_gubun==""){
				
				gcds_data00.namevalue(i,"CHK")="T";

			}else{
				
				gcds_data00.namevalue(i,"CHK")="F";

			}
			
		}
		
	}
</script>


<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>

<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공-TR1
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
		ln_Query();
	</script>	

<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
%>

	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
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

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<!-- 버튼 테이블 시작 -->
<table width="970" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	<tr>
		<td height="30" class="paddingTop5" align="right">
			<img src="../../Common/img/btn/com_b_rowadd.gif"	name="Image2"	style="cursor:hand" onclick="fn_Add()">&nbsp;			
			<img src="../../Common/img/btn/com_b_trans.gif"		name="Image3"	style="cursor:hand" onclick="fn_Tran()">
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 --> 



<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<font color="blue" size = "2">* 메세지 입력</font>
	    <tr>
			<td class="padding2423" align="left" valign="top">
				<textarea id="txtComment"  cols=40  rows=10> [부고]
 
빈소:
발인:
연락처:</textarea>
				<img src="../../Common/img/btn/com_b_save.gif"		name="Image1"	style="cursor:hand" onclick="fn_Save()">
				<br>
				<br>1. 전송 대상자를 선택/해제/퇴사자 추가
				<br>&nbsp;&nbsp;(퇴사자의 경우 전화번호 다를 수 있음)
				<br><br>2. 메세지 입력 후 저장
				<br><br>3. 전송 버튼을 누르면 SMS 발송됨
				<br><br>4. 85byte 이므로 전체 전송 전 테스트 권장			
			</td>

			<td>
				<!-- body table -->
				<table cellpadding="0" cellspacing="0" width=730 height=600 bordercolor=black border="0">
						<tr>
							<td align="left" >
								<%=HDConstant.COMMENT_START%>
								<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp1 style="width:700;height:600px;border:1 solid #708090;border-right-width:1px;border-left-width:1px;border-top-width:1px;">
										<PARAM NAME="DataID"				VALUE="gcds_data00">
										<PARAM NAME="BorderStyle" 			VALUE="0">
										<PARAM NAME="Indwidth"				VALUE="0">
										<PARAM NAME="Fillarea"				VALUE="true">
										<PARAM NAME="Colsizing"				VALUE="true">
										<PARAM NAME="editable"				VALUE="true">
										<PARAM NAME="TitleHeight"			VALUE=20>
										<param name="sortview"    			value=left>
										<param name="ViewSummary"  			value="1">
										<PARAM NAME="Format"				VALUE="  
											  <C> Name='No'						ID={CURROW}				Width=30	align=center edit=none</C>   
					                          <C> name='CHK'             		ID='CHK'         		Width=20    align=center edit=true editstyle=CheckBox HeadCheck=false HeadCheckShow=true</C>           
					                          <C> name='부서'             		ID='DPT_NM'         	Width=120   align=center edit=none sort=true</C>
					                          <C> name='직책'        			ID='JOB_NM'        		Width=80    align=center edit=none sort=true</C>   
					                          <C> name='사번'        			ID='ENO_NO'         	Width=100   align=center show=false</C>  
					                          <C> name='성명'        			ID='ENO_NM'         	Width=80    align=center edit=none sort=true</C>  
					                          <C> name='수신번호'     			ID='EM_PHN_NO'         	Width=100   align=center edit=none </C>
					                          <C> name='메세지'     			ID='MEMO'         		Width=250   align=left   edit=none</C>                            
								">
								</OBJECT>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
				</table>
			</td>
		</tr>
</table>

<!-- 기본탭 -->
	<%=HDConstant.COMMENT_START%>
	<OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"			VALUE="true">
		<PARAM NAME="BindInfo"				VALUE="
			<C>Col=YOIL       		 				Ctrl=empno      			   					Param=Value</C>
			<C>Col=ENO_NM       					Ctrl=empnmk       								Param=Value</C>
			<C>Col=DEPT_CD   			 			Ctrl=txt_dept_cd     					  		Param=Value</C>
			<C>Col=T_PAY 							Ctrl=gcem_t_pay 								Param=Text</C>		
		">
	</OBJECT>
	<%=HDConstant.COMMENT_END%>


<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


