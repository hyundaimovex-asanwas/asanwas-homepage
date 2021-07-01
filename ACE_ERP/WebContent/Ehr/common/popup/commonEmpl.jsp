<!--
***********************************************************************
* @source      : commonEmpl.jsp
* @description : ���������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/04/28            �̵���            	ERP �̻�									 *
***********************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>

    <head>
    <title>���������ȸ(commonEmpl)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/result.js"></script>	    
    <script language=javascript src="../../common/common.js"></script>
    <script language="javascript" src="../../common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

    
        var retObj = window.dialogArguments;
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����

            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR00"
									                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
									                                 + "&DPT_CD="+document.getElementById("hidEMPL_DPT_CD").value
									                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
									                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
									                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
									                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
									                                 ;
            
            //prompt(this, dsT_CM_PERSON.DataID);
            dsT_CM_PERSON.reset();


        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {


        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ ���� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style ����

            document.getElementById("txtENO_NO_SHR").value  = retObj.eno_nm;
            document.getElementById("hidEMPL_DPT_CD").value = retObj.dpt_cd;
            document.getElementById("hidGBN_CD").value      = retObj.gbn_cd;
            document.getElementById("hidRET_CD").value      = retObj.ret_cd;
            document.getElementById("hidSTR_YMD").value     = retObj.str_ymd;
            document.getElementById("hidEND_YMD").value     = retObj.end_ymd;

            if (retObj.eno_nm != "") {
                fnc_SearchList();
            }else{//�Ѿ�� �����Ͱ� ������ ��Ŀ���� �˻������� ����. 
                document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus
            }


            //��ȯ�� ����Ÿ �ʱ�ȭ
            retObj.eno_no ='';
            retObj.eno_nm ='';
            retObj.occ_cd ='';
            retObj.occ_nm ='';
            retObj.dpt_cd ='';
            retObj.dpt_nm ='';
            retObj.job_cd = '';
            retObj.job_nm = '';
            retObj.head_cd = '';
            retObj.head_nm = '';
            retObj.cet_no  = '';
            retObj.mf_tag  = '';
            retObj.hirg_ymd = '';
            retObj.hir_ymd  = '';
            retObj.ret_ymd  = '';
            retObj.ram_ymd  = '';
            retObj.ram_ymd2 = '';
            retObj.ram_ymd3 = '';
            retObj.dpa_ymd  = '';
            retObj.mid_ymd1 = '';
            retObj.mid_ymd2 = '';
            retObj.mid_ymd3 = '';
            retObj.hirr_ymd = '';
        }
        
        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺���()      |
    | 3. ���Ǵ� Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //�˻� 1���ǿ� Focus

        } else {

            //fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        retObj.occ_cd   = dsT_CM_PERSON.NameValue(row,'OCC_CD');
        retObj.occ_nm   = dsT_CM_PERSON.NameValue(row,'OCC_NM');
        retObj.dpt_cd   = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        retObj.dpt_nm   = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        retObj.job_cd   = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        retObj.job_nm   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        retObj.head_cd  = dsT_CM_PERSON.NameValue(row,'HEAD_CD');
        retObj.head_nm  = dsT_CM_PERSON.NameValue(row,'HEAD_NM');
        retObj.cet_no   = dsT_CM_PERSON.NameValue(row,'CET_NO');
        retObj.mf_tag   = dsT_CM_PERSON.NameValue(row,'MF_TAG');
        retObj.hirg_ymd = dsT_CM_PERSON.NameValue(row,'HIRG_YMD');
        retObj.hir_ymd  = dsT_CM_PERSON.NameValue(row,'HIR_YMD' );
        retObj.ret_ymd  = dsT_CM_PERSON.NameValue(row,'RET_YMD' );
        retObj.ram_ymd  = dsT_CM_PERSON.NameValue(row,'RAM_YMD' );
        retObj.ram_ymd2 = dsT_CM_PERSON.NameValue(row,'RAM_YMD2');
        retObj.ram_ymd3 = dsT_CM_PERSON.NameValue(row,'RAM_YMD3');
        retObj.dpa_ymd  = dsT_CM_PERSON.NameValue(row,'DPA_YMD' );
        retObj.mid_ymd1 = dsT_CM_PERSON.NameValue(row,'MID_YMD1');
        retObj.mid_ymd2 = dsT_CM_PERSON.NameValue(row,'MID_YMD2');
        retObj.mid_ymd3 = dsT_CM_PERSON.NameValue(row,'MID_YMD3');
        retObj.hirr_ymd = dsT_CM_PERSON.NameValue(row,'HIRR_YMD');
        
        window.close();

    </script>

    <!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        retObj.occ_cd   = dsT_CM_PERSON.NameValue(row,'OCC_CD');
        retObj.occ_nm   = dsT_CM_PERSON.NameValue(row,'OCC_NM');
        retObj.dpt_cd   = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        retObj.dpt_nm   = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        retObj.job_cd   = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        retObj.job_nm   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        retObj.head_cd  = dsT_CM_PERSON.NameValue(row,'HEAD_CD');
        retObj.head_nm  = dsT_CM_PERSON.NameValue(row,'HEAD_NM');
        retObj.cet_no   = dsT_CM_PERSON.NameValue(row,'CET_NO');
        retObj.mf_tag   = dsT_CM_PERSON.NameValue(row,'MF_TAG');
        retObj.hirg_ymd = dsT_CM_PERSON.NameValue(row,'HIRG_YMD');
        retObj.hir_ymd  = dsT_CM_PERSON.NameValue(row,'HIR_YMD' );
        retObj.ret_ymd  = dsT_CM_PERSON.NameValue(row,'RET_YMD' );
        retObj.ram_ymd  = dsT_CM_PERSON.NameValue(row,'RAM_YMD' );
        retObj.ram_ymd2 = dsT_CM_PERSON.NameValue(row,'RAM_YMD2');
        retObj.ram_ymd3 = dsT_CM_PERSON.NameValue(row,'RAM_YMD3');
        retObj.dpa_ymd  = dsT_CM_PERSON.NameValue(row,'DPA_YMD' );
        retObj.mid_ymd1 = dsT_CM_PERSON.NameValue(row,'MID_YMD1');
        retObj.mid_ymd2 = dsT_CM_PERSON.NameValue(row,'MID_YMD2');
        retObj.mid_ymd3 = dsT_CM_PERSON.NameValue(row,'MID_YMD3');
        retObj.hirr_ymd = dsT_CM_PERSON.NameValue(row,'HIRR_YMD');
        
        window.close();

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������� ��ȸ</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">��� ��ȣ/����&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()"><input type="text" style="display:none">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->

    <!-- ��ȸ ���� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
					    <td>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span>
						</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
     
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">                         
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:200px;">
                                <param name="DataID"            	value="dsT_CM_PERSON">
                                <param Name="Editable"          	value="false">
                                <param name=HiddenHScroll    	value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=����   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=�μ�   align=left   </C>
                                    <C> id=JOB_NM            width=80   name=����   align=left   </C>
                                    <C> id=ENO_NO            width=80   name=���   align=center </C>
                                    <C> id=ENO_NM            width=80   name=����   align=center </C>
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

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
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
    </form>
    <!-- form �� -->

</body>
</html>