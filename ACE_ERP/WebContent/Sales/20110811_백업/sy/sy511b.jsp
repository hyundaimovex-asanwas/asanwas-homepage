<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ü����Ȳ
 * ���α׷�ID   : AC020S
 * J  S  P      : ac020s
 * �� �� ��        : Ac020S
 * �� �� ��        : �̺���
 * �� �� ��        : 2006-08-07
 * �������     :
 * ��������     : 
 * �� �� ��        :
 * ������������   :
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
    // ContextPath
    String dirPath = request.getContextPath(); //HDASan
    
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());           
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <!-- HEAD ���� -->
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
                ����� ��ũ��Ʈ
******************************************************************************/
%>      
        <script language="javascript">
        /*
         * �������ε�
         */
        function fnOnLoad(){
            cfStyleTab(getObjectFirst("mxTab"), "comn");
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");
            cfStyleGrid(getObjectFirst("gr3"), "comn");
            cfStyleGrid(getObjectFirst("gr4"), "comn");
            cfStyleGrid(getObjectFirst("gr5"), "comn");
            cfStyleGrid(getObjectFirst("gr6"), "comn");
            cfStyleGrid(getObjectFirst("gr7"), "comn");
            cfStyleGrid(getObjectFirst("gr8"), "comn");
            
            fnInit(); 
        }       

        /*
         * �ʱ��۾�
         */
        function fnInit(){
           
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                "JSP(O:EXCELDS=tempExcelDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
        }

        /**
         * �������� 
         * ���� ���ε� �Ŀ� ��ȸ 
         */
         
        function fnExcelApply()  {
        
            tempExcelDs.addrow();
            
            tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
            tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
         
             ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS1=ds1,O:EXCELDS2=ds2,O:EXCELDS3=ds3,O:EXCELDS4=ds4,O:EXCELDS5=ds5,O:EXCELDS6=ds6,O:EXCELDS7=ds7,O:EXCELDS8=ds8)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>");
            tr_post(tr1);
        }
            
        /*
         * ����
         */
        function fnApply() {
            
            var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
                         
            if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated || ds5.IsUpdated || ds6.IsUpdated || ds7.IsUpdated || ds8.IsUpdated) {
                 ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy511B",
                 "JSP(I:EXCELDS1=ds1,I:EXCELDS2=ds2,I:EXCELDS3=ds3,I:EXCELDS4=ds4,I:EXCELDS5=ds5,I:EXCELDS6=ds6,I:EXCELDS7=ds7,I:EXCELDS8=ds8,O:RESULT=ds_result)",
                 param);
                 
                tr_post(tr1);
            }   
        }
        
        /*
         * ���������� ���� 
         */
            
            
        </script>
<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
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
    
    <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
        if (ds1.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds1.countrow; i++) {
            ds1.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
        if (ds2.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds2.countrow; i++) {
            ds2.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
        if (ds3.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds3.countrow; i++) {
            ds3.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
        if (ds4.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds4.countrow; i++) {
            ds4.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
        if (ds5.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds5.countrow; i++) {
            ds5.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
        if (ds6.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds6.countrow; i++) {
            ds6.namevalue(i, "yn") = "U";
        }
    </script>
    <script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
        if (ds7.countrow <= 0) {
            return;
        }
        for(i = 1; i <= ds7.countrow; i++) {
            ds7.namevalue(i, "yn") = "U";
        }
    </script>      
    <script language=JavaScript  for=ds8 event="OnLoadCompleted(row)">
		if (ds8.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds8.countrow; i++) {
			ds8.namevalue(i, "yn") = "U";
		}
	</script>             
    
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

<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  ����� -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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
    
<body leftmargin="10" topmargin="10" marginwidth="0" marginheight="0" onLoad="fnOnLoad();">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
           <td width="422" height="30" align="left" valign="middle" class="tt"><img src="/HDASan/Sales/images/icon.gif" width="14" height="14"> �ڷ�����</td>
         </tr>
    </table>
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td width='845px'>
                <table   border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td>
                            <table border='0' cellpadding='0' cellspacing='1' bgcolor=#666666>
                                <tr height="30px">
                                    <td align="center" width="85px" height="30px" class="text">��������</td>       
                                    <td width=350 bgcolor=#ffffff  valign="middle">&nbsp;
                                        <input type="text" name="file_path" value="" >&nbsp;
                                        <%=HDConstant.COMMENT_START%>
                                        <OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
                                            <param name="Text"      value="ã�ƺ���">
                                        </OBJECT>&nbsp;
                                        <img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand"  border='0' onClick='javascript:fnExcelApply();'>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align='right' bgcolor=#ffffff>
                            <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand" align=absmiddle onClick="fnApply();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px"><td>&nbsp;</td></tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <table  border="0" cellpadding="0" cellspacing="0">
                                <tr valign="top"">
                                    <td align="left" width="845px" bordercolor="#000000">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='845px' height='20px'>
                                            <param name="BackColor"         value="#00ffff">
                                            <param name="DisableBackColor"  value="#ffffee">
                                            <param name="Format"            value='
                                                <T>divid="mxTab_page1"  title="����������"</T>
                                                <T>divid="mxTab_page2"  title="������"</T>
                                                <T>divid="mxTab_page3"  title="����Ÿ������"</T>
                                                <T>divid="mxTab_page4"  title="��������"</T>
                                                <T>divid="mxTab_page5"  title="��ǰ����"</T>
                                                <T>divid="mxTab_page6"  title="�����ڵ�"</T>
                                                <T>divid="mxTab_page7"  title="����ó����"</T>
                                                <T>divid="mxTab_page8"	title="���� ����ڿ������"</T>
                                                '> 
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                                <tr valign=top>
                                    <td align="left" width="845px" bordercolor="#000000">
                                        <div class=page id="mxTab_page1" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds1">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='����SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C>  
                                                <C> name='�����ڵ�'         ID='UPJANG_CD'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='�����'          ID='UPJANG_NM'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='���念����'            ID='UPJANG_ENG_NM'      width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='��������'            ID='UPJANG_SHORT_NM'    width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='����Ÿ��'         ID='UPJANG_TYPE'        width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='��������'         ID='DIRECT_YN'          width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='��뿩��'         ID='USE_YN'             width=100 align=left editlimit=50 show=true </C>  
                                                <C> name='ȭ��ǥ�ü���'       ID='DISPLAY_SEQ'        width=100 align=left editlimit=50 show=true dec=0</C>  
                                                <C> name='�������'         ID='REMARKS'            width=100 align=left editlimit=50 show=true </C>  
                                                    <C> name='���SID'            ID='SAUP_SID'           width=100 align=left editlimit=50 show=true dec=0</C>  
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page2" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds2">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='��SID'             ID='DONG_SID'           width=100 align=left editlimit=50 show=true dec=0 </C>
                                                <C> name='���ڵ�'          ID='DONG_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='���̸�'          ID='DONG_NM'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='������'          ID='DONG_ENG_NM'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�����'          ID='DONG_SHORT_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0 </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page3" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds3">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='����Ÿ��SID'              ID='ROOM_TYPE_SID'          width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='����SID'            ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='���ǵ���ڵ�'           ID='ROOM_GRADE_CD'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='���Ÿ��'         ID='BED_TYPE_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����Ÿ��'         ID='ROOM_TYPE_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='����Ÿ�Ը�'            ID='ROOM_TYPE_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����'               ID='PYUNG'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�ּ��ο�'         ID='STD_PERSONS'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='�ִ��ο�'         ID='MAX_PERSONS'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='ȭ��ǥ�ü���'           ID='DISPLAY_SEQ'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                
                                                <C> name='��뿩��'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page4" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds4">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='����SID'            ID='ROOM_SID'           width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='���ǹ�ȣ'         ID='ROOM_NO'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��������'         ID='BGN_DATE'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��������'         ID='END_DATE'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��������:R'           ID='ROOM_VIEW_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='������'          ID='FLOORS'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��뿩��:S'           ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�����SID'           ID='UPJANG_SID'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='��SID'             ID='DONG_SID'           width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='����Ÿ��SID'      ID='ROOM_TYPE_SID'          width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='�������'         ID='REMARKS'            width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page5" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds5">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='��ǰSID'            ID='GOODS_SID'          width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='��ǰ�ڵ�'         ID='GOODS_CD'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��ǰ��'          ID='GOODS_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='������ǰ��'            ID='ENG_NM'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�⺻���'         ID='COURSE'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�ڼ�'               ID='NIGHTS'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='�ϼ�'               ID='DAYS'           width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='��뿩��'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page6" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds6">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='��з�'          ID='HEAD'           width=100 align=left editlimit=50 show=true </C>
                                                <C> name='�Һз�'          ID='DETAIL'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Һз���'         ID='DETAIL_NM'      width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�1'              ID='ITEM1'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�2'              ID='ITEM2'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�3'              ID='ITEM3'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�4'              ID='ITEM4'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�5'              ID='ITEM5'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�6'              ID='ITEM6'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�7'              ID='ITEM7'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�8'              ID='ITEM8'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�9'              ID='ITEM9'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�10'         ID='ITEM10'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�11'         ID='ITEM11'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�12'         ID='ITEM12'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�13'         ID='ITEM13'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�14'         ID='ITEM14'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�Ӽ�15'         ID='ITEM15'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page7" style="position:absolute; width:845; height:300">
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:480" border="1" >
                                            <param name="DataID"        VALUE="ds7">
                                            <param name="BorderStyle"   VALUE="0">
                                            <param name=ColSizing       value="true">
                                            <param name="editable"      value="false">
                                            <param name=UsingOneClick   value="1">
                                            <Param Name="AllShowEdit"   value="True">
                                            <param name="SortView"      value="Right">
                                            <param name=SuppressOption value=1>
                                            <param name="Format"            value="
                                                <C> name='����óSID'           ID='CLIENT_SID'         width=100 align=left editlimit=50 show=true dec=0</C>
                                                <C> name='ȸ��ŷ�ó'            ID='VEND_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����ó�ڵ�'            ID='CLIENT_CD'      width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����ó��'         ID='CLIENT_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����ó����'            ID='CLIENT_GU'          width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='�븮������'            ID='AGEN_GU'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='���ǿ���'         ID='DIR_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�����ڵ�'         ID='AREA_CD'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='����������ڵ�'      ID='SAL_DAM_SID'            width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='����ó�����'       ID='CLIENT_DAM_NM'          width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='��ȭ��ȣ'         ID='TEL_NO'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�޴���ȭ'         ID='MOBILE_NO'          width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='FAX��ȣ'            ID='FAX_NO'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�̸���'          ID='E_MAIL'         width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�����ȣ'         ID='ZIP_CD'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='�ּ�1'          ID='ADDRESS1'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�ּ�2'          ID='ADDRESS2'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��������'         ID='COMMI_RATE'         width=100 align=left editlimit=50 show=true dec=0</C> 
                                                <C> name='������'         ID='CUNT_STATUS'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='�����ڵ�'         ID='BANCOD'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                                <C> name='������¹�ȣ'           ID='BANK_ACC_NO'            width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='������'          ID='BANK_ACCT_NM'           width=100 align=left editlimit=50 show=true </C> 
                                                <C> name='��뿩��'         ID='USE_YN'         width=100 align=left editlimit=50 show=true </C> 
                                                
                                            ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%> 
                                        </div>
                                        <div class=page id="mxTab_page8" style="position:absolute; width:845; height:300">
										<%=HDConstant.COMMENT_START%>
										<object id=gr8 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
		                        			<param name="DataID"		VALUE="ds8">
		                        			<param name="BorderStyle"   VALUE="0">
		                        			<param name=ColSizing       value="true">
		                        			<param name="editable"      value="false">
		                        			<param name=UsingOneClick  	value="1">
		                                    <Param Name="AllShowEdit"   value="True">
		                                    <param name="SortView"      value="Right">
											<param name=SuppressOption value=1>
											<param name="Format" 			value="
							           					<C> name='�޴�SID'			ID='MENU_SID'	width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='�޴��ڵ�'			ID='MENU_CD'	 width=100 align=left editlimit=13 show=true</C>
														<C> name='�޴������ڵ�'		ID='MENU_GUBUN_CD'	width=100  align=left editlimit=2 show=true</C>
														<C> name='�޴�����1'			ID='MENU_ITEM1'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='�޴�����2'			ID='MENU_ITEM2'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='�޴�����3'			ID='MENU_ITEM3'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='�޴�����4'			ID='MENU_ITEM4'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='�޴�����5'			ID='MENU_ITEM5'	 width=100 align=left editlimit=5 show=true</C>
														<C> name='�����������'		ID='BGN_DATE'	 width=100 align=left editlimit=8 show=true</C>
														<C> name='������������'		ID='END_DATE'	 width=100 align=left editlimit=8 show=true</C>
														<C> name='�����ο�'			ID='BGN_PERSONS'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='�����ο�'			ID='END_PERSONS'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='�޴���'			ID='MENU_NM'	 width=100 align=left editlimit=50 show=true</C>
														<C> name='�޴�������'			ID='MENU_ENG_NM'	width=100  align=left editlimit=30 show=true</C>
														<C> name='�޴������'			ID='MENU_SHORT_NM'	width=100  align=left editlimit=12 show=true</C>
														<C> name='��������'			ID='TAX_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='���ݰ����'		ID='TAX_CALCU_CD'	width=100  align=left editlimit=1 show=true</C>
															<C> name='�ܰ�'				ID='UNIT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='���ް�'			ID='NET_AMT'	width=100  align=left editlimit=12 show=true dec=0</C>
														<C> name='�ΰ���'			ID='VAT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='Ư�Ҽ�'			ID='EXCISE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='������'			ID='EDU_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='��Ư��'			ID='VILLAGE_AMT' width=100 	 align=left editlimit=12 show=true dec=0</C>
														<C> name='ü�����'			ID='SPORTS_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='�������'			ID='TOUR_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='��ȸ��'			ID='ASSOC_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='�����'			ID='TIP_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
														<C> name='��ȭ�ڵ�(RV022)'	ID='CURRENCY_CD'	width=100  align=left editlimit=3 show=true</C>
														<C> name='�ɼǻ�ǰ����'		ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='�ɼǺ���(RV023)'	ID='OPTION_VIEW_CD'width=100 	 align=left editlimit=1 show=true</C>
														<C> name='ȭ��ǥ�ü���'		ID='DISPLAY_SEQ'	width=100  align=left editlimit=4 show=true dec=0</C>
														<C> name='��뿩��'			ID='USE_YN'	 width=100 align=left editlimit=1 show=true</C>
														<C> name='���SID'			ID='SAUP_SID'	width=100  align=left editlimit=12 show=true dec=0</C>
														<C> name='����SID'			ID='UPJANG_SID' width=100 	 align=left editlimit=12 show=true dec=0</C>
														<C> name='�������'			ID='REMARKS'	width=100  align=left editlimit=100 show=true</C>
	
											">
										</object>
										<%=HDConstant.COMMENT_END%>	
										</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
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
<!--------------------------------- �ڵ� �κ� �� -------------------------------->   
    <iframe id="LowerFrame" 
            name="work" 
            style="visibility:hidden; position:absolute; left:280px; top:220px;" 
            Frameborder="0" src="/HDASan/Sales/common/img/flash/loading.swf" 
            width="320px" 
            height="42px">
    </iframe>   
<!---------------------------------- BODY End --------------------------------> 
    </body>
</html>