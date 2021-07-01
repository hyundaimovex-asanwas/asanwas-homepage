<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���� ���ε� ȭ��
 * ���α׷�ID 	 : PMS/Itm
 * J  S  P		 : Bud025.jsp
 * �� �� ��		 : Bud025
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-07-19
 * �������		 : ���� ���ε� ȭ��
 *****************************************************************************/
%>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<jsp:include page="/Pms/common/include/head.jsp"/>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
    SmartRequest sr = new SmartRequest(request);
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	
%>



<!-- HTML ����-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
	<jsp:include page="/Pms/common/include/head.jsp"/>

	

    
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
    
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		//fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		alert("1");
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//list detail

		fnInit();

	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
        
    	strParam=window.dialogArguments;

		document.getElementById("v_project").value 		= strParam[0];				//Project Code
		document.getElementById("v_project_nm").value 	= strParam[1];				//Project ��
		document.getElementById("v_no_budget").value 	= strParam[2];				//��������   
	    
        //fnSelect();
        
    }
    
    
    <%//�⺻ ��ȸ  %>
    function fnSelect() {
    	
   	 	v_job="S";
   	 

   	 	
   	 	//������ �־��ֱ� 
	   	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								    		+ ",v_project=" + document.getElementById("v_project").value 
								    		+ ",v_no_budget=" + document.getElementById("v_no_budget").value	   	
									   		;
	   	

	   	
	   	
	   	
	   	ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud025",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);
  	
	   	
        tr_post(tr1);
		        
		        
    }
    
    


    
    
    
    
    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�   		*
     ********************************************/
    function fnc_OnLoadProcess() {

		//cfStyleGrid_New(form1.ds_default,15,"true","true");      // Grid Style ����
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//list detail
		
        document.getElementById("txtPIS_YM_SHR").value = gcurdate.substring(0,7);  //getTodayArray()[0]+"-"+getTodayArray()[1];

    }
    
    /********************************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
     ********************************************/
    function fnc_SearchList() {

        //�̰��� �ش� �ڵ��� �Է� �ϼ���

        //�˻�����
        //var PIS_YM_SHR    	= document.getElementById("txtPIS_YM_SHR").value;

        //�����ͼ� ����
        ds_default.UseChangeInfo = true;
        ds_default.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.wel.n.weln030.cmd.WELN030CMD&S_MODE=SHR&PIS_YM_SHR="+PIS_YM_SHR;
        ds_default.Reset();

    }
    
    
    /*****************************
     * 17. �������� ���ε� ó��  *
     ****************************/
     function fnc_FileUpload() {
    	
        var oFile_url = null;						//���� url 	-> c:\User\admin\Desktop\zx.xlsx		c:\User\admin\Desktop\zx.xls
        var oFile_name = null;						//���� �̸�    	-> xz.xlsx								xz.xls
        var oFile_name_pieces = new Array();		//�����̸�		->23.123.42.xlsx						23.123.42.xlsx
        var extensions	= null;						//�����̸�[0]  -> xz			Ȯ���ڸ�[1] -> xlsx		xls
        var extension = null;						//Ȯ���ڸ�		-> xlsx		xls
        /* gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file1.value;
		gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL") = file1.value; */
		
        var file1 = document.getElementById("file1").value;		//file1�̶�� id���� value�� �����´�.
        alert("file1==="+file1);
        
        
       

/*         fcFILE_UPLOAD.Open();

        //Ȯ���� Ŭ���ߴ��� ���� ����
        if(fcFILE_UPLOAD.SelectState != true)
            return false; */
            
            
        oFile_url = document.getElementById("file1").value;
            
        oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);
        //extName = oFile_url.substring(pathMiddle+1, filepath);
        //alert("extName==="+extName);
        alert("oFile_name==="+oFile_name); 

        
        oFile_name_pieces = oFile_name.split(/[\s.]+/);
        alert("oFile_name_pieces==="+oFile_name_pieces);
        
        
        extension = oFile_name_pieces[oFile_name_pieces.length-1];
        alert("Ȯ���ڸ�==="+extension);
        
        //zx.xlsx		zx.xls
        
        //pathMiddle = oFile_name.lastIndexOf(".");
        //extensions = oFile_name.split(".");		//���� �̸�����    . �� �������� �迭���ٰ� ���� ����ش�.
        //extension = extensions[1];		//Ȯ���ڸ�
        
           
            /* 
            extension=extension[1];
            
            extensionName = oFile_name.substring(pathMiddle+1, filepath);
            alert(extensionName);
         */
        


        //alert("extension==="+extension);


        // �ش� Dataset�� Header�� ������ Header ����
        if (dsFILE_UPLOAD.CountColumn < 1) {
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
        }

        dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

        dsFILE_UPLOAD.ClearData();
        dsFILE_UPLOAD.AddRow();
        dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
        dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

        if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

            trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:ds_default=ds_default, O:dsRESULT=dsRESULT)";
            trFILE_UPLOAD.action   = "/HDAsan/servlet/GauceChannelSVL?cmd=pms.news.bud.excel.Bud025Excel&S_MODE=ULD&extension="+extension;
            //trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.wel.n.weln030.cmd.WELN030CMD&S_MODE=ULD";
            
            alert("trFILE_UPLOAD.action==="+trFILE_UPLOAD.action);
            
            
            trFILE_UPLOAD.post();
        }

    }
    
    
</script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

    
</script>


<script language=JavaScript for=tr1 event=OnFail()>

alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
 	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
 	
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

	</script> 
	
	<!-- �����߰� -->
	<Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
            	alert("�����...?��");
                //alert(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>
    
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=ds_default Event="OnLoadCompleted(iCount)">
    alert(iCount);
    if (iCount == 0) {
    	alert("������ ��ȸ ������1");
    	fnc_Message(document.getElementById("resultMessage"), "MSG_02");
    } else {
    	alert("������ ��ȸ ������2");

        alert(document.getElementById("resultMessage"));

		for(i=1;i<=iCount;i++){
            ds_default.UserStatus(i) = 1;
        }
    }
    
    
       /*  if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                ds_default.UserStatus(i) = 1;
            }
        } */
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=ds_default Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        //cfErrorMsg(this);
        alert("����?");
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=ds_default Event="OnDataError()">
        //Dataset���� Error ó��
        //cfErrorMsg(this);
        alert("����?");
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_WELCARD event="OnSuccess()">
	alert("2");
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<script for=trT_WL_WELCARD_END event="OnSuccess()">
		alert("���������� �����Ǿ����ϴ�");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_WELCARD event="OnFail()">
        alert(trT_WL_WELCARD.ErrorMsg);
    </script>
    <script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>

 	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=ds_default event=CanRowPosChange(row)>
		if ( ds_default.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + ds_default.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}

	</script>
	<script language="javascript" for="gcip_file" event=OnClick()>
		if (fn_trim(gcip_file.value)!="") {
			file1.value = gcip_file.value;
		}
	</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<%-- <object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object> --%>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>



<!-- �����߰� -->
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								|
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_CARDUP)			|
    | 3. ���Ǵ� Table List(T_WL_CARDUP) 				   |
    +------------------------------------------------------>
	<Object ID="ds_default" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trT_WL_WELCARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:ds_default=ds_default,I:ds_default=ds_default)">
	</Object>

	<Object ID="trT_WL_WELCARD_END" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:ds_default=ds_default,I:ds_default=ds_default)">
	</Object>

    <!-- ��� result -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"  value="true">
    </object>

    <!-- Ʈ������ ������Ʈ ���� [���� ÷�ο�] -->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name="KeyName"   value="dataid">
    </Object>
    
    
    <OBJECT id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>


</head>


<!-- //body_s.jsp -->
<jsp:include page="/Common/sys/body_s11.jsp"/>
<!-- //body_s.jsp -->

<!--------------------------------- �ڵ� �κ� ���� ------------------------------>


<!-- form ���� -->
<form name="form1">
     
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=right>

                        </td>								
                    </tr>
                </table>
            </td>
        </tr>
	<tr><td height=4></td></tr>
</table>
        
  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>        
        
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
            <td class="r">
				<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
					<tr>
						<td align="center" class="text" width="80">������Ʈ</td>
 						<td bgcolor='#ffffff' >&nbsp;
						    <input type="text"  name='v_project'   		id='v_project'  	style="width:70px;"   	class='input01' readOnly="readonly">
						    <input type="text"  name='v_project_nm'   	id='v_project_nm'  	style="width:200px;"   	class='input01' readOnly="readonly">			    
						</td>		
						<td align="center" class="text" width="80">��������</td>
						<td bgcolor='#ffffff' >&nbsp;
						    <input type="text"  name='v_no_budget'   id='v_no_budget'  style="width:50px;" class='input01'  readOnly="readonly">
						</td>		
					</tr>
				</table>           		
            </td>	
	</tr>
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
        
	<!-- <tr>
            <td class="r">
				<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
					<tr>
						<td  width="150px" bgcolor='#FFFOFO' align=center>��������</td>
						<td  width="700px" bgcolor='#FFFOFO'>&nbsp;
						<input type="text" name="file1" id="file1" style="width:690px;" value="" readonly  class=textbox> </td>
						<td  width="150px" bgcolor='#FFFOFO' style="padding-left:8px">
			                  <div style="position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;">
			                  <input type='file' name='file_nm' id='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:19;filter:alpha(opacity=0);"></div>
					   </td>
					</tr>
				</table>
				
				 <table width="1000" border="0" cellspacing="0" cellpadding="0">
			    	<tr>
			    		<td class="paddingTop8">
			    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			    				<tr>
			                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
			
			                        <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
			                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
			                        </td>
			    				</tr>
			    			</table>
			    		</td>
			    	</tr>
			    </table>           		
            </td>	
	</tr> -->
	
	<tr>
            <td class="r">
				<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
					<tr>
						<td  width="100px" bgcolor='#FFFOFO' align=center>��������</td>
						<td  width="700px" bgcolor='#FFFOFO'>&nbsp;
							<input type="text" name="file1" id="file1" style="width:600px;" value="" readonly  class=textbox> </td>
							
						<td  width="200px" bgcolor='#FFFOFO' style="padding-left:8px">
							<!-- <OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:4px;width:70;height:20"  >
								<param name="Text"		value="ã�ƺ���">
							</OBJECT> -->
							<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a> -->
							
							<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:10px;width:70;height:20"  >
								<param name="Text"		value="ã�ƺ���">
							</OBJECT>&nbsp;&nbsp;
							
							<img src="<%=dirPath%>/Sales/images/upload.gif" name="btnUPLOAD" width="66" height="20" border="0" align="absmiddle" style="position:relative;top:10px;" onClick="fnc_FileUpload()">
			                  <!-- <div style="position:relative;left:0px;top:0px;height:19;width:40;background-image:url(http://www.mtkumgang.com/asanway/img/tour_img/btn/btn_s_filesch.gif);background-repeat:no-repeat;"> -->
			                  
			                  <input type='file' name='file_nm' id='file_nm' onChange="this.form.file1.value=this.value" style="width:40;height:19;filter:alpha(opacity=0);"></div>
					   </td>
					</tr>
				</table>  
				
				<%-- <table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
					<tr width="876px"> 
						<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
						<td class="tab18" style="width:750px;"><nobr>&nbsp;
								<input type="text" name="file_path" value="" style="position:relative;top:-2px;width:350px;" >&nbsp;
								<comment id="__NSID__">
								<OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="position:relative;top:4px;width:70;height:20"  >
									<param name="Text"		value="ã�ƺ���">
								</OBJECT>&nbsp;
								<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a> -->
								<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="position:relative;top:3px;cursor:hand;"  onClick="ln_Excel_Apply()">
								<img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()">
								</comment><script>__ws__(__NSID__);</script>  
								</nobr>
						</td> 
					</tr>
			 </table> --%>
				
				         		
            </td>	
	</tr>         
        
  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
  
        <tr>
            <td valign="top" style="position:relative;left:10px">
                <object id="gr_default" classid=<%=HDConstant.MxGrid_CLSID_S%>" width='1000px' height='500px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="ColSizing"         	value="true">
                    <param name="Editable"          	value="true">
                    <param name="SuppressOption"    	value="1">
                    <param name="BorderStyle"       	value="0">
                    <param name=ColSelect    			value="True">
                    <param name="Format"           		value="
                    
                    	<C> id='DS_KSITEM1'			name='1'			width=100			align=left</C>
                    	<C> id='DS_KSITEM2'			name='2'			width=100			align=left</C>
                    	<C> id='DS_KSITEM3'			name='3'			width=100			align=left</C>
                    	<C> id='DS_KSITEM4'			name='4'			width=100			align=left</C>
	                    
	                    <C> id='CD_COST'			name='CODE'			width=120			align=left</C>
	                    <C> id='COST_YN'			name='ITEM' 		width=60			align=center	value={decode(COST_YN,'N',,'Y','Y', )}</C>
	                    <C> id='ORDER_AMT'			name='�ݾ�'			width=80			align=right decao = 0 </C>

	                    <C> id='EXE_ACT_QN'			name='����'			width=80			align=center decao = 0 </C>
	                    <C> id='EXE_ACT_UP'			name='�ܰ�'			width=80			align=right decao = 0 </C> 
	                    <C> id='EXE_ACT_AMT'		name='�ݾ�'			width=80			align=right decao = 0 </C> 

                 ">                             
                </object>
 		    </td>
        </tr>

    </table>
    
</form>
<!-- form �� -->

    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		