<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ǰ ���� ���ε� ���/��ȸ
 * ���α׷�ID 	 : ML110I
 * J  S  P		 : ml110i
 * �� �� ��		 : ML110I
 * �� �� ��		 : ���ϳ�
 * �� �� ��		 : 2011-07-14
 * �������		 : ��ǰ���(���� ���ε�, ��ȸ,����)
 * [��  ��   ��  ��][������] ī�װ� ����/��ȸ/���� ���� 2012-01-06 ���ϳ�
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
/*=============================================================================,
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
     //   var v_job = "H";
	    var v_job = "I";	 
		//��ü���� �� : ��ȸ�����ϱ� ���ؼ�		        
     
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description 	:  ������ �ε�
	// Parameter 	:
	%>
	function fnOnLoad(tree_idx){
	
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��		
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
		
		fnInit();
		
			if (excelDs.countrow<1){

			//  ���ε� ��� ����
									
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
	// Description 	: ����ȸ
	// Parameter 	:
	%>
	function fnInit(){
	
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        		
        
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();  //���θ� �ŷ�����1 (����������,�鼼����,������Ʈ)
        
        
       // codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML002&s_item1=Y";
      //  codeDs2.Reset();  ���θ� �ŷ�����2 (2012��,�߼���)      
      
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML003&s_item1=Y";
        ds2.Reset();  
        //����2�� �ڵ尪�� ML002   SELECT HEAD, DETAIL, DETAIL_NM FROM   SALES.TSY010 where head='ML003' ī�װ�����
        
  
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=S&s_Head=ML004&s_item1=Y";
        ds3.Reset();   //������SID
                
               
	}
	
	
	

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
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
// Description 	:  ������ȸ
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
// Description 	:  ����
// Parameter 	:
%>

		/*
		 * ����
		 */
		function fnApply() {
			alert("�������� ������ �ּ���.");
			return;
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ML%>Ml110I",
               	  "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("������Ʈ�� ���� �����ϴ�.");
			};	
		}
		
			

		function fnExcelDs1() {
	        if(excelDs.CountRow==0){
    	        alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������Ʈ ��ǰ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","������Ʈ ��ǰ���.xls", 8);
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
        //ds3.Reset(); //�������ڵ� 
        
        
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

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

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
					<param name="Text"		value="ã�ƺ���">
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
                            			<param name="DataID"		VALUE="excelDs">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="                                      		
                                            <FC> name='ī�װ�'    ID='COL01'          Width=80   align=left    EditStyle=Lookup Data='ds2:detail:detail_nm' editlimit=5 Sort=True</FC>
                                            <FC> name='����2'     ID='COL02'          Width=50   align=left      Edit=Any </FC>
                                            <C> name='�귣��'          ID='COL03'      Width=100   align=left      Edit=Any</C>
                                            <C> name='��ǰ��'          ID='COL04'    Width=200   align=left      Edit=Any</C>
                                            <C> name='������'     ID='COL05'        Width=140    align=left      Edit=Any </C>
                                            <C> name='������'    ID='COL06'     Width=60   align=left        Edit=Any  </C>                    
                                            <C> name='���ǿ���'         ID='COL07'       Width=60  align=Center EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��뿩��'           ID='COL08'             Width=60  align=center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��������ǰ�ڵ�'     ID='COL09'            Width=100   align=left      Edit=Any</C>
                                            <C> name='������SID'     ID='COL10'            Width=80   align=left     editstyle=lookup Data='ds3:detail:detail_nm'  DEC=0 </C>
                                            <C> name='���� ����'     ID='COL11'            Width=80   align=center      EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C> name='��ȭ'     ID='COL12'            Width=50   align=left      Edit=Any </C>
                                            <C> name='�ܰ�'     ID='COL13'            Width=60   align=center     	DEC=0</C>
                                            <C> name='���ް�'     ID='COL14'            Width=60   align=center     DEC=0 </C>
                                            <C> name='�ΰ���'     ID='COL15'            Width=60   align=center     DEC=0</C>
                                            <C> name='������'     ID='COL16'            Width=60   align=center     DEC=0</C>
											<C> name='�ŷ�����'     ID='COL17'            Width=60   align=left   editstyle=lookup  data='codeDs1:detail:detail_nm'   Edit=Any</C>                                            
											<C> name='����'     ID='COL18'            Width=60   align=center      DEC=0</C>                                                 
                                            <C> name='�������'     ID='COL19'            Width=1000   align=left      Edit=Any</C> 
											<C> name='������Ʈ����'     ID='COL20'            Width=80   align=left  editstyle=lookup  data='codeDs2:detail:detail_nm'   Edit=Any</C>                                                   
											<C> name='GARBAGE_SID'  		ID='GARBAGE_SID'  Width=80   align=center  show=false	</C>                                                                                  
										">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
                		    </tr><br>
                		    <tr><td>�� �׼� ��Ʈ�� �̸��� "Sheet1" �̾�� �մϴ�.</td></tr>
  							<tr><td>&nbsp; <font color=blue>* ã�ƺ��� --> �������� --> ����  </font></td></tr>                		    
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

