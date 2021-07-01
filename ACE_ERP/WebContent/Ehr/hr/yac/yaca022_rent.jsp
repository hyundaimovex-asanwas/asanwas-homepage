<!--*************************************************************************
* @source      : yaca022_rent.jsp                                                *
* @description : ������ �ҵ���� ���� �ۼ� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2014/01/09           �̵���             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
     String ROLE_CD = box.getString("SESSION_ROLE_CD");
     String YAC_AUTHO    = box.getString("SESSION_YAC_AUTHO");

     String PIS_YY       = request.getParameter("PIS_YY");     
     String ENO_NO       = request.getParameter("ENO_NO");
     String ENO_NM       = request.getParameter("ENO_NM");
     String DPT_NM       = request.getParameter("DPT_NM");
     String JOB_NM       = request.getParameter("JOB_NM");

     if(ENO_NO == null){
	      ENO_NO       = box.getString("SESSION_ENONO");
	      ENO_NM       = box.getString("SESSION_ENONM");
	      DPT_NM       = box.getString("SESSION_DPTNM");
	      JOB_NM       = box.getString("SESSION_JOBNM");
     }          

     //ROLE_CD�� IT���� ����
     boolean itMaster = false;

     if(ROLE_CD.equals("1001")) {
     itMaster = true;
     }

%>


<html>
<head>
    <title>������ �ҵ���� ���� �ۼ�(yaca022_2013�⵵)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
		var opener = window.dialogArguments;

        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "T"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD";
        var params = null;

        //�Ѿ�� ������ ó��
        var TYPE = "<%=request.getParameter("TYPE") %>";
        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
        var CET_NO = "<%=request.getParameter("CET_NO") %>";
        var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
        var DPT_NM = "<%=request.getParameter("DPT_NM") %>";
        var JOB_NM = "<%=request.getParameter("JOB_NM") %>";        
        
        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
        	
			var PIS_YY   = document.form1.txtPIS_YY_SHR.value;
			var ENO_NO  = document.form1.txtENO_NO_SHR.value;			
			
			dsT_AC_RENT.dataid = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD&S_MODE=SHR_RENT&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
			dsT_AC_RENT.reset();
			
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

            //�� ��ȿ�� ����
            //if(!fnc_SaveItemCheck()) return;

			// save
			trT_AC_RENT.Parameters = "PIS_YY="+PIS_YY+",ENO_NO="+ENO_NO;					
			trT_AC_RENT.KeyValue = "tr01(I:dsT_AC_RENT=dsT_AC_RENT)";
			trT_AC_RENT.action = "/servlet/GauceChannelSVL?cmd=hr.yac.a.yaca021.cmd.YACA021CMD&S_MODE=SAV_RENT";
			trT_AC_RENT.post();   
			
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {

        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

			document.form1.txtPIS_YY_SHR.value = '<%=PIS_YY%>';
			document.form1.txtENO_NO_SHR.value = '<%=ENO_NO%>';
            document.form1.txtENO_NM_SHR.value = '<%=ENO_NM%>';
            document.form1.txtDPT_NM_SHR.value = '<%=DPT_NM%>';
            document.form1.txtJOB_NM_SHR.value = '<%=JOB_NM%>';        	
        	
			cfStyleGrid(form1.grdT_AC_RENT, 15, "false","false");      // Grid Style ����            

            fnc_SearchList();					
			
            if (dsT_AC_RENT.Countrow < 1) {
                //dsT_AC_RENT.setDataHeader("PIS_YY:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, HOST_NM:STRING, CET_NO:STRING, ADDRESS:STRING, AMOUNT:NUMBER, CON_YMD:STRING, DUE_YMD:STRING");
            	
            	dsT_AC_RENT.AddRow();
    			document.form1.medAMOUNT.text = "0";        
           	
            }				
		
	

        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {

        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        	
        }


    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       			|
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RENT)                	|
    | 3. ���Ǵ� Table List(T_AC_RENT)                  			|
    +------------------------------------------------------>
    <Object ID="dsT_AC_RENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>



    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RENT)                |
    | 3. ���Ǵ� Table List(T_AC_RENT)                      	|
    +------------------------------------------------------>
    <Object ID="trT_AC_RENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RENT Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�

        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RENT Event="OnLoadError()">
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RENT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RENT event="OnSuccess()">
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RENT event="OnFail()">
        cfErrorMsg(this);
        window.close();
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">������</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="620px" border="0" cellspacing="0" cellpadding="0">
		<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="40"></col>
							<col width="50"></col>
                            <col width="130"></col>
                            <col width="50"></col>
                            <col width="70"></col>
                            <col width="50"></col>
							<col width=""></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
							<td class="padding2423">
                               <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>
							</td>
                            <td align="right" class="searchState">���&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength= "8" class="input_ReadOnly" readonly>
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="8" maxlength= "10" class="input_ReadOnly" readonly>
                            </td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="15" class="input_ReadOnly" readonly>
							</td>
                            <td class="searchState" align="right">����&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id=txtJOB_NM_SHR name=txtJOB_NM_SHR size="10" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="620px" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="100"></col>
                        <col width="240"></col>
                        <col width="100"></col>                                                                 
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">�Ӵ��μ���</td>
                        <td class="padding2423">
                            <input id="txtNAM_KOR" maxlength="5" style="width:30%">
                        </td>
                        <td align="center" class="creamBold">�ֹε�Ϲ�ȣ</td>
                        <td class="padding2423">
                            <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="changeCetTag()">
                        </td>
                      </tr>                    
                    <tr>
                        <td align="center" class="creamBold">�����ּ���</td>
						<td class="padding2423" align="left">
                            <input id="txtADDRESS" style="width:100%"">
						</td>                    
                        <td align="center" class="creamBold">�����Ѿ�</td>
                        <td class="padding2423" >
                            <comment id="__NSID__">
                            <object id="medAMOUNT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false">
                                <param name=Alignment               		value=2>
                                <param name=Border                  		value=true>
                                <param name=ClipMode                		value=true>
                                <param name=DisabledBackColor       	value="#EEEEEE">
                                <param name=Enable                  		value=true>
                                <param name=IsComma                 	value=true>
                                <param name=Language                	value=0>
                                <param name=MaxLength               	value=8>
                                <param name=Numeric                 		value=true>
                                <param name=NumericRange            	value=0~+:0>
                                <param name=ShowLiteral             		value=false>
                                <param name=Visible                 		value=true>
                                <param name=SelectAll               		value="true">
                            </object>
                            </comment>
                            <script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                       </tr>
                       
                    <tr>
                        <td align="center" class="creamBold">��������</td>
                        <td class="padding2423" >
                        <input type="text" id="txtCON_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCON_YMD','','100','200');" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">���������</td>
                        <td class="padding2423">
                        <input type="text" id="txtDUE_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUE_YMD','','410','200');" style="cursor:hand;">
                        </td>
                    </tr>                       
                </table>
			</td>
		</tr>
	</table>

	<!-- ���� �Է� ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="280"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
					<comment id="__NSID__">
					<object id="grdT_AC_RENT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:620px;height:130px;">
						<param name="DataID" 						value="dsT_AC_RENT">
						<param name="Editable" 						value="true">
						<param name="DragDropEnable" 			value="true">
						<param name="SortView" 						value="Left">
						<param name="VIEWSUMMARY"				value=0>						
						<param name="Format" 						value='
							<C> id={currow}					width=20    name="NO"		                		align=center  	</C>
                            <C> id="HOST_NM"				width=70	name="�Ӵ��μ���"		    		align=center  	</C>
							<C> id="CET_NO"					width=80	name="�ֹε�Ϲ�ȣ"		    		align=center 	</C>
                          	<C> id="ADDRESS"				width=180	name="�Ӵ�����༭���ּ���"	   	align=left	</C>
                            <C> id="AMOUNT"				width=90	name="�����Ѿ�"		    			align=right	  RightMargin="10"  	</C>
							<C> id="CON_YMD"				width=70	name="��������"		    		align=center 	</C>
                          	<C> id="DUE_YMD"				width=70	name="���������"	   				align=center	</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    </form>
    <!-- form �� -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_RENT ���� ���̺� -->
	<object id="bndT_AC_RENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_RENT">
		<Param Name="BindInfo", Value="
			<C>Col=HOST_NM		Ctrl=txtNAM_KOR			Param=value </C>
            <C>Col=CET_NO			Ctrl=txtCET_NO			Param=value </C>
            <C>Col=ADDRESS			Ctrl=txtADDRESS			Param=value </C>
            <C>Col=AMOUNT			Ctrl=medAMOUNT			Param=text </C>
            <C>Col=CON_YMD		Ctrl=txtCON_YMD			Param=value </C>
            <C>Col=DUE_YMD			Ctrl=txtDUE_YMD			Param=value </C>       
		">
	</object>


