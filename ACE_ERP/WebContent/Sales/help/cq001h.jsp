<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명         : 조장, 운전자 조회 Help
 * 프로그램ID   : CQ001H
 * J  S  P      : cq001h
 * 서 블 릿        : Cq001H
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-15
 * 기능정의     : 
 * 수정내용     : 
 * 수 정 자        : 
 * 최종수정일자 :  
 * TODO         :
 * TODO         :
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            var v_saup_gu = "";
            var v_depart_date = "";
            var v_depart_time = "";
            var v_saup_sid = "";
            var v_goods_sid = "";
            
            function fnOnLoad() {
                cfStyleGrid(getObjectFirst("gr1"), "comn");
                var strParam = new Array();
                strParam=window.dialogArguments;
                
                v_saup_gu = strParam[0];
                v_depart_date = strParam[1];
                v_depart_time = strParam[2];
                v_saup_sid = strParam[3];
                v_goods_sid = strParam[4];
                
                if(v_saup_gu == "50")
                    getObjectFirst("v_title").innerHTML = "조장 정보조회";
                if(v_saup_gu == "60")
                    getObjectFirst("v_title").innerHTML = "운전자 정보조회";
                
                fnSelect();
            }
            
            function fnSelect() {
                var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=1"
                            + "&v_saup_sid="+v_saup_sid
                            + "&v_goods_sid="+v_goods_sid
                            + "&v_saup_gu="+v_saup_gu
                            + "&v_depart_date="+v_depart_date
                            + "&v_depart_time="+v_depart_time;
                ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cq001H?"+v_param;
                ds1.Reset();
            }
             
            function fnAdd() {
                var row = ds1.rowposition;
            
                window.returnValue = ds1.namevalue(row, "CUST_NM")  + ";" +
                                     ds1.namevalue(row, "REGI_NO") + ";" +
                                     ds1.namevalue(row, "CUST_SID");
                fnClose();
            }
            
            function fnClose() {
                window.close();
            }
            
            
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            document.all.LowerFrame.style.visibility="hidden";
            if(row==0){
                alert("<%=HDConstant.S_MSG_NO_DATA%>");
                window.close();
            }
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            document.all.LowerFrame.style.visibility="hidden";
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  그리드 더블클릭 이벤트 발생
//
%>          
        <script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
            fnAdd();
        </script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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

<%=HDConstant.COMMENT_START%>       
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <span id=v_title></span></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
                        <tr>
                            <td align=right><img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnAdd()">                            
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnClose()">                          
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
            <tr>
                <td>
<%
/*---------------------------------------------------------------------------->
    Object ID   : 그리드 , gr1
    Data ID     : ds1
-----------------------------------------------------------------------------*/
%>
                    <%=HDConstant.COMMENT_START%>
                    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='479px' height='278px' border='1'>
                        <param name="DataID"        value="ds1">
                        <param name="BorderStyle"   value="0"> 
                        <param name="ColSizing"     value="true">
                        <param name="Fillarea"      value="true">
                        <param name="AutoResizing"  value=true> 
                        <param name="Editable"      value="false">
                        <param name="Format"        value="
                            <c> Name='성명'           ID='CUST_NM'      Width=100  align=center </c>
                            <c> Name='주민등록번호'     ID='REGI_NO'      Width=150  align=center</c>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%> 
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
                    &nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                <!--  상태바 플레쉬  -->
            <iframe id="LowerFrame" 
                name="work" 
                style="visibility:hidden; position:absolute; left:100px; top:150px;" 
                Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
                width="320px" 
                height="42px">
            </iframe>   
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>