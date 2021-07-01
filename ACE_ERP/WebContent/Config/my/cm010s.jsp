<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>환경설정>마이페이지>커뮤니티>2015 소통QnA
 * 프로그램ID 	 : Config/my/cm010s
 * J  S  P		 : cm010s.jsp
 * 서 블 릿		 : Cm010S
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2015-02-10
 * [ 수정일자 ][수정자] 내용
 * [2015-02-10][심동현] 신규 개발 
 *****************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Config/common/include/head.jsp"/>
    
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
		fnSelect();
	}
	
    <%//초기작업 %>
    function fnInit() {
	    v_job ="I";
	    gr_default.RowHeight = "50";	//그리드 로우하이트 변경
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MY%>Cm010S",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:주요 작업 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("주요 작업 현황", v_date.text+"주요 작업 현황.xls", 8);        
    }
    
 

    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<%// 더블 클릭시 작업일보 조회 팝 %>
	<script language=javascript for="gr_default" event="OnDblClick(Row, Colid)">
	    if(Row==0) return;
	 	fnDraft(ds_default.NameValue(Row, "DWR_SID"),ds_default.NameValue(Row, "W_STS"));
	</script>

	<%//검색 일자에서 엔터시 바로 조회 %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_default" event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        msgTxt.innerHTML="조회가 완료 되었습니다.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}
		}
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.MxDataSetU_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTRU_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

</head>


<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->






<!--------------------------------- 코딩 부분 시작 ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                         
                        <object id=gr_default classid=<%=HDConstant.MxGridU_CLSID_S%> width='890px' height='450px' border='1'>
                            <param name="DataID"            value="ds_default">
                            <param name="ColSizing"         value="true">
                            <param name="Editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="BorderStyle"       value="0">
                            <param name="ViewSummary"       value="0">
                            <param name="Format"            value="
                                 <C> name='번 호'			ID='A_SID'	width=60 	align=center	Edit=None </C>
                                 <C> name='1.질문 대상'		ID='A1'   	width=180 	align=left	multiline=true</C>
                                 <C> name='2.질문 내용'  	ID='A2'		width=520 	align=left	multiline=true</C>
                                 <C> name='작성일자'		ID='I_DATE' width=100 	align=center	Edit=None  </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top"><br>

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		