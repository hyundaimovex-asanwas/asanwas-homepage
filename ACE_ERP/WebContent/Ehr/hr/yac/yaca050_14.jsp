<!--*************************************************************************
* @source      : yaca050_14.jsp                                                *
* @description : ������������ȸ PAGE                                      *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2014/11/6            �̵���             �����ۼ�    
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
    <jsp:include page="/Ehr/common/include/head.jsp"/>     
    
    <title>������������ȸ(yaca050_2014�⵵)</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>	
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {

            params = "&S_MODE=SHR_14"
                + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;            

            trT_AC_RETACC.KeyValue = "tr"
                + "(O:dsT_AC_RETACC=dsT_AC_RETACC)";
            
			trT_AC_RETACC.action = dataClassName+params;
			
			trT_AC_RETACC.post();            
            
        }



        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmp() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm('txtENO_NO_SHR');

            if(document.getElementById("txtENO_NO_SHR").value != "") {
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM_SHR").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM_SHR").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NM_SHR").value      = "";
                document.getElementById("txtDPT_NM_SHR").value      = "";
                document.getElementById("txtJOB_NM_SHR").value      = "";
            }
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
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

            //�ͼӳ⵵ �ʱⰪ ����
            document.getElementById("txtPIS_YY_SHR").value = '2014';

            document.getElementById("txtENO_NO_SHR").value = gusrid;            
            document.getElementById("txtENO_NM_SHR").value = gusrnm;   
            
    		//�����ڰ� �ƴ� ��� Ÿ���� ��ȸ�� ���� �ʰ�
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "2140002" ){
				
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}            

           fnc_SearchList();
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        
        
        



        function gf_setnum2(src){ 
          
          if(src==""){
        		return 0;
        	}

        	//alert("src"+src);

        	var arrParam	= new Array();
        	var buf_all  = "";
        	var buf_comma  = "";
        	var len	= 0;
        	var comma = 0;
        	var buf  = "";
        	var dest = "";

        	buf_all = "" + src + "";
        	arrParam = buf_all.split(".");
          
          buf = arrParam[0];
          
        	if (arrParam.length>1){
        		buf_comma = arrParam[1];
        	}else{
            buf_comma="";
        	}
          
        	
        	buf = "" + buf + "";
        	len = buf.length;
        	
        	for(i = 3; i < len; i+=3) {
        		if((i < len) || (len < (i+4)))	comma++;
        	}
        	
        	for(i = 0; i < len; i++) {
        		if(i == (len - (3 * comma))) {
        			dest += ",";
        			dest += buf.charAt(i);
        			comma--;
        		}
        		else {
        			dest += buf.charAt(i);
        		}
        	}

        	if (dest.substring(0,1)=="-") {
        		if (dest.substring(1,2)==",") {
        			dest = dest.substring(0,1) + dest.substring(2,dest.length);
        		}
        	}

        	if(buf_comma!=""){
            dest=dest+"."+buf_comma;
        	}

        	return dest;
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/
         var oFieldList = new Array("TAX_INCOME"
							        		,"MGR_AMT"
							        		,"MNI_AMT"
							        		,"BADD_AMT"
							        		,"SPSB_AMT"
							        		,"GDED_AMT"
							        		,"GOL_AMT70"
							        		,"TBL_DED"
							        		,"WDD_AMT"
							        		,"OTX_DED"
							        		,"NPEN_DED"
							        		,"ETC_DED"
							        		,"HIN_DED"							        		
							        		,"LOAN_DED"
							        		,"LONG_DED"
							        		,"DON_FWD"
							        		,"VEN_DED"
							        		,"INDED_TOT"
							        		,"PER_DED"
							        		,"SAVE_DED"
							        		,"CARD_DED"
							        		,"SAJU_DED"
							        		,"LSS_DED"
							        		,"INDED_EXC"
							        		,"TTAX_STD"
							        		,"TAX_AMT"
							        		,"HGR_DED"
							        		,"AGE_AMT"
							        		,"ANN_DED"
							        		,"MIN_DED"
							        		,"MMA_DED"
							        		,"EDU_DED"
							        		,"GOV_DED"
							        		,"GOV2_DED"								        		
							        		,"LC1_DED"
							        		,"LC23_DED"								        		
							        		,"CPC_DED"
							        		,"NSE_TOT"
							        		,"STA_TOT"
							        		,"MRENT_DED"
							        		,"TDED_TOT"
							        		,"DGG_TAX"
							        		,"DJM_TAX"
							        		,"DBW_TAX"
							        		,"DGG_SUM"
							        		,"AGG_TAX"
							        		,"AJM_TAX"
							        		,"CONT_TAX"
							        		,"AGG_SUM"
							        		,"DRE_INTX"
							        		,"DRE_CTTX"
							        		,"DRE_DFTX"
							        		,"RESULT");

		var oElementList = new Array("txtTAX_INCOME"
								        		,"txtMGR_AMT"
								        		,"txtMNI_AMT"
								        		,"txtBADD_AMT"
								        		,"txtSPSB_AMT"
								        		,"txtGDED_AMT"
								        		,"txtGOL_AMT70"
								        		,"txtTBL_DED"
								        		,"txtWDD_AMT"
								        		,"txtOTX_DED"
								        		,"txtNPEN_DED"
								        		,"txtETC_DED"
								        		,"txtHIN_DED"										        		
								        		,"txtLOAN_DED"
								        		,"txtLONG_DED"
								        		,"txtDON_FWD"								        		
								        		,"txtVEN_DED"
								        		,"txtINDED_TOT"
								        		,"txtPER_DED"
								        		,"txtSAVE_DED"
								        		,"txtCARD_DED"
								        		,"txtSAJU_DED"
								        		,"txtLSS_DED"
								        		,"txtINDED_EXC"								        		
								        		,"txtTTAX_STD"
								        		,"txtTAX_AMT"
								        		,"txtHGR_DED"
								        		,"txtAGE_AMT"
								        		,"txtANN_DED"
								        		,"txtMIN_DED"
								        		,"txtMMA_DED"
								        		,"txtEDU_DED"
								        		,"txtGOV_DED"
								        		,"txtGOV2_DED"								        		
								        		,"txtLC1_DED"
								        		,"txtLC23_DED"								        		
								        		,"txtCPC_DED"
								        		,"txtNSE_TOT"
								        		,"txtSTA_TOT"
								        		,"txtMRENT_DED"
								        		,"txtTDED_TOT"
								        		,"txtDGG_TAX"
								        		,"txtDJM_TAX"
								        		,"txtDBW_TAX"
								        		,"txtDGG_SUM"
								        		,"txtAGG_TAX"
								        		,"txtAJM_TAX"
								        		,"txtCONT_TAX"
								        		,"txtAGG_SUM"
								        		,"txtDRE_INTX"
								        		,"txtDRE_CTTX"
								        		,"txtDRE_DFTX"
								        		,"txtRESULT");

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->
<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton               |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)           |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
	<Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
	//		alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			

			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

            //for(var i =0; i<oFieldList.length; i++) {

            //     document.getElementById(oElementList[i]).value = formatNumber(dsT_AC_RETACC.NameString(1, oFieldList[i]));
    			//alert(oFieldList[i]);
            //}
        }
        
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������������ȸ</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">������������ȸ</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="100"></col>
                                    <col width="200"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                                <tr>
                                    <td class="searchState" align="right">�ͼӳ⵵&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                        			<input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="4" class="input_ReadOnly" readonly>                                                
                                            </tr>
                                        </table>
                                    </td>

                                    <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��&nbsp;</td>
                                    <td class="padding2423">
										<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
										<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
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

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td class="paddingTop8">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->


    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="520" valign="top" style="padding-right:5px">

                <!-- ù��° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="70"></col>
                        <col width="180"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">�������޿�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtTAX_INCOME classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtTAX_INCOME" id="txtTAX_INCOME" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly>  -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">�ٷμҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtMGR_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtMGR_AMT" id="txtMGR_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">�������ٷμҵ�ݾ�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtMNI_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtMNI_AMT" id="txtMNI_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="3">�⺻����</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtBADD_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtBADD_AMT" id="txtBADD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtSPSB_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtSPSB_AMT" id="txtSPSB_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�ξ簡��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtGDED_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                         
                            <!-- <input type="text" name="txtGDED_AMT" id="txtGDED_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="4">�߰�����</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">��ο��(70��)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtGOL_AMT70 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtGOL_AMT70" id="txtGOL_AMT70" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtTBL_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtTBL_DED" id="txtTBL_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�γ���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtWDD_AMT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtWDD_AMT" id="txtWDD_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�Ѻθ����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtOTX_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtOTX_DED" id="txtOTX_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  

                    <tr>
                        <td class="blueBold" align="center" rowspan="2">���ݺ����</td>                    
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">���ο��ݺ����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtNPEN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtNPEN_DED" id="txtNPEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">��Ÿ���ݺ����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtETC_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                
                            <!-- <input type="text" name="txtETC_DED" id="txtETC_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    

                    <tr>
                        <td class="blueBold" align="center" rowspan="5">Ư������</td>
                        <td class="blueBold" align="left" style="padding-left:10px">�����</td>
                        <td class="blueBold" align="left" style="padding-left:10px">�ǰ�,��뺸����</td>                        
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtHIN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                
                            <!-- <input type="text" name="txtHIN_DED" id="txtHIN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" rowspan="2">�����ڱ�</td>
                        <td class="blueBold" align="left" style="padding-left:10px">�����������Ա� �����ݻ�ȯ��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtLOAN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLOAN_DED" id="txtLOAN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px">��������������Ա� ���ڻ�ȯ��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtLONG_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLONG_DED" id="txtLONG_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px">��α�</td>
                        <td class="blueBold" align="left" style="padding-left:10px">�̿���</td>                        
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtDON_FWD classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtDON_FWD" id="txtDON_FWD" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px"  colspan="2">�հ�(Ư������)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtVEN_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtVEN_DED" id="txtVEN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" colspan="3">�����ҵ�ݾ�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtINDED_TOT classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtINDED_TOT" id="txtINDED_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                      <td class="blueBold" align="center" rowspan="5">�׹���<br>�ҵ����</td>                    
                        <td class="blueBold" align="center" colspan="2">���ο�������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id=txtPER_DED classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                              
                            <!-- <input type="text" name="txtPER_DED" id="txtPER_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">���ø�������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSAVE_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                              
                            <!-- <input type="text" name="txtSAVE_DED" id="txtSAVE_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="2">�ſ�ī����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCARD_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtCARD_DED" id="txtCARD_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="2">�츮�����⿬�ݼҵ����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSAJU_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtSAJU_DED" id="txtSAJU_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="2">�������������������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLSS_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtLSS_DED" id="txtLSS_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                </table>
                <!-- ù��° ���̺� -->

            </td>
            <td valign="top">

                <!-- �ι�° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="70"></col>                        
                        <col width="180"></col>
                        <col width="*"></col>
                    </colgroup>

                    <tr>
                        <td class="blueBold" align="center" colspan="3">�ҵ���� �����ѵ� �ʰ���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtINDED_EXC" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtINDED_EXC" id="txtINDED_EXC" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="center" colspan="3">���ռҵ����ǥ��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTTAX_STD" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtTTAX_STD" id="txtTTAX_STD" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center" colspan="3">���⼼��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTAX_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtTAX_AMT" id="txtTAX_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>

                    <tr>
                        <td class="blueBold" align="center" rowspan="16">���װ���</td>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�ٷμҵ漼�װ���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtHGR_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtHGR_DED" id="txtHGR_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">�ڳ�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtAGE_AMT" id="txtAGE_AMT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">���ݰ���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtANN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                            <!-- <input type="text" name="txtANN_DED" id="txtANN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                                        
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" rowspan="10">&nbsp;&nbsp;Ư��<br>���װ���</td>                    
                        <td class="blueBold" align="left" style="padding-left:10px" >���强�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMIN_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtMIN_DED" id="txtMIN_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >�Ƿ��</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMMA_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtMMA_DED" id="txtMMA_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtEDU_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                            <!-- <input type="text" name="txtEDU_DED" id="txtEDU_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >��ġ�ڱݱ�α� (10�� ����)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtGOV_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtGOV_DED" id="txtGOV_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                                      
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >��ġ�ڱݱ�α� (10�� �ʰ�)</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtGOV2_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtGOV2_DED" id="txtGOV2_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >������α�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLC1_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtLC1_DED" id="txtLC1_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >������α�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtLC23_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtLC23_DED" id="txtLC23_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>  
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >��αݼ��װ�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCPC_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtCPC_DED" id="txtCPC_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                                      
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >Ư�����װ�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtNSE_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                               
                            <!-- <input type="text" name="txtNSE_TOT" id="txtNSE_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                    
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" >ǥ�ؼ��װ���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtSTA_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtSTA_TOT" id="txtSTA_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtMRENT_DED" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtMRENT_DED" id="txtMRENT_DED" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr> 
                    <tr>
                        <td class="blueBold" align="left" style="padding-left:10px" colspan="2">���װ�����</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtTDED_TOT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=120>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                                 
                            <!-- <input type="text" name="txtTDED_TOT" id="txtTDED_TOT" size="15" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                    </tr>                      
                                       
                </table>
                <!-- �ι�° ���̺� -->

                <br>

                <!-- ����° ���̺� -->
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="70"></col>
                        <col width="100"></col>
                        <col width="100"></col>
                        <col width="100"></col>                        
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="blueBold" align="center"></td>
                        <td class="blueBold" align="center">�ҵ漼</td>
                        <td class="blueBold" align="center">�ֹμ�</td>
                        <td class="blueBold" align="center">��Ư��</td>                        
                        <td class="blueBold" align="center">��</td>
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">��������</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDGG_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDGG_TAX" id="txtDGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDJM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDJM_TAX" id="txtDJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDBW_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDBW_TAX" id="txtDBW_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDGG_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                            
                            <!-- <input type="text" name="txtDGG_SUM" id="txtDGG_SUM" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">�ⳳ�ξ�</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGG_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAGG_TAX" id="txtAGG_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAJM_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAJM_TAX" id="txtAJM_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtCONT_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtCONT_TAX" id="txtCONT_TAX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtAGG_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                            <!-- <input type="text" name="txtAGG_SUM" id="txtAGG_SUM" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly> -->
                        </td>                        
                    </tr>
                    <tr>
                        <td class="blueBold" align="center">ȯ�޼���</td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_INTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                         <!--    <input type="text" name="txtDRE_INTX" id="txtDRE_INTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_CTTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_CTTX" id="txtDRE_CTTX" size="10" style="text-align:right;" style="ime-mode:disabled"   style="border: #333333 1px solid" readonly> -->
                        </td>
                        <td class="padding2423" style="padding-left:10px">
		                        <comment id="__NSID__"><object id="txtDRE_DFTX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>                        
                          <!--   <input type="text" name="txtDRE_DFTX" id="txtDRE_DFTX" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid" readonly > -->
                        </td>
                        <td class="padding2423" style="padding-left:10px" >
		                        <comment id="__NSID__"><object id="txtRESULT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=20 width=70>
									<param name=Alignment			value=2>
									<param name=Numeric				value=true>
									<param name=IsComma			value=true>	
									<param name=ReadOnly  			value=true>
									<param name=ReadOnlyBackColor   value="#ccffcc">
									<param name=MaxLength			value=10>
									<param name=MaxDecimalPlace	value=2>
								</object></comment><script> __ShowEmbedObject(__NSID__); </script>
                            <!-- <input type="text" name="txtRESULT" id="txtRESULT" size="10" style="text-align:right;" style="ime-mode:disabled"  style="border: #333333 1px solid; color:red; IsComma:true" readonly >  -->
                        </td>                        
                    </tr>
                </table>
                <!-- ����° ���̺� -->

            </td>
        </tr>
    </table>


    </form>
    <!-- form �� -->


	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AC_PENSION ���� ���̺� -->
	<object id="bndT_AC_RETACC" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AC_RETACC">
		<Param Name="BindInfo", Value="
			<C>Col=TAX_INCOME			Ctrl=txtTAX_INCOME				Param=text </C>
			<C>Col=MGR_AMT				Ctrl=txtMGR_AMT					Param=text </C>
			<C>Col=MNI_AMT					Ctrl=txtMNI_AMT					Param=text </C>
			<C>Col=BADD_AMT				Ctrl=txtBADD_AMT				Param=text  </C>
			<C>Col=SPSB_AMT				Ctrl=txtSPSB_AMT					Param=text  </C>
			<C>Col=GDED_AMT				Ctrl=txtGDED_AMT				Param=text </C>
			<C>Col=GOL_AMT70				Ctrl=txtGOL_AMT70				Param=text </C>
			<C>Col=TBL_DED					Ctrl=txtTBL_DED					Param=text </C>
			<C>Col=WDD_AMT				Ctrl=txtWDD_AMT					Param=text </C>
			<C>Col=OTX_DED					Ctrl=txtOTX_DED					Param=text  </C>
			<C>Col=NPEN_DED				Ctrl=txtNPEN_DED					Param=text  </C>
			<C>Col=ETC_DED					Ctrl=txtETC_DED					Param=text </C>
			<C>Col=HIN_DED					Ctrl=txtHIN_DED					Param=text </C>
			<C>Col=LOAN_DED				Ctrl=txtLOAN_DED				Param=text </C>
			<C>Col=LONG_DED				Ctrl=txtLONG_DED				Param=text </C>
			<C>Col=DON_FWD				Ctrl=txtDON_FWD					Param=text </C>
			<C>Col=VEN_DED					Ctrl=txtVEN_DED					Param=text </C>
			<C>Col=INDED_TOT				Ctrl=txtINDED_TOT				Param=text </C>
			<C>Col=PER_DED					Ctrl=txtPER_DED					Param=text  </C>
			<C>Col=SAVE_DED				Ctrl=txtSAVE_DED					Param=text  </C>
			<C>Col=CARD_DED				Ctrl=txtCARD_DED				Param=text </C>
			<C>Col=SAJU_DED				Ctrl=txtSAJU_DED					Param=text </C>
			<C>Col=LSS_DED					Ctrl=txtLSS_DED					Param=text </C>
			<C>Col=INDED_EXC				Ctrl=txtINDED_EXC				Param=text </C>
			<C>Col=TTAX_STD				Ctrl=txtTTAX_STD				Param=text  </C>
			<C>Col=TAX_AMT					Ctrl=txtTAX_AMT					Param=text  </C>
			<C>Col=HGR_DED					Ctrl=txtHGR_DED					Param=text </C>
			<C>Col=AGE_AMT					Ctrl=txtAGE_AMT					Param=text </C>
			<C>Col=ANN_DED					Ctrl=txtANN_DED					Param=text </C>
			<C>Col=MIN_DED					Ctrl=txtMIN_DED					Param=text </C>
			<C>Col=MMA_DED				Ctrl=txtMMA_DED					Param=text </C>
			<C>Col=EDU_DED					Ctrl=txtEDU_DED					Param=text </C>
			<C>Col=GOV_DED					Ctrl=txtGOV_DED					Param=text </C>
			<C>Col=GOV2_DED				Ctrl=txtGOV2_DED				Param=text  </C>
			<C>Col=LC1_DED					Ctrl=txtLC1_DED					Param=text  </C>
			<C>Col=LC23_DED				Ctrl=txtLC23_DED					Param=text </C>
			<C>Col=CPC_DED					Ctrl=txtCPC_DED					Param=text </C>
			<C>Col=NSE_TOT					Ctrl=txtNSE_TOT					Param=text </C>
			<C>Col=STA_TOT					Ctrl=txtSTA_TOT					Param=text </C>
			<C>Col=MRENT_DED				Ctrl=txtMRENT_DED				Param=text  </C>
			<C>Col=TDED_TOT				Ctrl=txtTDED_TOT				Param=text  </C>
			<C>Col=DGG_TAX					Ctrl=txtDGG_TAX					Param=text </C>
			<C>Col=DJM_TAX					Ctrl=txtDJM_TAX					Param=text </C>
			<C>Col=DBW_TAX					Ctrl=txtDBW_TAX					Param=text </C>
			<C>Col=DGG_SUM					Ctrl=txtDGG_SUM					Param=text </C>
			<C>Col=AGG_TAX					Ctrl=txtAGG_TAX					Param=text </C>
			<C>Col=AJM_TAX					Ctrl=txtAJM_TAX					Param=text </C>
			<C>Col=CONT_TAX				Ctrl=txtCONT_TAX				Param=text </C>
			<C>Col=AGG_SUM					Ctrl=txtAGG_SUM					Param=text  </C>
			<C>Col=DRE_INTX				Ctrl=txtDRE_INTX					Param=text  </C>
			<C>Col=DRE_CTTX				Ctrl=txtDRE_CTTX				Param=text </C>
			<C>Col=DRE_DFTX				Ctrl=txtDRE_DFTX				Param=text </C>
			<C>Col=RESULT					Ctrl=txtRESULT					Param=text </C>
       ">
	</object>




</body>
</html>

