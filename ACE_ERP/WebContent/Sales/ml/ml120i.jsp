<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ǰ���/��ȸ
 * ���α׷�ID 	 : ML120I
 * J  S  P		 : ml120i
 * �� �� ��		 : ML120I
 * �� �� ��		 : ���ϳ�
 * �� �� ��		 : 2011-07-25
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


   
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();  //���θ� �ŷ�����1
        
        
       // codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML002&s_item1=Y";
      //  codeDs2.Reset();        //���θ� �ŷ�����2 

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML003&s_item1=Y";
        ds2.Reset();  
        //����2�� �ڵ尪�� ML002   SELECT HEAD, DETAIL, DETAIL_NM FROM   SALES.TSY010 where head='ML003'
  
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML004&s_item1=Y";
        ds3.Reset();       
      
      
      
 //           ln_TRSetting(tr1, 
//            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml120I",
//            "JSP(O:DEFAULT5=ds3)",
//            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
//        tr_post(tr1);        
                 
           
        ln_SetDataHeader();      
      

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
					+ "sTrGu=" + codeDs1.namevalue(codeDs1.rowposition,"detail")+ "," 
					+ "sTrGu2=" + codeDs2.namevalue(codeDs2.rowposition,"detail")+ ","                    
					+ "v_cate1=" + ds2.namevalue(ds2.rowposition,"detail") ;
     
     //         alert(param);
        ln_TRSetting(tr1, 
   		    "<%=dirPath%><%=HDConstant.PATH_ML%>Ml120I",
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
                    "<%=dirPath%><%=HDConstant.PATH_ML%>Ml120I",
                    "JSP(I:DEFAULT=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr1);
               
            }
		}
	}
	

	function ln_SetDataHeader(){
	  
	
		if (ds1.countrow<1){
			var s_temp = " ITEM_SID:DECIMAL(10.0),ML_GUBN:STRING(2), ML_GUBN2:STRING(3),CATE1:STRING(30),CATE2:STRING(10),BRAND:STRING(30),ITEM_NM:STRING(100),MAKER:STRING(30),"
								 + " MADEIN:STRING(30),DSP_YN:STRING(1),USE_YN:STRING(1),SELLER_CD:STRING(10),SELLER_SID:DECIMAL(10.0),TAX_YN:STRING(1), "
								 + " CURRENCY_CD:STRING(3),AMT_UNIT:DECIMAL(10.0),AMT_NET:DECIMAL(10.0),AMT_VAT:DECIMAL(10.0),AMT_EMP:DECIMAL(10.0),"
								 + " AMT_COST:DECIMAL(10,0),REMARKS:STRING(2000)";
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

	<script language=JavaScript for=sTrGu event=OnSelChange()>
	
        //    ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_SaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&s_UpjangType=10&s_use_yn=Y";
        //ds3.Reset(); //�������ڵ� 
        
        
        codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML002&s_item1=Y&s_item2="+codeDs1.namevalue(codeDs1.RowPosition, "detail")+" ";
        codeDs2.Reset();
                    
	</script>   	
	

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

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		



            		            


	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td align="right" width="350" style="padding-right:6px">
										<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
				            			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
				            			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
				            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
				            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
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
							
		                        <td align="center" width="90px" height="30px" class="text">�ŷ�����</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=180 width=123 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								
		                        <td align="center" width="90px" height="30px" class="text">�ŷ�����2</td>
								<td align="left" bgcolor="#ffffff">&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=180 width=150 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								
		                        <td align="center" width="90px" height="30px" class="text">ī�װ�</td>
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
											<C> name='�ŷ�����'     ID='ML_GUBN'     editstyle=lookup  data='codeDs1:detail:detail_nm'        Width=60   align=left      Edit=Any</C>                                            
											<C> name='������Ʈ����'     ID='ML_GUBN2'            editstyle=lookup  data='codeDs2:detail:detail_nm'  Width=120   align=left      Edit=Any</C>                                                
                                            <FC> name='����1'    ID='CATE1'          Width=100   align=left    EditStyle=Lookup Data='ds2:detail:detail_nm' editlimit=5 Sort=True</FC>
                                            <FC> name='����2'     ID='CATE2'          Width=50   align=left      Edit=Any </FC>
                                            <C> name='�귣��'          ID='BRAND'      Width=100   align=left      Edit=Any</C>
                                            <C> name='��ǰ��'          ID='ITEM_NM'    Width=200   align=left      Edit=Any</C>
                                            <C> name='������'     ID='MAKER'        Width=140    align=left      Edit=Any </C>
                                            <C> name='������'    ID='MADEIN'     Width=60   align=left        Edit=Any  </C>                    
                                            <C> name='���ǿ���'         ID='DSP_YN'       Width=60  align=Center EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��뿩��'           ID='USE_YN'             Width=60  align=center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��������ǰ�ڵ�'     ID='SELLER_CD'            Width=100   align=left      Edit=Any</C>
                                            <C> name='������SID'     ID='SELLER_SID'      editstyle=lookup Data='ds3:detail:detail_nm'      Width=80   align=left      Edit=Any </C>
                                            <C> name='���� ����'     ID='TAX_YN'            Width=80   align=center      EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��ȭ'     ID='CURRENCY_CD'            Width=50   align=left      Edit=Any</C>
                                            <C> name='�ܰ�'     ID='AMT_UNIT'            Width=60   align=center      DEC=0</C>
                                            <C> name='���ް�'     ID='AMT_NET'            Width=60   align=center      DEC=0</C>
                                            <C> name='�ΰ���'     ID='AMT_VAT'            Width=60   align=center      DEC=0</C>
                                            <C> name='������'     ID='AMT_EMP'            Width=60   align=center     DEC=0c</C>                                            
                                            <C> name='����'     ID='AMT_COST'            Width=60   align=center     DEC=0</C>                                                                                    
                                            <C> name='�������'     ID='REMARKS'            Width=600   align=left      Edit=Any</C>
                            			">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
                		    </tr>
                		</table>
                    </td>
                </tr>
            </table>
        
    



<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

