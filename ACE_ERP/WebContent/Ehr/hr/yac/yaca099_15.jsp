<!--*************************************************************************
* @source      : yaca099_15.jsp                  *
* @description : ���ڹ��� ���ε�  - �ſ�ī�� PDF���� ���ε�                                                  *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2016/01/06           ������             �����ۼ�                                        *
***********************************************************************--*-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    request.setCharacterEncoding("euc-kr"); 
    
    String PIS_YY       = request.getParameter("PIS_YY");        
    String ENO_NO       = request.getParameter("ENO_NO");
    String ENO_NM       = request.getParameter("ENO_NM");
    String CET_NO       = request.getParameter("CET_NO");
    
	boolean itMaster = false;     
 	
	itMaster = true;     
%>


<html>
    <head>
    <title>���ڹ������ε�(2015�⵵)</title>
    
    <jsp:include page="/Ehr/common/include/head.jsp"/>  	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language=javascript src="../../common/calendar/calendar.js"></script>
<%
    /* ���� �˾�â���� ���� ���� (���, ����) */
   
%>

<%
    /*
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String YAC_AUTHO  = box.getString("SESSION_YAC_AUTHO");
    String ENO_NO    = box.getString("SESSION_ENONO");    
    
    //ROLE_CD�� IT���� ����
    boolean itMaster = false;
    
    if(ROLE_CD.equals("1001")) {
        itMaster = true;
    }
    
    //���������� �ƴ��� ����
    boolean isMaster = false;
    boolean isSave   = false;  //�Է� ���� �� �߰� �Է��ϴ� �ο� ����
    
    if(YAC_AUTHO.equals("M")) {
        isMaster = true;
    }else if(YAC_AUTHO.equals("Y")) {
        isSave = true;
    }
    
    */

%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';
        var today   = getToday();
        /* ���� �˾�â���� ���� ���� (���, ����) */
<%--        "<%=request.getParameter("ENO_NO")%>";  --%>
<%--        "<%=request.getParameter("ENO_NM")%>";  --%>
<%--        "<%=request.getParameter("PIS_YY")%>"; --%>
        var opener = window.dialogArguments;
        
        //�Ѿ�� ������ ó��
		var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var ENO_NO = "<%=request.getParameter("ENO_NO") %>";
		var ENO_NM = "<%=request.getParameter("ENO_NM") %>";
		var CET_NO = "<%=request.getParameter("CET_NO") %>";
        
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;        
            var key = PIS_YY+"_"+ENO_NO;
            
            trFILE_CONVERT.KeyValue = "SVL(O:dsT_AC_FAMILY_TEMP=dsT_AC_FAMILY_TEMP)";
            trFILE_CONVERT.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD&S_MODE=SHR&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
            
            trFILE_CONVERT.post();
            
            dsT_AC_FAMILY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD&S_MODE=SHR_CHK&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
            dsT_AC_FAMILY.reset();
            
            fnc_GetFileList('dsFILE1', key); 
            
        }
        
        /***********************************
         * . ����÷���Ͽ� ���� ���̺� ����� ���� ��ȸ  *
         ***********************************/
        function fnc_Famliy_Update_SearchList() {
        	
        	
        	if(!fnc_UpdateItemCheck()) return;
        	
        	
        	if(confirm("�����Ű� �Է��ϸ� �� �̻� �ſ�ī��,����ī��,���ݿ������� ���� ���ε� �� �� �����ϴ�. �Է��Ͻðڽ��ϱ�?")){
          
	            var PIS_YY = form1.txtPIS_YY_SHR.value;
	            var ENO_NO = form1.txtENO_NO_SHR.value;     
	            var params = null;
	           
	            var params = "&S_MODE=FAM_SHR"
	                        + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
	                        + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
	
	            var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD";
	
	            trT_AC_FAMILY_UPDATE.KeyValue = "tr"
		                                + "(O:dsT_AC_FAMILY_UPDATE=dsT_AC_FAMILY_UPDATE)";
	            trT_AC_FAMILY_UPDATE.action = dataClassName+params;
	            trT_AC_FAMILY_UPDATE.post();
	            
	            fnc_SearchList();
        	}
   
        }
        
        
        /***********************************
         *  ���� ���������� ��ȸ �� 
         *  FAMILY, RETACC�� UPDATE �� TEMP UPDATE
         ***********************************/
        function fnc_Family_Card_Update(){
        
        	 var params = "&S_MODE=FAM_UPT"
                 + "&PIS_YY="+document.getElementById("txtPIS_YY_SHR").value
                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
        	
        	 dsT_AC_FAMILY_UPDATE.UseChangeInfo = false;

		     var dataClassName = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD";
		
		     trT_AC_FAMILY_UPDATE2.KeyValue = "tr"
		                             + "(I:dsT_AC_FAMILY_UPDATE=dsT_AC_FAMILY_UPDATE)";
		     trT_AC_FAMILY_UPDATE2.action = dataClassName+params;

		     //prompt('dsT_AC_FAMILY_UPDATEdsT_AC_FAMILY_UPDATE',dsT_AC_FAMILY_UPDATE.text); 
		     trT_AC_FAMILY_UPDATE2.post();		     
		     
        }
        
        /******************************
         *     �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }
        
 		function fnc_UpdateItemCheck() {
 			
			if(dsT_AC_FAMILY_TEMP.COUNTROW < 1 ) {
	            alert("�Է��� �����Ͱ� �������� �ʽ��ϴ�.");
	            return false;
	        }
 			
			
			//alert("LOCK_YN"+dsT_AC_FAMILY_TEMP.namevalue(1,"LOCK_YN"));
            
            if(dsT_AC_FAMILY_TEMP.namevalue(1,"LOCK_YN")=="Y") {
                alert("�̹� �����Ű� �ԷµǾ����ϴ�.");
                return false;
            }
            
            return true;
           
        }


        /******************
         * 02. ���� ��ȯ �� ���� �Լ�  *
         ******************/
        function fnc_Save() {
        	
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;
            
            if(!fnc_SaveItemCheck()) return;
           	
            trFILE_CONVERT.KeyValue = "SVL(I:dsT_AC_FAMILY_TEMP=dsT_AC_FAMILY_TEMP)";
            trFILE_CONVERT.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD&S_MODE=SAV&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO+"&DEL_TAG=N&CET_NO="+CET_NO;
            
           //prompt("dsT_AC_FAMILY_TEMP",dsT_AC_FAMILY_TEMP.text);
            
            trFILE_CONVERT.post();
            
            alert("���ڹ����� ��ϵǾ����ϴ�.\n ���ε� ������ Ȯ�� �� [�����Ű� �Է�]�� Ŭ���ϼž� �մϴ�.");
            
            fnc_SearchList();
        }
        
        /*************************
         *     ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
            
            if(!dsT_AC_FAMILY_TEMP.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                return false;
            }
            
            return true;
           
        }
        
        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
        	
        	//alert("fnc_Delete");
            
            //var PIS_YY = form1.txtPIS_YY_SHR.value;
            //var ENO_NO = form1.txtENO_NO_SHR.value;
            var file_seq = "";
            
            var my_cet = "";
            var app_yn = "";
           
            if(dsFILE1.CountRow < 1) {
                alert("������ ������ �������� �ʽ��ϴ�1.");
                return;
            }
            
            /*
            if(dsT_AC_FAMILY_TEMP.namevalue(1,"LOCK_YN")=="Y") {
                alert("�̹� �����Ű� �ԷµǾ����ϴ�. ���� �Ұ��մϴ�.");
                return false;
            }
            */
             
            
            if(!fnc_DeleteItemCheck(my_cet, file_seq)) return;
            
            file_seq = dsFILE1.NameValue(dsFILE1.RowPosition,"SEQ_NO");
            
            if(!confirm("����NO("+file_seq + ") "+dsFILE1.NameValue(dsFILE1.RowPosition,"FILE_NAME")+"\n�ڷḦ �����Ͻðڽ��ϱ�?")) return;            
           
            /*
            for(var j=1; j<= dsT_AC_FAMILY.CountRow; j++) {
                if(dsT_AC_FAMILY.NameValue(j,"REL_CD") == "0") {
                    my_cet = dsT_AC_FAMILY.NameValue(j,"CET_NO");
                    ///med_cnt = dsT_AC_FAMILY.NameValue(j,"MED_CNT");
                    ///pen_cnt = dsT_AC_FAMILY.NameValue(j,"PEN_CNT");
                    ///don_cnt = dsT_AC_FAMILY.NameValue(j,"DON_CNT");
                }
            }
            */
            
           
            
            dsT_AC_FAMILY_TEMP.ViewDeletedRow = true;
            
            for(var i = 1; i<= dsT_AC_FAMILY_TEMP.CountRow; i++) {
                if(dsT_AC_FAMILY_TEMP.NameValue(i,"FILE_SEQ") == file_seq) {
                    dsT_AC_FAMILY_TEMP.DeleteRow(i);
                }
            }
            
          
            
            //dsFILE1.DeleteRow(dsFILE1.RowPosition);
            
            
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;
            
            //if(!fnc_SaveItemCheck()) return;
           	
            trFILE_CONVERT.KeyValue = "SVL(I:dsT_AC_FAMILY_TEMP=dsT_AC_FAMILY_TEMP)";
            trFILE_CONVERT.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD&S_MODE=SAV&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO+"&DEL_TAG=Y&CET_NO="+CET_NO+"&FILE_SEQ="+file_seq;
            
           //prompt("dsT_AC_FAMILY_TEMP",dsT_AC_FAMILY_TEMP.text);
            
            trFILE_CONVERT.post();
            
            /*
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;
        	
			trFILE_CONVERT.Parameters = "PIS_YY="+PIS_YY+",ENO_NO="+ENO_NO;					
            trFILE_CONVERT.KeyValue = "tr01(I:dsT_AC_FAMILY_TEMP=dsT_AC_FAMILY_TEMP)";
            trFILE_CONVERT.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA0099CMD&S_MODE=SAV&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO+"&DEL_TAG=Y&CET_NO="+CET_NO;
            trFILE_CONVERT.post();
            */
            fnc_FileDelete('dsFILE1',1,'D');
            
            fnc_SearchList();
            
            
       
            
            
        }
        
        /*********************
        *   ���� ��ȿ�� üũ *
        **********************/
        function fnc_DeleteItemCheck(my_cet, file_seq) {
        	
        	 if(dsT_AC_FAMILY_TEMP.namevalue(1,"LOCK_YN")=="Y") {
                 alert("�̹� �����Ű� �ԷµǾ����ϴ�. ���� �Ұ� �մϴ�. \n �� �ʿ�� [������]�� �����ٶ��ϴ�.");
                 return false;
             }
        	
        	
        	/*
            var fam_no = 0;
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;        
            
            for(var i = 1; i<= dsT_AC_FAMILY_TEMP.CountRow; i++) {
                if(dsT_AC_FAMILY_TEMP.NameValue(i,"FILE_SEQ") == file_seq && dsT_AC_FAMILY_TEMP.NameValue(i,"APP_YN") == "Y" && dsT_AC_FAMILY_TEMP.NameValue(i,"CET_NO") != my_cet) {
                    alert("�ش� ���ڹ����� �̹� �ξ簡������ ��ϵǾ����ϴ�.\n�ξ簡�����׵�Ͽ��� �ξ簡�� ���� �� ���ڹ��� �����ϼ���.\n�ξ簡�� ����: "+dsT_AC_FAMILY_TEMP.NameValue(i,"NAM_KOR"));
                    return false;
                }else if(dsT_AC_FAMILY_TEMP.NameValue(i,"FILE_SEQ") == file_seq && dsT_AC_FAMILY_TEMP.NameValue(i,"APP_YN") == "Y" && dsT_AC_FAMILY_TEMP.NameValue(i,"CET_NO") == my_cet) {
                    if(!confirm("�̹� ��ϵ� ������ ����û �ڷᰡ �����˴ϴ�.\n��� �����Ͻðڽ��ϱ�?")) return false;
                }
            }
            */
            
            return true;
        }

        /******************
         * 04. �μ� �Լ�  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
        	     	
        	document.form1.txtPIS_YY_SHR.value = PIS_YY;
        	document.form1.txtENO_NO_SHR.value = ENO_NO;
		    document.form1.txtENO_NM_SHR.value = ENO_NM;
		    
            cfStyleGrid_New(form1.grdT_AC_FAMILY_TEMP,15,"false","false"); 
            cfStyleGrid_New(form1.grdT_AC_FAMILY,15,"false","false"); 
            
            
            var key     = form1.txtPIS_YY_SHR.value+"_"+form1.txtENO_NO_SHR.value;
            
            fnc_ChangeStateElement(false, "txtPIS_YY_SHR");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");
            
            document.getElementById("ImgEnoNo").style.display = "none";
            document.getElementById("btnUPLOAD").style.display = "";
            document.getElementById("btnDEL").style.display = "";
            
<%
//1. ������������ڱ��� 
  if(itMaster) {
%>             
            fnc_ChangeStateElement(false, "txtPIS_YY_SHR");
            fnc_ChangeStateElement(true, "txtENO_NO_SHR");
            fnc_ChangeStateElement(true, "txtENO_NM_SHR");
            fnc_ChangeStateElement(true, "ImgEnoNo");
            document.getElementById("ImgEnoNo").style.display = "";
            
            document.getElementById("btnUPLOAD").style.display = "";
            document.getElementById("btnDEL").style.display = "";
            
<%
}
%> 

            fnc_SearchList();
            
            //alert("fnc_OnLoadProcess  key"+key);
            ////fnc_GetFileList('dsFILE1', key);
                        
        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {  
           
            window.close();
              
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

        }

        /********************************************
         * ÷������ ó��                          *
         ********************************************/
        function fnc_FileUpload(dsfile, fileType) {
        	
        	var vdsfile = document.getElementById(dsfile);
            var isHan   = false;
            var key     = form1.txtPIS_YY_SHR.value+"_"+form1.txtENO_NO_SHR.value;
            
            if(fileType == 2) isHan = true;
            
            if(!fnc_AddFile(dsfile, key, isHan)) {            	           	
                return;
            }
            
            fnc_InsFile(dsfile);
        }

        /********************************************
         * ÷������ ����                          *
         ********************************************/
        function fnc_FileDelete(dsfile, fileType, gbn) {
        	
            var vdsfile = document.getElementById(dsfile);
            var row = "";

            if(vdsfile.CountRow < 1) {
                alert("������ ������ �������� �ʽ��ϴ�2.");
                return;
            }
            
            if(gbn == "C") { //�Է� ���
                vdsfile.DeleteRow(vdsfile.CountRow);
            }else if(gbn == "D") { //����� ������ ����
                vdsfile.DeleteRow(vdsfile.RowPosition);
            }
            
            fnc_DelFile(dsfile);

          
        }

        function fnc_AddFile(dsfile, key, isHan) {
            var vdsFILE = document.getElementById(dsfile);
            var foFILE = document.getElementById("foFILE");

            var fileUrl;
            var fileName;

            if (vdsFILE.CountColumn == 0){
                vdsFILE.setDataHeader("KEY:STRING, SEQ_NO:INT, FILE_NAME:STRING, FILE_URL:STRING, UPLOAD_URL:URL");
            }

            vdsFILE.Do("FileUploadShareWrite", "TRUE");
            vdsFILE.addrow();

            foFILE.Open();

            if(foFILE.SelectState != true) {
                vdsFILE.deleterow(vdsFILE.RowPosition);
                return false;
            }

            fileUrl = foFILE.value;
            fileName = fileUrl.substring(fileUrl.lastIndexOf("\\") + 1, fileUrl.length);

            if(isHan != undefined && isHan == true) {
                    var obj = fileName.split(".");
                    var ext;
                    var cnt = 0;

                    cnt = obj.length - 1;
                    ext = obj[cnt].toLowerCase();

            }

            vdsFILE.NameValue(vdsFILE.RowPosition, "KEY")       = key;
            vdsFILE.NameValue(vdsFILE.RowPosition, "FILE_URL")  = fileUrl;
            vdsFILE.NameValue(vdsFILE.RowPosition, "UPLOAD_URL")= fileUrl;
            vdsFILE.NameValue(vdsFILE.RowPosition, "FILE_NAME") = fileName;

            return true;
        }

        function fnc_InsFile(dsfile) {
        	
            var trFILE = document.getElementById("trFILE");
            var file_url = "";
            var file_seq = "";
            var key      = form1.txtPIS_YY_SHR.value+"_"+form1.txtENO_NO_SHR.value;

            trFILE.KeyValue = "file(I:FILE="+dsfile+")";
            trFILE.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=INS";
            trFILE.Parameters = "ENO_NO="+ENO_NO;	
            trFILE.post();
            
                      
           // alert("fnc_InsFile2 fnc_GetFileList ");
            
            fnc_GetFileList(dsfile, key);
            file_url = dsFILE1.NameValue(dsFILE1.CountRow,"FILE_URL");
            file_seq = dsFILE1.NameValue(dsFILE1.CountRow,"SEQ_NO");
            
           // alert("fnc_InsFile3 fnc_Convert ");
            fnc_Convert(file_url, file_seq);
        }

        function fnc_DelFile(dsfile) {
            var trFILE = document.getElementById("trFILE");

            trFILE.KeyValue = "file(I:FILE="+dsfile+")";
            trFILE.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=DEL";
            
            //prompt('dsfile',dsfile.text);
            
            trFILE.post();
        }

        function fnc_GetFileList(dsfile, key) {
        	
            var vdsFILE = document.getElementById(dsfile);

            vdsFILE.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=SHR&KEY="+key;
            vdsFILE.Reset();
          
        }

        function fnc_Down(){
            
            if(dsFILE1.CountRow < 1) {
                alert("�������� ������ �������� �ʽ��ϴ�.");
                return;
            }
            
            var vFILE_NAME  = document.getElementById("dsFILE1").NameValue(dsFILE1.RowPosition, "FILE_NAME");
            var vFILE_URL   = document.getElementById("dsFILE1").NameValue(dsFILE1.RowPosition, "FILE_URL");
            
             //÷�� ������ �����ϴ� ��츸 �����ϰ�~
             if (vFILE_NAME != "" && vFILE_URL != "") {
    
                 cfDownload(vFILE_NAME, vFILE_URL);
             }
        }
        
        /*********************
        *       ������ȯ     *
        **********************/
        function fnc_Convert(file_url, file_seq){
        	
        	//alert("fnc_Convert ������ȯ::;CET_NO"+CET_NO);
            
            var PIS_YY = form1.txtPIS_YY_SHR.value;
            var ENO_NO = form1.txtENO_NO_SHR.value;
            
            //CET_NO ="620101-1234567";
            
            trFILE_CONVERT.KeyValue = "SVL(O:dsRESULT=dsRESULT, O:dsT_AC_FAMILY_FILE=dsT_AC_FAMILY_FILE )";
            trFILE_CONVERT.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca099.cmd.YACA099CMD&S_MODE=FILE&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO+"&FILE_URL="+file_url+"&FILE_SEQ="+file_seq+"&CET_NO="+CET_NO;
            
            //prompt("dsRESULT",dsRESULT.text);
            //prompt("dsT_AC_FAMILY_FILE",dsT_AC_FAMILY_FILE.text);
            
            trFILE_CONVERT.post();
            
            //alert("RESULT:"+dsRESULT.NameValue(1,"RESULT")+":::::::::"+dsT_AC_FAMILY_FILE.CountRow);
            
            
            
            
            if(dsRESULT.NameValue(1,"RESULT") != "OK" || dsT_AC_FAMILY_FILE.CountRow < 1) {
            	
            	//alert("���������");
            	
                //alert(dsRESULT.NameValue(1,"RESULT"));
                
                dsT_AC_FAMILY_FILE.ClearData();
                /*
                dsT_AC_PENSION_FILE.ClearData();
                dsT_AC_MEDICAL_FILE.ClearData();
                dsT_AC_DONATION_FILE.ClearData();
                dsT_AC_INSURANCE_FILE.ClearData();
                */
                
                fnc_FileDelete('dsFILE1',1,'C');
                return;
            }
            
            //alert("fnc_Compare")
            
            if(!fnc_Compare()) return;
            
            fnc_Copy();
            
            fnc_Save();
        }
        
        /**************************
        *     �����ͼ� ī��       *
        ***************************/
        function fnc_Copy() {
        	
        	//alert("fnc_Copy");
            
            var strFamily = "";
            var strPension = "";
            var strMedical = "";
            var strDonation = "";
            
            
           //alert("dsT_AC_FAMILY_FILE.CountRow::"+dsT_AC_FAMILY_FILE.CountRow);
           //prompt("dsT_AC_FAMILY_FILE",dsT_AC_FAMILY_FILE.text);  
            
                        
            //1. �������� (T_AC_FAMILY)
            if(dsT_AC_FAMILY_FILE.CountRow > 0) {
                for(var i = 1; i<= dsT_AC_FAMILY_FILE.CountRow; i++) {
                	
                	//alert("i"+i+":::"+dsT_AC_FAMILY_FILE.namevalue(i,"PIS_YY")+"::"+dsT_AC_FAMILY_FILE.namevalue(i,"CARD_AMT_NTS"));
                	
                    dsT_AC_FAMILY_TEMP.AddRow();
                    for(var j=0; j<=dsT_AC_FAMILY_FILE.CountColumn; j++) {
                    	
                        dsT_AC_FAMILY_TEMP.NameValue(dsT_AC_FAMILY_TEMP.RowPosition, form1.grdT_AC_FAMILY_FILE.GetColumnID(j)) = dsT_AC_FAMILY_FILE.NameValue(i, form1.grdT_AC_FAMILY_FILE.GetColumnID(j));                        
                    }
                }
            }
            
          
            //prompt("dsT_AC_FAMILY_TEMP",dsT_AC_FAMILY_TEMP.text);  
            
            dsT_AC_FAMILY_FILE.ClearData();
        
        }
        
        /**************************
         *     �ߺ� ������ ��    *
         ***************************/
         function fnc_Compare() {
            
            var ng_no = 0;
            
            //�ξ簡������
            if(dsT_AC_FAMILY_TEMP.CountRow > 0 && dsT_AC_FAMILY_FILE.CountRow > 0) {
                for(var i = 1; i<= dsT_AC_FAMILY_TEMP.CountRow; i++) {
                    for(var j=1; j<= dsT_AC_FAMILY_FILE.CountRow; j++) { 
                    	
                    	//alert("FORM_CD::"+dsT_AC_FAMILY_TEMP.NameValue(i,"FORM_CD")+"::"+dsT_AC_FAMILY_FILE.NameValue(j,"FORM_CD"));
                    	
                        if(dsT_AC_FAMILY_TEMP.NameValue(i,"CET_NO") == dsT_AC_FAMILY_FILE.NameValue(j,"CET_NO")&&dsT_AC_FAMILY_TEMP.NameValue(i,"FORM_CD")==dsT_AC_FAMILY_FILE.NameValue(j,"FORM_CD")) {
                            ng_no = ng_no + 1;
                        }
                    }
                }
                
                if(ng_no > 0) {
                    alert("�̹� ����� �ڷ�� �ߺ��˴ϴ�");
                    
                    dsT_AC_FAMILY_FILE.ClearData();
               
                    fnc_FileDelete('dsFILE1',1,'C');
                    return false;
                }
            }
          
            
            return true;
            
        }
         
        /**************************
         *  ���ε� �� PDF ���� SAVE
         *  UPDATE ó��
         *  T_AC_FAMILY_15
         *  T_RETACC_15   
         *
         ***************************/
         function fnc_Upload_Save() { 
        	
        	fnc_Famliy_Update_SearchList();
        	 
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DO_DOCUMENT2) |
    | 3. ���Ǵ� Table List(T_DO_DOCUMENT2 )       |
    +----------------------------------------------->
    <object id="dsFILE1" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"       value="true">
    </object>
    
    <Object ID="dsT_AC_FAMILY"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>
    
    <Object ID="dsT_AC_FAMILY_TEMP"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>
    
    
    <Object ID="dsT_AC_FAMILY_UPDATE"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
    </Object>
    
    <Object ID="dsT_AC_RETACC_UPDATE"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
    </Object>
    
   
    
    <Object ID="dsT_AC_FAMILY_FILE"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>
    
    
     <Object ID="dsRESULT"   ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"       Value="True">
        <Param Name="UseChangeInfo"  Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>
    
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_FB"/>
       <jsp:param name="CODE_GUBUN"    value="FB"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    
    
    
    
        
    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_SEQ" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"      value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=foFILE classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE style="display:none" >
        <param name="Enable"        value="true">
    </object>    
    
    <!-- Ʈ������ ���� [���� ÷�ο�] -->
    <Object ID="trFILE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName         Value="toinb_dataid4">
    </Object>
    
    <!-- ���� ó�� Ʈ������ -->
    <Object ID="trFILE_CONVERT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName             Value="dataid">
        <param name="StatusResetType"   Value="1">
    </Object>
    
    
    <Object ID="trT_AC_FAMILY_UPDATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	
	 <Object ID="trT_AC_FAMILY_UPDATE2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	        
    
    

    <script for=trFILE event="OnSuccess()">
        if(dsFILE.CountRow > 0) {
            fnc_GetFileList(dsFILE.NameValue(1, "KEY"));
        }
    </script>

    <script for=trFILE event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    
    
    <script for=trT_AC_FAMILY_UPDATE event="OnSuccess()">
    
        //alert("OnSuccess()::"+dsT_AC_FAMILY_UPDATE.CountRow );
    
        if(dsT_AC_FAMILY_UPDATE.CountRow > 0) {
            fnc_Family_Card_Update();
        }
    </script>

    <script for=trT_AC_FAMILY_UPDATE event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    
     <script for=trT_AC_FAMILY_UPDATE2 event="OnSuccess()">
    
       alert("���������� �����Ű��� �Է� �Ǿ����ϴ�.");
    </script>

    <script for=trT_AC_FAMILY_UPDATE2 event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    <script language="javascript" for=grdFILE event=OnDblClick(row,colid)>
    
    var vFILE_NAME  = document.getElementById("dsFILE1").NameValue(row, "FILE_NAME");
    var vFILE_URL   = document.getElementById("dsFILE1").NameValue(row, "FILE_URL");
    
     //÷�� ������ �����ϴ� ��츸 �����ϰ�~
     if (vFILE_NAME != "" && vFILE_URL != "") {

         cfDownload(vFILE_NAME, vFILE_URL);
     }
    
    </script>
    
     <script for=trFILE_CONVERT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>
    
    <script for=trFILE_CONVERT event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">���ڹ������[�ſ�ī���]</td>
                     <td align="right" class="navigator">HOME/���꼼��/��������/<font color="#000000">���ڹ������</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right" colspan="8">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
<!--             <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">         <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a> -->
<!--             <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)">     <img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">         <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" class="greenTable">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="200"></col>
                        <col width="80"></col>
                        <col width="140"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="right" class="searchState">�ͼӳ⵵&nbsp;</td>
                        <td class="padding2423">
                        <input id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" size="5">
                        </td>
                        <td align="right" class="searchState">���&nbsp;</td>
                        <td class="padding2423">
                            <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                            <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="800" border="0" cellspacing="0" cellpadding="0" align = "right">
                <tr>
                    <td width="40%"  >
                        &nbsp;
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',3)"><img src="../../images/button/FileAddOn.gif" id="btnUPLOAD" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload('dsFILE1',1)" ></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEL','','../../images/button/FileDelOver.gif',3)">   <img src="../../images/button/FileDelOn.gif" id="btnDEL"    name="btnDEL"    width="80" height="20" border="0" align="absmiddle" onclick="fnc_Delete()" ></a>
                        <comment id="__NSID__">
                        <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%; height:80px;">
                            <param name="DataID"                value="dsFILE1">
                            <param name="Editable"              value="false">
                            <param name="DragDropEnable"        value="true">
                            <param name="UseOneColumnScroll"    value="true">
                            <param name="SortView"              value="Left">
                            <param name="ViewHeader"            value="false">
                            <param name="Format"                value='
                                <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)} </C>
                                <C> id=FILE_NAME    width="500"     name="���ϸ�"     align="left"    leftmargin="10" </C>
                                <C> id=SEQ_NO       width="50"      name="FILE_SEQ"   align="left"    leftmargin="10" </C>
                             '>
                        </object> </comment><script> __ShowEmbedObject(__NSID__); </script>                        
                    </td> 
                    <td width="40%" align="left" valign="bottom" class="padding2423" style="display:none">
                        <img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"><b>&nbsp;��ϵ� �ڷ� ����Ʈ</b>
                        <comment id="__NSID__">
                        <object id="grdT_AC_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:100%;height:80px;">
                            <param name="DataID"            value="dsT_AC_FAMILY">
                            <param name="Editable"          value="false">
                            <param name="DragDropEnable"    value="true">
                            <param name="SortView"          value="Left">
                            <param name="Format"            value='
                                <C> id="{CUROW}"    width=30        align=center        name="NO"         value={String(Currow)}  </C>
                                <C> id="REL_CD"     width=40        align=center        name="REL_CD"     Show=false </C>
                                <C> id="REL_NM"     width=117       align=center        name="����"       </C>
                                <C> id="NAM_KOR"    width=70        align=center        name="����"       </C>
                                <C> id="CET_NO"     width=80        align=center        name="�ֹι�ȣ"   Show=true </C>
                                 
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>              
                </tr>
                <tr>
                    <td colspan="2">
                        <font color="blue">�� [�����Ű� �Է�] Ŭ�� �� ����÷��, ���ϻ����� �Ұ��մϴ�.  <br> 
                        &nbsp;&nbsp;&nbsp;&nbsp;�������  <font color="red"> [�ſ�ī��, ����ī��, ���ݿ�����]</font> ÷�� �� �������� <font color="red"> [�����Ű� �Է�]</font> ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�.
                       </font>
                    </td>
                </tr>
           </table>
        <td>
    </tr>
</table>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5"><img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"><b>&nbsp;���ε� ������</b>&nbsp;&nbsp;
        <button id="btnPRO_PERSON"  style="cursor:hand;width:140pt;height:15pt;" onclick="fnc_Upload_Save();"><font color="red"><b>&nbsp;[�����Ű� �Է�] Click!</b></font></button>      
        </td>
    </tr>
    <tr>
        <td>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr align="center">
                <td>
                <comment id="__NSID__">
                <object id="grdT_AC_FAMILY_TEMP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:430px;">
                    <param name="DataID"            value="dsT_AC_FAMILY_TEMP">
                    <param name="Editable"          value="false">
                    <param name="DragDropEnable"    value="true">
                    <param name="SortView"          value="Left">
                    <param name="Format"            value='
                        <FC> id="{CUROW}"    width=30        align=center        name="NO"         value={String(Currow)}  </FC>
                        <FC> id="FILE_SEQ"   width=45        align=center        name="����\\NO"       </FC>
                        <FC> id="NAM_KOR"    width=50        align=center        name="����"         </FC>
                        <FC> id="CET_NO"     width=90        align=center        name="�ֹι�ȣ"                mask="XXXXXX-XXXXXXX" </FC>
                        
                        <FC> id="FORM_CD"     width=80        align=center        name="����1"           RightMargin=5    </FC>
                        <G> name="2015�⵵ " HeadBgColor="#dae0ee"
                        <C> id="TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2015�⵵ ��ݱ� " HeadBgColor="#dae0ee"
                        <C> id="CF_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="CF_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="CF_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2015�⵵ �Ϲݱ� " HeadBgColor="#dae0ee"
                        <C> id="CS_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="CS_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="CS_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2014�⵵" HeadBgColor="#dae0ee"
                        <C> id="PR_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="PR_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="PR_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2013�⵵" HeadBgColor="#dae0ee"
                        <C> id="FT_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="FT_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="FT_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <C> id="LOCK_YN"   width=60   align=center       name="�Է±���"         RightMargin=5   EditStyle=Combo  Data="Y:�Է¿Ϸ�,N:���Է�,:���Է�" </C>
                        
                        <G> name="2015�⵵ �ſ�ī�� �� �ҵ����" HeadBgColor="#dae0ee"
                            <C> id="CARD_AMT_NTS"        width=70        align=right        name="�ſ�ī���"           RightMargin=5  show=false  </C>
                            <C> id="CASH_AMT_NTS"        width=70        align=right        name="���ݿ�����"           RightMargin=5   show=false </C>
                            <C> id="DIR_CARD_AMT_NTS"    width=70        align=right        name="����ī��"             RightMargin=5   show=false </C>
                            <C> id="MARKET_AMT_NTS"      width=70        align=right        name="�������"             RightMargin=5  show=false  </C>
                            <C> id="PUBLIC_AMT_NTS"      width=70        align=right        name="���߱���"             RightMargin=5  show=false  </C>
                        </G>
                        
                         <G> name=" ���� 2015�⵵ " HeadBgColor="#dae0ee"
                           <C> id="CARD_2015_AMT"       width=80        align=right        name="ī������"        RightMargin=5   show=false </C>
                           <C> id="CARD_2015_FH_OVER"   width=80        align=right        name="��ݱ��߰�������"      RightMargin=5   show=false </C>
                           <C> id="CARD_2015_SH_OVER"   width=80        align=right        name="�Ϲݱ��߰�������"      RightMargin=5   show=false </C>
                        </G>
                        
                        <G> name=" ���� 2014�⵵ " HeadBgColor="#dae0ee"
                            <C> id="CARD_2014_AMT"      width=95        align=right        name="ī������"  RightMargin=5     show=false</C>
                            <C> id="CARD_2014_OVER"     width=95        align=right        name="�߰�������"       RightMargin=5  show=false  </C>
                        </G>
                        
                         <G> name=" ���� 2013�⵵ " HeadBgColor="#dae0ee"
                            <C> id="CARD_2013_AMT"      width=95        align=right        name="ī������"  RightMargin=5    show=false</C>
                            <C> id="CARD_2013_OVER"     width=95        align=right        name="�߰�������"       RightMargin=5 show=false   </C>
                        </G>
                        
                       
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
                </td>
                <td style="display:none">
                <comment id="__NSID__">
                <object id="grdT_AC_FAMILY_FILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:300px;">
                    <param name="DataID"            value="dsT_AC_FAMILY_FILE">
                    <param name="Editable"          value="false">
                    <param name="DragDropEnable"    value="true">
                    <param name="SortView"          value="Left">
                    <param name="Format"            value='
                        <FC> id="{CUROW}"    width=30        align=center        name="NO"         value={String(Currow)}  </FC>
                        <FC> id="FILE_SEQ"   width=45        align=center        name="����NO"       </FC>
                        <FC> id="PIS_YY"     width=50        align=center        name="���"         </FC>
                        <FC> id="ENO_NO"     width=50        align=center        name="���"         </FC>
                        <FC> id="NAM_KOR"    width=50        align=center        name="����"         </FC>
                        <FC> id="CET_NO"     width=90        align=center        name="�ֹι�ȣ"                mask="XXXXXX-XXXXXXX" </FC>
                       
                        <C> id="FORM_CD"     width=80        align=right        name="����1"           RightMargin=5    </C>
                        <C> id="GB_CD"     width=80        align=right        name="����1"           RightMargin=5    </C>
                        <G> name="2015�⵵ " HeadBgColor="#dae0ee"
                        <C> id="TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2015�⵵ ��ݱ� " HeadBgColor="#dae0ee"
                        <C> id="CF_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="CF_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="CF_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2015�⵵ �Ϲݱ� " HeadBgColor="#dae0ee"
                        <C> id="CS_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="CS_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="CS_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2014�⵵" HeadBgColor="#dae0ee"
                        <C> id="PR_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="PR_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="PR_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        <G> name="2013�⵵" HeadBgColor="#dae0ee"
                        <C> id="FT_TOT_AMT"     width=80        align=right        name="�Ϲ�"            RightMargin=5    </C>
                        <C> id="FT_MARKET_TOT_AMT"   width=80   align=right        name="�������"         RightMargin=5    </C>
                        <C> id="FT_TMONEY_TOT_AMT"   width=80   align=right        name="���߱���"         RightMargin=5    </C>
                        </G>  
                        
                       
                        <G> name="2015�⵵ �ſ�ī�� �� �ҵ����" HeadBgColor="#F7DCBB"
                            <C> id="CARD_AMT_NTS"        width=70        align=right        name="�ſ�ī���"           RightMargin=5    </C>
                            <C> id="CASH_AMT_NTS"        width=70        align=right        name="���ݿ�����"           RightMargin=5    </C>
                            <C> id="DIR_CARD_AMT_NTS"    width=70        align=right        name="����ī��"             RightMargin=5    </C>
                            <C> id="MARKET_AMT_NTS"         width=70        align=right        name="�������"             RightMargin=5    </C>
                            <C> id="PUBLIC_AMT_NTS"      width=70        align=right        name="���߱���"             RightMargin=5    </C>
                        </G>
                        
                         <G> name=" ���� 2015�⵵ " HeadBgColor="#F7DCBB"
                           <C> id="CARD_2015_AMT"       width=80        align=right        name="ī������"        RightMargin=5    </C>
                           <C> id="CARD_2015_FH_OVER"   width=80        align=right        name="��ݱ��߰�������"      RightMargin=5    </C>
                           <C> id="CARD_2015_SH_OVER"   width=80        align=right        name="�Ϲݱ��߰�������"      RightMargin=5    </C>
                        </G>
                        
                        <G> name=" ���� 2014�⵵ " HeadBgColor="#F7DCBB"
                            <C> id="CARD_2014_AMT"      width=95        align=right        name="ī������"  RightMargin=5    </C>
                            <C> id="CARD_2014_OVER"     width=95        align=right        name="�߰�������"       RightMargin=5    </C>
                        </G>
                        
                         <G> name=" ���� 2013�⵵ " HeadBgColor="#F7DCBB"
                            <C> id="CARD_2013_AMT"      width=95        align=right        name="ī������"  RightMargin=5    </C>
                            <C> id="CARD_2013_OVER"     width=95        align=right        name="�߰�������"       RightMargin=5    </C>
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


<!-- ���� ��ȸ �׸��� ���̺� ��-->
<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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

