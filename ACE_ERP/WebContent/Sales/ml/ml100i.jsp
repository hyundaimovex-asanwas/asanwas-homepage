<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ǰ���/��ȸ
 * ���α׷�ID 	 : ML100I
 * J  S  P		 : ml100i
 * �� �� ��		 : ML100I
 * �� �� ��		 : ���ϳ�
 * �� �� ��		 : 2011-01-19
 * �������		 : ��ǰ���(��ȸ,���߰�,����)
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
     
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description 	:  ������ �ε�
	// Parameter 	:
	%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}

	<%
	///////////////////////////////////////////////////////////////////////////////   
	// Description 	: ����ȸ
	// Parameter 	:
	%>
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
  /*        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

 
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=5&s_Head=ML003";
        ds2.Reset(); //ī�װ�Ÿ��
   */     
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML003&s_item1=Y";
        ds2.Reset(); 
        
        ln_SetDataHeader();       
        
/*

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm010I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        */
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	:
%>
    function fnSelect() {
        //window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        //document.all.LowerFrame.style.visibility="visible";
      
        v_job = "S";
           
     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
					+ "v_cate1=" + ds2.namevalue(ds2.rowposition,"detail") ;
     
             //  alert(param);
        ln_TRSetting(tr1, 
   		    "<%=dirPath%><%=HDConstant.PATH_ML%>Ml100I", 
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);


 					        
       
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	:
%>
	function fnAddRow() {
		ds1.addrow();
		gr1.SetColumn("CATE1");
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	:
%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����
// Parameter 	:
%>
	function fnApply() {
        v_job = "I";
        //sSaupSid = drp_saup.ValueOfIndex("saup_sid", drp_saup.Index);
		if (ds1.IsUpdated) {
            if(confirm("�����Ͻðڽ��ϱ�?")){
            /*    for(var i=1; i<=ds1.CountRow; i++){
                    if(ds1.NameValue(i, "UPJANG_CD")==""){
                        alert("������ �ڵ�<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_CD");
                        return;
                    }
                    if(ds1.NameValue(i, "UPJANG_NM")==""){
                        alert("�������<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_NM");
                        return;
                    }
                    if(ds1.NameValue(i, "UPJANG_TYPE_NM")==""){
                        alert("����Ÿ�Ը�<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("UPJANG_TYPE");
                        return;
                    }
                }*/
                
                
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                document.all.LowerFrame.style.visibility="visible";
				ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_ML%>Ml100I",
                    "JSP(I:DEFAULT=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr1);
               
            }
		}
	}
	

	function ln_SetDataHeader(){
	  
	      //��������,��������,��������
		if (ds1.countrow<1){
			var s_temp = " ITEM_SID:DECIMAL(10.0),CATE1:STRING(30),CATE2:STRING(10),BRAND:STRING(30),ITEM_NM:STRING(100),MAKER:STRING(30),"
								 + " MADEIN:STRING(30),DSP_YN:STRING(1),USE_YN:STRING(1),SELLER_CD:STRING(10),SELLER_SID:DECIMAL(10.0),TAX_YN:STRING(1), "
								 + " CURRENCY_CD:STRING(3),AMT_UNIT:DECIMAL(10.0),AMT_NET:DECIMAL(10.0),AMT_VAT:DECIMAL(10.0),AMT_EMP:DECIMAL(10.0),"
								 + " REMARKS:STRING(2000)";
		  ds1.SetDataHeader(s_temp);
		}
}
	
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
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


<!--
    <script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;
            
            gr1.ReDraw = "False";
            if(colid=="UPJANG_TYPE"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "UPJANG_TYPE") = ds1.NameValue(1, "UPJANG_TYPE");
                    ds1.NameValue(i, "UPJANG_TYPE_NM") = ds1.NameValue(1, "UPJANG_TYPE_NM");
                }
            } else if(colid=="DIRECT_YN1") {
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "DIRECT_YN1") = ds1.NameValue(1, "DIRECT_YN1");
                    if(ds1.NameValue(1, "DIRECT_YN1")=="T")
                        ds1.NameValue(i, "DIRECT_YN") = "Y";
                    else 
                         ds1.NameValue(i, "DIRECT_YN") = "N";
               }
            } else if(colid=="USE_YN1" ){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "USE_YN1") = ds1.NameValue(1, "USE_YN1");
                    if(ds1.NameValue(1, "USE_YN1")=="T")
                        ds1.NameValue(i, "USE_YN") = "Y";
                    else 
                         ds1.NameValue(i, "USE_YN") = "N";
               }
            }
            gr1.ReDraw = "True";
            return;
        }
        
        if(colid=="DIRECT_YN1") {
            if(ds1.NameValue(row, "DIRECT_YN1")=="T")
                ds1.NameValue(row, "DIRECT_YN") = "Y";
            else 
                 ds1.NameValue(row, "DIRECT_YN") = "N";
        } else if(colid=="USE_YN1" ){
            if(ds1.NameValue(row, "USE_YN1")=="T")
                ds1.NameValue(row, "USE_YN") = "Y";
            else 
                 ds1.NameValue(row, "USE_YN") = "N";
        }
    </script>
    
    <script language=JavaScript for=ds1 event=onColumnChanged(row,colid)>
        var flag = false;
        if(colid=="UPJANG_TYPE"){
            for(var i=1; i<=ds21.CountRow; i++){
                if(ds21.NameValue(i, "DETAIL")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "UPJANG_TYPE_NM") = ds21.NameValue(i, "DETAIL_NM");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "UPJANG_TYPE_NM") = "";
        }
    </script>


-->
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<!--
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
    }
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>
-->
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table width="100%" height="525" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border=0 cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
							<tr bgcolor="#6f7f8d">
								<td width="100px" align=left class="text">&nbsp;ī�װ�</td>
								<td width="120px" class="text">&nbsp;
								<%=HDConstant.COMMENT_START%>
								<object id=v_cate1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
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
					<td align="right" width="350" style="padding-right:6px"><img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
            			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
            			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
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
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                            <FC> name=''             ID='{CURROW}'           Width=25    align=center Suppress=2</FC>
                                            <C> name='ITEM_SID'          ID='ITEM_SID'      Width=100   align=left      Edit=Any show=false</C>
                                            <FC> name='����1'    ID='CATE1'          Width=100   align=left    EditStyle=Lookup Data='ds2:detail:detail_nm' editlimit=5 Sort=True</FC>
                                            <FC> name='����2'     ID='CATE2'          Width=50   align=left      Edit=Any </FC>
                                            <C> name='�귣��'          ID='BRAND'      Width=100   align=left      Edit=Any</C>
                                            <C> name='��ǰ��'          ID='ITEM_NM'    Width=200   align=left      Edit=Any</C>
                                            <C> name='������'     ID='MAKER'        Width=140    align=left      Edit=Any </C>
                                            <C> name='������'    ID='MADEIN'     Width=60   align=left        Edit=Any  </C>                    
                                            <C> name='���ǿ���'         ID='DSP_YN'       Width=60  align=Center EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��뿩��'           ID='USE_YN'             Width=60  align=center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��������ǰ�ڵ�'     ID='SELLER_CD'            Width=100   align=left      Edit=Any</C>
                                            <C> name='������SID'     ID='SELLER_SID'            Width=80   align=left      Edit=Any show=false</C>
                                            <C> name='���� ����'     ID='TAX_YN'            Width=80   align=center      EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��ȭ'     ID='CURRENCY_CD'            Width=50   align=left      Edit=Any</C>
                                            <C> name='�ܰ�'     ID='AMT_UNIT'            Width=60   align=center      Edit=Numeric</C>
                                            <C> name='���ް�'     ID='AMT_NET'            Width=60   align=center      Edit=Numeric</C>
                                            <C> name='�ΰ���'     ID='AMT_VAT'            Width=60   align=center      Edit=Numeric</C>
                                            <C> name='������'     ID='AMT_EMP'            Width=60   align=center     Edit=Numeric</C>
                                            <C> name='�������'     ID='REMARKS'            Width=1000   align=left      Edit=Any</C>
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
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

