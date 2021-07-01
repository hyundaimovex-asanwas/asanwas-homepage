
<!--
*****************************************************
* @source      : idtc080.jsp
* @description : �ְ�����Ȯ�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      �̵���        �����ۼ�
*-------------+-----------+--------------------------+
*****************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�ۼ���Ȳ</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >



        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var pis_yy = document.getElementById('txtPIS_YY_SHR').value;


            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc080.cmd.IDTC080CMD"
													                + "&S_MODE=SHR"						                                
													                + "&PIS_YY="+pis_yy;
			
			dsT_WF_WORKFORM.Reset();    		
    		
    		
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


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {


        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {


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

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //��¥���� ���ε�
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, 0);
            
            document.getElementById("txtPIS_YY_SHR").value = svc_ymd.substr(0,4); // �ش��

			//���� ��� �����¸� �����°� ����
			var PIS_YY_SHR = (document.getElementById("txtPIS_YY_SHR").value).replace("-", "").replace("-", "");

			if(PIS_YY_SHR.trim() == ""){
				
				document.getElementById("txtPIS_YY_SHR").value = "";
				
			}

            //Grid Style ����
			cfStyleGrid_New(form1.grdT_WF_WORKFORM,0,"false","false");

			fnc_SearchList();


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

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WF_WORKFORM)|
    | 3. ���Ǵ� Table List(T_WF_WORKFORM)		 |
    +------------------------------------------------>
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WF_WORKFORM)		   |
    | 3. ���Ǵ� Table List(T_WF_WORKFORM)			   |
    +------------------------------------------------------>
	<Object ID="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>





    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->



    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_WF_WORKFORM event="OnDblClick(row,colid)">

	    curRowPosition = dsT_WF_WORKFORM.RowPosition;
	
	    
	    
		if(colid == "ENO_NM") {
			
			//���� ����Ŭ���� ��ü �ۼ� ��Ȳ ǥ��
	        var url = "../../hr/idt/idtc082.jsp?ENO_NO="+dsT_WF_WORKFORM.NameString(row, "ENO_NO");
            
	        //alert(url);
	        
	   		cfWinOpen(url,"�ְ���������",1100,800);
			
		} else {

			var dummy = colid.substr(2,3); // �ش��
			var WEEK_NO; 
			
			
			if(dummy == "11"){
				WEEK_NO = 1;
			}else if(dummy == "12"){
				WEEK_NO = 2;
			}else if(dummy == "13"){
				WEEK_NO = 3;
			}else if(dummy == "14"){
				WEEK_NO = 4;					
			}else if(dummy == "21"){
				WEEK_NO = 5;
			}else if(dummy == "22"){
				WEEK_NO = 6;
			}else if(dummy == "23"){
				WEEK_NO = 7;
			}else if(dummy == "24"){
				WEEK_NO = 8;		
			}else if(dummy == "31"){
				WEEK_NO = 9;
			}else if(dummy == "32"){
				WEEK_NO = 10;
			}else if(dummy == "33"){
				WEEK_NO = 11;					
			}else if(dummy == "34"){
				WEEK_NO = 12;
			}else if(dummy == "35"){
				WEEK_NO = 13;				
			}else if(dummy == "42"){
				WEEK_NO = 14;
			}else if(dummy == "43"){
				WEEK_NO = 15;
			}else if(dummy == "44"){
				WEEK_NO = 16;					
			}else if(dummy == "45"){
				WEEK_NO = 17;	
			}else if(dummy == "52"){
				WEEK_NO = 18;
			}else if(dummy == "53"){
				WEEK_NO = 19;
			}else if(dummy == "54"){
				WEEK_NO = 20;					
			}else if(dummy == "55"){
				WEEK_NO = 21;					
				
			}
			
			
	        var url = "../../hr/idt/idtc081.jsp?ENO_NO="+dsT_WF_WORKFORM.NameString(row, "ENO_NO")+"&WEEK_NO="+WEEK_NO;
	               
	        //alert(url);
	        
	   		cfWinOpen(url,"�ְ���������",1100,800);
	  
		}
		
	</script>



    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_WF_WORKFORM event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_WF_WORKFORM event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
						<col width="70"></col>
						<col width=""></col>
					</colgroup>
	                        <tr>
					<td align="center" class="searchState">���س�</td>
					<td>
						<input id="txtPIS_YY_SHR" size="4" maxlength="4" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
					 </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->


<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:595px;">
							<param name="DataID"					value="dsT_WF_WORKFORM">
                            <param name="ColSelect"  				value="true">
							<PARAM NAME="BorderStyle"				VALUE="0">
							<PARAM NAME="Indwidth"					VALUE="0">
							<PARAM NAME="Fillarea"					VALUE="true">
							<PARAM NAME="Editable"					VALUE="false">
							<PARAM NAME="Colsizing"					VALUE="true">
							<PARAM NAME="TitleHeight"				VALUE=15>
							<param name="GTitleHeight"              value=20>							
							<param name="sortview"					value=left>
                            <param name="Format"					value="
								<FC>ID={CurRow}		Name='��'	Width=20   		align=center  	sort=false  editable=false</FC>
								<FC> ID='DPT_NM'	width=80	Name='�Ҽ�'		align=left		edit=none  sort=true suppress=1</FC>
								<FC> ID='ENO_NO'	width=60	Name='���'		align=center	edit=none  sort=true show=false</FC>
								<FC> ID='ENO_NM'	width=60	Name='����'		align=center	edit=none  sort=true</FC>

                               <G> name='1��' 		BgColor='#dae0ee'
                                <C> id='AT11'		width=25	name='1��'		align=center    BgColor={Decode(AT11,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT12'	    width=25	name='2��'		align=center    BgColor={Decode(AT12,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT13'	    width=25	name='3��'	    align=center    BgColor={Decode(AT13,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT14'	    width=25	name='4��'		align=center    BgColor={Decode(AT14,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT15'	    width=25	name='5��'		align=center    BgColor={Decode(AT11,'X','#FFC6C6','#FFFFFF')} show=false</C>
                               </G>
                               
                               <G> name='2��' 		BgColor='#dae0ee'
                                <C> id='AT21'	    width=25	name='1��'	    align=center    BgColor={Decode(AT21,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT22'     	width=25	name='2��'		align=center    BgColor={Decode(AT22,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT23'    	width=25	name='3��'		align=center    BgColor={Decode(AT23,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT24'     	width=25	name='4��'		align=center    BgColor={Decode(AT24,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='3��' 		BgColor='#dae0ee'
                                <C> id='AT31'     	width=25	name='1��'		align=center    BgColor={Decode(AT31,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT32'    	width=25	name='2��'		align=center    BgColor={Decode(AT32,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT33'    	width=25	name='3��'		align=center    BgColor={Decode(AT33,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT34'    	width=25	name='4��'		align=center    BgColor={Decode(AT34,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT35'    	width=25	name='5��'		align=center    BgColor={Decode(AT35,'X','#FFC6C6','#FFFFFF')} </C>                                
                               </G>
                               
                               <G> name='4��' 		BgColor='#dae0ee'
                                <C> id='AT42'    	width=25	name='2��'		align=center    BgColor={Decode(AT42,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT43'    	width=25	name='3��'		align=center    BgColor={Decode(AT43,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT44'   	width=25	name='4��'		align=center    BgColor={Decode(AT44,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT45'    	width=25	name='5��'		align=center    BgColor={Decode(AT45,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='5��' 		BgColor='#dae0ee'
                                <C> id='AT52'    	width=25	name='2��'		align=center    BgColor={Decode(AT52,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT53'    	width=25	name='3��'		align=center    BgColor={Decode(AT53,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT54'    	width=25	name='4��'		align=center    BgColor={Decode(AT54,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT55'    	width=25	name='5��'		align=center    BgColor={Decode(AT55,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='6��' 		BgColor='#dae0ee'
                                <C> id='AT61'    	width=25	name='1��'		align=center    BgColor={Decode(AT61,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT62'    	width=25	name='2��'		align=center    BgColor={Decode(AT62,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT63'    	width=25	name='3��'		align=center    BgColor={Decode(AT63,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT64'    	width=25	name='4��'		align=center    BgColor={Decode(AT64,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT65'    	width=25	name='5��'		align=center    BgColor={Decode(AT65,'X','#FFC6C6','#FFFFFF')} </C>                                
                               </G>
                               
                               <G> name='7��' 		BgColor='#dae0ee'                                
                                <C> id='AT71'    	width=25	name='1��'		align=center    BgColor={Decode(AT71,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT72'    	width=25	name='2��'		align=center    BgColor={Decode(AT72,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT73'    	width=25	name='3��'		align=center    BgColor={Decode(AT73,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT74'    	width=25	name='4��'		align=center    BgColor={Decode(AT74,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='8��' 		BgColor='#dae0ee'                                
                                <C> id='AT81'    	width=25	name='1��'		align=center    BgColor={Decode(AT81,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT82'    	width=25	name='2��'		align=center    BgColor={Decode(AT82,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT83'    	width=25	name='3��'		align=center    BgColor={Decode(AT83,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT84'    	width=25	name='3��'		align=center    BgColor={Decode(AT84,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='9��' 		BgColor='#dae0ee'
                                <C> id='AT91'    	width=25	name='1��'		align=center    BgColor={Decode(AT91,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT92'    	width=25	name='2��'		align=center    BgColor={Decode(AT92,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT93'    	width=25	name='3��'		align=center    BgColor={Decode(AT93,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT94'    	width=25	name='4��'		align=center    BgColor={Decode(AT94,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='10��' 		BgColor='#dae0ee'
                                <C> id='AT101'    	width=25	name='1��'		align=center    BgColor={Decode(AT101,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT102'    	width=25	name='2��'		align=center    BgColor={Decode(AT102,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT103'    	width=25	name='3��'		align=center    BgColor={Decode(AT103,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT104'    	width=25	name='4��'		align=center    BgColor={Decode(AT104,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='11��' 		BgColor='#dae0ee'
                                <C> id='AT111'    	width=25	name='1��'		align=center    BgColor={Decode(AT111,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT112'    	width=25	name='2��'		align=center    BgColor={Decode(AT112,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT113'    	width=25	name='3��'		align=center    BgColor={Decode(AT113,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT114'    	width=25	name='4��'		align=center    BgColor={Decode(AT114,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='12��' 		BgColor='#dae0ee'                                
                                <C> id='AT121'    	width=25	name='1��'		align=center    BgColor={Decode(AT121,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT122'    	width=25	name='2��'		align=center    BgColor={Decode(AT122,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT123'    	width=25	name='3��'		align=center    BgColor={Decode(AT123,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT124'    	width=25	name='4��'		align=center    BgColor={Decode(AT124,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                              
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
	
	<tr>
		<td align="left" class="blueBold">
			<br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ������ ����Ŭ���Ͻø� ��ü �ۼ� ��Ȳ�� ��ȸ�Ͻ� �� �ֽ��ϴ�.</font>
			<br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� Grid�� ����Ŭ���Ͻø� �ش� ������ �ش��� �ۼ� ��Ȳ�� ��ȸ�Ͻ� �� �ֽ��ϴ�.</font> 	
			<br>			
		</td>
	 </td>
	</tr>	
	
	
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->





</form>
<!-- form �� -->

</body>
</html>


<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 





