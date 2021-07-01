<!--
***********************************************************************
* @source      : find_empno.jsp
* @description : ���������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/08/08            �̵���            	ERP �̻�									 *
***********************************************************************
-->
<%@ page import="security.common.*" %>
<%@ page contentType="text/html;charset=euc-kr"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>



<html>

<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>���������ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="../../../Ehr/common/common.js"></script>	    

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

    
        var retObj = window.dialogArguments;
        
        //��ȯ�� ����Ÿ �ʱ�ȭ
        retObj.eno_no ='';
        retObj.eno_nm ='';        
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
    		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_enono=" + document.getElementById("txtENO_NO").value;
    		
    	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Find_empno",  "JSP(O:dsT_CM_PERSON=dsT_CM_PERSON)",  param);

    	    tr_post(tr1);            

        }


</script>

</head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     	|
    | 2. �̸��� ds_ + �ֿ� ���̺��()      			|
    | 3. ���Ǵ� Table List()             				|
    +----------------------------------------------->
	<object  id=dsT_CM_PERSON classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" 				VALUE="false">
	    <Param Name="UseChangeInfo"   			Value="True">
	    <Param Name="ViewDeletedRow"  		Value="False">
	</object>
	
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
	<comment id="__NSID__">
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="KeyName"    		value="toinb_dataid4">
	    <param name="ServerIP"   			value="">
	    <param name="Action"     			value="">
	    <param name="KeyValue"   			value="">
	    <param name="Parameters" 			value="">
	</object>
	</comment><script>__ws__(__NSID__);</script>	
	
	
    <!--*************************************
    *                                       		*
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       		*
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');

		//alert(retObj.eno_no);
		//alert(retObj.eno_nm);  
		
		window.returnValue = retObj.eno_no +";"+ retObj.eno_nm;		

        window.close();

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=gcgd_disp01 event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        
		//prompt(this, retObj);
        
        window.close();

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body>

<br><br>

<!-- ��ư ���̺� ���� -->
<table width="435px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnc_SearchList();">
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<br>

<!-- power Search���̺� ���� -->
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:435px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="100px;" class="tab25"  bgcolor="#eeeeee" align=center>��� ��ȣ/����&nbsp;</td> 
		<td class="tab24" >&nbsp;
                   <input name="txtENO_NO" id="txtENO_NO" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
		</td>	
	</tr>
</table>
<!-- power Search���̺� �� -->

<br>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="435" border="0" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
		<tr> 
			<td>
				<comment id="__NSID__">
							<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:435px; height:350px; border:1 solid #708090;display:block;" viewastext>
									<param name="DataID"		 		value="dsT_CM_PERSON">
									<param name="IndWidth"		 	value='0'>
									<param name="BorderStyle"  		value="0">
									<param name="Fillarea"		 		value="true">
									<param name="Sortview"		 		value="left">
									<param name="ColSizing"	 		value="true">
									<param name="Editable"		 		value="False"> 
									<param name=TitleHeight      		value="20">
				                    <param name="SuppressOption"   value="1">						
									<param name="Format"	 	 		value=" 
                                    <C> id=HEAD_NM           width=100  name=����   align=left   </C>
                                    <C> id=DPT_NM             width=90    name=�μ�   align=left   </C>
                                    <C> id=JOB_NM             width=80    name=����   align=left   </C>
                                    <C> id=ENO_NO             width=80    name=���   align=center </C>
                                    <C> id=ENO_NM             width=80    name=����   align=center </C>
									">
							</object>
					</comment><script>__ws__(__NSID__);</script>
              </td>
       </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">* �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->


</body>
</html>

