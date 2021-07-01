<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 전체 메뉴 조회 및 권한 요청!
 * 프로그램ID  	: SY140I
 * J  S  P   	: Sy140i
 * 서 블 릿     : Sy120I
 * 작 성 자     : 차태주
 * 작 성 일     : 2006-09-10
 * 기능정의     : 메뉴조회 권한 요청
 * [ 수정일자 ][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * delete  from sales.tsy140 where u_empno='2010021' and tree_idx=265
 * [2013-11-20][심동현] 시스템 이전 / 메뉴 정리
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
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

    var v_Main_row = 0;

   //페이지로딩
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
	
   //선조회
   function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");

 		//작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item2=Y";
        ds_status1.Reset();
 		
   }

   /*
    * 메인조회
    */
    function fnSelect() {
		v_job = "S";
           msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			           + ",sEmpno=" + v_empno.Text
			           + ",sStatus="+ lc_status1.ValueOfIndex("detail", lc_status1.Index);

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy141I",
               "JSP(O:Main=ds1)",
               v_param);
           tr_post(tr1);
    }


	// 취소
	function fnCancel() {
        ds1.undoall();
		msgTxt.innerHTML="데이터 변경이 취소되었습니다.";
		return;		
	}

	// 그리드 행삭제
	function fnDeleteRow() {
		ds1.DeleteRow(ds1.RowPosition);
	}
	
	//저장 (신규메뉴 권한 신청)- 관리자가 확인 후 실제로 저장해주는 것.. 엄청 피곤할지도.. ;;
	function fnApply() {
		if (ds1.IsUpdated) {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy141I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);  
			
			fnSelect();
		} else {
			alert("체크된 요청 건이 없습니다.");
		};
	}


	// 엑셀
	function fnExcelDs1() {
		if(ds1.RowCount==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        } 
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:메뉴목록조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("메뉴목록조회","메뉴목록조회.xls", 8);
	}

	
	
    <%//직원 팝- 검색조건 처리자 : 관리자만 가능하게%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		
    		v_empno.text = arrParam[1];
    		//v_eno_nm.value = arrParam[0];

    		
        } else {
        	
			//fnEmpNoCleanup();
			
        }               
    	
    }	
	

</script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>




<%//탭 선택시 조회하기 %>
<script language="javascript" for="lc_status1" event="onselChange()">


		if(lc_status1.text=="선택"){

		}else{
			fnSelect();
		}
		
		
</script>	

<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="")
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>


<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds2 event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>


<%
/*=============================================================================
         DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


</head>



<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="1000px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td align="right" height="30px">
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
			<!-- 		<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">					    
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		 엑셀 -->					    
						<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply()">
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>
		  <tr>
			<td>
			  <table width=1000 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr height="25px">
                  <td width="100px" class="text">신청자 사번
                  </td>
                  <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                    <object id=v_empno classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                        <param name=Format      value="0000000">
                        <param name=Alignment   value=1>
                        <param name=ClipMode    value=true>
                        <param name=Border      value=false>
                        <param name=SelectAll   value=true>
                        <param name=SelectAllOnClick      value=true>
                        <param name=SelectAllOnClickAny   value=false>
                    </object>
                    <%=HDConstant.COMMENT_END%>

                    

	  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onclick="fnEmpNoPopup('<%=dirPath%>');" alt="직원 찾기" style="cursor:hand;">

                  </td>
				  <td align="center" width="70px"  class="text">상태</td>
				  <td align="center" bgcolor=#ffffff><%=HDConstant.COMMENT_START%>
                    <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=80 width=80 border="0" align=absmiddle>
						<param name=ComboDataID		value=ds_status1>
						<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^80">
					</object><%=HDConstant.COMMENT_END%>	
				  </td>
				</tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height='15px'></td>
		  </tr>		  
		  <tr>
			<td width="1000px">
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=845>
					    <%=HDConstant.COMMENT_START%>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=1000px; height:560px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="True">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="SuppressOption"    value="1">
					        <param name="ViewSummary"   	value="1">
					        <param name="SortView"			value="Right">
					        <param name="Format"            value="
					            <C> name='체크'      	ID='CHK'   	   Width=50  align=center EditStyle=CheckBox edit=True</C>
					            <C> name='상태'     	ID='AUTH_RQ'   Width=80  align=center editstyle=lookup data='ds_status1:detail:detail_nm' edit=none Sumtext=계</C>
					            <C> name='요청자'      	ID='U_EMPNM'   Width=70  align=center Sumtext=@cnt edit=none Sort=True </C>
					            <C> name='사번'      	ID='U_EMPNO'   Width=70  align=center  edit=none</C>
					            <C> name='요청일자'     ID='U_DATE'    Width=80  align=center  edit=none mask='XXXX-XX-XX'</C>
					            <C> name='레벨'     	ID='TREE_LV'   Width=40  align=center  edit=none</C>
					            <C> name='메뉴ID'       ID='TREE_ID'   Width=70  align=center  edit=none</C>
					            <C> name='메뉴번호'     ID='TREE_IDX'  Width=80  align=center  edit=none</C>
					            <C> name='메뉴명1'      ID='TREE_NM1'  Width=90  align=center suppress=1 edit=none</C>
					            <C> name='메뉴명2'      ID='TREE_NM2'  Width=100  align=left suppress=2 edit=none</C>
					            <C> name='메뉴명3'      ID='TREE_NM3'  Width=100  align=left suppress=3 edit=none</C>
					            <C> name='메뉴명4'      ID='TREE_NM4'  Width=150  align=left edit=none  Sort=True</C>
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
  <tr>
	<td style="padding-top:6px">※ 좌측 [전체 메뉴 리스트]에서 필요한 메뉴를 더블클릭하면 우측 [권한 요청]에 목록이 생성됩니다.<br>
		　 필요한 메뉴를 추가하신 후 저장을 누르면 관리자에게 신청됩니다.<br>
		※ 각 메뉴별 관리팀의 요청에 의해 권한을 드리지 못할 수도 있습니다.
	</td>
  </tr>

</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

