<!--
*****************************************************
* @source       : gune015.jsp
* @description : ����ٹ�������û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/10/18     MOON              �����ۼ�
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<%

	String req_no = request.getParameter("REQ_NO");         //��û��ȣ
	String eno_no = request.getParameter("ENO_NO");         //��û�ڻ��
	String app_yn = request.getParameter("APP_YN");			//�������
	String app_status = request.getParameter("APP_STATUS"); //���������Ȳ
	String app_cmt = request.getParameter("APP_CMT");       //�������ǰ�
%>


<html>


<head>

	<title>����ٹ�������û</title>
	
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../../css/style.css" rel="stylesheet" type="text/css">
		<link href="../../css/general.css" rel="stylesheet" type="text/css">
		
		<script language=javascript src="../../common/common.js"></script>
		<script language=javascript src="../../common/input.js"></script>
		<script language=javascript src="../../common/result.js"></script>
		<script language=javascript src="../../common/mdi_common.js"></script>
		<script language="javascript" src="../../common/calendar/calendar.js"></script>
	
	
	
	<!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
	<script language="javascript" >
	
	
	// ��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
	var btnList = 'TTTTTFTT';
	
	
	//var today = getToday();
	
	
	var today = gcurdate;
	
	var GBN = "";
	
	var obj = new String();
	
     
	obj.app_cmt = "";
	// ��������
	
	
	
	
    /***********************************
     * 01. ��ȸ �Լ�_List ������ ��ȸ*
     ***********************************/
    function fnc_SearchList()
    {
    	
		
    	trT_DI_OVERTIMEWORK.KeyValue = "tr(O:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
    	
    	trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SHR&REQ_NO=<%=req_no%>&ENO_NO=<%=eno_no%>";
    	
    	trT_DI_OVERTIMEWORK.post();
    	
    	
    	
    }

	
	
	
    /***********************************
     * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
     ***********************************/
    function fnc_SearchItem()
    {
    	
    	
    }

    
    
    
    /******************
     * 03. ���� �Լ�   *
     ******************/
    function fnc_Save()
    {
    	
    	
    }

    
    
    
    /******************
     * 04. ���� �Լ�  *
     ******************/
    function fnc_Delete()
    {
    	
    	
    }

    
    
    /******************
     * 05. �μ� �Լ�  *
     ******************/
    function fnc_Print()
    {
    	
    	
    	
    }

    
    
    
    /***********************
     * 06. ���� ���� �Լ�   *
     ***********************/
    function fnc_ToExcel()
    {
    	
    	
    	
    }

    
    
    
    /******************
     * 07. �ű� �Լ�  *
     ******************/
    function fnc_AddNew()
    {
    	
    	
    	
    }

    
    
    /******************
     * 08. ��ȿ�� �˻� *
     ******************/
    function fnc_Valid()
    {
    	
    	
    	
    }

    
    
    
    
    /******************
     * 08. �߰� �Լ�   *
     ******************/
	function fnc_Append()
    {
    	
    	
		
	}
    
    /******************
     * 09. ���� �Լ� - �Ϸ�   *
     ******************/
    function fnc_Remove()
    {
    	
    	

    }

    
    
    
    /********************
     * 10. �ʱ�ȭ �Լ�   *
     ********************/
    function fnc_Clear()
    {
    	
    	location.reload();
    	
    }

    
    
    /************************
     * 11. ȭ�� ����(�ݱ�)   *
     ***********************/
    function fnc_Exit()
    {
    	
    	if (dsT_DI_OVERTIMEWORK.IsUpdated) {
    		
			if (!fnc_ExitQuestion()) return;
			
		}

    	
		frame = window.external.GetFrame(window);
		
		frame.CloseFrame();
		
		
    }
    
    
    
    

    /******************************
     * 12. �˻� ���� ��ȿ�� �˻�  *
     ******************************/
    function fnc_SearchItemCheck(year)
    {
    	
    	
    	
    }

    
    
    /*************************
     * 13. ���� ��ȿ�� üũ  *
     *************************/
    function fnc_SaveItemCheck()
    {
    	
    	
    	
    	
    }

    /********************************************
     * 14. Form Load �� Default �۾� ó�� �κ�    *
     *******************************************/
    function fnc_OnLoadProcess()
    {
    	
    	
    	
    	
    	dsT_DI_APPROVAL.SetDataHeader(
				"GUN_YMD:STRING(10),"+			// ���³�¥
                "GUN_GBN:STRING(1),"+			// ���°��籸��
				"DPT_CD:STRING(6),"+			// ���ºμ�
				"DPT_NM:STRING(10),"+			// ���ºμ���
				"SEQ_NO:STRING(1),"+			// ���缱
				"ENO_NO:STRING(10),"+			// �����ڻ��
				"JOB_CD:STRING(10),"+			// ����������
				"APP_TIME:STRING(10),"+			// ����ð�
				"ENO_NO:STRING(10),"+			// ����ڻ��
				"APP_YN:STRING(10),"+			// ���翩��
				"ENO_NM:STRING(10),"+			// �����ڸ�
				"JOB_NM:STRING(10)"				// ������
		);
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","false"); // ����ٹ� Grid Style ����(�׸���, ���º����÷� width, ���üũ�ڽ�, �������)
    	
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,0,"true","false"); // ����ٹ� Grid Style ����(�׸���, ���º����÷� width, ���üũ�ڽ�, �������)
    	
    	
    	
    	fnc_SearchList();
    	
   		
    	// �����ڸ�, �̰��� �ΰ�쿡�� ��ư�� Ȱ��ȭ
		if(dsT_DI_APPROVAL.NameValue(1,"ENO_NO") == gusrid && dsT_DI_APPROVAL.NameValue(1,"APP_TIME") == ""){
        	
			
        	document.getElementById("btn_approval").style.display = "";
        	
            
        }else{
        	
        	
        	document.getElementById("btn_approval").style.display = "none";
        	
        	
        }
    	
    	
    	
    	
    }

	/********************
     * 15. ����Ű ó��   *
     *******************/
	function fnc_HotKey()
	{
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
		
	}
	

   
	
	/********************
     * 16. �׿� �Լ� ó��  *
     *******************/
	/**
     * ����ٹ� ��û�� �Ⱓ üũ - �Ϸ�
     */
	function fnc_CheckDate()
	{
		
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value.replaceAll("-","");
		var END_YMD = document.getElementById("txtEND_YMD").value.replaceAll("-","");
		
		
		
		
		if(STR_YMD > END_YMD){
			
			
			alert("����ٹ����� ������ ������ �߸��Ǿ����ϴ�.");
			
			
			return false;
			
			
		}
		
		
		
		return true;
		
		
	}
	
	
	
	
	
	
	/**
     * �����ð����� - �Ϸ�
     */
     function fnc_CalcReTime()
	{
		
		
        //var TOT_TIME = document.getElementById("txtTOT_TIME").value; // ��� ���� �ð�
        var TOT_TIME = dsMonAccHour.NameValue(1,"ALL_TOT_TIME"); // �� ���� �ð�
        	
        
        
        for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
        	
        	
        	// �����ð� ���
 			TOT_TIME = Number(TOT_TIME) + Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
        	
        	
 			if(Number(TOT_TIME) > 52) {
 				
				alert("�� �ִ� ��� ������ 52�ð��� �ʰ��Ͽ����ϴ�.(���ϱٹ�����)\n�߰� �Ǵ� ������ �Ͻ� �� �����ϴ�.");
				
				return false;
				
			}
 			
 			
        	dsT_DI_OVERTIMEWORK.NameString(i, "ALL_TOT_TIME") = TOT_TIME; // �����ð� ���� ó��
        	
        	
       	}
        
        
        return true;
        
        
        
	}
	
	
	
	
	
     /**
      * �����ð����� - �Ϸ�
      */
	function fnc_CalcAccReTime(mon, fri, row, calc)
 	{
    	 
    	 
    	 
		var tempVal = 0; // ����ð�
		var tempVal2 = 0; // �ֺ� ���� ���� �ð�
		
		
		
		
		// �ֺ� �����ð� ��������
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++){
			
			
			if(tempVal2 == 0 && mon == dsOTPossibleDt.NameString(i, "WK_MON") && fri == dsOTPossibleDt.NameString(i, "WK_FRI")) {
				
				tempVal2 = Number(dsOTPossibleDt.NameString(i, "WEEK_TOT_TIME"));
				
			}
			
			
		}
		
		
		
		
		// �հ�ð� ����
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				if(i == row) {
					
					tempVal += calc;
					
				} else {
					
					tempVal += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
				}
				
			}
			
		}
		
		
		
		
		
		// �ֺ� 12�ð� üũ
		if( (tempVal2+tempVal) > 12) return false;
		
		
		
		var tempVal3 = 0; // ���� ����� �����ð�
		
		
		
		// ����� �ð��� ����
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				
				if(i == row) {
					
					tempVal3 += calc;
					
				} else {
					
					tempVal3 += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
				}
				
				dsT_DI_OVERTIMEWORK.NameString(i, "WEEK_TOT_TIME") = (tempVal3+tempVal2)+"";
				
			}
			
		}
		
		
		return true;
		
		
	}
     
     
     
     
     
     
	
	/**
	* �ٹ��ð��� ���� ������ üũ�Ѵ�. - �Ϸ�
	*/
	function fnc_OVR_Time(catg)
	{
		
		var OVR_time =  "";
		
		OVR_time = ((fnc_covNumber(document.getElementById("cmbEND_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbEND_OVR_MIN").value)) - 
		((fnc_covNumber(document.getElementById("cmbSTR_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbSTR_OVR_MIN").value));
		
		
		
		if(parseInt(OVR_time) < 0) {
			alert("����ð��� ���۽ð����� �۽��ϴ�.\n�ٽ� ������ �ּ���");
			return;
		}
		
		
		
		document.getElementById("txtREQ_TIME").value = (OVR_time/60);
		
		
		
		
	}
	
	
	
	
	
	/**
	* ���ó��
	*/
	function fnc_Conduct()
	{
		
		
		
		if(dsT_DI_OVERTIMEWORK.CountRow < 1){
			
			
			alert("��Ű����� ����ٹ���û������ �����ϴ�");
			
			
			return;
			
			
		}
		

		
		if(!fnc_CheckDate()) return;

		// �ڵ� ���缱 üũ
		if(dsT_DI_APPROVAL.CountRow < 1) {
			
			alert("�ڵ����缱 ������ �����ϴ�.");
			
			return;
			
		}
		
		
		
		if(!confirm("��û������ ��� �Ͻðڽ��ϱ�?")) return;
		
		
		dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_MAX";
		dsT_DI_REQNO.reset();
		
		
		var req_no = dsT_DI_REQNO.NameValue(1, "REQ_NO");
		
		//alert(dsT_DI_OVERTIMEWORK.NameString(1, "ALL_TOT_TIME"));
		
		
		
		GBN = "SAV01";
		
		trT_DI_OVERTIMEWORK.KeyValue = "SAV01(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
		
		trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD"
												+ "&S_MODE=UPT_APP" // ���
												+ "&APP_TYPE=" + document.getElementById("cmbAPP_TYPE").value // ���� / ���� ����
												+ "&APP_YN="  +"N" // ������� : ���
												+ "&GUN_YMD=" +today.replaceAll("-","") // ���ó�¥
												+ "&GUN_GBN=" +"O" // ������� : ����ٹ�������û�� ��Ī�� O�� �Ҵ�
												+ "&REQ_NO=" +req_no //
												;
		
		trT_DI_OVERTIMEWORK.post();
	}
	
	
	
	
	
	// �Ϸ� - trim ��������
	String.prototype.trim = function(){
		
		return this.replace(/\s/g, "");
		
	}
	
	
	
	
	// �Ϸ� - replaceAll ��� - str.replaceAll("-","")
	String.prototype.replaceAll = function(taget, replacement){
		
		return this.split(taget).join(replacement);
		
	}
	
	
	
	

    /*************************
     * 19. ���, ���� ó��   *
     *************************/
	function fnc_SubmitApproval(kind) {

    	
    	
    	
        if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;


        var app_yn = "";    //����ϷῩ��

       
        if(kind == "���"){
        	
        	
            fnc_InputDisabled();//�Է¶� disabled
            
            
            document.getElementById("btn_appre").style.display = "none";//��žʺ��̰�  ===>  ���� ���
            
            
            status = kind;
            
            
            return false;

            
            
        }else if(kind == "����"){
        	
            app_yn = "Y";
            
        }else if(kind == "�ΰ�" || kind == "�ݼ�"){
        	

			if(obj.app_cmt == ""){
				
      			window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      	    
			}

            if(obj.app_cmt != ""){
            	
				app_yn = "N";
				
	            if(kind == "�ΰ�") {
	            	
	            	app_yn = "N";
	            	

	            }else if(kind == "�ݼ�") {
	            	
	            	app_yn = "E";
	            	
	            }
	            
            }else{
            	
                alert("�ΰ� �Ǵ� �ݼۻ����� �Է��� ó���ٶ��ϴ�.\n \n�۾��� ��ҵǾ����ϴ�.");
                
                return false;
                
        	}

        }
        
        
        
        
        dsT_DI_OVERTIMEWORK_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
        
        
        dsT_DI_OVERTIMEWORK_STATE.AddRow();
        
        
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"REQ_NO") = dsT_DI_OVERTIMEWORK.NameValue(1,"REQ_NO");
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"ENO_NO") = dsT_DI_OVERTIMEWORK.NameValue(1,"ENO_NO");
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_STATUS") = kind;
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_YN") = app_yn;


        
        trT_DI_OVERTIMEWORK_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
		trT_DI_OVERTIMEWORK_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SAV";
		trT_DI_OVERTIMEWORK_STATE.post();
		
		
        document.getElementById("btn_approval").style.display = "none";//�����ư��

        
        window.close();
        

    }
    
    
    
    
    /*************************
     * 21. �˾��� ��� ó��  *
     *************************/
	function fnc_OnLoadPop() {
    	
    	
    	
		//alert("�˾��̴�");
		
		
        status = "<%=app_status%>";
        
        cmt = "<%=app_cmt%>";

        fnc_SearchList(); //�ش� ��û�� ��ȸ
        
        fnc_InputDisabled();


        
        var APP_STATUS = "";
        
        
        var Aeno_no = "";

        
            for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){

	                Aeno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");   //������
	                
					APP_STATUS = dsT_DI_APPROVAL.NameValue(i,"APP_STATUS");   //���翩��  &&  (app_yn == null)			
					
					if(Aeno_no == gusrid && ( APP_STATUS == "�̰�")){
	
						document.getElementById("btn_approval").style.display = "";
						
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "�ǰ��Է�";
						
						break;
	
	            	}
				
				
			}
            

    }
    
    
    
    /*****************************************
     * 22. �����Է��˾�(�ΰ�, �ݼ�ó��)      *
     ****************************************/
	function fnc_SubmitCancle(kind) {


        var obj = new String();

        
        window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        
        if(obj.app_cmt != undefined){

        	
        	
            dsT_DI_OVERTIMEWORK_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
            
            
            dsT_DI_OVERTIMEWORK_STATE.AddRow();
            
            
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"REQ_NO") = document.getElementById("txtREQ_NO").value;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_STATUS") = kind;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_CMT") = kind+"ó��-"+obj.app_cmt;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"KIND") = kind;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_YN") = "N";
            
            

            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
            trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SAV_03";
            trT_DI_BUSINESSTRIP_STATE.post();

            
            
            document.getElementById("btn_approval").style.display = "";
            
            

        }

        
    }
    
    
	</script>
	
	
	
</head>




<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
*                                                                                        *
***************************************************************************************-->
	<!----------------------------------------------+
    | 1. �ð� �޺� �ڽ� ó����                  	|
    | 2. �̸� : dsOT_Hour                       	|
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Hour1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <Object ID="dsT_DI_REQNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. �ð� �޺� �ڽ� ó����                  	|
    | 2. �̸� : dsOT_Hour                       	|
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Hour2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. �� �޺� �ڽ� ó����                        |
    | 2. �̸� : dsOT_Minute                         |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Minute" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_OVERTIMEWORK                 |
    | 3. Table List : T_DI_OVERTIMEWORK             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
        <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                 |
    | 2. �̸� : dsT_DI_APPROVAL               |
    | 3. Table List : T_DI_APPROVAL            |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                 |
    | 2. �̸� :                                      |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsWeekOfYear" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                 |
    | 2. �̸� :                                      |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsMonAccHour" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                 |
    | 2. �̸� :                                      |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsOTPossibleDt" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	
	
    <!--------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			      |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    
<!--*************************************
*                                       *
*  Component���� �߻��ϴ� Event ó����  *
*                                       *
**************************************-->
	<!----------------------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ���� dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
        if (iCount > 0) {
			
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			
		}
        
    </Script>
    
    <Script For=dsWeekOfYear Event="OnLoadCompleted(iCount)">
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultWkSq").innerText = dsWeekOfYear.NameValue(1,"WEEK_NO");
    		document.getElementById("resultWkterm").innerText = dsWeekOfYear.NameValue(1,"REG_YMD");
    		
    	}
    	
    	
    </Script>
    
    
    
    
    <Script For=dsMonAccHour Event="OnLoadCompleted(iCount)">
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(����) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(����) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
    		document.getElementById("resultAllow").innerText = (12 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";
    		//document.getElementById("resultWkSq").innerText = dsMonAccHour.NameValue(1,"WEEK_NO")
    		//document.getElementById("resultWkterm").innerText = dsMonAccHour.NameValue(1,"TARGET_WEEK");
    		
    		
    	} else {
    		
    		
    		document.getElementById("resultUse").innerText = "0H(����) + 0H(����) = 0H";
    		document.getElementById("resultAllow").innerText = "12H";
    		dsMonAccHour.AddRow();
    		
    		//prompt(this,dsMonAccHour.text);
    		
    	}
    	
    </Script>
    
    
    
    
    <Script For=dsOTPossibleDt Event="OnLoadCompleted(iCount)">
    	
    	if (iCount > 0) {
    		
    		
    		var catg = document.getElementById("cmbAPP_TYPE").value;
    		
    		
    		//alert(catg);
    		
    		var REQ_CNT = 0;
    		
    		
    		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
    			
    			
    			if(dsOTPossibleDt.NameString(i, "HOL_YN") == "N") {
    				
    				
    				REQ_CNT++;
    				
    				
   				}
    	
   			}
    		
    		
    		
    		if(REQ_CNT = 0) {
    			
    			alert("��û�� �� ��û/���� ���� �Ǵ� ������ ���ԵǾ� �ֽ��ϴ�.\n\n��û �Ǵ� ���簡 �Ϸ�Ǿ��ų�,\n������ ���ԵǾ� �ִ� �ٹ����� ��û�Ͽ��� ���ܵ˴ϴ�.");
    		
    		}
    		

    	}
    	

    </Script>
    
    
    
    
    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <Script For=dsWeekOfYear Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <Script For=dsMonAccHour Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <Script For=dsOTPossibleDt Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsWeekOfYear Event="OnDataError()">
        cfErrorMsg(this);
    </Script>    
    
    
    <Script For=dsMonAccHour Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsOTPossibleDt Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
        	
        	fnc_Clear();
        	
        }
        
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnFail()">
	
		cfErrorMsg(this);
		
    </script>
    
    
    
    <!------------------------------------------+
    | �׸��� ��ȸ�� ȭ�鼳�� ���� �� ���缱 ��ȸ|
    +------------------------------------------->
    <script language=JavaScript for=grdT_DI_OVERTIMEWORK event=OnExit(row,colid,olddata)>
    
	    var ovr_time = ""; 
	    
		var catg = document.getElementById("cmbAPP_TYPE").value;
		
		
		
		if(colid == "STR_OVR_TIME" || colid == "END_OVR_TIME") {
			
			
			
			if(colid == "STR_OVR_TIME") {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
				
			} else {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
				
			}
			
			
			
			if(ovr_time == "") {
				
				alert("�ð� ������ �߸��Ǿ����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(!fnc_isNumber(ovr_time)) {
				
				
				alert("���ڸ� �Է� �����մϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(ovr_time.length > 4) {
				
				
				alert("�ð������� 4�ڸ��� �ʰ��� �� �����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if( !(ovr_time.substring(2, 4) == "00" || ovr_time.substring(2, 4) == "30") ) {
				
				alert("�д����� 30�� ������ �������� �մϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			
			var STR_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
			var END_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
			
			
			
			if(catg == "AM") {
				

					if(  !((STR_TIME >= "0600" && STR_TIME <= "0900") && (END_TIME >= "0600" && END_TIME <= "0900")) ) {
						
						
						alert("���� : ���� 06:00 ~ ���� 09:00 ���̿��� ��ϰ����մϴ�.");
						
						dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
						
						return;
						
					}
				
			} else {
				
				
				if( (Number(STR_TIME.substring(0, 2)) >= 24 && Number(STR_TIME.substring(0, 2)) <= 30) || (Number(END_TIME.substring(0, 2)) >= 24 && Number(END_TIME.substring(0, 2)) <= 30)   ) {
					
					
					alert("�ùٸ� �Է½ð� ���� �ƴմϴ�.\n00:00 ~ 06:00 ���̷� �Է��Ͻʽÿ�.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
					
				}
				
				
				
				STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
				END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );
	
				
				
				if(  !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
					
					alert("���� : ���� 18:00 ~ ���� 06:00 ���̿��� ��ϰ����մϴ�.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
					
				}
				
				
				
				
			}
			
			var CALC_TIME = ((fnc_covNumber(END_TIME.substring(0, 2)) * 60) + fnc_covNumber(END_TIME.substring(2, 4))) - 
			((fnc_covNumber(STR_TIME.substring(0, 2)) * 60) + fnc_covNumber(STR_TIME.substring(2, 4)));
			
			
			
			
			if(parseInt(CALC_TIME) < 0 && STR_TIME != "" && END_TIME != "") {
				
				alert("����ð��� ���۽ð����� �۽��ϴ�.\n�ٽ� ������ �ּ���");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			
			// �ֺ� 12�ð� üũ
			if(!fnc_CalcAccReTime(dsT_DI_OVERTIMEWORK.NameString(row, "WK_MON"),dsT_DI_OVERTIMEWORK.NameString(row, "WK_FRI"),row,(CALC_TIME/60))) {
				
				alert("�ֺ� �ִ� ��ϰ����� 12�ð��� �ʰ��Ͽ����ϴ�.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			var temp_ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME");
			
			dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME") = (CALC_TIME/60);
			

		}
		
		
		
	</script>
	
	
	
	
	
	<!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

	    this.ReDraw = "false";	// �׸��� ��ü draw �� false �� ����
	
		if (bCheck == '1'){	// ��üüũ
			
			for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'T';
				
			}
		
		}else{	// ��üüũ����
			
			for (var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'F';
				
			}
		
		}
		
		this.ReDraw = "true";

    </script>
    
    <!-----------------------------------------------------+
    | grdT_DI_OVERTIMEWORK OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnClick(Row,Colid)>
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK") != "" ){
			
			var obj =  dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
	</script>
    
    <!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick ó�� - �ΰ���� ��ȸ        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

  
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ��Է�" ){

		window.showModalDialog("../../hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
	
	
  </script>
  
  
<!--
**************************************************************
* BODY START
**************************************************************
-->




<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>




<!-- Ķ���� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>



<!-- form ���� -->
<form name="form1">




<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left">
		</td>
		<td height="35" class="paddingTop5" align="right">
			 <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">
				<img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_SubmitApproval('����');">
				</a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">
				<img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('�ΰ�');">
				</a>
 			</span>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->





<p><br></p>	




<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
			<table width="210" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							
							<tr height="28">
								<td align="center" class="blueBold">��û��ȣ</td>
								<td class="padding2423">
									<input id="txtREQNO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            
                          <!--   <tr height="27">
								<td align="center" class="blueBold">�Ҽ�</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">����</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">��û��</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr> -->
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
			
			
			
        </td>
        <td width="25">&nbsp;</td>
        <td>
        
        
        	<!-- ���缱 ���� ���̺� ���� -->
			<table width="900" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:780px;height:100px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NM'			width=70	name='����'				align=center	Value={IF(SEQ_NO > '90','����', '����')}</C>
								<C> id='ENO_NM'			width=90	name='������'			align=center	</C>
								<C> id='JOB_NM'			width=80	name='����'				align=center	</C>
                                <C> id='DPT_NM'			width=150	name='��'				align=center	</C>
								<C> id='APP_STATUS'		width=250	name='�������'			align=center    </C>
								<C> id='REMARK1'		width=120	name='�ǰ�'				align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
       		  </table>
        	<!-- ���缱 ���� ���̺� �� -->
        	
        	
        </td>
    </tr>
</table>





<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">* �� �����ð�(����+����)�� ���/������/����Ϸ��� ������ ������ �ð��Դϴ�.</span></td>
				</tr>
			</table>
		</td>

	</tr>
</table>




<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:250px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="Editable"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='{CUROW}'			width=40			name='NO'				align=center			value={String(Currow)}		</C>							
								<C> id='JOB_NM'				width=60			name='����'				align=center			Edit=none		</C>
								<C> id='ENO_NO'				width=80			name='���'				align=center			Edit=none		</C>
								<C> id='ENO_NM'				width=80			name='����'				align=center			Edit=none		</C>
								<C> id='STR_REG_YMD'		width=100			name='�ٹ�����'			align=center			Edit=none MASK='XXXX-XX-XX' </C>
								<C> id='REQ_NO'				width=50			name='��û��ȣ'			align=center			Edit=none show=false</C>
								<C> id='STR_OVR_TIME'		width=80			name='���۽ð�'			align=center			Edit=none		MASK='XX:XX'</C>
								<C> id='END_OVR_TIME'		width=80			name='����ð�'			align=center			Edit=none		MASK='XX:XX'</C>
								<C> id='OVR_TIME'			width=80			name='�ѱٹ��ð�'		align=center			Edit=none</C>
								<C> id='REMARK'				width=380			name='�ٹ�����'			align=center			Edit=none		</C>
								<C> id='APP_REMARK'			width=40			name='������'			align=center			Edit=none show=false</C>
							">
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
