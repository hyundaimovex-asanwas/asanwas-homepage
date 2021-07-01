<!--*************************************************
* @source      : yaca070_14.jsp                                                *
* @description : ���κ��󼼳�����Ȳ PAGE                                         *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            �̵���             �����ۼ�                                         *
****************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

    <title>���κ��󼼳�����Ȳ(yaca070_142)</title>
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
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca070.cmd.YACA070CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");


            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR_142"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&ENO_NO="+oENO_NO.value
            	   + "&USESTS_SHR="+document.getElementById("cmbUSESTS_SHR").value; 
            
            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
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
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("���κ��󼼳�����Ȳ", '', 225);
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

            cfStyleGrid_New(form1.grdT_AC_RETACC,0,"false","true");      // Grid Style ����

			form1.grdT_AC_RETACC.TitleHeight = 45;
            
            document.getElementById("txtPIS_YM_SHR").value = '2014-12';

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

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbOCC_CD_SHR");

        //�׸���� �޼���
        var oElementMsgList = new Array( "������"
                                        ,"�ٷα���"
                                        ,"���걸��");

        //���� �׸��
        var oExceptionList = new Array(  "cmbOCC_CD_SHR");


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
	   }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
	    }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>


    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
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

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>

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
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">���κ��󼼳�����Ȳ_2</td>
                    <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">���κ��󼼳�����Ȳ_2</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
	<table width="1050" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
                    <col width="100"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">������</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','../../images/button/btn_HelpOver.gif',1)" ><img src="../../images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
					</td>
                    <td align="right" class="searchState">���</td>
                    <td class="padding2423" colspan="3">
							<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) {fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();}" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
							<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) {fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');fnc_SearchList();">						
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                    </td>
					<td align="center" class="searchState">��������</td>
					<td>
							<select id="cmbUSESTS_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
									<option value="" >��ü</option>
									<option value="Y">����</option>
									<option value="N">����</option>
							</select>
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

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="1050" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1050px;height:550px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=����     SubSumText="" Value={Decode(RET_YN,"","����","����")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=������     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=�Ҽ�                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=���                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=����                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=�ֹι�ȣ                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=����                          SubSumText=" �� �� "</FC>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name="�������޿�"                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="�ٷμҵ�;������"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name="�ٷμҵ�ݾ�"                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name="���ΰ���"                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name="����ڰ���"                  </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="�ξ簡��;����"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="��ο��;����"                </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name="����ڰ���"                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name="�γ��ڰ���"                  </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name="�Ѻθ����"                  </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="���ο��ݺ���;����"   </C>
                            <C> id=HIN_DED          width=100   align=right     rightmargin=10    name="�ǰ�,��뺸���;����"         /C>   
                            <C> id=LOAN_DED          width=100   align=right     rightmargin=10    name="��������;���Ա�;�����ݻ�ȯ��"     </C>
                            <C> id=LONG_DED          width=100   align=right     rightmargin=10    name="�����������;���Ա�;�������޾�"  </C>                                                     
                            <C> id=DON_FWD          width=100   align=right     rightmargin=10    name="��α�;�̿�"  </C>                                                      
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name="Ư���ҵ�;����"  </C>                                                        
                            <C> id=INDED_TOT          width=100   align=right     rightmargin=10    name="�����ҵ�ݾ�"                  BgColor=#FAFAD2</C>                                             
                            <C> id=PER_DED          width=100   align=right     rightmargin=10    name="���ο���;�������"          </C>                                             
                            <C> id=SAVE_DED          width=100   align=right     rightmargin=10    name="���ø���;����"              </C>                                             
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="�ſ�ī��;����"                </C>                                             
                            <C> id=SAJU_DED         width=100   align=right     rightmargin=10    name="�츮�����⿬;����"              </C>                                             
                            <C> id=LSS_DED         width=100   align=right     rightmargin=10    name="�����������;�����������"         </C>  
                            <C> id=INDED_EXC         width=100   align=right     rightmargin=10    name="�ҵ����;�����ѵ�;�ʰ���"         </C>                            
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name="���ռҵ�;����ǥ��"                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name="���⼼��"                        BgColor=#AAFAD2</C>                                                                                  
 
                           <G> name=���װ��� BgColor="#dae0ee"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="�ٷμҵ�;���װ���"      </C> 
                            <C> id=AGE_AMT          width=100   align=right     rightmargin=10    name="�ڳ�;���װ���"             </C>  
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="���ݰ���;����"         </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name="���强����;���װ���"          </C>                                                                                                         
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name="�Ƿ��;���װ���"          </C>
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name="������;���װ���"           </C>
                            <C> id=GOV1_DED         width=100   align=right     rightmargin=10    name="��ġ�ڱ�;(10��������)"     </C>
                            <C> id=GOV2_DED          width=100   align=right     rightmargin=10    name="��ġ�ڱ�;(10�����ʰ�)"    </C>
                            <C> id=LC1_DED           width=100   align=right     rightmargin=10    name="������α�"                    </C>
                            <C> id=LC23_DED          width=100   align=right     rightmargin=10    name="������α�"                    </C>
                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name="��α�;���װ���"           </C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name="Ư������;������"             BgColor=#99FF22</C>
                            <C> id=STA_TOT          width=100   align=right     rightmargin=10    name="ǥ�ؼ��װ���"              </C>   
                            <C> id=MRENT_DED       width=100   align=right     rightmargin=10    name="������;���װ���"         </C>                                                       
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name="���װ����� "                   BgColor=#FAFAD2</C>
                           </G> 

                           <G> name=�������� BgColor="#dae0ee"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=�����ҵ漼                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=�����ֹμ�                   </C>
                            <C> id=DBW_TAX          width=100   align=right     rightmargin=10    name=������Ư��                   </C>                            
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=�������װ�                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                            
                           <G> name=�ⳳ�μ��� BgColor="#dae0ee"                            

                            <C> id=AGG_TAX         width=100   align=right     rightmargin=10    name=���μҵ漼                    </C>
                            <C> id=AJM_TAX         width=100   align=right     rightmargin=10    name=�����ֹμ�                    </C>
                            <C> id=CONT_TAX         width=100   align=right     rightmargin=10    name=���γ�Ư��                    </C>                            
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=���μ��װ�                        value={AGG_TAX +AJM_TAX+CONT_TAX} BgColor=#FAFAD2</C>
                            </G>                            

                           <G> name=ȯ�޼��� BgColor="#dae0ee"                                                    
                            
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=ȯ�޼ҵ漼                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=ȯ���ֹμ�                    </C>
                            <C> id=DRE_DFTX        width=100   align=right     rightmargin=10    name=ȯ�޳�Ư��                    </C>                            
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=ȯ�޼��װ�                    value={DRE_INTX+DRE_CTTX+DRE_DFTX} BgColor=#FFAADD</C>
                            </G>                         
                        
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
